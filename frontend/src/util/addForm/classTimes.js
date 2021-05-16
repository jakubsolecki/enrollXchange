import {parseDay} from "../offer/weekDays";

export const parseClassTimes = (node, id) => {
    node = node["data"]["classTimes"]["edges"]
    node = node.map(node => node.node)
        .filter(node => node.id !== id)
        .map(classTime => ({
            id: classTime.id,
            code: classTime.course.code,
            fullName: classTime.course.fullName,
            day: classTime.day,
            humanName: parseDay(classTime.day),
            start: classTime.start,
            lecturerName: classTime.lecturer.fullName,
            lecturerId: classTime.lecturer.id,
        }))
    return node;
}

function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

export const getDays = (classTimes) => {
    return classTimes.map(classTime => classTime.day)
        .filter(onlyUnique)
        .map(day => ({day: day, humanDay: parseDay(day)}))
}
export const getLecturers = (classTimes) => {
    const array = classTimes.map(classTime => ({name: classTime.lecturerName, id: classTime.lecturerId}))

    //I was too lazy to do it myself :<
    let flags = [], output = [], l = array.length, i;
    for( i=0; i<l; i++) {
        if( flags[array[i].id]) continue;
        flags[array[i].id] = true;
        output.push(array[i]);
    }

    return output;
}

