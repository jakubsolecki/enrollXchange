from django.db import models
from enum import Enum


class DayOfTheWeek(Enum):
    MONDAY = "Monday"
    TUESDAY = "Tuesday"
    WEDNESDAY = "Wednesday"
    THURSDAY = "Thursday"
    FRIDAY = "Friday"
    SATURDAY = "Saturday"
    SUNDAY = "Sunday"

    def __str__(self):
        """Allow to directly assign enum values to the model field."""
        return self.name


class DayOfTheWeekField(models.CharField):
    def __init__(self, *args, **kwargs):
        kwargs["choices"] = [(tag.name, tag.value) for tag in DayOfTheWeek]
        kwargs["max_length"] = 10
        super(DayOfTheWeekField, self).__init__(*args, **kwargs)
