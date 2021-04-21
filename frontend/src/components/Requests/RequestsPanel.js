import React, {useState} from "react";
import {Button} from "react-bootstrap";
import {SlideDown} from "react-slidedown";
import RequestElement from "./RequestElement";

const RequestsPanel = () => {
    const request = {
        title: "TOiZO Zajęcia jakieś tam nwm o co chodzi .-.",
        description: "Panie doktorze niech Pan mnie przeniesie do innej grupy bo mam prace a w ogóle to nie chce mi sie tego uczyc i nwm o co w tym chodzi :("
    };

    return (
        <div className="container mt-4">
            <div className="row-cols-1 text-center">
                <h2>Requesty</h2>
            </div>
            <div>
                <RequestElement request={request} />
                <RequestElement request={request} />
                <RequestElement request={request} />
                <RequestElement request={request}/>
            </div>
        </div>
    )
}

export default RequestsPanel;
