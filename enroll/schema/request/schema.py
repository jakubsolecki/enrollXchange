import graphene
from graphene import relay

from enroll.schema.common.accepting_mutations import Accepting
from enroll.mail import send_request_accepted
from enroll.models import StudentRequest, Enrollment, ClassTime

from .type import StudentRequestType


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

        lecturer = class_time.lecturer

        request = StudentRequest.objects.create(
            enrollment=enrollment, comment=comment, active=True, lecturer=lecturer
        )

        request.exchange_to.add(class_time)

        return CreateRequest(request=request)


class AcceptRequest(Accepting, graphene.Mutation):
    class Arguments:
        offer_id = graphene.String()

    accepted = graphene.Boolean()

    @staticmethod
    def mutate(root, info, offer_id):
        request_id = offer_id
        request = StudentRequest.objects.get(id=Accepting.get_id(request_id))
        student = request.enrollment.student
        if (
            not Accepting.test_user(user := info.context.user)
            or not Accepting.test_active(request)
            or not request.lecturer.account == info.context.user
            or not Accepting.test_request(request, student)
        ):
            return AcceptRequest(accepted=False)

        request.active = False
        request.enrollment.class_time = request.exchange_to.first()
        request.enrollment.save()
        request.save()
        Accepting.clean_offers(
            student, request.enrollment.class_time.course, request.enrollment.class_time
        )
        send_request_accepted(
            student_mail=student.account.email,
            lecturer_mail=user.email,
            class_time=request.exchange_to.first(),
            former_class_time=request.enrollment.class_time,
            comment=request.comment,
            name=student,
        )
        return AcceptRequest(accepted=True)
