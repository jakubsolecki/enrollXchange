import React, {useContext} from "react";
import { Col, Container, Row} from "react-bootstrap";
import '../../styles/home.css';
import {UserContext} from "../../context/User";
import {Link} from "react-router-dom";
import StudentHome from "./StudentHome";
import LecturerHome from "./LecturerHome";

const Home = () => {
    const { user, _setUser } = useContext(UserContext);
    return (
        <div className="bg-image">
            <Container className="image-container" >
                <Row className="row-login">
                    <Col className="col-6 offset-3 col-login">
                        <div className="text-center title">enrollXchange</div>
                        <div className="mt-5 d-flex flex-column justify-content-around">
                            {!user ?
                                (
                                    <a className="btn btn-outline-light" style={{width: '100%'}}
                                    href="/accounts/login">Zaloguj</a>)
                                : (
                                    user.userType === "A_3" ?
                                        <LecturerHome user={user}/>
                                    :
                                        <StudentHome user={user}/>
                                )
                            }
                        </div>
                    </Col>

                </Row>
            </Container>
        </div>
    )
}

export default Home;
