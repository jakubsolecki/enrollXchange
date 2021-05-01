import React from "react";
import {Link} from "react-router-dom";

const LecturerHome = ({user}) => {
    return (
        <div className="text-center">
            <h2 style={{color: "white"}}>Witaj {user.username}!</h2>
            <Link to="/requests">
                <button className="btn btn-outline-light mt-3" style={{width: '100%'}}>Requesty</button>
            </Link>
            <a className="btn btn-outline-light mt-5" style={{width: '100%'}}
               href="/accounts/logout">Wyloguj</a>
        </div>
    )
}

export default LecturerHome;
