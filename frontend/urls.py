from django.urls import path
from . import views


urlpatterns = [
    path('', views.index),
    path('market', views.index),
    path('login', views.index),
    path('my-schedule', views.index),
    path('addUser', views.index)
]
