--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases
--

DROP DATABASE aneesh;
DROP DATABASE college;
DROP DATABASE emp;
DROP DATABASE s1;
DROP DATABASE sales;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5dba12238094c5b2f23cb2828ab71fc2a';






--
-- Database creation
--

CREATE DATABASE aneesh WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE college WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE emp WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE s1 WITH TEMPLATE = template0 OWNER = postgres;
CREATE DATABASE sales WITH TEMPLATE = template0 OWNER = postgres;
REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


\connect aneesh

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: department_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE department_details (
    d_id integer NOT NULL,
    d_name character varying(20),
    d_salary integer
);


ALTER TABLE department_details OWNER TO postgres;

--
-- Name: emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emp (
    emp_id integer NOT NULL,
    emp_name character varying(20),
    manager_id integer,
    department_id integer
);


ALTER TABLE emp OWNER TO postgres;

--
-- Name: emp_emp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE emp_emp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE emp_emp_id_seq OWNER TO postgres;

--
-- Name: emp_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE emp_emp_id_seq OWNED BY emp.emp_id;


--
-- Name: emp emp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emp ALTER COLUMN emp_id SET DEFAULT nextval('emp_emp_id_seq'::regclass);


--
-- Data for Name: department_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department_details (d_id, d_name, d_salary) FROM stdin;
13	dev	35000
14	des	30000
15	sales	35000
16	finance	40000
\.


--
-- Data for Name: emp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY emp (emp_id, emp_name, manager_id, department_id) FROM stdin;
1	aneesh	\N	13
2	vinod	\N	14
3	arjun	1	13
4	ahok	\N	15
5	vikas	2	14
6	anoop	4	15
\.


--
-- Name: emp_emp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('emp_emp_id_seq', 6, true);


--
-- Name: department_details department_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY department_details
    ADD CONSTRAINT department_details_pkey PRIMARY KEY (d_id);


--
-- Name: emp emp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY emp
    ADD CONSTRAINT emp_pkey PRIMARY KEY (emp_id);


--
-- PostgreSQL database dump complete
--

\connect college

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ak; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA ak;


ALTER SCHEMA ak OWNER TO postgres;

--
-- Name: test; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA test;


ALTER SCHEMA test OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA information_schema;


--
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = public, pg_catalog;

--
-- Name: p1(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION p1(s_id integer DEFAULT NULL::integer, y integer DEFAULT NULL::integer) RETURNS TABLE(student_id integer, student_name character varying, course_name character varying, year integer, sem integer, total_score integer, sub1 text, score1 integer, sub2 text, score2 integer, sub3 text, score3 integer, total bigint)
    LANGUAGE plpgsql
    AS $_$
 declare
                        c boolean:= not null;
 v_sql text;
               
 begin
       
 v_sql:='
                         select student_id,student_name,course_name,
                         year,sem,total_score,sub1,score1,sub2,score2,sub3,score3,total from(
                         
                         select *from(with stud_details as(
         select s1.student_id,                      
         s1.student_name,
         c1.course_name,
         g1.year,
         g1.sem,
         g1.total_score,
         s_name,score,rank() 
 over(partition by s1.student_name,g1.sem order by score desc,s_name desc) 
                         from student s1 
                                inner join courses c1 on c1.dp_id=s1.dept_id 
                                inner join grades g1 on s1.student_id=g1.stud_id 
                                 inner join marks m1 on m1.stud_id=s1.student_id 
                                 inner join subjects sub1 on sub1.subject_id=m1.subject_id and g1.sem=sub1.sem_id) 
                         select 
                                 s1.student_id,
                                 s1.student_name,
                                 s1.course_name,
                                 s1.year,
                                 s1.sem,
                                 s1.total_score,
                                 max(case when s1.rank = 1 then s1.s_name end) as sub1,
                                 max(case when s1.rank = 1 then s1.score end) as score1,
                                 max(case when s1.rank = 2 then s1.s_name end) as sub2,
                                 max(case when s1.rank = 2 then s1.score end) as score2,
                                 max(case when s1.rank = 3 then s1.s_name end) as sub3,
                                 max(case when s1.rank = 3 then s1.score end) as score3,
                                 sum(total_score) over (partition by student_id) as total
                               
         from stud_details s1           
 where (case when $1 is not null then s1.student_id=$1 else true end)
   
                  group by s1.student_id,s1.student_name,s1.course_name,s1.year,s1.sem,s1.total_score
  order by student_id) t where (case when $2 is not null then t.year=$2 else true end)
) t1';
 
 return query execute v_sql using s_id,y;
 
 end;
 $_$;


ALTER FUNCTION public.p1(s_id integer, y integer) OWNER TO postgres;

--
-- Name: p2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION p2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if new.grade='A' then
new.remarks:='Excelent';
end if;return new;
end;
$$;


ALTER FUNCTION public.p2() OWNER TO postgres;

--
-- Name: t1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION t1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        begin
        update grades set total_score=(select sum(score) 
        from marks 
                inner join subjects on 
                        marks.subject_id=subjects.subject_id 
                        and sem_id=New.sem 
                                where stud_id=new.stud_id group by stud_id) where stud_id=new.stud_id and sem=new.sem;
        return new;                        
        end;
        $$;


ALTER FUNCTION public.t1() OWNER TO postgres;

--
-- Name: myserver; Type: SERVER; Schema: -; Owner: postgres
--

CREATE SERVER myserver FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'foodb',
    host 'foo',
    port '5454'
);


ALTER SERVER myserver OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: a; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE a (
    id integer,
    CONSTRAINT a_id_check CHECK ((id > 1))
);


ALTER TABLE a OWNER TO postgres;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE courses (
    dp_id integer NOT NULL,
    course_name character varying
);


ALTER TABLE courses OWNER TO postgres;

--
-- Name: dep_hod_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dep_hod_map (
    dp_id integer NOT NULL,
    hod_id integer
);


ALTER TABLE dep_hod_map OWNER TO postgres;

--
-- Name: dep_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dep_map (
    id integer,
    type integer,
    dept_id integer
);


ALTER TABLE dep_map OWNER TO postgres;

--
-- Name: dep_sub_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dep_sub_map (
    d_id integer,
    sub_id integer
);


ALTER TABLE dep_sub_map OWNER TO postgres;

--
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE department (
    department_id integer NOT NULL,
    department_name character varying(50)
);


ALTER TABLE department OWNER TO postgres;

--
-- Name: emp_sub_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE emp_sub_map (
    em_id integer,
    subj_id integer
);


ALTER TABLE emp_sub_map OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE employees (
    emp_id integer NOT NULL,
    emp_name character varying(20),
    emp_addr character varying(20),
    phone integer,
    salary integer
);


ALTER TABLE employees OWNER TO postgres;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grades (
    stud_id integer,
    year integer,
    sem integer,
    total_score integer
);


ALTER TABLE grades OWNER TO postgres;

--
-- Name: marks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE marks (
    stud_id integer,
    subject_id integer,
    score integer
);


ALTER TABLE marks OWNER TO postgres;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sales (
    year integer,
    month integer,
    qty integer
);


ALTER TABLE sales OWNER TO postgres;

--
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE student (
    student_id integer NOT NULL,
    student_name character varying(20),
    email character varying(20),
    address character varying(20),
    joining_date date,
    dept_id integer
);


ALTER TABLE student OWNER TO postgres;

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE subjects (
    subject_id integer NOT NULL,
    s_name character varying(20),
    sem_id integer
);


ALTER TABLE subjects OWNER TO postgres;

--
-- Name: type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE type (
    type_id integer NOT NULL,
    type_name character varying
);


ALTER TABLE type OWNER TO postgres;

--
-- Name: v1; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW v1 AS
 WITH stud_details AS (
         SELECT s1_1.student_id,
            s1_1.student_name,
            c1.course_name,
            g1.year,
            g1.sem,
            g1.total_score,
            sub1.s_name,
            m1.score,
            rank() OVER (PARTITION BY s1_1.student_name, g1.sem ORDER BY m1.score DESC, sub1.s_name DESC) AS rank
           FROM ((((student s1_1
             JOIN courses c1 ON ((c1.dp_id = s1_1.dept_id)))
             JOIN grades g1 ON ((s1_1.student_id = g1.stud_id)))
             JOIN marks m1 ON ((m1.stud_id = s1_1.student_id)))
             JOIN subjects sub1 ON (((sub1.subject_id = m1.subject_id) AND (g1.sem = sub1.sem_id))))
        )
 SELECT s1.student_id,
    s1.student_name,
    s1.course_name,
    s1.year,
    s1.sem,
    s1.total_score,
    max((
        CASE
            WHEN (s1.rank = 1) THEN s1.s_name
            ELSE NULL::character varying
        END)::text) AS sub1,
    max(
        CASE
            WHEN (s1.rank = 1) THEN s1.score
            ELSE NULL::integer
        END) AS score1,
    max((
        CASE
            WHEN (s1.rank = 2) THEN s1.s_name
            ELSE NULL::character varying
        END)::text) AS sub2,
    max(
        CASE
            WHEN (s1.rank = 2) THEN s1.score
            ELSE NULL::integer
        END) AS score2,
    max((
        CASE
            WHEN (s1.rank = 3) THEN s1.s_name
            ELSE NULL::character varying
        END)::text) AS sub3,
    max(
        CASE
            WHEN (s1.rank = 3) THEN s1.score
            ELSE NULL::integer
        END) AS score3,
    sum(s1.total_score) OVER (PARTITION BY s1.student_id) AS total
   FROM stud_details s1
  GROUP BY s1.student_id, s1.student_name, s1.course_name, s1.year, s1.sem, s1.total_score
  ORDER BY s1.student_id;


ALTER TABLE v1 OWNER TO postgres;

--
-- Data for Name: a; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY a (id) FROM stdin;
7
8
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY courses (dp_id, course_name) FROM stdin;
20	CSE
21	IT
22	EEE
23	ECE
\.


--
-- Data for Name: dep_hod_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dep_hod_map (dp_id, hod_id) FROM stdin;
20	55
21	50
22	60
23	65
\.


--
-- Data for Name: dep_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dep_map (id, type, dept_id) FROM stdin;
1	1	21
2	1	20
3	1	22
4	1	23
5	1	23
6	1	22
100	2	20
101	2	21
102	2	20
103	2	22
104	2	23
105	2	22
106	2	22
107	2	22
\.


--
-- Data for Name: dep_sub_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dep_sub_map (d_id, sub_id) FROM stdin;
21	1
21	2
21	3
20	1
20	2
20	3
22	1
22	5
22	6
23	2
23	4
23	6
20	7
20	8
20	9
21	7
21	8
21	9
22	9
22	11
22	12
23	10
23	11
23	12
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY department (department_id, department_name) FROM stdin;
21	INFORMATION TECHNOLOGY
20	COMPUTER SCIENCE
22	ELECTRICAL ENGINEERING
23	ELECTRONICS ENGINEERING
\.


--
-- Data for Name: emp_sub_map; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY emp_sub_map (em_id, subj_id) FROM stdin;
100	1
101	2
103	3
104	4
105	5
106	6
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employees (emp_id, emp_name, emp_addr, phone, salary) FROM stdin;
101	akash	pkd	7559074	25000
100	seetha	tcr	9633113	25000
102	nishanth	otp	881123	35000
103	daniel	tvm	9966244	27000
105	kumar	chennai	444222	30000
106	vijay	ktm	464222	28000
107	akshith	aaa	654321	27000
104	mukesh	pkd	22222	30000
50	vinayachandran	pkd	543222	53000
55	anil kumar	hyt	113222	51000
60	ranjith k	cbe	993222	52000
65	arunachal	ktr	773222	52000
\.


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY grades (stud_id, year, sem, total_score) FROM stdin;
2	2013	1	170
3	2013	1	157
4	2013	1	195
5	2013	1	78
2	2014	2	88
3	2014	2	77
4	2014	2	117
5	2014	2	136
6	2013	1	79
6	2014	2	103
1	2013	1	145
1	2013	2	123
\.


--
-- Data for Name: marks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY marks (stud_id, subject_id, score) FROM stdin;
1	2	60
1	3	60
2	1	55
2	2	56
2	3	59
3	1	51
3	5	52
3	6	54
4	2	64
4	4	65
4	6	66
1	1	25
6	1	20
6	5	27
5	2	20
5	4	37
5	6	21
6	6	32
1	7	32
1	8	54
1	9	37
2	7	22
2	8	34
2	9	32
3	9	32
3	11	24
3	12	21
4	10	42
4	11	44
4	12	31
5	10	48
5	11	49
5	12	39
6	9	35
6	11	23
6	12	45
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sales (year, month, qty) FROM stdin;
2007	1	1000
2007	2	1500
2007	7	500
2007	11	1500
2007	12	2000
2008	1	1000
\.


--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY student (student_id, student_name, email, address, joining_date, dept_id) FROM stdin;
1	jibin	j@abc.com	abc	2013-01-07	21
2	anil	an@abc.com	efg	2013-01-07	20
3	vijay	vijay@abc.com	hij	2013-01-07	22
4	vinu	vinu@abc.com	klm	2013-01-07	23
5	rakesh	rakesh@abc.com	agd	2013-01-07	23
6	anoop	anoop@abc.com	xyz	2013-01-07	22
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subjects (subject_id, s_name, sem_id) FROM stdin;
1	Maths	1
2	DSA	1
3	OS	1
4	DBMS	1
5	DCE	1
6	DSP	1
7	Maths2	2
8	SQM	2
9	DDC	2
10	SP	2
11	ECT	2
12	FT	2
\.


--
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY type (type_id, type_name) FROM stdin;
1	Student
2	Teacher
\.


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (dp_id);


--
-- Name: dep_hod_map dep_hod_map_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dep_hod_map
    ADD CONSTRAINT dep_hod_map_pkey PRIMARY KEY (dp_id);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY department
    ADD CONSTRAINT department_pkey PRIMARY KEY (department_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_id);


--
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (subject_id);


--
-- Name: type type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY type
    ADD CONSTRAINT type_pkey PRIMARY KEY (type_id);


--
-- Name: grades tr1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER tr1 AFTER INSERT ON grades FOR EACH ROW EXECUTE PROCEDURE t1();


--
-- Name: marks marks_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marks
    ADD CONSTRAINT marks_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES subjects(subject_id);


--
-- PostgreSQL database dump complete
--

\connect emp

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categories (
    category_id integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categories_category_id_seq OWNED BY categories.category_id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE departments (
    department_id integer NOT NULL,
    department_name character varying(255) NOT NULL
);


ALTER TABLE departments OWNER TO postgres;

--
-- Name: departments_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE departments_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE departments_department_id_seq OWNER TO postgres;

--
-- Name: departments_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE departments_department_id_seq OWNED BY departments.department_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE employees (
    employee_id integer NOT NULL,
    employee_name character varying(255),
    department_id integer
);


ALTER TABLE employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE employees_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE employees_employee_id_seq OWNED BY employees.employee_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_product_id_seq OWNED BY products.product_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories ALTER COLUMN category_id SET DEFAULT nextval('categories_category_id_seq'::regclass);


--
-- Name: departments department_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departments ALTER COLUMN department_id SET DEFAULT nextval('departments_department_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees ALTER COLUMN employee_id SET DEFAULT nextval('employees_employee_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN product_id SET DEFAULT nextval('products_product_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (category_id, category_name) FROM stdin;
1	Smart Phone
2	Laptop
3	Tablet
4	Desktop
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categories_category_id_seq', 3, true);


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY departments (department_id, department_name) FROM stdin;
1	Sales
2	Marketing
3	HR
4	IT
5	Production
\.


--
-- Name: departments_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('departments_department_id_seq', 5, true);


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employees (employee_id, employee_name, department_id) FROM stdin;
1	Bette Nicholson	1
2	Christian Gable	1
3	Joe Swank	2
4	Fred Costner	3
5	Sandra Kilmer	4
6	Julia Mcqueen	\N
\.


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('employees_employee_id_seq', 6, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (product_id, product_name, category_id) FROM stdin;
1	iPhone	1
2	Samsung Galaxy	1
3	HP Elite	2
4	Lenovo Thinkpad	2
5	iPad	3
6	Kindle Fire	3
\.


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_product_id_seq', 6, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (department_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(category_id);


--
-- PostgreSQL database dump complete
--

\connect postgres

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

\connect s1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: product_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product_groups (
    group_id integer NOT NULL,
    group_name character varying(255) NOT NULL
);


ALTER TABLE product_groups OWNER TO postgres;

--
-- Name: product_groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_groups_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_groups_group_id_seq OWNER TO postgres;

--
-- Name: product_groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_groups_group_id_seq OWNED BY product_groups.group_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    price numeric(11,2),
    group_id integer NOT NULL
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_product_id_seq OWNED BY products.product_id;


--
-- Name: product_groups group_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_groups ALTER COLUMN group_id SET DEFAULT nextval('product_groups_group_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN product_id SET DEFAULT nextval('products_product_id_seq'::regclass);


--
-- Data for Name: product_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_groups (group_id, group_name) FROM stdin;
1	Smartphone
2	Laptop
3	Tablet
\.


--
-- Name: product_groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_groups_group_id_seq', 3, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (product_id, product_name, price, group_id) FROM stdin;
1	Microsoft Lumia	200.00	1
2	HTC One	400.00	1
3	Nexus	500.00	1
4	iPhone	900.00	1
5	HP Elite	1200.00	2
6	Lenovo Thinkpad	700.00	2
7	Sony VAIO	700.00	2
8	Dell Vostro	800.00	2
9	iPad	700.00	3
10	Kindle Fire	150.00	3
11	Samsung Galaxy Tab	200.00	3
\.


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_product_id_seq', 11, true);


--
-- Name: product_groups product_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_groups
    ADD CONSTRAINT product_groups_pkey PRIMARY KEY (group_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: products products_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_group_id_fkey FOREIGN KEY (group_id) REFERENCES product_groups(group_id);


--
-- PostgreSQL database dump complete
--

\connect sales

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product (
    id integer NOT NULL,
    name character varying,
    price character varying
);


ALTER TABLE product OWNER TO postgres;

--
-- Name: sales_fact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE sales_fact (
    id integer NOT NULL,
    product_id integer,
    store_id integer,
    worker_id integer,
    suplier_id integer,
    unit_sold integer
);


ALTER TABLE sales_fact OWNER TO postgres;

--
-- Name: store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE store (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE store OWNER TO postgres;

--
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE supplier (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE supplier OWNER TO postgres;

--
-- Name: worker; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE worker (
    id integer NOT NULL,
    name character varying
);


ALTER TABLE worker OWNER TO postgres;

--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product (id, name, price) FROM stdin;
1	lap_top	25000
2	smart_phone	9000
3	tv	27000
\.


--
-- Data for Name: sales_fact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sales_fact (id, product_id, store_id, worker_id, suplier_id, unit_sold) FROM stdin;
1	1	1	1	2	13
2	1	2	2	1	13
3	3	3	3	3	15
\.


--
-- Data for Name: store; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY store (id, name) FROM stdin;
1	gkstore
2	mkstore
3	pkstore
\.


--
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY supplier (id, name) FROM stdin;
1	hp
2	dell
3	LG
\.


--
-- Data for Name: worker; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY worker (id, name) FROM stdin;
1	anil
2	vineeth
3	vishnu
\.


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: sales_fact sales_fact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_fact
    ADD CONSTRAINT sales_fact_pkey PRIMARY KEY (id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (id);


--
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);


--
-- Name: worker worker_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY worker
    ADD CONSTRAINT worker_pkey PRIMARY KEY (id);


--
-- Name: sales_fact sales_fact_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_fact
    ADD CONSTRAINT sales_fact_product_id_fkey FOREIGN KEY (product_id) REFERENCES product(id);


--
-- Name: sales_fact sales_fact_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_fact
    ADD CONSTRAINT sales_fact_store_id_fkey FOREIGN KEY (store_id) REFERENCES store(id);


--
-- Name: sales_fact sales_fact_suplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_fact
    ADD CONSTRAINT sales_fact_suplier_id_fkey FOREIGN KEY (suplier_id) REFERENCES supplier(id);


--
-- Name: sales_fact sales_fact_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_fact
    ADD CONSTRAINT sales_fact_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES worker(id);


--
-- PostgreSQL database dump complete
--

\connect template1

SET default_transaction_read_only = off;

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

