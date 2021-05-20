from enroll.tests import factory
from enroll.tests.support import ConnectionTestCase, get_global_id

from enroll.schema import types


class CoursesTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        query courses {
            courses {
              edges {
                node {
                  id
                  code
                  fullName
                }
              }
            }
        }
        """

        self.courses = [factory.CourseFactory() for _ in range(10)]

    @staticmethod
    def validate_node(courses):
        def __validate(node):
            instance = None
            for ct in courses:
                ct_gid = get_global_id(types.CourseType, ct)
                if node["id"] == ct_gid:
                    instance = ct
                    break
            if not instance:
                assert False

            assert node == {
                "id": get_global_id(types.CourseType, instance),
                "fullName": instance.full_name,
                "code": instance.code,
            }

        return __validate

    def test_get_all_courses(self):
        result = self.execute(self.query, user=self.user)
        edges = list(map(lambda x: x["node"], result["data"]["courses"]["edges"]))
        assert "errors" not in result
        assert len(edges) == len(self.courses)
        map(CoursesTest.validate_node(self.courses), edges)
