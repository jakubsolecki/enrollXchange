import React from "react";
import OffersList from "./OffersList";
import Filters from "./Filters";
import {FiltersProvider} from "../../context/Filters";


const Market = () => {
    return (
        <div className="container mt-4">
            <FiltersProvider>
                <div className="row-cols-1 text-center">
                    <h2>Filtry</h2>
                </div>
                <div className="row-cols-1">
                    <div className="d-flex justify-content-center">
                        <Filters />
                    </div>
                </div>
                <OffersList />
            </FiltersProvider>
        </div>
    )
}

export default Market;
