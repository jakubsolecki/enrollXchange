import datetime as dt
from django.contrib.auth import get_user_model

from enroll.schema import types
from enroll.tests.support import ConnectionTestCase, get_global_id
from enroll.models import UserType, Enrollment, ClassTime, Student


class GetEnrollmentsTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        query {
          enrollments {
            edges {
              node {
                id
                student {
                    id
                    firstName
                    lastName
                    username
                }
              }
            }
          }
        }
        """

    def test_an_example(self):
        user = get_user_model().objects.create(
            username="test2", user_type=UserType.get_by_name("teacher")
        )
        student_acc = get_user_model().objects.create(
            username="test1", user_type=UserType.get_by_name("student")
        )
        ct = ClassTime.objects.create(
            day="1",
            frequency=ClassTime.FrequencyType.EVERY_WEEK,
            start=dt.time(hour=23, minute=59),
            duration_minutes=10,
            seats=0,
        )
        student = Student.objects.create(
            account=student_acc,
            student_id="123456",
        )
        enrollment = Enrollment.objects.create(
            class_time=ct,
            student=student,
        )
        result = self.execute(self.query, user=user)
        assert result == {
            "data": {
                "enrollments": {
                    "edges": [
                        {
                            "node": {
                                "id": get_global_id(types.EnrollmentType, enrollment),
                                "student": {
                                    "id": get_global_id(types.StudentType, student),
                                    "firstName": student.first_name,
                                    "lastName": student.last_name,
                                    "username": student_acc.username,
                                },
                            }
                        }
                    ]
                }
            }
        }
