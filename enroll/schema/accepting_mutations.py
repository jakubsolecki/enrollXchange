import graphene
from graphene import relay

from ..mail import send_offer_accepted, send_request_accepted
from ..models import (
    Offer,
    ClassTime,
    Enrollment,
    StudentRequest,
    Lecturer,
    Student,
    StudentRequest,
)


class Accepting:
    class Arguments:
        offer_id = graphene.String()

    accepted = graphene.Boolean()

    @staticmethod
    def freq_conflicting(a, b):
        return bool({"every week", "other"} & {a.label, b.label}) or a.label == b.label

    @staticmethod
    def times_conflicting(a, b):
        return (a.start < b.end and a.end > b.start) or (
            b.start < a.end and b.end > a.start
        )

    @staticmethod
    def conflicting(a, b):
        return bool(
            a.day == b.day
            and freq_conflicting(a.frequency, b.frequency)
            and times_conflicting(a, b)
        )

    @staticmethod
    def user_has_class_time_to_trade(user_classes_to_trade, offer_exchange_to):
        if offer_exchange_to:
            return bool(set(user_classes_to_trade) & set(offer_exchange_to))

        # To allow offers with *any* exchange_to
        return bool(user_classes_to_trade)

    @staticmethod
    def user_has_collision(user_classes, user_classes_to_trade, offer_time):
        for user_class in set(user_classes) - set(user_classes_to_trade):
            if conflicting(user_class, offer_time):
                return True
        return False
        # return bool((set(user_classes) - set(user_classes_to_trade)) & {offer_time})

    @staticmethod
    def test_user(user):
        return user.is_authenticated

    @staticmethod
    def test_active(obj):
        return obj.active

    @staticmethod
    def get_id(fake_id):
        return relay.Node.from_global_id(global_id=fake_id)[1]

    @staticmethod
    def test_exchange(user_to_trade, user_class_times, offer):
        return user_has_class_time_to_trade(
            user_to_trade, offer.exchange_to.all()
        ) and not user_has_collision(
            user_class_times, user_to_trade, offer.enrollment.class_time
        )

    @staticmethod
    def test_request(request, student):
        for time in list(map(lambda x: x.class_time, Enrollment.Objects.filter(student))):
            if conflicting(time, request.exchange_to):
                return False
        return True

    @staticmethod
    def clean_offers(student, course, class_time):
        try:
            user_offer = Offer.objects.get(
                enrollment__student=student,
                enrollment__class_time__course=course,
            )
            user_offer.active = False
            user_offer.save(force_update=True)
        except Offer.DoesNotExist as ignored:
            pass
        offers = list(Offer.objects.filter(enrollment__student=student))
        for offer in offers:
            for exchange in offer.exchange_to:
                if conflicting(exchange, class_time):
                    offer.remove(exchange)
                    offer.save()


class AcceptOffer(Accepting, graphene.Mutation):
    @staticmethod
    def mutate(root, info, offer_id):
        if not super.test_user(user := info.context.user) or not super.test_active(
            offer := Offer.objects.get(id=super.get_id())
        ):
            return AcceptOffer(accepted=False)
        student = Student.objects.get(account=user)
        user_enrollments = list(Enrollment.objects.filter(student=student))
        user_class_times = [e.class_time for e in user_enrollments]
        course = offer.enrollment.class_time.course
        user_to_trade = list(
            filter(
                lambda x: x.course == course,
                user_class_times,
            )
        )
        if not super.test_exchange(user_to_trade, user_class_times, offer):
            return AcceptOffer(accepted=False)

        offer.active = False
        offer.save()
        user_enrollment = next(
            filter(
                lambda x: x.class_time.course == course,
                user_enrollments,
            )
        )
        super.clean_offers(student, course, offer.enrollmnt.class_time)
        offer.enrollment.student, user_enrollment.student = (
            user_enrollment.student,
            offer.enrollment.student,
        )
        offer.enrollment.save()
        user_enrollment.save()
        offer.save()
        send_offer_accepted(
            offer_client_mail=user_enrollment.student.account.email,
            offer_owner_mail=offer.enrollment.student.account.email,
            client_class_time=user_enrollment.class_time,
            offer_class_time=offer.enrollment.class_time,
        )
        return AcceptOffer(accepted=True)


class AcceptRequest(Accepting, graphene.Mutation):
    @staticmethod
    def mutate(root, info, offer_id):
        request_id = offer_id
        if (
            not super.test_user(user := info.context.user)
            or not super.test_active(
                request := StudentRequest.objects.get(id=super.get_id())
            )
            or not request.enrollment.class_time.lecturer == user
            or not super.test_request(request, student := request.enrollment.student)
        ):
            return AcceptOffer(accepted=False)
        request.active = False
        request.enrollment.class_time = request.exchange_to
        request.enrollment.class_time.save()
        request.save()
        super.clean_offers(
            student, request.enrollment.class_time.course, request.enrollment.class_time
        )
        send_request_accepted(
            student_mail=student.account.mail,
            lecturer_mail=user.account.mail,
            class_time=request.exchange_to,
            former_class_time=request.enrollment.class_time,
            comment=request.comment,
            name=student,
        )
        return AcceptRequest(accepted=True)
