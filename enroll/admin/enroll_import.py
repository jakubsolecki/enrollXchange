from django.contrib import admin

import tablib
import datetime
from import_export.admin import ImportMixin
from import_export.formats import base_formats
from import_export.forms import ConfirmImportForm
from import_export import resources

from enroll.models import Student, Lecturer, Enrollment, ClassTime, Course
from enroll.fields import DayOfTheWeek


class EnrollImporter:
    def __init__(self, in_stream):
        self.students = dict()
        lines = self.parse_file(in_stream)
        self.save_models(lines)

    @staticmethod
    def clear_list(array):
        return list(filter(lambda el: el, array))

    @staticmethod
    def split_list(array, condition):
        if not array:
            return array
        res = []
        subarray = [array[0]]
        array = array[1:]
        for el in array:
            if condition(el):
                res.append(subarray)
                subarray = [el]
            else:
                subarray.append(el)
        res.append(subarray)
        return res

    def parse_file(self, in_stream):
        def parse_name(name):
            return {
                "first_name": name.split(" ", 1)[0],
                "last_name": name.split(" ", 1)[1],
            }

        def parse_student(line):
            student = {
                "id": line.split(";", 1)[0],
                "name": parse_name(line.split(";", 1)[1]),
            }
            student["id"] = student["id"] if student["id"] else None
            self.students[line] = student
            return student

        def split_courses(lines):
            return EnrollImporter.split_list(
                lines, lambda line: line and line[-1] == ";" and line != ";"
            )

        def parse_courses(lines):
            def parse_course(course_lines):
                course = {"name": course_lines[0].rstrip(";")}
                course_lines = course_lines[1:]
                times = EnrollImporter.split_list(course_lines, lambda line: line == ";")
                course["times"] = list(map(parse_time, times))
                return course

            return list(map(parse_course, lines))

        def parse_time(time_lines):
            def get_day_enum(day):
                if day == "poniedziałek":
                    return DayOfTheWeek.MONDAY
                if day == "wtorek":
                    return DayOfTheWeek.TUESDAY
                if day == "środa":
                    return DayOfTheWeek.WEDNESDAY
                if day == "czwartek":
                    return DayOfTheWeek.THURSDAY
                if day == "piątek":
                    return DayOfTheWeek.FRIDAY
                if day == "sobota":
                    return DayOfTheWeek.SATURDAY
                if day == "niedziela":
                    return DayOfTheWeek.SUNDAY

            def get_day(day):
                if not get_day_enum(day):
                    return None
                return get_day_enum(day).value

            def get_duration(start_time, end_time):
                start_datetime = datetime.datetime.combine(
                    datetime.date.today(), start_time
                )
                end_datetime = datetime.datetime.combine(datetime.date.today(), end_time)
                diff = end_datetime - start_datetime
                return int(diff.total_seconds() // 60)

            def parse_time_entry(entry):
                left, end_time = entry.split(" - ", 1)
                day, start = left.split(" ", 1)
                hour, minute = start.split(":", 1)
                end_hour, end_minute = end_time.split(":", 1)
                start_time = datetime.time(int(hour), int(minute), 0)
                end_time = datetime.time(int(end_hour), int(end_minute), 0)
                return {
                    "day": get_day(day),
                    "start": start_time,
                    "duration": get_duration(start_time, end_time),
                }

            time_lines = time_lines[1:]
            time_entry, lecturer_entry = time_lines[0].split("; ", 1)
            time = {
                "time": parse_time_entry(time_entry),
                "lecturer": parse_name(lecturer_entry),
            }
            time_lines = time_lines[1:]
            time_lines = list(map(parse_student, time_lines))
            time["students"] = time_lines
            return time

        file = EnrollImporter.clear_list(
            map(lambda line: line.strip(), in_stream.split("\n"))
        )
        file = split_courses(file)
        file = parse_courses(file)
        return file

    def save_models(self, parsed):
        for student in self.students.values():
            Student.objects.update_or_create(
                student_id=student["id"],
                defaults={
                    "last_name": student["name"]["last_name"],
                    "first_name": student["name"]["first_name"],
                },
            )

        def create_course(parsed_course):
            course_object = Course.objects.get_or_create(
                full_name=parsed_course["name"],
            )[0]
            for time in parsed_course["times"]:
                lecturer = Lecturer.objects.filter(
                    first_name=time["lecturer"]["first_name"],
                    last_name=time["lecturer"]["last_name"],
                ).first()
                if not lecturer:
                    lecturer = Lecturer.objects.create(
                        first_name=time["lecturer"]["first_name"],
                        last_name=time["lecturer"]["last_name"],
                    )

                class_time = ClassTime.objects.filter(
                    course=course_object.id,
                    lecturer=lecturer.id,
                    day=time["time"]["day"],
                    start=time["time"]["start"],
                    duration_minutes=time["time"]["duration"],
                ).first()
                if not class_time:
                    class_time = ClassTime.objects.create(
                        frequency=ClassTime.FrequencyType.EVERY_WEEK,
                        seats=len(time["students"]),
                        course_id=course_object.id,
                        lecturer_id=lecturer.id,
                        day=time["time"]["day"],
                        start=time["time"]["start"],
                        duration_minutes=time["time"]["duration"],
                    )

                for class_student in time["students"]:
                    student_object = Student.objects.get(student_id=class_student["id"])
                    Enrollment.objects.get_or_create(
                        class_time=class_time,
                        student=student_object,
                    )

        map(create_course, parsed)


class CustomConfirmImportForm(ConfirmImportForm):
    pass


class EnrollImportFormat(base_formats.CSV):
    def get_title(self):
        return "enroll"

    def create_dataset(self, in_stream, **kwargs):
        EnrollImporter(in_stream)
        return tablib.Dataset()


class EnrollmentAdmin(ImportMixin, admin.ModelAdmin):
    resource_class = resources.modelresource_factory(model=Enrollment)

    def get_import_formats(self):
        return [EnrollImportFormat]

    def get_confirm_import_form(self):
        return CustomConfirmImportForm
