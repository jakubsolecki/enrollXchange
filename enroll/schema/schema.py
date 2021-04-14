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
            offer = None
        
        if offer is not None:
            offer.exchange_to.add(class_time)
        else:
            offer = Offer.objects.create(
                enrollment=enrollment,
                comment=comment,
                active=True
            )
            offer.exchange_to.add(class_time)
        
        return CreateOffer(offer=offer)


class MyMutations(graphene.ObjectType):
    pass
    create_offer = CreateOffer.Field()

schema = graphene.Schema(query=Query, mutation=MyMutations)
