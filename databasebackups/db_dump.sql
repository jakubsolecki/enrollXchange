--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Debian 13.2-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Debian 13.2-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.graphql_auth_userstatus DROP CONSTRAINT graphql_auth_userstatus_user_id_3feef183_fk_enroll_user_id;
ALTER TABLE ONLY public.enroll_user_user_permissions DROP CONSTRAINT enroll_user_user_permissions_user_id_5d6fdff0_fk_enroll_user_id;
ALTER TABLE ONLY public.enroll_user_user_permissions DROP CONSTRAINT enroll_user_user_per_permission_id_18ff09ab_fk_auth_perm;
ALTER TABLE ONLY public.enroll_user_groups DROP CONSTRAINT enroll_user_groups_user_id_ded9e499_fk_enroll_user_id;
ALTER TABLE ONLY public.enroll_user_groups DROP CONSTRAINT enroll_user_groups_group_id_467a24df_fk_auth_group_id;
ALTER TABLE ONLY public.enroll_offer_exchange_to DROP CONSTRAINT enroll_offer_exchange_to_offer_id_7569f7da_fk_enroll_offer_id;
ALTER TABLE ONLY public.enroll_offer_exchange_to DROP CONSTRAINT enroll_offer_exchang_classtime_id_3dbdb22e_fk_enroll_cl;
ALTER TABLE ONLY public.enroll_offer DROP CONSTRAINT enroll_offer_enrollment_id_65ff1994_fk_enroll_enrollment_id;
ALTER TABLE ONLY public.enroll_lecturer DROP CONSTRAINT enroll_lecturer_account_id_50806509_fk_enroll_user_id;
ALTER TABLE ONLY public.enroll_enrollment DROP CONSTRAINT enroll_enrollment_student_id_da1bd0db_fk_enroll_user_id;
ALTER TABLE ONLY public.enroll_enrollment DROP CONSTRAINT enroll_enrollment_class_time_id_d528c16a_fk_enroll_classtime_id;
ALTER TABLE ONLY public.enroll_classtime DROP CONSTRAINT enroll_classtime_lecturer_id_407bbc81_fk_enroll_lecturer_id;
ALTER TABLE ONLY public.enroll_classtime DROP CONSTRAINT enroll_classtime_course_id_a6e9511a_fk_enroll_course_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_enroll_user_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX public.enroll_user_username_a600390d_like;
DROP INDEX public.enroll_user_user_permissions_user_id_5d6fdff0;
DROP INDEX public.enroll_user_user_permissions_permission_id_18ff09ab;
DROP INDEX public.enroll_user_groups_user_id_ded9e499;
DROP INDEX public.enroll_user_groups_group_id_467a24df;
DROP INDEX public.enroll_offer_exchange_to_offer_id_7569f7da;
DROP INDEX public.enroll_offer_exchange_to_classtime_id_3dbdb22e;
DROP INDEX public.enroll_offer_enrollment_id_65ff1994;
DROP INDEX public.enroll_enrollment_student_id_da1bd0db;
DROP INDEX public.enroll_enrollment_class_time_id_d528c16a;
DROP INDEX public.enroll_classtime_lecturer_id_407bbc81;
DROP INDEX public.enroll_classtime_course_id_a6e9511a;
DROP INDEX public.django_session_session_key_c0390e0f_like;
DROP INDEX public.django_session_expire_date_a5c62663;
DROP INDEX public.django_admin_log_user_id_c564eba6;
DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX public.auth_permission_content_type_id_2f476e4b;
DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX public.auth_group_name_a6ea08ec_like;
ALTER TABLE ONLY public.graphql_auth_userstatus DROP CONSTRAINT graphql_auth_userstatus_user_id_key;
ALTER TABLE ONLY public.graphql_auth_userstatus DROP CONSTRAINT graphql_auth_userstatus_pkey;
ALTER TABLE ONLY public.enroll_user DROP CONSTRAINT enroll_user_username_key;
ALTER TABLE ONLY public.enroll_user_user_permissions DROP CONSTRAINT enroll_user_user_permissions_pkey;
ALTER TABLE ONLY public.enroll_user_user_permissions DROP CONSTRAINT enroll_user_user_permiss_user_id_permission_id_fba82a36_uniq;
ALTER TABLE ONLY public.enroll_user DROP CONSTRAINT enroll_user_pkey;
ALTER TABLE ONLY public.enroll_user_groups DROP CONSTRAINT enroll_user_groups_user_id_group_id_44f7d5ac_uniq;
ALTER TABLE ONLY public.enroll_user_groups DROP CONSTRAINT enroll_user_groups_pkey;
ALTER TABLE ONLY public.enroll_offer DROP CONSTRAINT enroll_offer_pkey;
ALTER TABLE ONLY public.enroll_offer_exchange_to DROP CONSTRAINT enroll_offer_exchange_to_pkey;
ALTER TABLE ONLY public.enroll_offer_exchange_to DROP CONSTRAINT enroll_offer_exchange_to_offer_id_classtime_id_923437c7_uniq;
ALTER TABLE ONLY public.enroll_lecturer DROP CONSTRAINT enroll_lecturer_pkey;
ALTER TABLE ONLY public.enroll_lecturer DROP CONSTRAINT enroll_lecturer_account_id_key;
ALTER TABLE ONLY public.enroll_enrollment DROP CONSTRAINT enroll_enrollment_student_id_class_time_id_e46b8460_uniq;
ALTER TABLE ONLY public.enroll_enrollment DROP CONSTRAINT enroll_enrollment_pkey;
ALTER TABLE ONLY public.enroll_course DROP CONSTRAINT enroll_course_pkey;
ALTER TABLE ONLY public.enroll_classtime DROP CONSTRAINT enroll_classtime_pkey;
ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
ALTER TABLE public.graphql_auth_userstatus ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_user_user_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_user_groups ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_user ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_offer_exchange_to ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_offer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_lecturer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_enrollment ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_course ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enroll_classtime ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.graphql_auth_userstatus_id_seq;
DROP TABLE public.graphql_auth_userstatus;
DROP SEQUENCE public.enroll_user_user_permissions_id_seq;
DROP TABLE public.enroll_user_user_permissions;
DROP SEQUENCE public.enroll_user_id_seq;
DROP SEQUENCE public.enroll_user_groups_id_seq;
DROP TABLE public.enroll_user_groups;
DROP TABLE public.enroll_user;
DROP SEQUENCE public.enroll_offer_id_seq;
DROP SEQUENCE public.enroll_offer_exchange_to_id_seq;
DROP TABLE public.enroll_offer_exchange_to;
DROP TABLE public.enroll_offer;
DROP SEQUENCE public.enroll_lecturer_id_seq;
DROP TABLE public.enroll_lecturer;
DROP SEQUENCE public.enroll_enrollment_id_seq;
DROP TABLE public.enroll_enrollment;
DROP SEQUENCE public.enroll_course_id_seq;
DROP TABLE public.enroll_course;
DROP SEQUENCE public.enroll_classtime_id_seq;
DROP TABLE public.enroll_classtime;
DROP TABLE public.django_session;
DROP SEQUENCE public.django_migrations_id_seq;
DROP TABLE public.django_migrations;
DROP SEQUENCE public.django_content_type_id_seq;
DROP TABLE public.django_content_type;
DROP SEQUENCE public.django_admin_log_id_seq;
DROP TABLE public.django_admin_log;
DROP SEQUENCE public.auth_permission_id_seq;
DROP TABLE public.auth_permission;
DROP SEQUENCE public.auth_group_permissions_id_seq;
DROP TABLE public.auth_group_permissions;
DROP SEQUENCE public.auth_group_id_seq;
DROP TABLE public.auth_group;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: enroll_classtime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_classtime (
    id integer NOT NULL,
    day character varying(10) NOT NULL,
    frequency smallint NOT NULL,
    start time without time zone NOT NULL,
    duration_minutes integer NOT NULL,
    seats integer NOT NULL,
    course_id integer,
    lecturer_id integer,
    CONSTRAINT enroll_classtime_duration_minutes_check CHECK ((duration_minutes >= 0)),
    CONSTRAINT enroll_classtime_frequency_check CHECK ((frequency >= 0)),
    CONSTRAINT enroll_classtime_seats_check CHECK ((seats >= 0))
);


ALTER TABLE public.enroll_classtime OWNER TO postgres;

--
-- Name: enroll_classtime_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_classtime_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_classtime_id_seq OWNER TO postgres;

--
-- Name: enroll_classtime_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_classtime_id_seq OWNED BY public.enroll_classtime.id;


--
-- Name: enroll_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_course (
    id integer NOT NULL,
    code character varying(40) NOT NULL,
    full_name character varying(100) NOT NULL
);


ALTER TABLE public.enroll_course OWNER TO postgres;

--
-- Name: enroll_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_course_id_seq OWNER TO postgres;

--
-- Name: enroll_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_course_id_seq OWNED BY public.enroll_course.id;


--
-- Name: enroll_enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_enrollment (
    id integer NOT NULL,
    class_time_id integer NOT NULL,
    student_id integer NOT NULL
);


ALTER TABLE public.enroll_enrollment OWNER TO postgres;

--
-- Name: enroll_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_enrollment_id_seq OWNER TO postgres;

--
-- Name: enroll_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_enrollment_id_seq OWNED BY public.enroll_enrollment.id;


--
-- Name: enroll_lecturer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_lecturer (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    account_id integer NOT NULL
);


ALTER TABLE public.enroll_lecturer OWNER TO postgres;

--
-- Name: enroll_lecturer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_lecturer_id_seq OWNER TO postgres;

--
-- Name: enroll_lecturer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_lecturer_id_seq OWNED BY public.enroll_lecturer.id;


--
-- Name: enroll_offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_offer (
    id integer NOT NULL,
    comment character varying(280) NOT NULL,
    active boolean NOT NULL,
    enrollment_id integer NOT NULL
);


ALTER TABLE public.enroll_offer OWNER TO postgres;

--
-- Name: enroll_offer_exchange_to; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_offer_exchange_to (
    id integer NOT NULL,
    offer_id integer NOT NULL,
    classtime_id integer NOT NULL
);


ALTER TABLE public.enroll_offer_exchange_to OWNER TO postgres;

--
-- Name: enroll_offer_exchange_to_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_offer_exchange_to_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_offer_exchange_to_id_seq OWNER TO postgres;

--
-- Name: enroll_offer_exchange_to_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_offer_exchange_to_id_seq OWNED BY public.enroll_offer_exchange_to.id;


--
-- Name: enroll_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_offer_id_seq OWNER TO postgres;

--
-- Name: enroll_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_offer_id_seq OWNED BY public.enroll_offer.id;


--
-- Name: enroll_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    user_type smallint NOT NULL,
    CONSTRAINT enroll_user_user_type_check CHECK ((user_type >= 0))
);


ALTER TABLE public.enroll_user OWNER TO postgres;

--
-- Name: enroll_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.enroll_user_groups OWNER TO postgres;

--
-- Name: enroll_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_user_groups_id_seq OWNER TO postgres;

--
-- Name: enroll_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_user_groups_id_seq OWNED BY public.enroll_user_groups.id;


--
-- Name: enroll_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_user_id_seq OWNER TO postgres;

--
-- Name: enroll_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_user_id_seq OWNED BY public.enroll_user.id;


--
-- Name: enroll_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enroll_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.enroll_user_user_permissions OWNER TO postgres;

--
-- Name: enroll_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enroll_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enroll_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: enroll_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enroll_user_user_permissions_id_seq OWNED BY public.enroll_user_user_permissions.id;


--
-- Name: graphql_auth_userstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.graphql_auth_userstatus (
    id integer NOT NULL,
    verified boolean NOT NULL,
    archived boolean NOT NULL,
    secondary_email character varying(254),
    user_id integer NOT NULL
);


ALTER TABLE public.graphql_auth_userstatus OWNER TO postgres;

--
-- Name: graphql_auth_userstatus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.graphql_auth_userstatus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.graphql_auth_userstatus_id_seq OWNER TO postgres;

--
-- Name: graphql_auth_userstatus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.graphql_auth_userstatus_id_seq OWNED BY public.graphql_auth_userstatus.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: enroll_classtime id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_classtime ALTER COLUMN id SET DEFAULT nextval('public.enroll_classtime_id_seq'::regclass);


--
-- Name: enroll_course id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_course ALTER COLUMN id SET DEFAULT nextval('public.enroll_course_id_seq'::regclass);


--
-- Name: enroll_enrollment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_enrollment ALTER COLUMN id SET DEFAULT nextval('public.enroll_enrollment_id_seq'::regclass);


--
-- Name: enroll_lecturer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_lecturer ALTER COLUMN id SET DEFAULT nextval('public.enroll_lecturer_id_seq'::regclass);


--
-- Name: enroll_offer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer ALTER COLUMN id SET DEFAULT nextval('public.enroll_offer_id_seq'::regclass);


--
-- Name: enroll_offer_exchange_to id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer_exchange_to ALTER COLUMN id SET DEFAULT nextval('public.enroll_offer_exchange_to_id_seq'::regclass);


--
-- Name: enroll_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user ALTER COLUMN id SET DEFAULT nextval('public.enroll_user_id_seq'::regclass);


--
-- Name: enroll_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_groups ALTER COLUMN id SET DEFAULT nextval('public.enroll_user_groups_id_seq'::regclass);


--
-- Name: enroll_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.enroll_user_user_permissions_id_seq'::regclass);


--
-- Name: graphql_auth_userstatus id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graphql_auth_userstatus ALTER COLUMN id SET DEFAULT nextval('public.graphql_auth_userstatus_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_permission VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO public.auth_permission VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO public.auth_permission VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO public.auth_permission VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO public.auth_permission VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO public.auth_permission VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO public.auth_permission VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO public.auth_permission VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO public.auth_permission VALUES (21, 'Can add user status', 6, 'add_userstatus');
INSERT INTO public.auth_permission VALUES (22, 'Can change user status', 6, 'change_userstatus');
INSERT INTO public.auth_permission VALUES (23, 'Can delete user status', 6, 'delete_userstatus');
INSERT INTO public.auth_permission VALUES (24, 'Can view user status', 6, 'view_userstatus');
INSERT INTO public.auth_permission VALUES (25, 'Can add user', 7, 'add_user');
INSERT INTO public.auth_permission VALUES (26, 'Can change user', 7, 'change_user');
INSERT INTO public.auth_permission VALUES (27, 'Can delete user', 7, 'delete_user');
INSERT INTO public.auth_permission VALUES (28, 'Can view user', 7, 'view_user');
INSERT INTO public.auth_permission VALUES (29, 'Can add class time', 8, 'add_classtime');
INSERT INTO public.auth_permission VALUES (30, 'Can change class time', 8, 'change_classtime');
INSERT INTO public.auth_permission VALUES (31, 'Can delete class time', 8, 'delete_classtime');
INSERT INTO public.auth_permission VALUES (32, 'Can view class time', 8, 'view_classtime');
INSERT INTO public.auth_permission VALUES (33, 'Can add course', 9, 'add_course');
INSERT INTO public.auth_permission VALUES (34, 'Can change course', 9, 'change_course');
INSERT INTO public.auth_permission VALUES (35, 'Can delete course', 9, 'delete_course');
INSERT INTO public.auth_permission VALUES (36, 'Can view course', 9, 'view_course');
INSERT INTO public.auth_permission VALUES (37, 'Can add enrollment', 10, 'add_enrollment');
INSERT INTO public.auth_permission VALUES (38, 'Can change enrollment', 10, 'change_enrollment');
INSERT INTO public.auth_permission VALUES (39, 'Can delete enrollment', 10, 'delete_enrollment');
INSERT INTO public.auth_permission VALUES (40, 'Can view enrollment', 10, 'view_enrollment');
INSERT INTO public.auth_permission VALUES (41, 'Can add offer', 11, 'add_offer');
INSERT INTO public.auth_permission VALUES (42, 'Can change offer', 11, 'change_offer');
INSERT INTO public.auth_permission VALUES (43, 'Can delete offer', 11, 'delete_offer');
INSERT INTO public.auth_permission VALUES (44, 'Can view offer', 11, 'view_offer');
INSERT INTO public.auth_permission VALUES (45, 'Can add lecturer', 12, 'add_lecturer');
INSERT INTO public.auth_permission VALUES (46, 'Can change lecturer', 12, 'change_lecturer');
INSERT INTO public.auth_permission VALUES (47, 'Can delete lecturer', 12, 'delete_lecturer');
INSERT INTO public.auth_permission VALUES (48, 'Can view lecturer', 12, 'view_lecturer');


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_admin_log VALUES (1, '2021-04-12 20:29:49.501054+00', '1', 'Algorytmy dla Problemów Trudnych Obliczeniowo', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (2, '2021-04-12 20:32:16.566318+00', '2', 'faliszew (teacher)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (3, '2021-04-12 20:32:21.826525+00', '1', 'Piotr Faliszewski', 1, '[{"added": {}}]', 12, 1);
INSERT INTO public.django_admin_log VALUES (4, '2021-04-12 20:32:27.234888+00', '1', 'Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 06:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (5, '2021-04-12 20:35:06.593399+00', '3', 'denkov (student)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (6, '2021-04-12 20:35:16.180617+00', '1', 'denkov (student) - Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 06:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (7, '2021-04-12 20:35:47.218575+00', '1', 'Offer object (1)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (8, '2021-04-13 14:19:26.390916+00', '3', 'Stanisław (student)', 2, '[{"changed": {"fields": ["Password", "Username"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (9, '2021-04-13 14:19:58.571159+00', '2', 'Piotr (teacher)', 2, '[{"changed": {"fields": ["Password", "Username"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (10, '2021-04-13 14:20:37.286578+00', '4', 'Kacper (student)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (11, '2021-04-13 14:20:46.042485+00', '3', 'Stanisław (student)', 2, '[]', 7, 1);
INSERT INTO public.django_admin_log VALUES (12, '2021-04-13 14:20:49.721154+00', '2', 'Piotr (teacher)', 2, '[]', 7, 1);
INSERT INTO public.django_admin_log VALUES (13, '2021-04-13 14:21:26.17752+00', '5', 'Jan (student)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (14, '2021-04-13 14:22:40.208484+00', '6', 'Marcin (teacher)', 1, '[{"added": {}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (15, '2021-04-13 14:23:14.637742+00', '1', 'Algorytmy dla Problemów Trudnych Obliczeniowo', 2, '[]', 9, 1);
INSERT INTO public.django_admin_log VALUES (16, '2021-04-13 14:23:35.941003+00', '2', 'Algorytmy i Struktury Danych', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (17, '2021-04-13 14:24:26.815135+00', '3', 'Kompetencje Interpersonalne', 1, '[{"added": {}}]', 9, 1);
INSERT INTO public.django_admin_log VALUES (18, '2021-04-13 14:25:11.978811+00', '1', 'Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 2, '[{"changed": {"fields": ["Frequency", "Start"]}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (19, '2021-04-13 14:25:45.926566+00', '2', 'Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (20, '2021-04-13 14:26:05.032128+00', '2', 'Marcin Kurdziel', 1, '[{"added": {}}]', 12, 1);
INSERT INTO public.django_admin_log VALUES (21, '2021-04-13 14:26:41.90149+00', '2', 'Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 2, '[]', 8, 1);
INSERT INTO public.django_admin_log VALUES (22, '2021-04-13 14:27:36.37236+00', '3', 'Algorytmy dla Problemów Trudnych Obliczeniowo | TUESDAY 08:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (23, '2021-04-13 14:28:11.661622+00', '4', 'Algorytmy dla Problemów Trudnych Obliczeniowo | TUESDAY 09:30', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (24, '2021-04-13 14:30:48.341026+00', '5', 'Kompetencje Interpersonalne | WEDNESDAY 08:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (25, '2021-04-13 14:31:15.883109+00', '6', 'Kompetencje Interpersonalne | WEDNESDAY 08:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (26, '2021-04-13 14:32:06.975465+00', '6', 'Kompetencje Interpersonalne | WEDNESDAY 08:00', 2, '[]', 8, 1);
INSERT INTO public.django_admin_log VALUES (27, '2021-04-13 14:32:37.624588+00', '7', 'Algorytmy i Struktury Danych | WEDNESDAY 08:00', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (28, '2021-04-13 14:32:57.871975+00', '8', 'Algorytmy i Struktury Danych | THURSDAY 09:35', 1, '[{"added": {}}]', 8, 1);
INSERT INTO public.django_admin_log VALUES (29, '2021-04-13 14:33:01.996659+00', '8', 'Algorytmy i Struktury Danych | THURSDAY 09:35', 2, '[]', 8, 1);
INSERT INTO public.django_admin_log VALUES (30, '2021-04-13 14:33:05.079982+00', '7', 'Algorytmy i Struktury Danych | WEDNESDAY 08:00', 2, '[]', 8, 1);
INSERT INTO public.django_admin_log VALUES (31, '2021-04-13 14:33:50.668618+00', '2', 'Kacper (student) - Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (32, '2021-04-13 14:34:04.703582+00', '2', 'Kacper (student) - Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 2, '[]', 10, 1);
INSERT INTO public.django_admin_log VALUES (33, '2021-04-13 14:34:12.867304+00', '1', 'Stanisław (student) - Algorytmy dla Problemów Trudnych Obliczeniowo | MONDAY 08:00', 2, '[]', 10, 1);
INSERT INTO public.django_admin_log VALUES (34, '2021-04-13 14:34:24.135424+00', '3', 'Jan (student) - Algorytmy dla Problemów Trudnych Obliczeniowo | TUESDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (35, '2021-04-13 14:34:34.781973+00', '4', 'Kacper (student) - Kompetencje Interpersonalne | WEDNESDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (36, '2021-04-13 14:34:41.697378+00', '5', 'Stanisław (student) - Kompetencje Interpersonalne | WEDNESDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (37, '2021-04-13 14:34:51.023523+00', '6', 'Jan (student) - Kompetencje Interpersonalne | WEDNESDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (38, '2021-04-13 14:35:01.028847+00', '7', 'Kacper (student) - Algorytmy i Struktury Danych | WEDNESDAY 08:00', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (39, '2021-04-13 14:35:10.134736+00', '8', 'Stanisław (student) - Algorytmy i Struktury Danych | THURSDAY 09:35', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (40, '2021-04-13 14:35:17.76081+00', '9', 'Jan (student) - Algorytmy i Struktury Danych | THURSDAY 09:35', 1, '[{"added": {}}]', 10, 1);
INSERT INTO public.django_admin_log VALUES (41, '2021-04-13 14:49:39.012164+00', '1', 'Offer object (1)', 2, '[{"changed": {"fields": ["Exchange to"]}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (42, '2021-04-13 14:50:59.126195+00', '2', 'Offer object (2)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (43, '2021-04-13 14:51:58.222367+00', '3', 'Offer object (3)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (44, '2021-04-13 14:52:35.373087+00', '4', 'Offer object (4)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (45, '2021-04-13 14:53:22.827565+00', '4', 'Offer object (4)', 2, '[{"changed": {"fields": ["Exchange to"]}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (46, '2021-04-13 14:54:33.739498+00', '5', 'Offer object (5)', 1, '[{"added": {}}]', 11, 1);
INSERT INTO public.django_admin_log VALUES (47, '2021-04-13 15:59:06.714714+00', '6', 'Marcin (teacher)', 2, '[{"changed": {"fields": ["Password"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (48, '2021-04-13 15:59:31.505564+00', '5', 'Jan (student)', 2, '[{"changed": {"fields": ["Password"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (49, '2021-04-13 16:00:05.132355+00', '4', 'Kacper (student)', 2, '[{"changed": {"fields": ["Password"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (50, '2021-04-13 16:00:36.408366+00', '3', 'Stanisław (student)', 2, '[{"changed": {"fields": ["Password"]}}]', 7, 1);
INSERT INTO public.django_admin_log VALUES (51, '2021-04-13 16:01:04.947947+00', '2', 'Piotr (teacher)', 2, '[{"changed": {"fields": ["Password"]}}]', 7, 1);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_content_type VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type VALUES (5, 'sessions', 'session');
INSERT INTO public.django_content_type VALUES (6, 'graphql_auth', 'userstatus');
INSERT INTO public.django_content_type VALUES (7, 'enroll', 'user');
INSERT INTO public.django_content_type VALUES (8, 'enroll', 'classtime');
INSERT INTO public.django_content_type VALUES (9, 'enroll', 'course');
INSERT INTO public.django_content_type VALUES (10, 'enroll', 'enrollment');
INSERT INTO public.django_content_type VALUES (11, 'enroll', 'offer');
INSERT INTO public.django_content_type VALUES (12, 'enroll', 'lecturer');


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_migrations VALUES (1, 'contenttypes', '0001_initial', '2021-04-12 20:24:45.424954+00');
INSERT INTO public.django_migrations VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2021-04-12 20:24:45.437087+00');
INSERT INTO public.django_migrations VALUES (3, 'auth', '0001_initial', '2021-04-12 20:24:45.491914+00');
INSERT INTO public.django_migrations VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2021-04-12 20:24:45.50069+00');
INSERT INTO public.django_migrations VALUES (5, 'auth', '0003_alter_user_email_max_length', '2021-04-12 20:24:45.509469+00');
INSERT INTO public.django_migrations VALUES (6, 'auth', '0004_alter_user_username_opts', '2021-04-12 20:24:45.517674+00');
INSERT INTO public.django_migrations VALUES (7, 'auth', '0005_alter_user_last_login_null', '2021-04-12 20:24:45.528257+00');
INSERT INTO public.django_migrations VALUES (8, 'auth', '0006_require_contenttypes_0002', '2021-04-12 20:24:45.532471+00');
INSERT INTO public.django_migrations VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2021-04-12 20:24:45.542023+00');
INSERT INTO public.django_migrations VALUES (10, 'auth', '0008_alter_user_username_max_length', '2021-04-12 20:24:45.551789+00');
INSERT INTO public.django_migrations VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2021-04-12 20:24:45.56279+00');
INSERT INTO public.django_migrations VALUES (12, 'auth', '0010_alter_group_name_max_length', '2021-04-12 20:24:45.572047+00');
INSERT INTO public.django_migrations VALUES (13, 'auth', '0011_update_proxy_permissions', '2021-04-12 20:24:45.58115+00');
INSERT INTO public.django_migrations VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2021-04-12 20:24:45.590539+00');
INSERT INTO public.django_migrations VALUES (15, 'enroll', '0001_initial', '2021-04-12 20:24:45.81687+00');
INSERT INTO public.django_migrations VALUES (16, 'admin', '0001_initial', '2021-04-12 20:24:45.856452+00');
INSERT INTO public.django_migrations VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2021-04-12 20:24:45.870714+00');
INSERT INTO public.django_migrations VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2021-04-12 20:24:45.886282+00');
INSERT INTO public.django_migrations VALUES (19, 'enroll', '0002_auto_20210404_1400', '2021-04-12 20:24:45.931331+00');
INSERT INTO public.django_migrations VALUES (20, 'graphql_auth', '0001_initial', '2021-04-12 20:24:45.962699+00');
INSERT INTO public.django_migrations VALUES (21, 'sessions', '0001_initial', '2021-04-12 20:24:45.981702+00');


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_session VALUES ('b7x0v6r2xj96o4tjy1vfdaj3575kzmvr', '.eJxVjDsOwjAQBe_iGllZf2Kbkp4zRLvrNQmgWIqTCnF3iJQC2jcz76UG3NZx2Josw5TVWYE6_W6E_JB5B_mO861qrvO6TKR3RR-06WvN8rwc7t_BiG381rZI7D2TWEd9DmJAXMgcyGFyAD4Y6hLHEpGBHUNXLHqQZDtIxnhS7w_xLjfG:1lW3AN:cqonxhPQm5SAPXj78ly_o0UDDOJKOdIGjpfRpDTZG0s', '2021-04-26 20:28:15.902629+00');
INSERT INTO public.django_session VALUES ('z7532gsfoeovoordauoihijgeo9c136a', '.eJxVjEEOwiAQRe_C2hBKywy4dO8ZCAODVA0kpV0Z765NutDtf-_9l_BhW4vfOi9-TuIsRnH63SjEB9cdpHuotyZjq-syk9wVedAury3x83K4fwcl9PKtw4jZJCSNWWUFlmJgQ6iijowWDLPRbogGcARtYeBJGSYCcBYn7bR4fwDsSDdb:1lWLf2:ZqnahZ62JKYW3_vLG1jD75Ewsjww7VpXls8P3MWpRUI', '2021-04-27 16:13:08.502999+00');
INSERT INTO public.django_session VALUES ('u5gkuznosnai76ee778ox3197nkxvjj1', '.eJxVjDsOgzAQRO_iOrLAxp9NmZ4zWOvdJSaJQMJQRbl7QKJIypn3Zt4q4baWtFVZ0sjqqlp1-e0y0lOmA_ADp_usaZ7WZcz6UPRJq-5nltftdP8OCtayr9ENHgwgEgeUFsTmwINYsh1AjLAn6zvwJjgjTRcbjuzJsRWyxDmqzxf3kjhW:1lWPpQ:s-r4kyc-1_L8STRlKV8UsoL85wDTPYIue79TcvemtTc', '2021-04-27 20:40:08.53813+00');


--
-- Data for Name: enroll_classtime; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_classtime VALUES (1, 'MONDAY', 2, '08:00:00', 90, 10, 1, 1);
INSERT INTO public.enroll_classtime VALUES (2, 'MONDAY', 3, '08:00:00', 90, 10, 1, 1);
INSERT INTO public.enroll_classtime VALUES (3, 'TUESDAY', 2, '08:00:00', 90, 10, 1, 2);
INSERT INTO public.enroll_classtime VALUES (4, 'TUESDAY', 3, '09:30:00', 90, 10, 1, 2);
INSERT INTO public.enroll_classtime VALUES (5, 'WEDNESDAY', 1, '08:00:00', 90, 10, 3, 1);
INSERT INTO public.enroll_classtime VALUES (6, 'WEDNESDAY', 1, '08:00:00', 90, 10, 3, 2);
INSERT INTO public.enroll_classtime VALUES (8, 'THURSDAY', 1, '09:35:00', 90, 15, 2, 2);
INSERT INTO public.enroll_classtime VALUES (7, 'WEDNESDAY', 1, '08:00:00', 90, 15, 2, 1);


--
-- Data for Name: enroll_course; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_course VALUES (1, 'APTO', 'Algorytmy dla Problemów Trudnych Obliczeniowo');
INSERT INTO public.enroll_course VALUES (2, 'ASD', 'Algorytmy i Struktury Danych');
INSERT INTO public.enroll_course VALUES (3, 'KI', 'Kompetencje Interpersonalne');


--
-- Data for Name: enroll_enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_enrollment VALUES (2, 2, 4);
INSERT INTO public.enroll_enrollment VALUES (1, 1, 3);
INSERT INTO public.enroll_enrollment VALUES (3, 3, 5);
INSERT INTO public.enroll_enrollment VALUES (4, 5, 4);
INSERT INTO public.enroll_enrollment VALUES (5, 5, 3);
INSERT INTO public.enroll_enrollment VALUES (6, 6, 5);
INSERT INTO public.enroll_enrollment VALUES (7, 7, 4);
INSERT INTO public.enroll_enrollment VALUES (8, 8, 3);
INSERT INTO public.enroll_enrollment VALUES (9, 8, 5);


--
-- Data for Name: enroll_lecturer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_lecturer VALUES (1, 'Piotr', 'Faliszewski', 2);
INSERT INTO public.enroll_lecturer VALUES (2, 'Marcin', 'Kurdziel', 6);


--
-- Data for Name: enroll_offer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_offer VALUES (1, 'lorem ipsum', true, 1);
INSERT INTO public.enroll_offer VALUES (2, 'dołożę czekoladę', true, 2);
INSERT INTO public.enroll_offer VALUES (3, 'Dlaczego to pole jest required?', true, 3);
INSERT INTO public.enroll_offer VALUES (4, 'plz', true, 5);
INSERT INTO public.enroll_offer VALUES (5, 'thx in advance', true, 9);


--
-- Data for Name: enroll_offer_exchange_to; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_offer_exchange_to VALUES (2, 1, 2);
INSERT INTO public.enroll_offer_exchange_to VALUES (3, 2, 3);
INSERT INTO public.enroll_offer_exchange_to VALUES (4, 3, 4);
INSERT INTO public.enroll_offer_exchange_to VALUES (6, 4, 6);
INSERT INTO public.enroll_offer_exchange_to VALUES (7, 5, 7);


--
-- Data for Name: enroll_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enroll_user VALUES (6, 'pbkdf2_sha256$260000$S1jHYIjLKVlQJBWlz73YXa$534HshnwLaKUqK+I9iLls3c1lgsSiNd6SxrNrhD1rvA=', '2021-04-13 14:22:10+00', false, 'Marcin', 'Marcin', 'Kurdziel', 'marcin@kurdziel.pl', false, true, '2021-04-13 14:21:34+00', 3);
INSERT INTO public.enroll_user VALUES (5, 'pbkdf2_sha256$260000$hTdEIATLMoNTlxvmavmwOY$oD6mNX46dN7I4OkslVqyjOH/xSsVUntwXFtrGa1bpok=', '2021-04-13 14:21:02+00', false, 'Jan', 'Jan', 'Gargas', 'jan@gargas.pl', false, true, '2021-04-13 14:20:53+00', 2);
INSERT INTO public.enroll_user VALUES (4, 'pbkdf2_sha256$260000$KE0AjVY8JyOtccmEpoWYH1$w4tBjh6mcfpeE1i2hNKsAM7fLnJC8qvigfGp+bmf6BE=', '2021-04-13 14:20:11+00', false, 'Kacper', 'Kacper', 'Karoń', 'kacper@karon.pl', false, true, '2021-04-13 14:20:04+00', 2);
INSERT INTO public.enroll_user VALUES (2, 'pbkdf2_sha256$260000$Q7QHOFuOtUVA8tIIvuaINT$q9fptseM3PQFN93MlrzPg6/RuFaWUTwQsmIs+xNDLJM=', '2021-04-12 20:31:14+00', false, 'Piotr', 'Piotr', 'Faliszewski', 'piotr@faliszewski.pl', false, true, '2021-04-12 20:30:44+00', 3);
INSERT INTO public.enroll_user VALUES (3, 'pbkdf2_sha256$260000$PxUI3keG41WEoLJVFzhnZb$KnIuQr/anM74ymdYW09D/qZ3eysCAU4QGe37vb8ag/c=', '2021-04-13 16:13:08.499364+00', false, 'Stanisław', 'Stanisław', 'Denkowski', 'stanislaw@denkowski.pl', false, true, '2021-04-12 20:33:17+00', 2);
INSERT INTO public.enroll_user VALUES (1, 'pbkdf2_sha256$260000$g4LevqvdiKOQamWJitflzG$KSRG9IvTdQohotV0TpAdRZ9V2CCRqqVygKMtv3iK8Rk=', '2021-04-13 20:40:08.53581+00', true, 'admin', '', '', 'admin@gmail.com', true, true, '2021-04-12 20:27:33.156063+00', 1);


--
-- Data for Name: enroll_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: enroll_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: graphql_auth_userstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.graphql_auth_userstatus VALUES (1, false, false, NULL, 1);
INSERT INTO public.graphql_auth_userstatus VALUES (2, false, false, NULL, 2);
INSERT INTO public.graphql_auth_userstatus VALUES (3, false, false, NULL, 3);
INSERT INTO public.graphql_auth_userstatus VALUES (4, false, false, NULL, 4);
INSERT INTO public.graphql_auth_userstatus VALUES (5, false, false, NULL, 5);
INSERT INTO public.graphql_auth_userstatus VALUES (6, false, false, NULL, 6);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 51, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 21, true);


--
-- Name: enroll_classtime_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_classtime_id_seq', 8, true);


--
-- Name: enroll_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_course_id_seq', 3, true);


--
-- Name: enroll_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_enrollment_id_seq', 9, true);


--
-- Name: enroll_lecturer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_lecturer_id_seq', 2, true);


--
-- Name: enroll_offer_exchange_to_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_offer_exchange_to_id_seq', 7, true);


--
-- Name: enroll_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_offer_id_seq', 5, true);


--
-- Name: enroll_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_user_groups_id_seq', 1, false);


--
-- Name: enroll_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_user_id_seq', 6, true);


--
-- Name: enroll_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enroll_user_user_permissions_id_seq', 1, false);


--
-- Name: graphql_auth_userstatus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.graphql_auth_userstatus_id_seq', 6, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: enroll_classtime enroll_classtime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_classtime
    ADD CONSTRAINT enroll_classtime_pkey PRIMARY KEY (id);


--
-- Name: enroll_course enroll_course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_course
    ADD CONSTRAINT enroll_course_pkey PRIMARY KEY (id);


--
-- Name: enroll_enrollment enroll_enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_enrollment
    ADD CONSTRAINT enroll_enrollment_pkey PRIMARY KEY (id);


--
-- Name: enroll_enrollment enroll_enrollment_student_id_class_time_id_e46b8460_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_enrollment
    ADD CONSTRAINT enroll_enrollment_student_id_class_time_id_e46b8460_uniq UNIQUE (student_id, class_time_id);


--
-- Name: enroll_lecturer enroll_lecturer_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_lecturer
    ADD CONSTRAINT enroll_lecturer_account_id_key UNIQUE (account_id);


--
-- Name: enroll_lecturer enroll_lecturer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_lecturer
    ADD CONSTRAINT enroll_lecturer_pkey PRIMARY KEY (id);


--
-- Name: enroll_offer_exchange_to enroll_offer_exchange_to_offer_id_classtime_id_923437c7_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer_exchange_to
    ADD CONSTRAINT enroll_offer_exchange_to_offer_id_classtime_id_923437c7_uniq UNIQUE (offer_id, classtime_id);


--
-- Name: enroll_offer_exchange_to enroll_offer_exchange_to_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer_exchange_to
    ADD CONSTRAINT enroll_offer_exchange_to_pkey PRIMARY KEY (id);


--
-- Name: enroll_offer enroll_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer
    ADD CONSTRAINT enroll_offer_pkey PRIMARY KEY (id);


--
-- Name: enroll_user_groups enroll_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_groups
    ADD CONSTRAINT enroll_user_groups_pkey PRIMARY KEY (id);


--
-- Name: enroll_user_groups enroll_user_groups_user_id_group_id_44f7d5ac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_groups
    ADD CONSTRAINT enroll_user_groups_user_id_group_id_44f7d5ac_uniq UNIQUE (user_id, group_id);


--
-- Name: enroll_user enroll_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user
    ADD CONSTRAINT enroll_user_pkey PRIMARY KEY (id);


--
-- Name: enroll_user_user_permissions enroll_user_user_permiss_user_id_permission_id_fba82a36_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_user_permissions
    ADD CONSTRAINT enroll_user_user_permiss_user_id_permission_id_fba82a36_uniq UNIQUE (user_id, permission_id);


--
-- Name: enroll_user_user_permissions enroll_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_user_permissions
    ADD CONSTRAINT enroll_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: enroll_user enroll_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user
    ADD CONSTRAINT enroll_user_username_key UNIQUE (username);


--
-- Name: graphql_auth_userstatus graphql_auth_userstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graphql_auth_userstatus
    ADD CONSTRAINT graphql_auth_userstatus_pkey PRIMARY KEY (id);


--
-- Name: graphql_auth_userstatus graphql_auth_userstatus_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graphql_auth_userstatus
    ADD CONSTRAINT graphql_auth_userstatus_user_id_key UNIQUE (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: enroll_classtime_course_id_a6e9511a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_classtime_course_id_a6e9511a ON public.enroll_classtime USING btree (course_id);


--
-- Name: enroll_classtime_lecturer_id_407bbc81; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_classtime_lecturer_id_407bbc81 ON public.enroll_classtime USING btree (lecturer_id);


--
-- Name: enroll_enrollment_class_time_id_d528c16a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_enrollment_class_time_id_d528c16a ON public.enroll_enrollment USING btree (class_time_id);


--
-- Name: enroll_enrollment_student_id_da1bd0db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_enrollment_student_id_da1bd0db ON public.enroll_enrollment USING btree (student_id);


--
-- Name: enroll_offer_enrollment_id_65ff1994; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_offer_enrollment_id_65ff1994 ON public.enroll_offer USING btree (enrollment_id);


--
-- Name: enroll_offer_exchange_to_classtime_id_3dbdb22e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_offer_exchange_to_classtime_id_3dbdb22e ON public.enroll_offer_exchange_to USING btree (classtime_id);


--
-- Name: enroll_offer_exchange_to_offer_id_7569f7da; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_offer_exchange_to_offer_id_7569f7da ON public.enroll_offer_exchange_to USING btree (offer_id);


--
-- Name: enroll_user_groups_group_id_467a24df; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_user_groups_group_id_467a24df ON public.enroll_user_groups USING btree (group_id);


--
-- Name: enroll_user_groups_user_id_ded9e499; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_user_groups_user_id_ded9e499 ON public.enroll_user_groups USING btree (user_id);


--
-- Name: enroll_user_user_permissions_permission_id_18ff09ab; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_user_user_permissions_permission_id_18ff09ab ON public.enroll_user_user_permissions USING btree (permission_id);


--
-- Name: enroll_user_user_permissions_user_id_5d6fdff0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_user_user_permissions_user_id_5d6fdff0 ON public.enroll_user_user_permissions USING btree (user_id);


--
-- Name: enroll_user_username_a600390d_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX enroll_user_username_a600390d_like ON public.enroll_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_enroll_user_id FOREIGN KEY (user_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_classtime enroll_classtime_course_id_a6e9511a_fk_enroll_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_classtime
    ADD CONSTRAINT enroll_classtime_course_id_a6e9511a_fk_enroll_course_id FOREIGN KEY (course_id) REFERENCES public.enroll_course(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_classtime enroll_classtime_lecturer_id_407bbc81_fk_enroll_lecturer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_classtime
    ADD CONSTRAINT enroll_classtime_lecturer_id_407bbc81_fk_enroll_lecturer_id FOREIGN KEY (lecturer_id) REFERENCES public.enroll_lecturer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_enrollment enroll_enrollment_class_time_id_d528c16a_fk_enroll_classtime_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_enrollment
    ADD CONSTRAINT enroll_enrollment_class_time_id_d528c16a_fk_enroll_classtime_id FOREIGN KEY (class_time_id) REFERENCES public.enroll_classtime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_enrollment enroll_enrollment_student_id_da1bd0db_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_enrollment
    ADD CONSTRAINT enroll_enrollment_student_id_da1bd0db_fk_enroll_user_id FOREIGN KEY (student_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_lecturer enroll_lecturer_account_id_50806509_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_lecturer
    ADD CONSTRAINT enroll_lecturer_account_id_50806509_fk_enroll_user_id FOREIGN KEY (account_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_offer enroll_offer_enrollment_id_65ff1994_fk_enroll_enrollment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer
    ADD CONSTRAINT enroll_offer_enrollment_id_65ff1994_fk_enroll_enrollment_id FOREIGN KEY (enrollment_id) REFERENCES public.enroll_enrollment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_offer_exchange_to enroll_offer_exchang_classtime_id_3dbdb22e_fk_enroll_cl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer_exchange_to
    ADD CONSTRAINT enroll_offer_exchang_classtime_id_3dbdb22e_fk_enroll_cl FOREIGN KEY (classtime_id) REFERENCES public.enroll_classtime(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_offer_exchange_to enroll_offer_exchange_to_offer_id_7569f7da_fk_enroll_offer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_offer_exchange_to
    ADD CONSTRAINT enroll_offer_exchange_to_offer_id_7569f7da_fk_enroll_offer_id FOREIGN KEY (offer_id) REFERENCES public.enroll_offer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_user_groups enroll_user_groups_group_id_467a24df_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_groups
    ADD CONSTRAINT enroll_user_groups_group_id_467a24df_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_user_groups enroll_user_groups_user_id_ded9e499_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_groups
    ADD CONSTRAINT enroll_user_groups_user_id_ded9e499_fk_enroll_user_id FOREIGN KEY (user_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_user_user_permissions enroll_user_user_per_permission_id_18ff09ab_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_user_permissions
    ADD CONSTRAINT enroll_user_user_per_permission_id_18ff09ab_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: enroll_user_user_permissions enroll_user_user_permissions_user_id_5d6fdff0_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enroll_user_user_permissions
    ADD CONSTRAINT enroll_user_user_permissions_user_id_5d6fdff0_fk_enroll_user_id FOREIGN KEY (user_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: graphql_auth_userstatus graphql_auth_userstatus_user_id_3feef183_fk_enroll_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.graphql_auth_userstatus
    ADD CONSTRAINT graphql_auth_userstatus_user_id_3feef183_fk_enroll_user_id FOREIGN KEY (user_id) REFERENCES public.enroll_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

