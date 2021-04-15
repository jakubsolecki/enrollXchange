export const parseCourses = (nodes) => {
    nodes = nodes["data"]["courses"]["edges"];
    return nodes.map(node => ({code: node.node.code, fullName: node.node.fullName}));
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}


export const parseLecturers = (nodes) => {
    nodes = nodes["data"]["offers"]["edges"];
    return nodes.map(node => node.node.enrollment.classTime.lecturer.fullName).filter(onlyUnique);
}
