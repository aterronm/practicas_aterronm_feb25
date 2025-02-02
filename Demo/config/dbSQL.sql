--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-02-02 18:18:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS postgres;
--
-- TOC entry 4830 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 4830
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16415)
-- Name: login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.login (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    password text NOT NULL,
    type character varying(100),
    CONSTRAINT login_email_check CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text))
);


ALTER TABLE public.login OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16414)
-- Name: login_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.login_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.login_id_seq OWNER TO postgres;

--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 219
-- Name: login_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.login_id_seq OWNED BY public.login.id;


--
-- TOC entry 218 (class 1259 OID 16402)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    birth_date date NOT NULL,
    dni character varying(9) NOT NULL,
    genre character varying(15) NOT NULL,
    email character varying(100) NOT NULL,
    entry_date date NOT NULL,
    exit_date date,
    active boolean DEFAULT true,
    CONSTRAINT person_email_check CHECK (((email)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'::text))
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16401)
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.person_id_seq OWNER TO postgres;

--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 217
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.person_id_seq OWNED BY public.person.id;


--
-- TOC entry 222 (class 1259 OID 16434)
-- Name: work_hours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_hours (
    id integer NOT NULL,
    "employeeEmail" character varying NOT NULL,
    date date,
    entry_time time without time zone,
    exit_time time without time zone
);


ALTER TABLE public.work_hours OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16433)
-- Name: work_hours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_hours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_hours_id_seq OWNER TO postgres;

--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 221
-- Name: work_hours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_hours_id_seq OWNED BY public.work_hours.id;


--
-- TOC entry 4653 (class 2604 OID 16418)
-- Name: login id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login ALTER COLUMN id SET DEFAULT nextval('public.login_id_seq'::regclass);


--
-- TOC entry 4651 (class 2604 OID 16405)
-- Name: person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);


--
-- TOC entry 4654 (class 2604 OID 16437)
-- Name: work_hours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_hours ALTER COLUMN id SET DEFAULT nextval('public.work_hours_id_seq'::regclass);


--
-- TOC entry 4822 (class 0 OID 16415)
-- Dependencies: 220
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.login VALUES (4, 'bob.brown@example.com', 'hashed_password_4', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (5, 'charlie.davis@example.com', 'hashed_password_5', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (6, 'emily.white@example.com', 'hashed_password_6', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (7, 'david.harris@example.com', 'hashed_password_7', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (8, 'sophia.martinez@example.com', 'hashed_password_8', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (9, 'ethan.clark@example.com', 'hashed_password_9', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (10, 'olivia.lewis@example.com', 'hashed_password_10', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (3, 'alice.johnson@example.com', '6789', NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (1, 'alvaro@nebrija.com', '1234', 'Admin') ON CONFLICT DO NOTHING;
INSERT INTO public.login VALUES (2, 'adrian@nebrija.com', '2345', NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4820 (class 0 OID 16402)
-- Dependencies: 218
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES (88, 'Alvaro', 'Terron', '2003-05-20', '13246245P', 'Male', 'a@a.com', '2003-05-20', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (47, 'Jane', 'Smith', '1985-07-22', '987654320', 'female', 'jane.smith@example.com', '2019-03-15', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (48, 'Alice', 'Johnson', '1992-11-30', '234567891', 'female', 'alice.johnson@example.com', '2021-06-20', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (49, 'Bob', 'Brown', '1988-09-25', '345678902', 'male', 'bob.brown@example.com', '2018-12-01', '2023-02-10', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (50, 'Charlie', 'Davis', '1995-04-18', '456789013', 'male', 'charlie.davis@example.com', '2022-09-05', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (51, 'Emily', 'White', '1991-02-10', '567890124', 'female', 'emily.white@example.com', '2017-05-30', '2021-08-12', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (52, 'David', 'Harris', '1983-06-14', '678901235', 'male', 'david.harris@example.com', '2015-07-19', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (53, 'Sophia', 'Martinez', '1997-12-22', '789012346', 'female', 'sophia.martinez@example.com', '2023-01-01', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (54, 'Ethan', 'Clark', '1994-03-09', '890123457', 'male', 'ethan.clark@example.com', '2016-04-10', '2019-09-22', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (55, 'Olivia', 'Lewis', '1989-08-05', '901234568', 'female', 'olivia.lewis@example.com', '2018-11-11', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (56, 'Liam', 'Walker', '1996-10-20', '012345679', 'male', 'liam.walker@example.com', '2020-02-14', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (57, 'Ava', 'Hall', '1984-12-01', '112233446', 'female', 'ava.hall@example.com', '2017-09-25', '2022-07-30', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (58, 'Noah', 'Allen', '1993-07-07', '223344557', 'male', 'noah.allen@example.com', '2019-08-03', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (59, 'Isabella', 'Young', '1998-11-15', '334455668', 'female', 'isabella.young@example.com', '2021-12-19', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (60, 'Mason', 'King', '1990-06-29', '445566779', 'male', 'mason.king@example.com', '2016-03-11', '2020-10-05', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (61, 'Mia', 'Scott', '1995-05-23', '556677880', 'female', 'mia.scott@example.com', '2019-01-14', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (62, 'James', 'Green', '1986-09-12', '667788991', 'male', 'james.green@example.com', '2015-06-27', '2021-04-15', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (63, 'Ella', 'Adams', '1992-04-04', '778899002', 'female', 'ella.adams@example.com', '2020-10-08', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (64, 'Benjamin', 'Nelson', '1997-03-17', '889900113', 'male', 'benjamin.nelson@example.com', '2022-03-21', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (65, 'Charlotte', 'Carter', '1981-08-30', '990011224', 'female', 'charlotte.carter@example.com', '2017-07-05', '2023-01-20', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (66, 'Daniel', 'Mitchell', '1994-12-10', '001122335', 'male', 'daniel.mitchell@example.com', '2020-11-22', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (67, 'Amelia', 'Perez', '1987-06-06', '112233447', 'female', 'amelia.perez@example.com', '2018-05-18', '2022-12-11', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (68, 'Lucas', 'Roberts', '1999-10-31', '223344558', 'male', 'lucas.roberts@example.com', '2023-02-01', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (69, 'Harper', 'Garcia', '1991-01-20', '334455669', 'female', 'harper.garcia@example.com', '2019-04-13', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (70, 'Henry', 'Rodriguez', '1985-11-05', '445566770', 'male', 'henry.rodriguez@example.com', '2016-09-28', '2021-03-04', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (71, 'Grace', 'Lopez', '1996-08-14', '556677881', 'female', 'grace.lopez@example.com', '2021-07-12', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (72, 'Alexander', 'Gonzalez', '1982-07-25', '667788992', 'male', 'alexander.gonzalez@example.com', '2017-12-07', '2022-05-16', false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (73, 'Victoria', 'Wilson', '1993-02-28', '778899003', 'female', 'victoria.wilson@example.com', '2020-06-14', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (74, 'Sebastian', 'Anderson', '1998-05-09', '889900114', 'male', 'sebastian.anderson@example.com', '2022-08-23', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (46, 'John', 'Doe', '1990-05-14', '123456789', 'male', 'john.doe@example.com', '2020-01-10', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (75, 'Alvaro', 'Terron', '2003-05-20', '032208582', 'male', 'alvaro@nebrija.com', '2024-11-23', NULL, true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (76, 'Adrian', 'Nebrija', '1999-09-23', '123456213', 'male', 'adrian@nebrija.com', '2025-11-02', NULL, false) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (77, 'fff', 'fff', '2003-05-20', '2552003', 'fff', 'ffff@fff.com', '2003-05-20', '2003-05-20', true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (78, 'Alvaro', 'Alvaro', '2003-05-20', '03220858F', 'Male', 'alvaroterronmasoko@hotmail.com', '2003-05-20', '2003-05-23', true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (82, 'Alvaro', 'Terron', '2003-05-20', '03220858M', 'Male', 'alvaro.terron@alumnos.nebrija.es', '2003-05-20', '2003-05-20', true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (83, 'Alvaro', 'Terron', '2003-05-20', '03220858P', 'Male', 'alvaro@demo.com', '2003-05-20', '2003-05-20', true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (85, 'ff', 'ff', '2003-05-20', '03220858Q', 'Male', 'alvaro2terronmasoko@hotmail.es', '2003-05-20', '2003-06-20', true) ON CONFLICT DO NOTHING;
INSERT INTO public.person VALUES (90, 'Alvaro', '(LAST)', '2003-05-20', '02487274P', 'Male', 'a@e.com', '2003-05-20', NULL, true) ON CONFLICT DO NOTHING;


--
-- TOC entry 4824 (class 0 OID 16434)
-- Dependencies: 222
-- Data for Name: work_hours; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.work_hours VALUES (8, 'adrian@nebrija.com', '2003-02-04', '09:00:00', '18:00:00') ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (9, 'adrian@nebrija.com', '2003-02-03', '09:00:00', '18:00:00') ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (10, 'adrian@nebrija.com', '2003-02-02', '09:00:00', '18:00:00') ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (11, 'adrian@nebrija.com', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (12, 'adrian@nebrija.com', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (13, 'adrian@nebrija.com', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO public.work_hours VALUES (14, 'adrian@nebrija.com', NULL, NULL, NULL) ON CONFLICT DO NOTHING;


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 219
-- Name: login_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_id_seq', 11, true);


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 217
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 90, true);


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 221
-- Name: work_hours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_hours_id_seq', 14, true);


--
-- TOC entry 4664 (class 2606 OID 16425)
-- Name: login login_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_email_key UNIQUE (email);


--
-- TOC entry 4666 (class 2606 OID 16427)
-- Name: login login_pass_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pass_key UNIQUE (password);


--
-- TOC entry 4668 (class 2606 OID 16423)
-- Name: login login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT login_pkey PRIMARY KEY (id);


--
-- TOC entry 4670 (class 2606 OID 16459)
-- Name: work_hours onePerDay; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_hours
    ADD CONSTRAINT "onePerDay" UNIQUE ("employeeEmail", date);


--
-- TOC entry 4658 (class 2606 OID 16411)
-- Name: person person_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_dni_key UNIQUE (dni);


--
-- TOC entry 4660 (class 2606 OID 16413)
-- Name: person person_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_email_key UNIQUE (email);


--
-- TOC entry 4662 (class 2606 OID 16409)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 4672 (class 2606 OID 16439)
-- Name: work_hours work_hours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_hours
    ADD CONSTRAINT work_hours_pkey PRIMARY KEY (id);


--
-- TOC entry 4673 (class 2606 OID 16445)
-- Name: login fk_user_email; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.login
    ADD CONSTRAINT fk_user_email FOREIGN KEY (email) REFERENCES public.person(email);


-- Completed on 2025-02-02 18:18:37

--
-- PostgreSQL database dump complete
--

