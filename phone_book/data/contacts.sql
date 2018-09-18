--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE contacts (
    name character varying NOT NULL,
    phone character varying NOT NULL
);


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO contacts (name, phone) VALUES ('Miranda Carroll', '735-776-6891');
INSERT INTO contacts (name, phone) VALUES ('Lidia Vandervort', '432-570-9197');
INSERT INTO contacts (name, phone) VALUES ('Sherley Pacocha', '745-347-3375');
INSERT INTO contacts (name, phone) VALUES ('Archie VonRueden', '919-846-8946');
INSERT INTO contacts (name, phone) VALUES ('Samatha Hermann', '363-350-4983');
INSERT INTO contacts (name, phone) VALUES ('Tammi Reinger', '290-785-5362');
INSERT INTO contacts (name, phone) VALUES ('Mitzi Wisozk', '728-610-6384');
INSERT INTO contacts (name, phone) VALUES ('Kaylene Bahringer', '567-862-1768');
INSERT INTO contacts (name, phone) VALUES ('Cassandra Ledner', '833-954-4891');
INSERT INTO contacts (name, phone) VALUES ('Sybil Nicolas', '579-804-9800');
INSERT INTO contacts (name, phone) VALUES ('Karri Dare', '437-779-2544');
INSERT INTO contacts (name, phone) VALUES ('Belia Barton', '428-941-3115');
INSERT INTO contacts (name, phone) VALUES ('Shantelle Purdy', '756-999-5942');
INSERT INTO contacts (name, phone) VALUES ('Lauri Abshire', '675-281-8695');
INSERT INTO contacts (name, phone) VALUES ('Simonne Bayer', '422-721-2913');
INSERT INTO contacts (name, phone) VALUES ('Chang West', '510-242-7057');
INSERT INTO contacts (name, phone) VALUES ('Essie Luettgen', '489-839-8270');
INSERT INTO contacts (name, phone) VALUES ('Myrtis Corkery', '460-571-4056');
INSERT INTO contacts (name, phone) VALUES ('Nena Ward', '261-542-4695');

--
-- PostgreSQL database dump complete
--

