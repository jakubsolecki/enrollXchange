import datetime as dt
from django.contrib.auth import get_user_model

from enroll.schema import types
from enroll.tests.support import ConnectionTestCase, get_global_id
from enroll.models import UserType, Lecturer, Enrollment, StudentRequest, ClassTime


class GetStudentRequestsTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        query {
            studentRequests(active: true) {
                edges {
                    node {
                        id
                        lecturer {
                            firstName
                            lastName
                        }
                        active
                        comment
                    }
                }
            }
        }
        """

    def test_an_example(self):
        student = get_user_model().objects.create(
            username="test1", user_type=UserType.get_by_name("student")
        )
        result = self.execute(self.query, user=student)
        assert result == {"data": {"studentRequests": {"edges": []}}}

        teacher = get_user_model().objects.create(
            username="test2", user_type=UserType.get_by_name("teacher")
        )
        result = self.execute(self.query, user=teacher)
        assert result == {"data": {"studentRequests": {"edges": []}}}
        lecturer = Lecturer.objects.create(
            account=teacher,
            first_name="Elon",
            last_name="Musk",
        )
        ct = ClassTime.objects.create(
            day="1",
            frequency=ClassTime.FrequencyType.EVERY_WEEK,
            start=dt.time(hour=23, minute=59),
            duration_minutes=10,
            seats=0,
        )
        enrollment = Enrollment.objects.create(
            class_time=ct,
            student=student,
        )
        request = StudentRequest.objects.create(
            enrollment=enrollment,
            lecturer=lecturer,
        )
        result = self.execute(self.query, user=teacher)
        assert result == {
            "data": {
                "studentRequests": {
                    "edges": [
                        {
                            "node": {
                                "id": get_global_id(types.StudentRequestType, request),
                                "lecturer": {
                                    "firstName": lecturer.first_name,
                                    "lastName": lecturer.last_name,
                                },
                                "active": request.active,
                                "comment": request.comment,
                            }
                        }
                    ]
                }
            }
        }
