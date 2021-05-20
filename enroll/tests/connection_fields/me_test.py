from enroll.tests import factory
from enroll.tests.support import ConnectionTestCase


class CoursesTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        query meQuery{
            me {
                username,
                userType,
            }
        }
        """

        self.courses = [factory.CourseFactory() for _ in range(10)]

    def test_get_all_courses(self):
        result = self.execute(self.query, user=self.user)
        assert result == {
            "data": {
                "me": {
                    "username": self.user.username,
                    "userType": f"A_{self.user.user_type}",
                }
            }
        }
