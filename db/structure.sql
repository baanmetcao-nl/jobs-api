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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: benefits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.benefits (
    id bigint NOT NULL,
    job_id bigint NOT NULL,
    min_salary numeric(8,2) NOT NULL,
    max_salary numeric(8,2) NOT NULL,
    vacation_days integer NOT NULL,
    pension boolean NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT chk_rails_1fd45e0914 CHECK ((vacation_days >= 15)),
    CONSTRAINT chk_rails_4288c2ec5c CHECK ((min_salary <= (9999999)::numeric)),
    CONSTRAINT chk_rails_86d7908d7c CHECK ((max_salary >= (10000)::numeric)),
    CONSTRAINT chk_rails_8ecf757d06 CHECK ((max_salary <= (9999999)::numeric)),
    CONSTRAINT chk_rails_98ce32534d CHECK ((vacation_days <= 200)),
    CONSTRAINT chk_rails_9f13bfe3ea CHECK ((max_salary >= min_salary)),
    CONSTRAINT chk_rails_b51976d4dc CHECK ((min_salary >= (10000)::numeric))
);


--
-- Name: benefits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.benefits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: benefits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.benefits_id_seq OWNED BY public.benefits.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name text NOT NULL,
    location text NOT NULL,
    website_url text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT chk_rails_04156a7cff CHECK ((char_length(location) <= 50)),
    CONSTRAINT chk_rails_2aab2e34c7 CHECK ((char_length(name) <= 50)),
    CONSTRAINT chk_rails_b3fd79b16f CHECK ((char_length(location) >= 5)),
    CONSTRAINT chk_rails_e4a29012aa CHECK ((char_length(name) >= 2))
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_addresses (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    email public.citext NOT NULL
);


--
-- Name: email_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_addresses_id_seq OWNED BY public.email_addresses.id;


--
-- Name: employers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employers (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: employers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.employers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: employers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.employers_id_seq OWNED BY public.employers.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    employer_id bigint NOT NULL,
    "position" text NOT NULL,
    description text NOT NULL,
    experience integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    published_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT chk_rails_56e97aef51 CHECK ((experience <= 3)),
    CONSTRAINT chk_rails_604e41bd5a CHECK ((char_length("position") <= 50)),
    CONSTRAINT chk_rails_7bba318e1d CHECK ((char_length("position") >= 3)),
    CONSTRAINT chk_rails_9008251ec1 CHECK ((experience >= 0)),
    CONSTRAINT chk_rails_975fe2c403 CHECK ((char_length(description) >= 100)),
    CONSTRAINT chk_rails_d4f6b6646e CHECK ((char_length(description) <= 5000))
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: user_email_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_email_addresses (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    email_address_id bigint NOT NULL,
    use integer DEFAULT 0 NOT NULL
);


--
-- Name: user_email_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_email_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_email_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_email_addresses_id_seq OWNED BY public.user_email_addresses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    activated_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    CONSTRAINT chk_rails_80de706552 CHECK ((char_length(first_name) <= 50)),
    CONSTRAINT chk_rails_891bf6f494 CHECK ((char_length(first_name) >= 2)),
    CONSTRAINT chk_rails_ada713b61c CHECK ((char_length(last_name) <= 50)),
    CONSTRAINT chk_rails_dd2f0ae42c CHECK ((char_length(last_name) >= 2))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: benefits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.benefits ALTER COLUMN id SET DEFAULT nextval('public.benefits_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: email_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_addresses ALTER COLUMN id SET DEFAULT nextval('public.email_addresses_id_seq'::regclass);


--
-- Name: employers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employers ALTER COLUMN id SET DEFAULT nextval('public.employers_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: user_email_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_addresses ALTER COLUMN id SET DEFAULT nextval('public.user_email_addresses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: benefits benefits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: email_addresses email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_addresses
    ADD CONSTRAINT email_addresses_pkey PRIMARY KEY (id);


--
-- Name: employers employers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employers
    ADD CONSTRAINT employers_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_email_addresses user_email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_addresses
    ADD CONSTRAINT user_email_addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_benefits_on_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_benefits_on_job_id ON public.benefits USING btree (job_id);


--
-- Name: index_companies_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_on_name ON public.companies USING btree (name);


--
-- Name: index_employers_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_employers_on_company_id ON public.employers USING btree (company_id);


--
-- Name: index_employers_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_employers_on_user_id ON public.employers USING btree (user_id);


--
-- Name: index_jobs_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_description ON public.jobs USING btree (description);


--
-- Name: index_jobs_on_employer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_employer_id ON public.jobs USING btree (employer_id);


--
-- Name: index_jobs_on_experience; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_experience ON public.jobs USING btree (experience);


--
-- Name: index_jobs_on_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_expires_at ON public.jobs USING btree (expires_at);


--
-- Name: index_jobs_on_position; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_position ON public.jobs USING btree ("position");


--
-- Name: index_jobs_on_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_published_at ON public.jobs USING btree (published_at);


--
-- Name: index_jobs_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jobs_on_status ON public.jobs USING btree (status);


--
-- Name: index_user_email_addresses_on_email_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_email_addresses_on_email_address_id ON public.user_email_addresses USING btree (email_address_id);


--
-- Name: index_user_email_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_email_addresses_on_user_id ON public.user_email_addresses USING btree (user_id);


--
-- Name: index_user_email_addresses_on_user_id_and_email_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_email_addresses_on_user_id_and_email_address_id ON public.user_email_addresses USING btree (user_id, email_address_id);


--
-- Name: index_user_email_addresses_on_user_id_and_use; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_user_email_addresses_on_user_id_and_use ON public.user_email_addresses USING btree (user_id, use);


--
-- Name: index_users_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_status ON public.users USING btree (status);


--
-- Name: employers fk_rails_1cf01598e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employers
    ADD CONSTRAINT fk_rails_1cf01598e4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: benefits fk_rails_5ae1a05e8d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT fk_rails_5ae1a05e8d FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: user_email_addresses fk_rails_b0e6828797; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_addresses
    ADD CONSTRAINT fk_rails_b0e6828797 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: jobs fk_rails_c595bef11c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_rails_c595bef11c FOREIGN KEY (employer_id) REFERENCES public.employers(id);


--
-- Name: user_email_addresses fk_rails_c7148123b3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_addresses
    ADD CONSTRAINT fk_rails_c7148123b3 FOREIGN KEY (email_address_id) REFERENCES public.email_addresses(id);


--
-- Name: employers fk_rails_f6c09eca0e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employers
    ADD CONSTRAINT fk_rails_f6c09eca0e FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20230122192605');


