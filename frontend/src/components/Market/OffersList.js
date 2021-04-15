import React, {useContext, useEffect, useState} from "react";
import '../../styles/offer.css'
import OfferElement from "./OfferElement";
import apollo_client from "../../util/apollo";
import offersQuery from '../../queries/offers.graphql';
import {parseOffers} from "../../util/offer/offerParser";
import {FiltersContext} from "../../context/Filters";


const OffersList = () => {
    const [offers, setOffers] = useState([]);
    const { filters } = useContext(FiltersContext);

    useEffect(() => {
        const lec = filters.lecturer.split(" ")
        apollo_client
        .query({query: offersQuery, variables: {
                course: filters.course,
                firstName: lec[0],
                lastName: lec[1],
                day: filters.day
        }})
        .then(result => setOffers(parseOffers(result.data)));
    }, [filters])

    const htmlList = offers.map((offer) => <OfferElement key={offer.id} props={offer} />);

    return (
        <>
            <div className="row-cols-1 text-center mt-4">
                <h2>Offers</h2>
            </div>
            <div className="row mt-3">
                {htmlList}
            </div>
        </>

    )
}

export default OffersList;
