import React, {useEffect, useState} from 'react';
import apollo_client from "../util/apollo";
import meQuery from "../queries/me.graphql";

const UserContext = React.createContext({user: {}, setUser: () => {}});


const UserProvider = ({children}) => {
    const [user, setUser] = useState(null);
    useEffect(() => {
        apollo_client.query({query: meQuery})
            .then(result => result.data)
            .then(data => {
                setUser(data.me)
            })
    }, [])

    return (
        <UserContext.Provider value={{user, setUser}}>
            {children}
        </UserContext.Provider>
    )
}

export { UserContext, UserProvider};
