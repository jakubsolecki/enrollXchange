from enroll.schema import types

import enroll.tests.factory as factory
from enroll.tests.support import ConnectionTestCase, get_global_id
from enroll.models import Enrollment, Offer


class AcceptOfferTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        mutation acceptOffer($id: String){
            acceptOffer(offerId: $id) {
                accepted
            }
        }
        """

    def test_accepts_offer_to_any(self):
        course = factory.CourseFactory()

        first_class_time = factory.ClassTimeFactory(course=course)
        first_enrollment = factory.EnrollmentFactory(class_time=first_class_time)
        offer = factory.OfferFactory(enrollment=first_enrollment)

        user_class_time = factory.ClassTimeFactory(course=course)
        user_enrollment = factory.EnrollmentFactory(class_time=user_class_time)
        user = user_enrollment.student.account

        result = self.execute(
            self.query,
            user=user,
            variables={"id": get_global_id(types.OfferType, offer)},
        )

        assert result == {"data": {"acceptOffer": {"accepted": True}}}

        assert Offer.objects.get(id=offer.id).active is False
        assert (
            Enrollment.objects.get(id=user_enrollment.id).student
            == offer.enrollment.student
        )
        assert (
            Enrollment.objects.get(id=offer.enrollment.id).student
            == user_enrollment.student
        )


class AcceptRequestTest(ConnectionTestCase):
    def setUp(self):
        super().setUp()
        self.query = """
        mutation acceptRequest($id: String){
            acceptRequest(offerId: $id) {
                accepted
            }
        }
        """

    def test_accepts_request_to_any(self):
        course = factory.CourseFactory()

        lecturer = factory.LecturerFactory()
        first_class_time = factory.ClassTimeFactory(course=course, lecturer=lecturer)
        user_class_time = factory.ClassTimeFactory(course=course, lecturer=lecturer)
        first_enrollment = factory.EnrollmentFactory(class_time=first_class_time)
        request = factory.StudentRequestFactory(
            enrollment=first_enrollment,
            lecturer=lecturer,
        )
        request.exchange_to.set([user_class_time])

        result = self.execute(
            self.query,
            user=lecturer.account,
            variables={"id": get_global_id(types.OfferType, request)},
        )
        print(result)

        assert result == {"data": {"acceptRequest": {"accepted": True}}}
