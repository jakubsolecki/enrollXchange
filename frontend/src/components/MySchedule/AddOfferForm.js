import React, {useEffect, useState} from "react";
import 'bootstrap/dist/css/bootstrap.min.css'
import Modal from 'react-bootstrap/Modal'
import {Button, Form, Col} from "react-bootstrap";
import apollo_client from "../../util/apollo";
import schedulesQuery from "../../queries/shedules.graphql";
import {parseSchedule, parseScheduleByClass} from "../../util/courses/parseSchedule";
import offerMutation from '../../mutations/offer.graphql';

const AddOfferForm = (props) => {
    const [classes, setClasses] = useState([]);
    const [pickedClass, setPickedClass] = useState("");
    const [comment, setComment] = useState("");
    useEffect(() => {
        apollo_client.query({query: schedulesQuery}).then(res => setClasses(parseScheduleByClass(res, props.event.extendedProps.fullName)))
    }, [])

    const handlePick = (event) => {
        setPickedClass(event.target.value);
    }

    const handleComment = (event) => {
        setComment(event.target.value)
    }

    const handleSubmit = () => {
        if (pickedClass !== ""){
            apollo_client.mutate({mutation: offerMutation, variables: {
                "classTimeId": pickedClass, "comment": comment, "enrollmentId": props.event.extendedProps.enrollmentId,
            }}).then(res => console.log(res)).then(() => props.onHide()).then(() => location.reload())
        }
    }


    const list = classes.map(c => <option key={c.classTimeId} value={c.classTimeId}>{c.day} {c.start}</option>)
    return (
        <Modal show={props.show} onHide={props.onHide}>
            <Modal.Header closeButton>
                <Modal.Title>Szczegóły terminu</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Col>
                    <b>Twój termin:</b>
                    <div>{props.event.title}</div>
                </Col>
                <hr/>
                <Col>
                    <Form>
                        <Form.Group controlId="AddOfferForm.daySelect">
                            <Form.Label><span style={{color: 'black'}}>Wybierz termin</span></Form.Label>
                            <Form.Control as='select' custom onChange={handlePick}>
                                <option value="">Wybierz termin</option>
                                {list}
                            </Form.Control>
                        </Form.Group>
                        <Form.Group controlId="AddOfferForm.commentTextArea">
                            <Form.Label><span style={{color: 'black'}}>Komentarz</span></Form.Label>
                            <Form.Control as="textarea" rows={2} onChange={handleComment} />
                        </Form.Group>
                    </Form>
                </Col>

            </Modal.Body>
            <Modal.Footer>
                <Button variant="danger" type="submit" onClick={handleSubmit}>Złóż ofertę zamiany</Button>
            </Modal.Footer>
        </Modal>
    )
}

export default AddOfferForm;
