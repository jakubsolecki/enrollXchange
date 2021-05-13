from django.contrib import admin
from django.contrib.auth import get_user_model

from .models import Enrollment, Offer, ClassTime, Course, Lecturer, StudentRequest

admin.site.register(Offer)
admin.site.register(Course)
admin.site.register(Lecturer)
admin.site.register(ClassTime)
admin.site.register(Enrollment)
admin.site.register(StudentRequest)
admin.site.register(get_user_model())
