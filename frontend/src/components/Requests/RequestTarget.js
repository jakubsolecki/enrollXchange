import React from "react";

const RequestTarget = ({props}) => {
    return (
        <li className="list-group-item">
            <div className="d-flex justify-content-between align-items-center">
                <div className="ml-4">
                    {props.code} {props.lecturer}
                </div>

                <div className="mr-4">
                        <span>
                            {props.humanDay}{' '}{props.start}
                        </span>
                </div>
            </div>
        </li>
    )
}

export default RequestTarget;
