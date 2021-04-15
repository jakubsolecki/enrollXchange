import React, {useContext, useEffect, useState} from "react";
import {FiltersContext} from "../../context/Filters";
import {Form} from "react-bootstrap";
import apollo_client from "../../util/apollo";
import lecturersQuery from '../../queries/lecturers.graphql'
import coursesQuery from '../../queries/courses.graphql'
import {parseCourses, parseLecturers} from "../../util/filters/filters";
import {parseDay, weekDays} from "../../util/offer/weekDays";

const FilterElement = ({name, d_key}) => {
    const { filters, setFilters } = useContext(FiltersContext);
    const [options, setOptions] = useState([]);

    useEffect(() => {
        switch (d_key){
            case "course": apollo_client.query({query: coursesQuery})
                .then(res => setOptions(parseCourses(res))); break;
            case "lecturer": apollo_client.query({query: lecturersQuery})
                .then(res => setOptions(parseLecturers(res))); break;
            case "day": setOptions(Object.entries(weekDays).map(day => day[0])); break;
        }
    }, [])

    let optionsElements;
    switch (d_key) {
        case "course":
            optionsElements = options
                .map(option => <option value={option.fullName} key={option.code}>{option.code}</option>);
            break
        case "lecturer":
            optionsElements = options
                .map(option => <option value={option} key={option}>{option}</option>);
            break
        case "day":
            optionsElements = options
                .map(option => <option value={option} key={option}>{parseDay(option)}</option>);
            break
    }

    const handleChange = (event) => {
        const updatedValue = {};
        updatedValue[d_key] = event.target.value;
        setFilters(prev => ({
            ...prev,
            ...updatedValue,
        }))
    }

    return (
        <div className="m-2">
            <Form>
                <Form.Control size="sm" as="select" onChange={handleChange}>
                    <option value={""}>{name}</option>
                    {optionsElements}
                </Form.Control>
            </Form>
        </div>
    )
}

export default FilterElement;
