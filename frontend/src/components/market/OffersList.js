import React, {useEffect, useState} from "react";
import '../../styles/offer.css'
import {data} from './Data'
import OfferElement from "./OfferElement";


const OffersList = () => {
    const [offers, setOffers] = useState([]);

    useEffect(() => {
        // TODO Replace with fetch
        setOffers(data)
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