--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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

--
-- Name: dbproj; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dbproj;


ALTER SCHEMA dbproj OWNER TO postgres;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: archivedbookings; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.archivedbookings (
    room_number integer NOT NULL,
    hotel_address character varying,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE dbproj.archivedbookings OWNER TO postgres;

--
-- Name: archivedrentals; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.archivedrentals (
    room_number integer NOT NULL,
    hotel_address character varying,
    payment_amount integer,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE dbproj.archivedrentals OWNER TO postgres;

--
-- Name: hotel; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.hotel (
    address character varying NOT NULL,
    phone_number character varying,
    email_address character varying,
    star_rating integer,
    manager_first_name character varying,
    manager_middle_name character varying,
    manager_last_name character varying,
    number_of_rooms integer NOT NULL,
    chain_name character varying,
    CONSTRAINT hotel_star_rating_check CHECK (((star_rating >= 1) AND (star_rating <= 5)))
);


ALTER TABLE dbproj.hotel OWNER TO postgres;

--
-- Name: hotelroom; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.hotelroom (
    address character varying NOT NULL,
    room_number integer NOT NULL,
    amenities character varying,
    price double precision,
    capacity character varying,
    problems_and_damages character varying,
    view_type character varying,
    extension_capabilities character varying
);


ALTER TABLE dbproj.hotelroom OWNER TO postgres;

--
-- Name: rooms; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.rooms (
    room_number integer NOT NULL,
    hotel character varying NOT NULL
);


ALTER TABLE dbproj.rooms OWNER TO postgres;

--
-- Name: availableroomspercity; Type: VIEW; Schema: dbproj; Owner: postgres
--

CREATE VIEW dbproj.availableroomspercity AS
 SELECT h.address,
    count(*) AS available_rooms,
    split_part((h.address)::text, ','::text, 1) AS city
   FROM ((((dbproj.hotel h
     LEFT JOIN dbproj.hotelroom hr ON (((h.address)::text = (hr.address)::text)))
     LEFT JOIN dbproj.rooms r ON (((hr.room_number = r.room_number) AND ((hr.address)::text = (r.hotel)::text))))
     LEFT JOIN dbproj.archivedrentals ar ON ((r.room_number = ar.room_number)))
     LEFT JOIN dbproj.archivedbookings ab ON ((r.room_number = ab.room_number)))
  WHERE ((ar.room_number IS NULL) AND (ab.room_number IS NULL))
  GROUP BY (split_part((h.address)::text, ','::text, 1)), h.address;


ALTER VIEW dbproj.availableroomspercity OWNER TO postgres;

--
-- Name: contactemailaddress; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.contactemailaddress (
    email_address character varying NOT NULL,
    contact_first_name character varying,
    contact_middle_name character varying,
    contact_last_name character varying
);


ALTER TABLE dbproj.contactemailaddress OWNER TO postgres;

--
-- Name: contactphonenumber; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.contactphonenumber (
    phone_number character varying NOT NULL,
    contact_first_name character varying,
    contact_middle_name character varying,
    contact_last_name character varying
);


ALTER TABLE dbproj.contactphonenumber OWNER TO postgres;

--
-- Name: customer; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.customer (
    customer_id integer NOT NULL,
    id_type character varying(20),
    register_date date,
    first_name character varying,
    middle_name character varying,
    last_name character varying,
    address character varying
);


ALTER TABLE dbproj.customer OWNER TO postgres;

--
-- Name: employee; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.employee (
    first_name character varying NOT NULL,
    middle_name character varying NOT NULL,
    last_name character varying NOT NULL,
    address character varying,
    sin_ssn_number integer,
    job_position character varying
);


ALTER TABLE dbproj.employee OWNER TO postgres;

--
-- Name: hotelchain; Type: TABLE; Schema: dbproj; Owner: postgres
--

CREATE TABLE dbproj.hotelchain (
    chain_name character varying NOT NULL,
    central_office_address character varying,
    phone_number integer,
    email_address character varying,
    number_of_hotels integer
);


ALTER TABLE dbproj.hotelchain OWNER TO postgres;

--
-- Name: hotelroomcapacity; Type: VIEW; Schema: dbproj; Owner: postgres
--

CREATE VIEW dbproj.hotelroomcapacity AS
 SELECT address,
    sum(
        CASE
            WHEN ((capacity)::text = 'Single'::text) THEN 1
            WHEN ((capacity)::text = 'Double'::text) THEN 2
            WHEN ((capacity)::text = 'Suite'::text) THEN 4
            ELSE 0
        END) AS total_capacity
   FROM dbproj.hotelroom hr
  GROUP BY address;


ALTER VIEW dbproj.hotelroomcapacity OWNER TO postgres;

--
-- Data for Name: archivedbookings; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.archivedbookings (room_number, hotel_address, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: archivedrentals; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.archivedrentals (room_number, hotel_address, payment_amount, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: contactemailaddress; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.contactemailaddress (email_address, contact_first_name, contact_middle_name, contact_last_name) FROM stdin;
\.


--
-- Data for Name: contactphonenumber; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.contactphonenumber (phone_number, contact_first_name, contact_middle_name, contact_last_name) FROM stdin;
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.customer (customer_id, id_type, register_date, first_name, middle_name, last_name, address) FROM stdin;
\.


--
-- Data for Name: employee; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.employee (first_name, middle_name, last_name, address, sin_ssn_number, job_position) FROM stdin;
\.


--
-- Data for Name: hotel; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.hotel (address, phone_number, email_address, star_rating, manager_first_name, manager_middle_name, manager_last_name, number_of_rooms, chain_name) FROM stdin;
\.


--
-- Data for Name: hotelchain; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.hotelchain (chain_name, central_office_address, phone_number, email_address, number_of_hotels) FROM stdin;
Marriott	123 Central St, Ottawa	1234567890	MariottCanada@mariott.com	8
Hilton	456 Main St, Ottawa	1234567891	hiltonCanada@hiltonhotels.com	10
Les Suites	789 Downtown Ave, Ottawa	1234567892	lessuitesOtt@lessuites.com	9
Best Western	321 River Rd, Ottawa	1234567893	bestWesternOtt@bestwestern.com	12
Four Seasons	654 Park Blvd, Ottawa	1234567894	fourSeasonsinOttawa@fourseasons.com	11
\.


--
-- Data for Name: hotelroom; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.hotelroom (address, room_number, amenities, price, capacity, problems_and_damages, view_type, extension_capabilities) FROM stdin;
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: dbproj; Owner: postgres
--

COPY dbproj.rooms (room_number, hotel) FROM stdin;
\.


--
-- Name: archivedbookings archivedbookings_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.archivedbookings
    ADD CONSTRAINT archivedbookings_pkey PRIMARY KEY (room_number, start_date, end_date);


--
-- Name: archivedrentals archivedrentals_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.archivedrentals
    ADD CONSTRAINT archivedrentals_pkey PRIMARY KEY (room_number, start_date, end_date);


--
-- Name: contactemailaddress contactemailaddress_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.contactemailaddress
    ADD CONSTRAINT contactemailaddress_pkey PRIMARY KEY (email_address);


--
-- Name: contactphonenumber contactphonenumber_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.contactphonenumber
    ADD CONSTRAINT contactphonenumber_pkey PRIMARY KEY (phone_number);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (first_name, middle_name, last_name);


--
-- Name: employee employee_sin_ssn_number_key; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.employee
    ADD CONSTRAINT employee_sin_ssn_number_key UNIQUE (sin_ssn_number);


--
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (address);


--
-- Name: hotelchain hotelchain_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotelchain
    ADD CONSTRAINT hotelchain_pkey PRIMARY KEY (chain_name);


--
-- Name: hotelroom hotelroom_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotelroom
    ADD CONSTRAINT hotelroom_pkey PRIMARY KEY (room_number, address);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (room_number, hotel);


--
-- Name: archivedbookings archivedbookings_room_number_hotel_address_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.archivedbookings
    ADD CONSTRAINT archivedbookings_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES dbproj.rooms(room_number, hotel);


--
-- Name: archivedrentals archivedrentals_room_number_hotel_address_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.archivedrentals
    ADD CONSTRAINT archivedrentals_room_number_hotel_address_fkey FOREIGN KEY (room_number, hotel_address) REFERENCES dbproj.rooms(room_number, hotel);


--
-- Name: contactemailaddress contactemailaddress_contact_first_name_contact_middle_name_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.contactemailaddress
    ADD CONSTRAINT contactemailaddress_contact_first_name_contact_middle_name_fkey FOREIGN KEY (contact_first_name, contact_middle_name, contact_last_name) REFERENCES dbproj.employee(first_name, middle_name, last_name);


--
-- Name: contactphonenumber contactphonenumber_contact_first_name_contact_middle_name__fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.contactphonenumber
    ADD CONSTRAINT contactphonenumber_contact_first_name_contact_middle_name__fkey FOREIGN KEY (contact_first_name, contact_middle_name, contact_last_name) REFERENCES dbproj.employee(first_name, middle_name, last_name);


--
-- Name: hotel hotel_chain_name_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotel
    ADD CONSTRAINT hotel_chain_name_fkey FOREIGN KEY (chain_name) REFERENCES dbproj.hotelchain(chain_name);


--
-- Name: hotel hotel_email_address_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotel
    ADD CONSTRAINT hotel_email_address_fkey FOREIGN KEY (email_address) REFERENCES dbproj.contactemailaddress(email_address);


--
-- Name: hotel hotel_manager_first_name_manager_middle_name_manager_last__fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotel
    ADD CONSTRAINT hotel_manager_first_name_manager_middle_name_manager_last__fkey FOREIGN KEY (manager_first_name, manager_middle_name, manager_last_name) REFERENCES dbproj.employee(first_name, middle_name, last_name);


--
-- Name: hotel hotel_phone_number_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotel
    ADD CONSTRAINT hotel_phone_number_fkey FOREIGN KEY (phone_number) REFERENCES dbproj.contactphonenumber(phone_number);


--
-- Name: hotelroom hotelroom_address_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.hotelroom
    ADD CONSTRAINT hotelroom_address_fkey FOREIGN KEY (address) REFERENCES dbproj.hotel(address);


--
-- Name: rooms rooms_hotel_fkey; Type: FK CONSTRAINT; Schema: dbproj; Owner: postgres
--

ALTER TABLE ONLY dbproj.rooms
    ADD CONSTRAINT rooms_hotel_fkey FOREIGN KEY (hotel) REFERENCES dbproj.hotel(address);


--
-- Name: SCHEMA dbproj; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA dbproj TO PUBLIC;


--
-- Name: TABLE archivedbookings; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.archivedbookings FROM postgres;
GRANT ALL ON TABLE dbproj.archivedbookings TO postgres WITH GRANT OPTION;


--
-- Name: TABLE archivedrentals; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.archivedrentals FROM postgres;
GRANT ALL ON TABLE dbproj.archivedrentals TO postgres WITH GRANT OPTION;


--
-- Name: TABLE hotel; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.hotel FROM postgres;
GRANT ALL ON TABLE dbproj.hotel TO postgres WITH GRANT OPTION;


--
-- Name: TABLE hotelroom; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.hotelroom FROM postgres;
GRANT ALL ON TABLE dbproj.hotelroom TO postgres WITH GRANT OPTION;


--
-- Name: TABLE rooms; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.rooms FROM postgres;
GRANT ALL ON TABLE dbproj.rooms TO postgres WITH GRANT OPTION;


--
-- Name: TABLE availableroomspercity; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.availableroomspercity FROM postgres;
GRANT ALL ON TABLE dbproj.availableroomspercity TO postgres WITH GRANT OPTION;


--
-- Name: TABLE contactemailaddress; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.contactemailaddress FROM postgres;
GRANT ALL ON TABLE dbproj.contactemailaddress TO postgres WITH GRANT OPTION;


--
-- Name: TABLE contactphonenumber; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.contactphonenumber FROM postgres;
GRANT ALL ON TABLE dbproj.contactphonenumber TO postgres WITH GRANT OPTION;


--
-- Name: TABLE customer; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.customer FROM postgres;
GRANT ALL ON TABLE dbproj.customer TO postgres WITH GRANT OPTION;


--
-- Name: TABLE employee; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.employee FROM postgres;
GRANT ALL ON TABLE dbproj.employee TO postgres WITH GRANT OPTION;


--
-- Name: TABLE hotelchain; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.hotelchain FROM postgres;
GRANT ALL ON TABLE dbproj.hotelchain TO postgres WITH GRANT OPTION;


--
-- Name: TABLE hotelroomcapacity; Type: ACL; Schema: dbproj; Owner: postgres
--

REVOKE ALL ON TABLE dbproj.hotelroomcapacity FROM postgres;
GRANT ALL ON TABLE dbproj.hotelroomcapacity TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres REVOKE ALL ON TABLES FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

