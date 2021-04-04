from django.core.exceptions import ValidationError
from enroll.types import UserType


# def validate_student(user):
#     if user.user_type != UserType.get_by_name('student'):
#         raise ValidationError(f"Lecturer's account type must be 'student'!")
#
#
# def validate_teacher(user):
#     if user.user_type != UserType.get_by_name('teacher'):
#         raise ValidationError(f"Lecturer's account type must be 'teacher'!")


def validate_by_user_type(user_type):
    def __validate(user):
        if user.user_type != UserType.get_by_name(user_type):
            raise ValidationError(f"Lecturer's account type must be '{user_type}'!")

    return __validate