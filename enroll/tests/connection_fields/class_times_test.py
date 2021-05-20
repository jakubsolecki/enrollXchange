from enroll.tests import factory
from enroll.tests.support import ConnectionTestCase, get_global_id

from enroll.schema import types


class ClassTimesTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        query classTimesQuery($course_FullName: String){
          classTimes(course_FullName: $course_FullName) {
            edges {
              node {
                id
                day
                start
                lecturer {
                  id
                  fullName
                }
                course {
                  id
                  fullName
                  code
                }
              }
            }
          }
        }
        """

        self.course = factory.CourseFactory()
        self.class_times = [
            factory.ClassTimeFactory(course=self.course) for _ in range(5)
        ]
        self.all_class_times = [
            factory.ClassTimeFactory() for _ in range(10)
        ] + self.class_times

    @staticmethod
    def validate_node(class_times):
        def __validate(node):
            instance = None
            for ct in class_times:
                ct_gid = get_global_id(types.ClassTimeType, ct)
                if node["id"] == ct_gid:
                    instance = ct
                    break
            if not instance:
                assert False, "Returned not created class time instance"
            assert node == {
                "id": get_global_id(types.ClassTimeType, instance),
                "day": instance.day,
                "start": instance.start,
                "lecturer": {
                    "id": get_global_id(types.LecturerType, instance.lecturer),
                    "fullName": instance.lecturer.full_name,
                },
                "course": {
                    "id": get_global_id(types.CourseType, instance.course),
                    "fullName": instance.course.full_name,
                    "code": instance.course.code,
                },
            }

        return __validate

    def test_class_times_query_by_course(self):
        result = self.execute(
            self.query,
            user=self.user,
            variables={"course_FullName": self.course.full_name},
        )
        edges = list(map(lambda x: x["node"], result["data"]["classTimes"]["edges"]))
        assert "errors" not in result
        assert len(edges) == len(self.class_times)
        map(ClassTimesTest.validate_node(self.class_times), edges)

    def test_class_times_query_all(self):
        result = self.execute(self.query, user=self.user)
        edges = list(map(lambda x: x["node"], result["data"]["classTimes"]["edges"]))
        assert "errors" not in result
        assert len(edges) == len(self.all_class_times)
        map(ClassTimesTest.validate_node(self.all_class_times), edges)
