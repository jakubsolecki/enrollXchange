import React, {useEffect, useState} from "react";
import RequestElement from "./RequestElement";
import studentRequests from '../../queries/requests_to_me.graphql'
import apollo_client from "../../util/apollo";
import {parseRequests} from "../../util/requests/requestsParser";

const RequestsPanel = () => {
    const [requests, setRequests] = useState([])

    useEffect(() => {
        apollo_client.query({query: studentRequests})
            .then(data => parseRequests(data)).then(data => setRequests(data))
    }, [])

    return (
        <div className="container mt-4">
            <div className="row-cols-1 text-center">
                <h2>Requesty</h2>
            </div>
            <div>
                {requests.map(request => <RequestElement key={request.id} request={request} /> )}
            </div>
        </div>
    )
}

export default RequestsPanel;
