from django.db import models
from django.contrib.auth.models import AbstractUser

from enrollXchange.settings import ModelConstants
from enroll.fields import DayOfTheWeekField
from enroll.validators import validate_by_user_type, validate_student_id
from enroll.types import UserType
from enroll.utils import time_plus_minutes


class User(AbstractUser):
    user_type = models.PositiveSmallIntegerField(
        choices=UserType.get_choices(), default=UserType.get_by_name("new_user")
    )

    def __str__(self):
        return super().__str__() + " (" + (UserType.get_by_key(self.user_type)) + ")"


class Student(models.Model):
    first_name = models.CharField(max_length=ModelConstants.NAME_LENGTH)
    last_name = models.CharField(max_length=ModelConstants.NAME_LENGTH)
    student_id = models.CharField(max_length=6, null=False, blank=False, unique=True)
    account = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        null=True,
    )

    def __str__(self):
        return f"{self.first_name} {self.last_name} #{self.student_id}"

    def clean(self):
        validate_by_user_type("student")(self.account)
        validate_student_id(self)


class Lecturer(models.Model):
    first_name = models.CharField(max_length=ModelConstants.NAME_LENGTH)
    last_name = models.CharField(max_length=ModelConstants.NAME_LENGTH)
    account = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        null=True,
    )

    def clean(self):
        validate_by_user_type("teacher")(self.account)

    @property
    def full_name(self):
        return f"{self.first_name} {self.last_name}"

    def __str__(self):
        return self.full_name


class Course(models.Model):
    code = models.CharField(max_length=40)
    full_name = models.CharField(max_length=100)

    def __str__(self):
        return self.full_name


class ClassTime(models.Model):
    class FrequencyType(models.IntegerChoices):
        EVERY_WEEK = 1, "every week"
        A_WEEK = 2, "week a"
        B_WEEK = 3, "week b"
        OTHER = 4, "other"

    day = DayOfTheWeekField(null=False)
    frequency = models.PositiveSmallIntegerField(choices=FrequencyType.choices)
    start = models.TimeField(null=False, auto_now=False)
    duration_minutes = models.PositiveIntegerField()
    course = models.ForeignKey(Course, null=True, on_delete=models.CASCADE)
    lecturer = models.ForeignKey(Lecturer, null=True, on_delete=models.SET_NULL)
    seats = models.PositiveIntegerField()

    @property
    def end(self):
        return time_plus_minutes(self.start, self.duration_minutes)

    def __str__(self):
        return (
            self.course.__str__() + " | " + self.day + " " + self.start.strftime("%H:%M")
        )


class Enrollment(models.Model):
    class_time = models.ForeignKey(ClassTime, null=False, on_delete=models.CASCADE)
    student = models.ForeignKey(
        Student,
        null=False,
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.student.__str__() + " - " + self.class_time.__str__()

    class Meta:
        unique_together = (
            "student",
            "class_time",
        )


class OfferFields(models.Model):
    enrollment = models.ForeignKey(Enrollment, null=False, on_delete=models.CASCADE)
    comment = models.CharField(max_length=ModelConstants.OFFER_COMMENT_LENGTH)
    active = models.BooleanField(default=True, null=False)
    # ClassTimes for which author is willing to exchange
    exchange_to = models.ManyToManyField(ClassTime, blank=True)

    class Meta:
        abstract = True


class Offer(OfferFields):
    def __str__(self):
        return (
            self.enrollment.student.__str__()
            + " - "
            + self.enrollment.class_time.__str__()
        )


class StudentRequest(OfferFields):
    lecturer = models.ForeignKey(Lecturer, null=False, on_delete=models.CASCADE)

    def __str__(self):
        return (
            self.enrollment.student.__str__()
            + " - "
            + self.enrollment.class_time.__str__()
        )
