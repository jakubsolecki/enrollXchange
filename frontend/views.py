from django.shortcuts import render
from django.contrib.auth import logout


def index(request):
    return render(request, "frontend/index.html")


def logout_view(request):
    logout(request)
