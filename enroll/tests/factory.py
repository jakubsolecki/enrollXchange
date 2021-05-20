import factory
from factory.django import DjangoModelFactory

from enroll.types import UserType
from enroll.fields import DayOfTheWeek


class UserFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.User"

    user_type = factory.Iterator([1, 2, 3, 4])
    username = factory.Sequence(lambda n: f"User #{n}")
    email = factory.Faker("email")


class StudentFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.Student"

    account = factory.SubFactory(UserFactory, user_type=UserType.get_by_name("student"))
    student_id = factory.Sequence(lambda n: str(100000 + n))


class LecturerFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.Lecturer"

    account = factory.SubFactory(UserFactory, user_type=UserType.get_by_name("teacher"))


class CourseFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.Course"

    full_name = factory.Faker("sentence", nb_words=4)


class ClassTimeFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.ClassTime"

    lecturer = factory.SubFactory(LecturerFactory)
    course = factory.SubFactory(CourseFactory)
    day = factory.Iterator([tag.name for tag in DayOfTheWeek])
    frequency = factory.Iterator([1, 2, 3, 4])
    start = factory.Faker("time")
    duration_minutes = factory.Faker("pyint")
    seats = factory.Faker("pyint")


class EnrollmentFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.Enrollment"

    student = factory.SubFactory(StudentFactory)
    class_time = factory.SubFactory(ClassTimeFactory)


class OfferFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.Offer"

    enrollment = factory.SubFactory(EnrollmentFactory)


class StudentRequestFactory(DjangoModelFactory):
    class Meta:
        model = "enroll.StudentRequest"

    enrollment = factory.SubFactory(EnrollmentFactory)
    lecturer = factory.SubFactory(LecturerFactory)
