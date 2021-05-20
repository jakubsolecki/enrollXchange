import graphene
from graphene import relay
from graphql_auth.schema import MeQuery
from graphene_django.filter import DjangoFilterConnectionField
from django.db.models import Q

from .types import (
    CourseType,
    OfferType,
    ClassTimeType,
    EnrollmentType,
    StudentRequestType,
)
from ..models import (
    Offer,
    ClassTime,
    Enrollment,
    StudentRequest,
    Lecturer,
    Student,
    User,
)
from ..types import UserType

from .accepting_mutations import AcceptOffer, AcceptRequest


def get_student(user: User):
    return Student.objects.get(account=user)


class CourseConnection(relay.Connection):
    class Meta:
        node = CourseType


class Query(MeQuery, graphene.ObjectType):
    courses = relay.ConnectionField(CourseConnection, resolver=CourseType.resolve_all)
    offers = DjangoFilterConnectionField(OfferType)
    class_times = DjangoFilterConnectionField(ClassTimeType)
    my_class_times = DjangoFilterConnectionField(ClassTimeType)
    enrollments = DjangoFilterConnectionField(EnrollmentType)
    matching_offers = DjangoFilterConnectionField(OfferType)
    student_requests = DjangoFilterConnectionField(StudentRequestType)

    @staticmethod
    def resolve_enrollments(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Enrollment.objects.all()
        return Enrollment.objects.none()

    @staticmethod
    def resolve_my_class_times(self, info, **kwargs):
        user = info.context.user
        if user.is_authenticated:
            class_time_ids = Enrollment.objects.filter(
                student=get_student(user)
            ).values_list("class_time__id", flat=True)
            return ClassTime.objects.filter(id__in=class_time_ids)
        return ClassTime.objects.none()

    @staticmethod
    def resolve_offers(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Offer.objects.all()
        return Offer.objects.none()

    @staticmethod
    def resolve_matching_offers(self, info, **kwargs):
        if info.context.user.is_authenticated:
            user = info.context.user
            user_enrollments = list(
                Enrollment.objects.filter(student=get_student(user))
            )
            user_class_times = [e.class_time for e in user_enrollments]
            class_time_fields = [
                (c.day, c.frequency, c.start, c.end) for c in user_class_times
            ]
            query_list = [
                Q(enrollment__class_time__day=fields[0])
                & Q(enrollment__class_time__frequency=fields[1])
                & Q(enrollment__class_time__start__lt=fields[3])
                for fields in class_time_fields
            ]
            final_query = Q()

            for q in query_list:
                final_query |= q

            prefiltered_offers = Offer.objects.exclude(final_query)

            unwanted_offers_ids = []
            for (
                r
            ) in prefiltered_offers:  # temporary(?) solution to filtering by property
                for e in class_time_fields:
                    if (
                        r.enrollment.class_time.frequency == e[1]
                        and r.enrollment.class_time.day == e[0]
                        and r.enrollment.class_time.end >= e[2]
                    ):
                        unwanted_offers_ids.append(r.id)

            return prefiltered_offers.exclude(id__in=unwanted_offers_ids)

        return Offer.objects.none()

    @staticmethod
    def resolve_class_times(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return ClassTime.objects.all()
        return ClassTime.objects.none()

    @staticmethod
    def resolve_student_requests(self, info, **kwargs):
        user = info.context.user
        if not user.is_authenticated or user.user_type != UserType.get_by_name(
            "teacher"
        ):
            return StudentRequest.objects.none()

        lecturer = Lecturer.objects.filter(account=user).first()
        if not lecturer:
            return StudentRequest.objects.none()

        return StudentRequest.objects.filter(lecturer=lecturer)


class CreateRequest(graphene.Mutation):
    request = graphene.Field(StudentRequestType)

    class Arguments:
        enrollment_id = graphene.String()
        class_time_id = graphene.String()
        comment = graphene.String()

    @staticmethod
    def mutate(root, info, enrollment_id, class_time_id, comment=""):
        _, enrollment_id_real = relay.Node.from_global_id(global_id=enrollment_id)
        enrollment = Enrollment.objects.get(id=enrollment_id_real)

        _, class_time_id_real = relay.Node.from_global_id(global_id=class_time_id)
        class_time = ClassTime.objects.get(id=class_time_id_real)

        lecturer = enrollment.class_time.lecturer

        try:
            request = StudentRequest.objects.get(enrollment=enrollment)
        except StudentRequest.DoesNotExist as e:
            request = StudentRequest.objects.create(
                enrollment=enrollment, comment=comment, active=True, lecturer=lecturer
            )

        request.exchange_to.add(class_time)

        return CreateRequest(request=request)


class CreateOfferWithAny(graphene.Mutation):
    offer = graphene.Field(OfferType)

    class Arguments:
        enrollment_id = graphene.String()
        comment = graphene.String()
        lecturer_id = graphene.String()
        day = graphene.String()
        frequency = graphene.String()
        start = graphene.String()
        duration = graphene.Int()

    # on front end you can specify only those fields you ask for.
    # The rest is automatically set to 'any'

    @staticmethod
    def mutate(
        root,
        info,
        enrollment_id,
        comment="",
        lecturer_id=None,
        day=None,
        frequency=None,
        start=None,
        duration=None,
    ):
        _, enrollment_id_real = relay.Node.from_global_id(global_id=enrollment_id)
        enrollment = Enrollment.objects.get(id=enrollment_id_real)

        class_times = ClassTime.objects\
            .filter(course=enrollment.class_time.course)\
            .exclude(id=enrollment.class_time.id)
        if lecturer_id is not None:
            _, lecturer_id_real = relay.Node.from_global_id(global_id=lecturer_id)
            class_times = class_times.filter(lecturer__id=lecturer_id_real)
        if day is not None:
            class_times = class_times.filter(day=day)
        if frequency is not None:
            class_times = class_times.filter(frequency=frequency)
        if start is not None:
            class_times = class_times.filter(start=start)
        if duration is not None:
            class_times = class_times.filter(duration_minutes=duration)

        current_class_time = enrollment.class_time
        is_active = True

        acceptable_wanted_class_time = list(
            filter(
                lambda x: x.enrollment_set.count()
                <= (current_class_time.enrollment_set.count() - 1)
                and x.lecturer == current_class_time.lecturer,
                class_times,
            )
        )

        # in destination class_time there are N-1 students (in current N)
        # and both class_times have the same lecturer
        if len(acceptable_wanted_class_time) > 0:
            enrollment.class_time = acceptable_wanted_class_time[0]
            Enrollment.objects.filter(id=enrollment_id_real).update(
                class_time=acceptable_wanted_class_time[0]
            )
            is_active = False

        try:
            offer = Offer.objects.get(enrollment=enrollment)
        except Offer.DoesNotExist as e:
            offer = Offer.objects.create(
                enrollment=enrollment, comment=comment, active=is_active
            )
        if is_active:
            for class_time in class_times:
                offer.exchange_to.add(class_time)

        return CreateOffer(offer=offer)


class CreateOffer(graphene.Mutation):
    offer = graphene.Field(OfferType)

    class Arguments:
        enrollment_id = graphene.String()
        comment = graphene.String()
        class_time_id = graphene.String()

    @staticmethod
    def mutate(root, info, enrollment_id, comment, class_time_id):
        _, enrollment_id_real = relay.Node.from_global_id(global_id=enrollment_id)
        enrollment = Enrollment.objects.get(id=enrollment_id_real)

        _, class_time_id_real = relay.Node.from_global_id(global_id=class_time_id)
        class_time = ClassTime.objects.get(id=class_time_id_real)

        current_class_time = enrollment.class_time
        is_active = True

        # in destination class_time there are N-1 students (in current N) and
        # both class_times have the same lecturer
        if (
            class_time.enrollment_set.count()
            <= (current_class_time.enrollment_set.count() - 1)
            and class_time.lecturer == current_class_time.lecturer
        ):
            enrollment.class_time = class_time
            Enrollment.objects.filter(id=enrollment_id_real).update(
                class_time=class_time
            )
            is_active = False

        try:
            offer = Offer.objects.get(enrollment=enrollment)
        except Offer.DoesNotExist as e:
            offer = Offer.objects.create(
                enrollment=enrollment, comment=comment, active=is_active
            )

        offer.exchange_to.add(class_time)

        return CreateOffer(offer=offer)


class MyMutations(graphene.ObjectType):
    create_offer = CreateOffer.Field()
    accept_offer = AcceptOffer.Field()
    accept_request = AcceptRequest.Field()
    create_offer_with_any = CreateOfferWithAny.Field()
    create_request = CreateRequest.Field()


schema = graphene.Schema(query=Query, mutation=MyMutations)
