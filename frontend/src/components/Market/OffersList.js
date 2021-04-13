import React, {useEffect, useState} from "react";
import '../../styles/offer.css'
import OfferElement from "./OfferElement";
import apollo_client from "../../util/apollo";
import offersQuery from '../../queries/offers.graphql';
import parseOffers from "../../util/offer/offerParser";


const OffersList = () => {
    const [offers, setOffers] = useState([]);

    useEffect(() => {
        apollo_client
        .query({query: offersQuery})
        .then(result => setOffers(parseOffers(result.data)));
    }, [])

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
