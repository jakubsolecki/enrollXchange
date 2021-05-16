import React, {useEffect, useState} from "react";
import 'bootstrap/dist/css/bootstrap.min.css'
import Modal from 'react-bootstrap/Modal'
import {Button, Form, Col} from "react-bootstrap";
import apollo_client from "../../util/apollo";
import classTimesQuery from "../../queries/class_times.graphql";

import {getDays, getLecturers, parseClassTimes} from "../../util/addForm/classTimes";

const AddOfferForm = (props) => {
    const [pickedClasses, setPickedClasses] = useState([]);
    const [classTimes, setClassTimes] = useState([])
    const [filters, setFilters] = useState({
        day: "",
        start: "",
        lecturer: "",
    })
    const enrollmentId = props.event.extendedProps.enrollmentId;
    const fullName = props.event.extendedProps.fullName;
    const classTimeId = props.event.extendedProps.classTimeId;

    console.log(classTimes)

    useEffect(() => {
       apollo_client.query({query: classTimesQuery, variables: {course_FullName: fullName}})
           .then(data => parseClassTimes(data, classTimeId))
           .then(data => setClassTimes(data))
    }, [])

    useEffect(() => {
        setPickedClasses(classTimes
            .filter(time => !filters.day || time.day === filters.day)
            .filter(time => !filters.lecturer || time.lecturerId === filters.lecturer)
        )
    }, [classTimes, filters])

    const handleChange = (event) => {
        setFilters(prev => ({
            ...prev,
            [event.target.id]: event.target.value
        }))
    }

    return (
        <Modal show={props.show} onHide={props.onHide} size="lg">
            <Modal.Header closeButton>
                <Modal.Title>Szczegóły terminu</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <div className="row mb-4">
                    <div className="col-12">
                        <b>Twój termin:</b>
                        <div>{props.event.title}</div>
                        <div>{props.event.extendedProps.day} {props.event.extendedProps.start}</div>
                    </div>
                </div>
                <div className="row">
                    <div className="col-6">
                        <h3>Ustawienia</h3>
                        <Form.Label>Dzień tygodnia</Form.Label>
                        <Form.Control as="select" custom onChange={handleChange} id="day">
                            <option value="">Dowolny</option>
                            {getDays(classTimes).map(day => <option value={day.day} key={day.day}>{day.humanDay}</option>)}
                        </Form.Control>

                        <Form.Label>Prowadzący</Form.Label>
                        <Form.Control as="select" custom onChange={handleChange} id="lecturer">
                            <option value="">Dowolny</option>
                            {getLecturers(classTimes).map(lecturer => <option value={lecturer.id} key={lecturer.id}>{lecturer.name}</option>)}
                        </Form.Control>
                    </div>
                    <div className="col-6">
                        <h3>Wybrane terminy</h3>
                        <ul className="list-group">
                            {pickedClasses
                                .map(classTime => <li className="list-group-item" key={classTime.id}>
                                    {classTime.lecturerName}{' '}
                                    {classTime.humanName}{' '}
                                    {classTime.start}
                                </li>)}
                        </ul>
                    </div>
                </div>

            </Modal.Body>
            <Modal.Footer>
                <Button variant="danger" type="submit" onClick={props.onHide}>Złóż ofertę zamiany</Button>
            </Modal.Footer>
        </Modal>
    )
}

export default AddOfferForm;
