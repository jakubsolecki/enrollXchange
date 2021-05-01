import graphene
from graphene import relay
from graphql_auth.schema import UserQuery, MeQuery
from graphene_django.filter import DjangoFilterConnectionField

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

    def resolve_enrollments(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Enrollment.objects.all()
        return Enrollment.objects.none()

    def resolve_offers(self, info, **kwargs):
        if info.context.user.is_authenticated:
            return Offer.objects.all()
        return Offer.objects.none()

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

    # on front end you can specify only those fields you ask for, the rest is automatically set to 'any'

    @staticmethod
    def mutate(root, info, enrollment_id, comment="", lecturer_id=None, day=None, frequency=None, start=None, duration=None):
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


class MyMutations(graphene.ObjectType):
    create_offer = CreateOffer.Field()
    create_offer_with_any = CreateOfferWithAny.Field()


schema = graphene.Schema(query=Query, mutation=MyMutations)
