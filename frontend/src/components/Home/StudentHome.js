import React from "react";
import {Link} from "react-router-dom";

const StudentHome = ({user}) => {
    return (
        <div className="text-center">
            <h2 style={{color: "white"}}>Witaj {user.username}!</h2>
            <Link to="/my-schedule">
                <button className="btn btn-outline-light mt-3" style={{width: '100%'}}>Mój podział</button>
            </Link>
            <Link to="/market">
                <button className="btn btn-outline-light mt-5" style={{width: '100%'}}>Giełda</button>
            </Link>
            <a className="btn btn-outline-light mt-5" style={{width: '100%'}}
               href="/accounts/logout">Wyloguj</a>
        </div>
    )
}

export default StudentHome;
