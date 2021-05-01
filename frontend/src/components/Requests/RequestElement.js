import React, {useState} from "react";
import {Button} from "react-bootstrap";
import {SlideDown} from "react-slidedown";

const RequestElement = ({request}) => {
    const [closed, setClosed] = useState(true);
    const handleClick = () => setClosed(prevState => !prevState)
    return (
        <>
            <div className="row mt-3">
                <div className="col-8 offset-2 offer-element d-flex justify-content-between align-items-center">
                    <div className="ml-4">
                        {request.title}
                    </div>

                    <div className="mr-4">
                        <Button variant="success" className="mr-3" onClick={handleClick}>
                            {closed ? "Więcej" : "Zamknij"}
                        </Button>
                        <Button variant="danger">Usuń</Button>
                    </div>
                </div>
            </div>
            <div className="row">
                <div className="col-8 offset-2 slider">
                    <SlideDown closed={closed}>
                        <div style={{padding: "1rem", textAlign: "left"}}>
                            {request.description}
                        </div>
                    </SlideDown>
                </div>
            </div>
        </>
    )
}

export default RequestElement;
