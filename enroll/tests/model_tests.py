import datetime as dt
from django.test import TestCase
from django.core.exceptions import ValidationError

from enroll.models import User, Lecturer, Enrollment, ClassTime
from enroll.types import UserType
from enroll.utils import time_plus_minutes


class UtilsTestCase(TestCase):
    def test_time_plus_minutes(self):
        """
        Assert time_plus_minutes helper functions returns correct
        result of time + minutes calculation.
        """
        time = dt.time()
        self.assertEqual(time, time_plus_minutes(time, 0))
        self.assertEqual(time, dt.time())
        time = dt.time(hour=23, minute=59)
        self.assertEqual(time_plus_minutes(time, 30), dt.time(hour=0, minute=29))
        self.assertNotEqual(time_plus_minutes(time, 0), dt.time(hour=12, minute=0))


class UserTestCase(TestCase):
    def setUp(self):
        self.new_user = User.objects.create(
            user_type=UserType.get_by_name('new_user'),
            username='testuser1', password='12345',
        )
        self.student = User.objects.create(
            user_type=UserType.get_by_name('student'),
            username='testuser2', password='12345',
        )
        self.teacher = User.objects.create(
            user_type=UserType.get_by_name('teacher'),
            username='testuser3', password='12345',
        )
        self.moderator = User.objects.create(
            user_type=UserType.get_by_name('moderator'),
            username='testuser4', password='12345',
        )


class LecturerTestCase(UserTestCase):
    def setUp(self):
        super().setUp()

    def test_lecturer_account_validator(self):
        """
        Assert that ValidationError is raised when Lecturer account
        has user_type different than teacher.
        """
        Lecturer.objects.create(account=self.teacher).clean()
        with self.assertRaises(ValidationError):
            Lecturer.objects.create(account=self.new_user).clean()
        with self.assertRaises(ValidationError):
            Lecturer.objects.create(account=self.student).clean()


class EnrollmentTestCase(UserTestCase):
    def setUp(self):
        super().setUp()
        self.time = ClassTime.objects.create(
            day='1',
            frequency=ClassTime.FrequencyType.EVERY_WEEK,
            start=dt.time(),
            duration_minutes=0,
            seats=0,
        )

    def test_lecturer_account_validator(self):
        """
        Assert that ValidationError is raised when Enrollment is linked to user other than student.
        """
        Enrollment.objects.create(student=self.student, class_time=self.time).clean()
        with self.assertRaises(ValidationError):
            Enrollment.objects.create(student=self.new_user, class_time=self.time).clean()
        with self.assertRaises(ValidationError):
            Enrollment.objects.create(student=self.teacher, class_time=self.time).clean()


class ClassTimeCase(TestCase):
    def test_end_property(self):
        """
        Assert that ClassTime.end property returns correct end time
        (ClassTime.start + ClassTime.duration_minutes).
        """
        time = dt.time(hour=23, minute=59)
        duration = 10
        ct = ClassTime.objects.create(
            day='1',
            frequency=ClassTime.FrequencyType.EVERY_WEEK,
            start=time,
            duration_minutes=duration,
            seats=0,
        )
        self.assertEqual(time_plus_minutes(time, duration), ct.end)
