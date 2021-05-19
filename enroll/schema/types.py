from graphene_django import DjangoObjectType
from django.contrib.auth import get_user_model
from graphene import relay
import graphene

from enroll.models import Course, Lecturer, ClassTime, Enrollment, Offer, StudentRequest, Student


class UserType(DjangoObjectType):
    class Meta:
        model = get_user_model()


class StudentType(DjangoObjectType):
    class Meta:
        model = Student
        interfaces = (relay.Node,)
        fields = "__all__"

    username = graphene.String()

    def resolve_username(self, info, **kwargs):
        return self.account.username

    @staticmethod
    def resolve_all(root, info, **kwargs):
        return Student.objects.all()


class LecturerType(DjangoObjectType):
    full_name = graphene.String()

    class Meta:
        model = Lecturer
        interfaces = (relay.Node,)
        fields = "__all__"

    @staticmethod
    def resolve_all(root, info, **kwargs):
        return Lecturer.objects.all()


class CourseType(DjangoObjectType):
    class Meta:
        model = Course
        interfaces = (relay.Node,)
        fields = "__all__"

    @staticmethod
    def resolve_all(root, info, **kwargs):
        return Course.objects.all()


class ClassTimeType(DjangoObjectType):
    class Meta:
        model = ClassTime
        interfaces = (relay.Node,)
        fields = "__all__"
        filter_fields = [
            "day",
            "frequency",
            "start",
            "lecturer__first_name",
            "lecturer__last_name",
            "course__code",
            "course__full_name",
        ]

    @staticmethod
    def resolve_all(root, info, **kwargs):
        return ClassTime.objects.all()


class EnrollmentType(DjangoObjectType):
    class Meta:
        model = Enrollment
        interfaces = (relay.Node,)
        fields = "__all__"
        filter_fields = ["student__id"]

    @staticmethod
    def resolve_all(root, info, **kwargs):
        return Enrollment.objects.all()


class OfferType(DjangoObjectType):
    class Meta:
        model = Offer
        interfaces = (relay.Node,)
        fields = "__all__"
        filter_fields = [
            "active",
            "enrollment__class_time__course__full_name",
            "enrollment__class_time__lecturer__first_name",
            "enrollment__class_time__lecturer__last_name",
            "enrollment__class_time__day",
            "enrollment__class_time__start",
            "enrollment__class_time__frequency",
            "enrollment__student__id",
        ]


class StudentRequestType(DjangoObjectType):
    class Meta:
        model = StudentRequest
        interfaces = (relay.Node,)
        fields = "__all__"
        filter_fields = ["active", "lecturer__id"]
