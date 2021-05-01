import React from "react";
import Home from "../components/Home/Home";
import Market from "../components/Market/Market";
import MySchedule from "../components/MySchedule/MySchedule";
import RequestsPanel from "../components/Requests/RequestsPanel";

export const protectedRoutes = [
    {
        path: "/my-schedule",
        exact: true,
        component: MySchedule,
    },
    {
        path: "/market",
        exact: true,
        component: Market,
    },
    {
        path: "/requests",
        exact: true,
        component: RequestsPanel,
    },

];

export const openRoutes = [
    {
        path: "/",
        exact: true,
        component: Home,
    },
];
