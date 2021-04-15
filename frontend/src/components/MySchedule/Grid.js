import React, {useContext, useEffect, useState} from "react";
import FullCalendar from "@fullcalendar/react";
import timeGridPlugin from "@fullcalendar/timegrid";
import 'bootstrap/dist/css/bootstrap.min.css'
import AddOfferForm from "./AddOfferForm";
import apollo_client from "../../util/apollo";
import schedulesQuery from "../../queries/shedules.graphql"
import {parseSchedule} from '../../util/courses/parseSchedule'
import {UserContext} from "../../context/User";

const GridFullcalendar = () => {
    const [events, setEvents] = useState([]);
    const [isInfoWindowOpen, setIsInfoWindowOpen] = useState(false);
    const [highlightedEvent, setHighLightedEvent] = useState(null);
    const {user, setUser} = useContext(UserContext);

    useEffect(() => {
        apollo_client.query({query: schedulesQuery}).then(res => setEvents(parseSchedule(res, user)))
    }, [user])

    const handleEventClick= (props) => {
        setHighLightedEvent(props.event)
        setIsInfoWindowOpen(true);
    }

    return (
        <div>
            <FullCalendar
                plugins={[ timeGridPlugin ]}
                initialView="timeGridWeek"
                weekends={false}
                validRange={{
                    start: '2021-03-01',
                    end: '2021-03-07'
                }}
                headerToolbar={{
                    start: '',
                    center: '',
                    end: ''
                }}
                allDaySlot={false}
                dayHeaderFormat={{weekday: 'short'}}
                slotMinTime='08:00:00'
                slotMaxTime='20:00:00'
                eventClick={handleEventClick}
                slotEventOverlap={false}
                expandRows={true}
                events={events}
            />

            {isInfoWindowOpen ?
                <AddOfferForm
                    show={isInfoWindowOpen}
                    onHide={() => setIsInfoWindowOpen(false)}
                    event={highlightedEvent}
                />
                : null}
        </div>
    )
}

export default GridFullcalendar;
