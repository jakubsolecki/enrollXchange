import {parseDay} from "../offer/weekDays";

export const parseRequests = (node) => {
    node = node['data']['studentRequests']['edges']
    return  node.map(request => request.node)
        .map(request => ({
            id: request.id,
            comment: request.comment,
            code: request.enrollment.classTime.course.code,
            fullName: request.enrollment.classTime.course.fullName,
            day: request.enrollment.classTime.day,
            humanDay: parseDay(request.enrollment.classTime.day),
            start: request.enrollment.classTime.start,
            lecturer: `${request.enrollment.classTime.lecturer.firstName} ${request.enrollment.classTime.lecturer.lastName}`,

            exchangeTo: request.exchangeTo.edges.map(node => node.node).map(data => ({
                code: data.course.code,
                day: data.day,
                humanDay: parseDay(data.day),
                id: data.id,
                start: data.start,
                lecturer: data.lecturer.fullName,
            })),
        }))

}
