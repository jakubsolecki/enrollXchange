import {parseDay} from "../offer/weekDays";

const weekDays = {
    "MONDAY": "2021-03-01T",
    "TUESDAY": "2021-03-02T",
    "WEDNESDAY": "2021-03-03T",
    "THURSDAY": "2021-03-04T",
    "FRIDAY": "2021-03-05T",
    "SATURDAY": "2021-03-06T",
    "SUNDAY": "2021-03-07T",
}

const parseDate = (date, weekday) => {
    const newDate = new Date(date.getTime() + 90*60000 ).toString().split(" ")[4]
    return weekDays[weekday]+newDate;
}


export const parseSchedule = (node, user) => {
    node = node["data"]["enrollments"]["edges"]
    if (user === null){
        return []
    }
    node = node.map(node => node.node)
        .map(node => ({
            title: node.classTime.course.code + ", " + node.classTime.lecturer.firstName.charAt(0) + ". " + node.classTime.lecturer.lastName,
            start: weekDays[node.classTime.day] + node.classTime.start,
            end: parseDate(new Date(weekDays[node.classTime.day] + node.classTime.start), node.classTime.day),
            color: 'gray',
            extendedProps: {
                lecturer: node.classTime.lecturer.firstName + " " + node.classTime.lecturer.lastName,
                student: node.student.username,
                code: node.classTime.course.code,
                fullName: node.classTime.course.fullName,
                enrollmentId: node.id,
            }
        }))
        .filter(node => node.extendedProps.student === user.username)

    return node;

}

export const parseScheduleByClass = (node, name) => {
    node = node["data"]["enrollments"]["edges"]

    node = node.map(node => node.node)
        .map(node => ({
                title: node.classTime.course.code + ", " + node.classTime.lecturer.firstName.charAt(0) + ". " + node.classTime.lecturer.lastName,
                start: node.classTime.start,
                day: parseDay(node.classTime.day),
                fullName: node.classTime.course.fullName,
                classTimeId: node.classTime.id,
            }
        ))
        .filter(node => node.fullName === name)
    return node;

}
