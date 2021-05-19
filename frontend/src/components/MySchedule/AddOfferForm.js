import React, {useEffect, useState} from "react";
import 'bootstrap/dist/css/bootstrap.min.css'
import Modal from 'react-bootstrap/Modal'
import {Button, Form} from "react-bootstrap";
import apollo_client from "../../util/apollo";
import classTimesQuery from "../../queries/class_times.graphql";
import addOfferWithAny from '../../mutations/add_offer_with_any.graphql';
import requestMutation from '../../mutations/request.graphql';

import {getDays, getLecturers, getStartTimes, parseClassTimes} from "../../util/addForm/classTimes";

const AddOfferForm = (props) => {
    const [pickedClasses, setPickedClasses] = useState([]);
    const [classTimes, setClassTimes] = useState([])
    const [filters, setFilters] = useState({
        day: "",
        start: "",
        lecturer: "",
    })
    const [comment, setComment] = useState("");
    const [request, setRequest] = useState(false);
    const [requestClassTimeId, setRequestClassTimeId] = useState("");

    const enrollmentId = props.event.extendedProps.enrollmentId;
    const fullName = props.event.extendedProps.fullName;
    const classTimeId = props.event.extendedProps.classTimeId;

    useEffect(() => {
       apollo_client.query({query: classTimesQuery, variables: {course_FullName: fullName}})
           .then(data => parseClassTimes(data, classTimeId))
           .then(data => setClassTimes(data))
    }, [])

    useEffect(() => {
        setPickedClasses(classTimes
            .filter(time => !filters.day || time.day === filters.day)
            .filter(time => !filters.lecturer || time.lecturerId === filters.lecturer)
            .filter(time => !filters.start || time.start === filters.start)
        )
    }, [classTimes, filters])

    const handleChange = (event) => {
        setFilters(prev => ({
            ...prev,
            [event.target.id]: event.target.value
        }))
    }

    const handleRequest = (event) => {
        setRequest(event.target.checked)
    }

    const handleComment = (event) => {
        setComment(event.target.value)
    }

    const handleSubmit = () => {
        if (request) {
            console.log({
                classTimeId: requestClassTimeId,
                enrollmentId: enrollmentId,
                comment: comment
            })
            if (requestClassTimeId !== ""){
                apollo_client.mutate({mutation: requestMutation, variables: {
                    classTimeId: requestClassTimeId,
                    enrollmentId: enrollmentId,
                    comment: comment
                }}).then(() => location.reload())
                props.onHide();
            }
        } else {
            if (pickedClasses.length !== 0){
                let variables = {
                    enrollmentId: enrollmentId,
                    comment: comment,
                }
                if (filters.day) variables['day'] = filters.day
                if (filters.start) variables['start'] = filters.start
                if (filters.lecturer) variables['lecturerId'] = filters.lecturer

                console.log(variables);

                apollo_client.mutate({mutation: addOfferWithAny, variables: variables})
                    .then(() => location.reload())
                props.onHide();
            }
        }
    }

    return (
        <Modal show={props.show} onHide={props.onHide} size="lg">
            <Modal.Header closeButton>
                <Modal.Title>Szczegóły terminu</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <div className="row">
                    <div className="col-12">
                        <b>Twój termin:</b>
                        <div>{props.event.title}</div>
                        <div>{props.event.extendedProps.day} {props.event.extendedProps.start}</div>
                        <div className="mt-2">
                            <div className="custom-control custom-switch">
                                <input type="checkbox" className="custom-control-input" id="customSwitch1"
                                    onChange={handleRequest}/>
                                    <label className="custom-control-label" htmlFor="customSwitch1">
                                        Request do prowadzącego
                                    </label>
                            </div>
                        </div>
                        {request &&
                        <div className="alert alert-warning alert-dismissible fade show mt-2" role="alert">
                            <strong>UWAGA</strong> Request trafi bezpośrednio do prowadzącego
                        </div>}

                    </div>
                </div>
                <div className="row mt-3">

                    {
                        !request ? (
                            <>
                                <div className="col-6">
                                    <h3>Ustawienia</h3>
                                    <Form.Label>Dzień tygodnia</Form.Label>
                                    <Form.Control as="select" custom onChange={handleChange} id="day">
                                        <option value="">Dowolny</option>
                                        {getDays(classTimes).map(day => <option value={day.day} key={day.day}>{day.humanDay}</option>)}
                                    </Form.Control>

                                    <Form.Label>Godzina</Form.Label>
                                    <Form.Control as="select" custom onChange={handleChange} id="start">
                                        <option value="">Dowolny</option>
                                        {getStartTimes(classTimes).map(start => <option value={start} key={start}>{start}</option>)}
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
                            </>

                        ) : (
                            <div className="col-12">
                                <Form.Label>Termin</Form.Label>
                                <Form.Control as="select" custom id="classTime" onChange={event => setRequestClassTimeId(event.target.value)}>
                                    <option value="">Dowolny</option>
                                    {classTimes.map(classTime => <option value={classTime.id} key={classTime.id}>
                                        {classTime.lecturerName}{' '}
                                        {classTime.humanName}{' '}
                                        {classTime.start}</option>)}
                                </Form.Control>
                            </div>
                        )

                    }






                </div>
                <div className="row mt-4">
                    <div className="col-12">
                        <Form.Group controlId="AddOfferForm.commentTextArea">
                            <Form.Label><span style={{color: 'black'}}>Komentarz</span></Form.Label>
                            <Form.Control as="textarea" rows={2} value={comment} onChange={handleComment} />
                        </Form.Group>
                    </div>

                </div>

            </Modal.Body>
            <Modal.Footer>
                <Button variant="danger" type="submit" onClick={handleSubmit}>Zatwierdź</Button>
            </Modal.Footer>
        </Modal>
    )
}

export default AddOfferForm;
