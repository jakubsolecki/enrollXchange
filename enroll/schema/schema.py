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
                user_to_trade = list(filter(lambda x: x.course==offer.enrollment.class_time.course, user_class_times))
                
                if set(user_to_trade)&set(offer.exchange_to.all())\
                    and not (set(user_class_times)-set(user_to_trade))&set({offer.enrollment.class_time}):
                    offer.active = False
                    user_enrollment = list(filter(lambda x: x.class_time.course==offer.enrollment.class_time.course, user_enrollments))[0]
                    offer.enrollment.student,user_enrollment.student = user_enrollment.student,offer.enrollment.student

                    try:
                        user_offer = Offer.objects.get(enrollment__student=user, enrollment__class_time__course=offer.enrollment.class_time.course)
                        print("Klasa")
                        user_offer.active = False
                        user_offer.save(force_update=True)
                    except Offer.DoesNotExist as e:
                        print("DUpa")
                        user_offer = None
                    
                    offer.enrollment.save()
                    offer.save()
                    user_enrollment.save()
                    return AcceptOffer(offerAccepted=True)
        return AcceptOffer(offerAccepted=False)


class MyMutations(graphene.ObjectType):
    pass
    create_offer = CreateOffer.Field()
    accept_offer = AcceptOffer.Field()


schema = graphene.Schema(query=Query, mutation=MyMutations)
