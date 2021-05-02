import graphene
from graphene import relay
from graphql_auth.schema import MeQuery
from graphene_django.filter import DjangoFilterConnectionField
from django.db.models import Q, QuerySet

from .types import CourseType, OfferType, ClassTimeType, EnrollmentType
from ..models import Offer, ClassTime, Enrollment


class CourseConnection(relay.Connection):
    class Meta:
        node = CourseType


class Query(MeQuery, graphene.ObjectType):
    courses = relay.ConnectionField(CourseConnection, resolver=CourseType.resolve_all)
    offers = DjangoFilterConnectionField(OfferType)
    class_times = DjangoFilterConnectionField(ClassTimeType)
    enrollments = DjangoFilterConnectionField(EnrollmentType)
    matchingOffers = DjangoFilterConnectionField(OfferType)

    @staticmethod
    def resolve_enrollments(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Enrollment.objects.all()
        return Enrollment.objects.none()

    @staticmethod
    def resolve_offers(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Offer.objects.all()
        return Offer.objects.none()

    @staticmethod
    def resolve_matchingOffers(self, info, **kwargs):
        if info.context.user.is_authenticated:
            user = info.context.user
            user_enrollments = list(Enrollment.objects.filter(student=user))
            user_class_times = [e.class_time for e in user_enrollments]
            class_time_fields = [(c.day, c.frequency, c.start, c.end) for c in user_class_times]
            query_list = [
                Q(enrollment__class_time__day=fields[0]) &
                Q(enrollment__class_time__frequency=fields[1]) &
                Q(enrollment__class_time__start__lt=fields[3])
                for fields in class_time_fields
            ]
            final_query = Q()

            for q in query_list:
                final_query |= q

            prefiltered_offers = Offer.objects.exclude(final_query)

            unwanted_offers_ids = []
            for r in prefiltered_offers:  # temporary(?) solution to filtering by property
                for e in class_time_fields:
                    if r.enrollment.class_time.frequency == e[1] and \
                            r.enrollment.class_time.day == e[0] and \
                            r.enrollment.class_time.end >= e[2]:
                        unwanted_offers_ids.append(r.id)

            return prefiltered_offers.exclude(id__in=unwanted_offers_ids)

        return Offer.objects.none()

    @staticmethod
    def resolve_class_times(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return ClassTime.objects.all()
        return ClassTime.objects.none()


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
        duration=None
    ):
        _, enrollment_id_real = relay.Node.from_global_id(global_id=enrollment_id)
        enrollment = Enrollment.objects.get(id=enrollment_id_real)

        class_times = ClassTime.objects.filter(course=enrollment.class_time.course)
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

        try:
            offer = Offer.objects.get(enrollment=enrollment)
        except Offer.DoesNotExist as e:
            offer = Offer.objects.create(
                enrollment=enrollment,
                comment=comment,
                active=True
            )

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

        try:
            offer = Offer.objects.get(enrollment=enrollment)
        except Offer.DoesNotExist as e:
            offer = Offer.objects.create(
                enrollment=enrollment,
                comment=comment,
                active=True
            )

        offer.exchange_to.add(class_time)

        return CreateOffer(offer=offer)


class AcceptOffer(graphene.Mutation):
    class Arguments:
        offer_id = graphene.String()

    offerAccepted = graphene.Boolean()

    @staticmethod
    def mutate(root, info, offer_id):
        if info.context.user.is_authenticated:
            user = info.context.user
            _, real_offer_id = relay.Node.from_global_id(global_id=offer_id)
            offer = Offer.objects.get(id=real_offer_id)

            if offer.active:
                user_enrollments = list(Enrollment.objects.filter(student=user))
                user_class_times = [e.class_time for e in user_enrollments]
                user_to_trade = list(filter(
                    lambda x: x.course == offer.enrollment.class_time.course,
                    user_class_times
                ))

                if set(user_to_trade) & set(offer.exchange_to.all()) \
                        and not (set(user_class_times) - set(user_to_trade)) & \
                        {offer.enrollment.class_time}:
                    offer.active = False
                    user_enrollment = list(filter(
                        lambda x: x.class_time.course == offer.enrollment.class_time.course,
                        user_enrollments
                    ))[0]
                    offer.enrollment.student = user_enrollment.student
                    user_enrollment.student = offer.enrollment.student
                    try:
                        user_offer = Offer.objects.get(
                            enrollment__student=user,
                            enrollment__class_time__course=offer.enrollment.class_time.course
                        )
                        user_offer.active = False
                        user_offer.save(force_update=True)
                    except Offer.DoesNotExist as e:
                        user_offer = None

                    offer.enrollment.save()
                    offer.save()
                    user_enrollment.save()
                    return AcceptOffer(offerAccepted=True)
        return AcceptOffer(offerAccepted=False)


class MyMutations(graphene.ObjectType):
    create_offer = CreateOffer.Field()
    accept_offer = AcceptOffer.Field()
    create_offer_with_any = CreateOfferWithAny.Field()


schema = graphene.Schema(query=Query, mutation=MyMutations)
