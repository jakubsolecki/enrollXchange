import React, {useState} from 'react';
const FiltersContext = React.createContext({filters: {}, setFilters: () => {}});


const FiltersProvider = ({children}) => {
    const [filters, setFilters] = useState({
        course: "",
        lecturer: "",
        day: ""
    });

    return (
        <FiltersContext.Provider value={{filters, setFilters}}>
            {children}
        </FiltersContext.Provider>
    )
}

export { FiltersContext, FiltersProvider};
