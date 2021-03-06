from django.contrib import admin
from django.contrib.auth import get_user_model

from enroll.models import (
    Enrollment,
    Offer,
    ClassTime,
    Course,
    Lecturer,
    StudentRequest,
    Student,
)
from enroll.admin.enroll_import import EnrollmentAdmin

admin.site.register(Offer)
admin.site.register(Course)
admin.site.register(Lecturer)
admin.site.register(ClassTime)
admin.site.register(Student)
admin.site.register(StudentRequest)
admin.site.register(get_user_model())
admin.site.register(Enrollment, EnrollmentAdmin)
