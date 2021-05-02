import {parseDay} from "./weekDays";

const parseOffer = (node) => {
    node = node['node'];
    return {
        id: node['id'],
        title: node['enrollment']['classTime']['course']['code'],
        fullName: node['enrollment']['classTime']['course']['fullName'],
        lecturer: node['enrollment']['classTime']['lecturer']['fullName'],
        day: parseDay(node['enrollment']['classTime']['day']),
        time: node['enrollment']['classTime']['start'].substr(0,5),
        comment: node['comment'],
    }
};

const parseOffers = (queryResult) => {
    // TODO remove hardcoded query name ?
    return queryResult['matchingOffers']['edges'].map(offer => parseOffer(offer));
};

const parseExchange = (node) => {
    node = node['node'];
    return {
        id: node.id,
        title: node.course.code,
        lecturer: node.lecturer.fullName,
        day: parseDay(node.day),
        time: node.start.substr(0,5),
    }
}

const parseMyOffers = (queryResult, user) => {
    if (user === null){
        return [];
    }
    const parseNode = (node) => {
        node = node['node'];
        console.log(node)
        return {
            id: node['id'],
            title: node['enrollment']['classTime']['course']['code'],
            lecturer: node['enrollment']['classTime']['lecturer']['fullName'],
            day: parseDay(node['enrollment']['classTime']['day']),
            time: node['enrollment']['classTime']['start'].substr(0,5),
            exchangeTo: node['exchangeTo']['edges'].map(exchange => parseExchange(exchange)),
            student: node["enrollment"]["student"]["username"]
        }
    }
    // TODO remove hardcoded query name
    return queryResult['offers']['edges'].map(myOffer => parseNode(myOffer))
        .filter(myOffer => myOffer.student === user.username);
}

export {parseOffers, parseMyOffers};
