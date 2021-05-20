import React, {useState} from "react";
import {Button, Modal} from "react-bootstrap";
import {SlideDown} from "react-slidedown";
import RequestTarget from "./RequestTarget";
import apollo_client from "../../util/apollo";
import acceptMutation from "../../mutations/accept_request.graphql"

const RequestElement = ({request}) => {
    console.log(request)
    const [closed, setClosed] = useState(true);
    const [showInfo, setShowInfo] = useState(false);
    const handleClick = () => setClosed(prevState => !prevState)

    const acceptRequest = () => {
        apollo_client.mutate({mutation: acceptMutation, variables: {
            offerId: request.id
        }}).then(() => location.reload())
    }

    return (
        <>
            <div className="row mt-3">
                <div className="col-8 offset-2 offer-element d-flex justify-content-between align-items-center">
                    <div className="ml-4">
                        {request.code} {request.lecturer} {request.humanDay} {request.start}
                    </div>

                    <div className="mr-4">
                        <Button variant="info" className="mr-3" onClick = {() => setShowInfo(true)}>Powód</Button>
                        <Button variant="success" className="mr-3" onClick={handleClick}>
                            {closed ? "Więcej" : "Zamknij"}
                        </Button>

                    </div>
                </div>
            </div>
            <div className="row">
                <div className="col-8 offset-2 slider">
                    <SlideDown closed={closed}>
                        <ul className="list-group list-group-mine list-group-flush">
                            {request.exchangeTo.map(classTime => <RequestTarget key={classTime.id} props={classTime} />)}
                        </ul>
                    </SlideDown>
                </div>
            </div>
            <Modal
                show={showInfo}
                onHide={() => setShowInfo(false)}
                size="lg"
                aria-labelledby="contained-modal-title-vcenter"
                centered>
                <Modal.Header closeButton>
                    <Modal.Title id="contained-modal-title-vcenter">
                        Powód
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <p>
                        {request.comment}
                    </p>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="success" className="mr-3" onClick={acceptRequest}>Akceptuj</Button>
                    <Button variant="danger">Odrzuć</Button>
                </Modal.Footer>
            </Modal>
        </>
    )
}

export default RequestElement;
