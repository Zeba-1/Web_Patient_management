--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actemed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actemed (
    ida integer NOT NULL,
    nom character varying(50) NOT NULL,
    dateh timestamp without time zone NOT NULL,
    resum text NOT NULL,
    patient character(15) NOT NULL,
    medecin integer NOT NULL
);


--
-- Name: actemed_ida_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actemed_ida_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actemed_ida_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actemed_ida_seq OWNED BY public.actemed.ida;


--
-- Name: allergies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allergies (
    code character varying(5) NOT NULL,
    niv integer,
    CONSTRAINT allergies_niv_check CHECK (((niv >= 1) AND (niv <= 10)))
);


--
-- Name: dateentre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dateentre (
    datee date NOT NULL
);


--
-- Name: fichier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fichier (
    nom character varying(30) NOT NULL,
    lien character varying(200),
    descr text NOT NULL,
    actemed integer NOT NULL
);


--
-- Name: medecinh; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medecinh (
    idm integer NOT NULL,
    nom character varying(20) NOT NULL,
    prenom character varying(20) NOT NULL,
    adresse character varying(100),
    mdp character varying(32) NOT NULL
);


--
-- Name: medecinh_idm_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medecinh_idm_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medecinh_idm_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medecinh_idm_seq OWNED BY public.medecinh.idm;


--
-- Name: medecint; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medecint (
    npro character(9) NOT NULL,
    nom character varying(20) NOT NULL,
    prenom character varying(20) NOT NULL,
    adresse character varying(100)
);


--
-- Name: nbintervention; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.nbintervention AS
 SELECT date(actemed.dateh) AS date,
    count(actemed.ida) AS count
   FROM public.actemed
  GROUP BY (date(actemed.dateh));


--
-- Name: nbtypeintervention; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.nbtypeintervention AS
 SELECT actemed.nom,
    count(actemed.nom) AS count
   FROM public.actemed
  GROUP BY actemed.nom;


--
-- Name: passepar; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.passepar (
    patient character(15) NOT NULL,
    services integer NOT NULL,
    datee date NOT NULL,
    dates date
);


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    numsecu character(15) NOT NULL,
    nomu character varying(20) NOT NULL,
    nom character varying(20),
    prenom character varying(20) NOT NULL,
    adresse character varying(100),
    medecint character(9)
);


--
-- Name: possede; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.possede (
    patient character(15) NOT NULL,
    allergie character varying(5) NOT NULL,
    dated date NOT NULL,
    datef date
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    ids integer NOT NULL,
    nom character varying(30) NOT NULL,
    loc character(2) NOT NULL
);


--
-- Name: services_ids_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.services_ids_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_ids_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.services_ids_seq OWNED BY public.services.ids;


--
-- Name: tempspassageservice; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.tempspassageservice AS
 SELECT passepar.services,
    avg((passepar.dates - passepar.datee)) AS tempspasser
   FROM public.passepar
  GROUP BY passepar.services;


--
-- Name: travaille; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.travaille (
    medecin integer NOT NULL,
    services integer NOT NULL,
    fonction character varying(20),
    anciennete date
);


--
-- Name: actemed ida; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actemed ALTER COLUMN ida SET DEFAULT nextval('public.actemed_ida_seq'::regclass);


--
-- Name: medecinh idm; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medecinh ALTER COLUMN idm SET DEFAULT nextval('public.medecinh_idm_seq'::regclass);


--
-- Name: services ids; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services ALTER COLUMN ids SET DEFAULT nextval('public.services_ids_seq'::regclass);


--
-- Data for Name: actemed; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.actemed (ida, nom, dateh, resum, patient, medecin) FROM stdin;
1	Radio	2021-09-29 16:43:21	fracture du poignet	102099406908259	1
2	Platre	2019-06-14 21:41:44	RAS	160099160424193	2
3	Point de suture	2017-03-04 21:09:58	Annule	160099160424193	2
4	Point de suture	2017-03-04 21:01:49	RAS	160099160424193	2
5	Platre	2020-10-17 12:36:01	RAS	296060410603476	2
6	Point de suture	2015-08-27 23:08:17	Outils oublier (Programmer une réintervention)	296060410603476	2
7	Point de suture	2016-09-03 18:13:03	RAS	214072889800551	2
8	Infiltration	2016-08-27 03:05:16	RAS	214072889800551	1
9	Point de suture	2017-04-28 03:10:17	RAS	193012735171474	1
10	Depistage	2017-04-28 04:52:27	Le patient a pris la fuite	193012735171474	2
11	Radio	2021-11-17 09:36:50	RAS	248042148685557	1
12	Radio	2015-06-16 13:56:39	RAS	152027306574655	2
13	Depistage	2015-06-16 19:42:27	Personelle manquant	152027306574655	1
14	Radio	2021-03-12 04:36:36	Outils oublier (Programmer une réintervention)	279061486384848	3
15	Scanner	2020-08-10 14:50:43	Annule	279061486384848	11
16	Radio	2021-12-01 11:06:32	Membre couper par erreur	287073840279994	1
17	Radio	2021-02-27 14:05:10	RAS	114046512153391	1
18	Point de suture	2020-12-01 16:25:17	RAS	114046512153391	2
19	Point de suture	2021-02-27 07:29:40	Personelle manquant	114046512153391	1
20	Depistage	2020-12-01 14:36:47	Annule	114046512153391	2
21	Infiltration	2019-05-27 00:33:03	Le patient a pris la fuite	277092607082177	1
22	Depistage	2021-03-03 13:57:27	RAS	277092607082177	2
23	Point de suture	2021-12-01 02:45:03	RAS	299072728963532	1
24	Platre	2021-12-01 11:12:14	RAS	299072728963532	1
25	Laminectomie	2021-07-12 14:22:26	Annule	275033015197248	10
26	Chirurgie	2021-08-26 14:11:48	Personelle manquant	275033015197248	4
27	Radio	2021-09-18 10:12:01	RAS	275033015197248	3
28	trepanation	2021-07-02 16:58:48	Cancer confirmé	275033015197248	10
29	Platre	2017-09-06 12:20:12	Annule	222124053073274	2
30	Radio	2017-09-06 04:48:42	Membre couper par erreur	222124053073274	2
31	Depistage	2017-09-06 12:21:52	RAS	222124053073274	2
32	Infiltration	2017-09-06 22:31:46	Personelle manquant	222124053073274	2
33	Chirurie	2021-04-24 08:57:45	RAS	112017646417282	7
34	Examen	2021-11-24 18:15:41	Cancer confirmé	112017646417282	5
35	Depistage	2021-07-08 00:28:36	RAS	174054006457994	1
36	Infiltration	2020-09-14 14:53:41	RAS	174054006457994	2
37	Point de suture	2020-09-14 07:38:04	Outils oublier (Programmer une réintervention)	174054006457994	2
38	Reanimation	2018-12-07 07:09:14	RAS	129096634267071	6
39	Point de suture	2018-12-07 13:35:11	Le patient a pris la fuite	129096634267071	7
40	Chirurie	2018-12-18 23:58:07	RAS	129096634267071	7
41	Point de suture	2019-07-05 03:39:15	RAS	159078258577790	1
42	Platre	2019-02-16 17:21:27	Outils oublier (Programmer une réintervention)	159078258577790	2
43	Radio	2019-02-16 11:57:48	Personelle manquant	159078258577790	1
44	Infiltration	2019-02-16 19:15:36	RAS	159078258577790	2
45	Platre	2020-11-04 00:06:20	Annule	289117971785167	2
46	Infiltration	2021-07-04 01:17:28	Outils oublier (Programmer une réintervention)	142101422071437	2
47	Infiltration	2017-11-05 02:30:55	Le patient a pris la fuite	142101422071437	1
48	Infiltration	2017-11-05 15:01:16	RAS	142101422071437	1
49	Platre	2019-11-19 16:10:25	RAS	268125207178893	2
50	Platre	2020-08-12 22:44:37	Personelle manquant	268125207178893	1
51	Radio	2019-11-19 18:15:11	RAS	268125207178893	2
52	Platre	2019-11-19 12:06:59	Outils oublier (Programmer une réintervention)	268125207178893	2
53	Platre	2017-11-26 03:34:28	Outils oublier (Programmer une réintervention)	252083456811832	1
54	Instalation d un DCI	2017-07-19 19:03:43	Cancer confirmé	200047009218824	9
55	Examen	2021-11-16 02:48:02	RAS	200047009218824	10
56	Infiltration	2019-07-04 00:31:07	Annule	143019800299320	2
57	Point de suture	2019-07-04 13:49:18	RAS	143019800299320	2
58	Radio	2016-08-09 16:53:43	RAS	143019800299320	2
59	Depistage	2019-07-04 00:43:54	RAS	143019800299320	2
60	Radio	2021-12-01 13:45:04	RAS	211074534119340	2
61	Depistage	2015-07-10 06:01:12	Cancer confirmé	211074534119340	2
62	Infiltration	2015-07-10 09:45:57	RAS	211074534119340	1
63	Point de suture	2021-12-01 19:14:48	RAS	211074534119340	1
64	trepanation	2021-10-23 00:09:37	RAS	103125323589468	10
65	IRM	2015-11-27 01:14:21	RAS	103125323589468	12
66	Radio	2021-05-27 07:48:24	RAS	103125323589468	11
67	Ecographie	2020-09-25 21:49:11	RAS	103125323589468	12
68	Platre	2019-02-07 01:14:00	Personelle manquant	106087597638186	1
69	Platre	2019-02-07 17:53:34	RAS	106087597638186	2
70	Point de suture	2020-08-27 21:28:54	RAS	106087597638186	1
71	Point de suture	2019-02-07 16:59:29	Annule	106087597638186	2
72	Instalation d un DCI	2020-06-18 23:58:23	Membre couper par erreur	272058275424815	9
73	Platre	2016-04-16 10:51:29	Le patient a pris la fuite	273129609433214	1
74	Depistage	2017-02-02 12:04:42	RAS	273129609433214	1
75	Depistage	2017-02-02 22:10:29	RAS	273129609433214	2
76	Point de suture	2018-01-04 03:07:50	Le patient a pris la fuite	190103324064033	1
77	Infiltration	2016-05-17 16:25:43	RAS	190103324064033	2
78	Depistage	2018-01-04 03:30:57	Le patient a pris la fuite	190103324064033	2
79	Infiltration	2021-12-01 11:11:24	RAS	136127094573707	2
80	Infiltration	2021-12-01 20:18:25	Annule	136127094573707	1
81	Point de suture	2021-12-01 09:15:55	Membre couper par erreur	136127094573707	2
82	Radio	2017-03-23 13:49:34	Cancer confirmé	186117248253373	2
83	Radio	2017-03-23 15:31:53	RAS	186117248253373	2
84	Point de suture	2017-03-23 20:23:54	Le patient a pris la fuite	186117248253373	2
85	Point de suture	2017-03-23 02:26:44	Personelle manquant	186117248253373	2
86	Platre	2017-03-14 13:31:55	Membre couper par erreur	155103596746626	1
87	Platre	2017-03-14 19:15:59	Annule	155103596746626	2
88	Platre	2017-03-14 18:16:39	Le patient a pris la fuite	155103596746626	2
89	Infiltration	2017-02-05 11:32:25	Cancer confirmé	191039387061932	2
90	Platre	2021-07-02 02:54:39	Cancer confirmé	205088470224121	1
91	Depistage	2020-03-27 21:43:24	RAS	205088470224121	1
92	Radio	2019-01-24 22:28:09	RAS	168084074496066	2
93	Infiltration	2019-01-24 08:11:44	Annule	168084074496066	2
94	Platre	2020-01-26 04:30:51	Personelle manquant	168084074496066	2
95	Infiltration	2018-01-01 05:57:30	RAS	295113751469259	2
96	Point de suture	2018-10-10 11:20:16	Le patient a pris la fuite	224076688820310	2
97	Platre	2018-10-10 22:14:38	Membre couper par erreur	224076688820310	1
98	Platre	2018-10-10 12:07:16	RAS	224076688820310	2
99	Radio	2015-02-15 15:12:12	Personelle manquant	238113830884391	1
100	Infiltration	2015-02-15 05:37:38	RAS	238113830884391	2
101	Infiltration	2015-02-15 00:33:22	RAS	238113830884391	1
102	Point de suture	2015-02-15 05:35:34	Membre couper par erreur	238113830884391	2
103	IRM	2019-01-16 14:05:01	Outils oublier (Programmer une réintervention)	219023373245959	12
104	IRM	2018-12-01 15:48:09	RAS	219023373245959	12
105	Ecographie	2021-03-02 16:14:33	Le patient a pris la fuite	219023373245959	12
106	Point de suture	2017-10-08 10:13:33	RAS	269017040525206	2
107	Infiltration	2017-10-08 20:31:10	RAS	269017040525206	2
108	Infiltration	2017-10-08 02:19:29	RAS	269017040525206	1
109	Platre	2017-10-08 19:58:51	Le patient a pris la fuite	269017040525206	2
110	Depistage	2017-07-22 19:09:06	Le patient a pris la fuite	236056972976895	1
111	Infiltration	2017-07-28 22:49:34	RAS	236056972976895	1
112	Infiltration	2016-08-28 21:03:49	RAS	110026458507876	1
113	Depistage	2016-08-28 11:01:19	RAS	110026458507876	2
114	Platre	2020-02-10 08:43:08	RAS	247127106036787	2
115	Infiltration	2021-02-11 11:32:14	Membre couper par erreur	247127106036787	2
116	Platre	2021-02-11 19:31:00	Cancer confirmé	247127106036787	2
117	Radio	2017-02-08 11:39:56	RAS	138114541205136	12
118	Examen	2020-11-05 07:37:19	RAS	220061225495182	5
119	trepanation	2020-11-06 12:26:46	RAS	220061225495182	10
120	Craniatomie	2020-11-05 07:59:47	Annule	220061225495182	10
121	Chirurie	2021-12-01 08:32:08	Membre couper par erreur	220061225495182	7
122	Radio	2019-12-01 01:18:33	Outils oublier (Programmer une réintervention)	240033187603968	1
123	Infiltration	2019-12-01 19:51:53	RAS	240033187603968	1
124	trepanation	2021-03-07 17:30:18	Outils oublier (Programmer une réintervention)	272070825829025	5
125	Point de suture	2019-10-25 04:44:26	Membre couper par erreur	272070825829025	6
126	Point de suture	2018-11-27 13:40:58	RAS	272070825829025	6
127	Craniatomie	2021-02-02 03:46:48	RAS	272070825829025	10
128	Transplantation	2018-01-21 03:18:48	RAS	157087167057385	8
129	Depistage	2020-12-01 13:43:35	Membre couper par erreur	157087167057385	2
130	Transplantation	2018-08-09 09:18:26	Membre couper par erreur	157087167057385	8
131	Infiltration	2021-01-07 08:21:45	Outils oublier (Programmer une réintervention)	157087167057385	1
132	Radio	2021-11-11 20:14:03	RAS	133032823100292	1
133	Platre	2021-12-01 23:53:53	Annule	133032823100292	2
134	Transplantation	2019-06-08 03:57:45	RAS	127115565413833	8
135	Cardioversion	2020-02-01 14:48:08	Cancer confirmé	127115565413833	9
136	Cardioversion	2020-01-03 04:23:57	Membre couper par erreur	127115565413833	8
137	Chirurgie cardiaque	2018-11-27 21:24:59	RAS	127115565413833	8
138	Point de suture	2021-08-02 02:12:01	RAS	188029343169600	1
139	Radio	2021-08-02 22:28:31	Personelle manquant	188029343169600	1
140	Platre	2021-08-02 09:37:12	Annule	188029343169600	2
141	Depistage	2021-08-02 15:17:57	RAS	188029343169600	1
142	Platre	2021-05-01 02:19:51	RAS	224064678226352	1
143	Depistage	2021-05-01 03:27:58	RAS	224064678226352	2
144	Platre	2021-05-01 09:34:35	Outils oublier (Programmer une réintervention)	224064678226352	1
145	Chirurie	2020-09-03 15:42:58	RAS	116109407794060	7
146	Radio	2017-03-10 06:12:16	Outils oublier (Programmer une réintervention)	116109407794060	2
147	Depistage	2017-09-14 22:01:26	RAS	272039140869355	2
148	Point de suture	2015-12-01 22:42:16	Personelle manquant	272039140869355	2
149	Depistage	2017-09-14 19:05:06	RAS	272039140869355	1
150	Platre	2015-10-03 02:19:28	RAS	208074951895256	2
151	Infiltration	2015-10-03 23:33:14	RAS	208074951895256	2
152	Radio	2021-09-12 05:26:19	RAS	213106211666187	11
153	Reanimation	2021-12-01 14:51:09	RAS	213106211666187	6
154	Scanner	2021-09-21 20:58:00	Cancer confirmé	213106211666187	12
155	Radio	2021-04-15 09:29:34	Personelle manquant	118087215592174	1
156	Infiltration	2021-04-15 21:09:58	RAS	118087215592174	2
157	Point de suture	2020-04-13 04:39:33	Annule	234067373357213	2
158	Depistage	2020-04-13 09:50:26	RAS	234067373357213	1
159	Point de suture	2021-05-09 15:30:36	Le patient a pris la fuite	188045887135447	1
160	Depistage	2020-02-19 21:18:03	RAS	188045887135447	1
161	Infiltration	2020-02-19 17:32:23	RAS	188045887135447	2
162	Infiltration	2020-01-14 01:45:50	RAS	188045887135447	1
163	Infiltration	2015-05-10 19:45:22	RAS	241080926692571	2
164	Radio	2021-08-06 09:22:02	RAS	264097854809707	1
165	Depistage	2021-08-06 21:00:50	RAS	264097854809707	1
166	Depistage	2021-08-06 10:21:26	RAS	264097854809707	1
167	Platre	2021-08-06 02:19:22	RAS	264097854809707	1
168	Depistage	2021-07-13 12:43:10	RAS	144046178449562	1
169	Depistage	2017-08-09 07:37:02	Personelle manquant	144046178449562	2
170	Point de suture	2021-12-01 17:23:38	Le patient a pris la fuite	189095171291580	7
171	Point de suture	2021-12-01 22:34:44	Le patient a pris la fuite	189095171291580	6
172	Point de suture	2015-09-21 10:42:13	RAS	189095171291580	6
173	Chirurgie	2021-07-17 08:09:33	RAS	175015762007662	3
174	Infiltration	2021-05-19 12:52:31	RAS	227064841682823	1
175	Infiltration	2021-05-19 04:21:56	Cancer confirmé	227064841682823	2
176	Radio	2021-08-17 00:33:16	Outils oublier (Programmer une réintervention)	227064841682823	2
177	Point de suture	2021-08-17 20:30:27	Annule	227064841682823	1
178	Depistage	2020-07-12 15:26:09	Membre couper par erreur	292109226948564	2
179	Platre	2020-07-12 12:20:34	Le patient a pris la fuite	292109226948564	2
180	Depistage	2021-01-17 19:42:33	Outils oublier (Programmer une réintervention)	292109226948564	1
181	Laminectomie	2021-12-01 02:52:34	Cancer confirmé	155095540067981	10
182	Chirurgie	2021-11-27 13:55:49	RAS	155095540067981	3
183	Examen	2021-11-28 22:12:58	RAS	155095540067981	5
184	IRM	2021-05-17 03:04:29	RAS	228088926039612	11
185	Radio	2021-02-08 18:46:26	RAS	228088926039612	11
186	Ecographie	2020-10-16 23:57:15	Personelle manquant	228088926039612	12
187	Examen	2021-12-01 09:41:50	RAS	228088926039612	5
188	Radio	2019-07-24 20:45:35	RAS	257117887417480	2
189	Depistage	2018-12-01 21:55:16	Le patient a pris la fuite	257117887417480	2
190	Depistage	2021-03-19 22:30:09	Personelle manquant	225031944898819	1
191	Depistage	2021-03-19 05:56:48	Membre couper par erreur	225031944898819	1
192	Infiltration	2021-03-19 05:29:18	RAS	225031944898819	1
193	Infiltration	2019-01-09 08:54:49	Personelle manquant	185092827286780	1
194	Chirurgie	2018-02-22 23:39:51	RAS	264043437527700	4
195	Reanimation	2021-11-17 13:22:44	Membre couper par erreur	264043437527700	7
196	Platre	2021-11-02 07:55:16	Outils oublier (Programmer une réintervention)	245015721956300	2
197	Platre	2020-01-01 04:09:57	RAS	245015721956300	1
198	Radio	2015-08-03 07:40:08	Outils oublier (Programmer une réintervention)	231046716894840	1
199	Depistage	2016-06-23 13:30:41	Personelle manquant	231046716894840	2
200	Chirurie	2021-10-26 17:46:33	RAS	140063743131455	6
201	IRM	2021-10-28 09:11:50	Outils oublier (Programmer une réintervention)	140063743131455	12
202	Infiltration	2021-01-15 18:51:28	Membre couper par erreur	171022452464038	1
203	Radio	2021-01-15 14:20:30	Personelle manquant	171022452464038	1
204	Radio	2016-10-11 12:16:36	RAS	279097002609694	1
205	Craniatomie	2020-01-02 12:39:52	RAS	279097002609694	10
206	Craniatomie	2019-11-21 02:17:06	RAS	279097002609694	10
207	Radio	2021-12-01 15:28:27	Le patient a pris la fuite	187070500246915	11
208	Depistage	2019-09-05 20:35:54	RAS	212072855963112	2
209	Radio	2018-12-01 05:05:03	RAS	212072855963112	2
210	Examen	2021-11-23 12:19:11	RAS	262091838145236	4
211	trepanation	2020-07-06 09:24:12	RAS	262091838145236	10
212	Chirurgie	2020-11-28 18:45:55	Le patient a pris la fuite	262091838145236	4
213	IRM	2019-07-23 22:33:02	Cancer confirmé	276029947381735	12
214	Ecographie	2018-12-01 08:32:23	RAS	276029947381735	12
215	Ecographie	2017-03-23 03:06:53	Outils oublier (Programmer une réintervention)	276029947381735	11
216	IRM	2019-05-24 01:50:03	RAS	276029947381735	11
217	Platre	2019-09-27 18:53:47	Le patient a pris la fuite	259078280957764	1
218	Infiltration	2019-01-21 00:18:03	Outils oublier (Programmer une réintervention)	259078280957764	2
219	Platre	2019-01-21 01:20:49	RAS	259078280957764	1
220	Radio	2016-09-11 07:14:43	Le patient a pris la fuite	279017621953618	1
221	Platre	2019-06-28 09:26:58	Membre couper par erreur	279017621953618	2
222	Depistage	2016-09-11 07:00:09	RAS	279017621953618	1
223	Infiltration	2016-09-11 23:50:38	Cancer confirmé	279017621953618	2
224	Platre	2021-09-21 11:19:26	RAS	291059430428428	1
225	Depistage	2020-12-01 07:16:02	Membre couper par erreur	291059430428428	1
226	Radio	2015-11-16 00:25:11	Le patient a pris la fuite	225088516583057	2
227	Depistage	2015-09-19 02:17:27	RAS	254036634248290	1
228	Radio	2015-04-24 13:03:14	RAS	199055493956493	2
229	Radio	2015-04-24 03:51:18	RAS	199055493956493	2
230	Radio	2015-04-24 22:17:57	RAS	199055493956493	2
231	Depistage	2015-04-24 11:47:06	RAS	199055493956493	1
232	Platre	2017-03-20 06:51:54	Cancer confirmé	251044262482430	2
233	Infiltration	2017-03-20 14:46:50	RAS	251044262482430	1
234	Platre	2017-03-20 15:44:52	Le patient a pris la fuite	251044262482430	2
235	Point de suture	2016-11-27 04:36:43	RAS	230107599623686	6
236	Radio	2019-02-21 03:37:41	RAS	157028597172844	1
237	Radio	2019-02-21 18:01:36	Personelle manquant	157028597172844	2
238	Point de suture	2019-02-21 10:13:37	RAS	157028597172844	2
239	Platre	2019-02-21 02:57:02	RAS	157028597172844	2
240	Radio	2019-02-26 12:21:11	Cancer confirmé	214072768854685	1
241	Depistage	2021-12-01 02:33:49	Personelle manquant	214072768854685	2
242	Depistage	2019-02-26 22:25:13	RAS	214072768854685	2
243	Infiltration	2019-02-26 22:17:29	RAS	214072768854685	2
244	Platre	2020-10-20 02:36:39	Annule	280026155058522	2
245	Platre	2020-10-20 06:26:14	Outils oublier (Programmer une réintervention)	280026155058522	1
246	Radio	2021-08-14 19:00:34	RAS	135091467058684	1
247	Infiltration	2021-08-14 01:44:30	RAS	135091467058684	1
248	Infiltration	2019-06-24 00:46:28	Le patient a pris la fuite	135091467058684	2
249	Platre	2016-07-18 00:50:06	Cancer confirmé	299096402146261	1
250	Platre	2021-03-07 02:34:47	RAS	123079019442742	1
251	Point de suture	2021-03-07 03:36:29	Personelle manquant	123079019442742	1
252	Depistage	2021-08-27 21:09:29	Personelle manquant	123079019442742	2
253	Platre	2018-11-16 15:26:19	Outils oublier (Programmer une réintervention)	285073076628400	2
254	Point de suture	2018-11-16 02:52:30	RAS	285073076628400	2
255	Point de suture	2015-02-20 17:45:54	Le patient a pris la fuite	122076067789172	2
256	Point de suture	2015-02-20 16:37:03	RAS	122076067789172	1
257	Infiltration	2015-02-20 12:57:36	RAS	122076067789172	1
258	Infiltration	2016-08-10 17:43:19	Annule	223079798264179	2
259	Radio	2021-05-05 02:38:42	RAS	287128641152343	12
260	Depistage	2019-01-03 05:56:41	RAS	124064655533453	2
261	Infiltration	2019-06-05 08:34:03	Outils oublier (Programmer une réintervention)	124064655533453	2
262	Infiltration	2021-10-28 16:38:20	Membre couper par erreur	177087933217555	1
263	Infiltration	2021-10-28 14:32:40	RAS	177087933217555	2
264	Chirurgie cardiaque	2021-10-12 14:15:23	RAS	178083543213634	8
265	Instalation d un DCI	2021-10-03 06:32:58	Annule	178083543213634	8
266	Radio	2021-02-19 07:59:52	Membre couper par erreur	193052131885364	2
267	Platre	2021-04-03 05:46:42	RAS	193052131885364	1
268	Craniatomie	2016-05-08 14:50:27	Le patient a pris la fuite	193052131885364	5
269	Examen	2015-07-26 03:06:04	Personelle manquant	193052131885364	5
270	Infiltration	2021-03-17 15:37:48	Personelle manquant	138021076527659	1
2878	IRM	2021-03-13 10:01:02	RAS	270014064481086	11
271	Platre	2021-03-17 07:49:59	Annule	138021076527659	2
272	Depistage	2020-01-22 20:15:18	RAS	112011349625910	1
273	Point de suture	2020-01-22 20:53:06	RAS	112011349625910	1
274	Chirurie	2015-07-18 14:13:33	RAS	130110933481910	7
275	Radio	2020-06-10 22:49:34	RAS	200036971177056	2
276	Point de suture	2016-01-18 11:32:55	Annule	200036971177056	2
277	Radio	2016-04-15 00:34:02	Le patient a pris la fuite	200036971177056	1
278	Radio	2018-03-03 23:39:13	RAS	248026335038972	2
279	Instalation d un DCI	2015-07-01 02:06:47	Outils oublier (Programmer une réintervention)	113087786480165	8
280	Point de suture	2019-04-24 19:51:40	RAS	279045756456236	2
281	Platre	2018-11-23 13:40:15	RAS	158031664828007	2
282	Platre	2021-11-27 11:52:31	RAS	158031664828007	1
283	Radio	2018-11-23 08:04:40	RAS	158031664828007	2
284	Point de suture	2019-07-18 12:33:35	Membre couper par erreur	158031664828007	1
285	Point de suture	2017-11-25 14:03:02	RAS	253107320548282	2
286	Depistage	2017-11-25 23:43:12	RAS	253107320548282	2
287	Depistage	2017-11-25 13:20:07	RAS	253107320548282	1
288	Platre	2017-11-25 02:12:18	RAS	253107320548282	1
289	Platre	2019-08-26 10:26:21	Annule	159112943567608	2
290	Depistage	2021-05-04 00:53:43	Annule	159112943567608	1
291	Infiltration	2020-01-16 10:33:01	Outils oublier (Programmer une réintervention)	159112943567608	1
292	Platre	2020-02-27 19:10:32	Cancer confirmé	159112943567608	1
293	Radio	2018-05-23 22:35:41	Personelle manquant	249024680955619	2
294	Reanimation	2021-12-01 03:53:58	Annule	192057011550036	7
295	Ecographie	2019-10-16 18:44:23	RAS	192057011550036	11
296	Chirurie	2021-12-01 09:13:59	RAS	192057011550036	7
297	Infiltration	2021-12-01 13:03:03	Le patient a pris la fuite	256083287261288	1
298	Radio	2016-01-07 13:09:17	Le patient a pris la fuite	248098049506176	2
299	Radio	2016-06-20 21:24:23	RAS	248098049506176	2
300	Radio	2016-01-07 21:27:37	Annule	248098049506176	1
301	Point de suture	2016-01-07 05:42:20	RAS	248098049506176	1
302	Platre	2017-11-05 20:22:51	Le patient a pris la fuite	232123044977541	2
303	Depistage	2017-02-06 05:43:58	Annule	232123044977541	2
304	Platre	2015-07-18 15:33:09	RAS	232123044977541	1
305	Radio	2017-11-05 17:16:29	Le patient a pris la fuite	232123044977541	1
306	trepanation	2021-12-01 10:47:20	Membre couper par erreur	148074826149072	10
307	trepanation	2021-12-01 03:34:52	RAS	148074826149072	10
308	Laminectomie	2021-12-01 06:48:43	RAS	148074826149072	10
309	trepanation	2021-12-01 07:02:39	Outils oublier (Programmer une réintervention)	148074826149072	10
310	Depistage	2021-12-01 20:03:43	RAS	199051568162490	1
311	Platre	2021-12-01 07:17:42	Cancer confirmé	199051568162490	1
312	Platre	2021-12-01 09:27:42	Le patient a pris la fuite	199051568162490	2
313	Depistage	2021-12-01 05:32:38	Le patient a pris la fuite	199051568162490	2
314	Infiltration	2021-03-05 06:45:19	Personelle manquant	192091009413573	1
315	Platre	2020-10-15 05:39:42	Membre couper par erreur	167024655249766	2
316	Platre	2020-10-17 23:15:35	Outils oublier (Programmer une réintervention)	167024655249766	2
317	Radio	2020-10-15 01:18:26	RAS	167024655249766	2
318	Depistage	2021-07-24 06:20:34	RAS	160017115802452	2
319	Point de suture	2021-07-24 11:01:04	Le patient a pris la fuite	160017115802452	2
320	Depistage	2021-07-24 19:01:36	Personelle manquant	160017115802452	2
321	Infiltration	2021-07-24 10:14:56	RAS	160017115802452	2
322	Radio	2021-07-02 11:31:59	Annule	153016273510071	2
323	Point de suture	2021-07-02 03:56:41	RAS	153016273510071	2
324	Point de suture	2017-03-24 20:18:45	Personelle manquant	153016273510071	2
325	Point de suture	2017-03-24 08:50:53	Personelle manquant	153016273510071	2
326	Chirurgie cardiaque	2021-11-16 08:01:45	Le patient a pris la fuite	230073061835012	8
327	Chirurgie cardiaque	2015-05-27 12:56:21	RAS	230073061835012	9
328	Chirurgie cardiaque	2018-11-12 05:55:14	RAS	230073061835012	8
329	Platre	2016-09-18 00:36:14	RAS	242060173510692	1
330	Point de suture	2016-09-18 22:43:08	RAS	242060173510692	2
331	Platre	2018-07-03 00:16:14	RAS	168076338524481	1
332	Depistage	2018-12-09 05:07:36	Personelle manquant	168076338524481	2
333	Depistage	2018-11-02 06:16:04	RAS	168076338524481	1
334	Laminectomie	2020-11-28 00:42:41	Annule	112059565719842	10
335	Infiltration	2021-12-01 14:38:19	Le patient a pris la fuite	112059565719842	1
336	Platre	2021-10-18 14:00:59	RAS	112059565719842	2
337	Depistage	2021-11-05 23:40:34	Membre couper par erreur	112059565719842	2
338	Radio	2017-04-19 23:30:35	RAS	136076785900286	1
339	Radio	2017-04-19 17:38:07	Le patient a pris la fuite	136076785900286	2
340	Radio	2017-04-19 05:34:02	RAS	136076785900286	1
341	Platre	2017-04-19 20:29:14	RAS	136076785900286	2
342	Depistage	2021-09-24 21:11:21	Annule	103024280047064	2
343	Infiltration	2021-11-09 01:49:34	RAS	103024280047064	1
344	Radio	2021-05-26 06:56:53	RAS	103024280047064	1
345	Depistage	2017-06-13 22:27:47	Cancer confirmé	268075069028143	2
346	Point de suture	2017-06-13 12:59:32	RAS	268075069028143	2
347	Point de suture	2017-06-13 21:00:39	Le patient a pris la fuite	268075069028143	2
348	Platre	2017-06-13 20:34:19	RAS	268075069028143	2
349	Radio	2016-12-01 23:15:48	RAS	249111185011005	1
350	Radio	2016-07-10 15:49:17	RAS	185059544397412	1
351	Point de suture	2016-07-10 07:30:42	Le patient a pris la fuite	185059544397412	1
352	Depistage	2016-07-10 18:19:17	RAS	185059544397412	2
353	Platre	2021-05-26 09:02:58	Membre couper par erreur	101115361637735	1
354	Infiltration	2021-04-02 22:20:21	Personelle manquant	101115361637735	1
355	Radio	2021-04-02 16:36:39	Membre couper par erreur	101115361637735	2
356	Point de suture	2021-04-02 19:47:18	Personelle manquant	101115361637735	2
357	Depistage	2019-09-02 23:30:30	Outils oublier (Programmer une réintervention)	223064299968133	2
358	Platre	2019-05-09 07:39:18	Annule	223064299968133	1
359	Depistage	2019-09-02 05:04:24	Membre couper par erreur	223064299968133	2
360	Platre	2019-09-02 23:12:07	Cancer confirmé	223064299968133	2
361	Point de suture	2021-08-16 13:35:22	RAS	290030296252649	6
362	Reanimation	2020-05-19 22:51:40	Le patient a pris la fuite	290030296252649	6
363	Chirurie	2021-08-03 20:02:44	Membre couper par erreur	290030296252649	6
364	Radio	2019-05-15 11:16:13	RAS	183096237207201	2
365	Radio	2019-05-15 20:49:21	Outils oublier (Programmer une réintervention)	183096237207201	1
366	Point de suture	2016-08-20 22:09:42	RAS	257102630986082	1
367	Platre	2016-08-20 08:53:09	Cancer confirmé	257102630986082	1
368	Radio	2016-08-20 14:21:25	RAS	257102630986082	1
369	trepanation	2019-03-10 13:24:34	RAS	139058252403158	10
370	Chirurie	2021-10-23 12:29:08	Outils oublier (Programmer une réintervention)	139058252403158	6
371	Ecographie	2021-08-12 22:09:58	Annule	139058252403158	11
372	Infiltration	2016-04-08 09:43:19	Annule	197092256134117	1
373	Radio	2016-04-08 13:16:29	RAS	197092256134117	1
374	Examen	2020-11-03 03:15:25	Outils oublier (Programmer une réintervention)	167073348121233	3
375	Reanimation	2017-01-28 15:46:35	Le patient a pris la fuite	167073348121233	6
376	Point de suture	2016-03-18 02:05:07	Cancer confirmé	167073348121233	7
377	Chirurgie	2020-09-23 23:37:04	RAS	167073348121233	4
378	Depistage	2016-10-27 02:54:31	RAS	257084916573371	2
379	Depistage	2016-10-27 15:33:19	RAS	257084916573371	1
380	Radio	2016-10-26 17:32:05	Le patient a pris la fuite	257084916573371	2
381	Depistage	2020-03-21 23:15:06	Annule	269064890143438	2
382	Infiltration	2020-03-21 19:11:49	RAS	269064890143438	2
383	Depistage	2020-03-21 18:27:35	Le patient a pris la fuite	269064890143438	2
384	Radio	2020-03-21 09:31:52	RAS	269064890143438	1
385	Point de suture	2018-05-12 18:25:36	Le patient a pris la fuite	107063793494291	2
386	Point de suture	2018-05-12 04:15:40	RAS	107063793494291	2
387	Point de suture	2018-09-27 07:05:09	RAS	172057342339830	2
388	Point de suture	2018-09-27 16:52:52	RAS	172057342339830	1
389	Radio	2018-09-27 17:53:50	Personelle manquant	172057342339830	1
390	Infiltration	2018-09-27 00:37:07	RAS	172057342339830	2
391	Infiltration	2017-10-24 10:22:51	Membre couper par erreur	179076282691743	1
392	Infiltration	2021-10-02 17:34:12	RAS	179076282691743	1
393	Depistage	2015-08-03 08:44:31	Personelle manquant	125053714364144	2
394	Infiltration	2015-08-03 16:08:58	RAS	125053714364144	1
395	Depistage	2021-09-21 15:48:19	Personelle manquant	125053714364144	1
396	Point de suture	2016-10-10 18:16:23	Annule	107116261245646	1
397	Radio	2016-10-10 08:33:05	Le patient a pris la fuite	107116261245646	2
398	Point de suture	2016-10-10 12:45:36	RAS	107116261245646	2
399	Depistage	2016-10-10 21:25:37	RAS	107116261245646	1
400	Depistage	2016-07-12 23:16:32	Cancer confirmé	222095362060135	1
401	Depistage	2016-07-12 10:06:28	Annule	222095362060135	1
402	Depistage	2016-07-12 00:07:26	Outils oublier (Programmer une réintervention)	222095362060135	1
403	Radio	2016-07-12 14:29:42	RAS	222095362060135	2
404	Platre	2020-04-14 19:26:28	Outils oublier (Programmer une réintervention)	154100549674560	1
405	Radio	2020-04-14 21:55:51	RAS	154100549674560	1
406	Radio	2020-06-25 03:48:16	Le patient a pris la fuite	154100549674560	1
407	Platre	2020-06-25 15:46:12	Annule	154100549674560	1
408	Radio	2021-06-01 07:47:53	RAS	243124767698205	2
409	Radio	2021-02-05 13:09:42	RAS	243124767698205	2
410	Depistage	2021-06-01 21:21:29	Outils oublier (Programmer une réintervention)	243124767698205	1
411	Radio	2021-06-01 11:25:49	Cancer confirmé	243124767698205	2
412	Depistage	2020-07-02 20:26:02	RAS	240055800882855	1
413	Platre	2015-12-01 00:19:27	RAS	240055800882855	2
414	Infiltration	2017-01-26 17:09:03	Le patient a pris la fuite	213114441086169	1
415	Craniatomie	2019-12-01 20:07:20	RAS	250022187467305	10
416	Radio	2019-04-26 01:07:59	RAS	109039206294408	2
417	Point de suture	2020-11-10 16:17:04	Personelle manquant	109039206294408	1
418	Platre	2020-12-01 12:30:02	RAS	160026095111549	2
419	Platre	2020-12-01 20:42:18	Cancer confirmé	160026095111549	1
420	Infiltration	2020-12-01 18:29:04	Cancer confirmé	160026095111549	1
421	Point de suture	2020-12-01 23:09:16	RAS	160026095111549	2
422	Examen	2021-01-11 10:58:22	RAS	237012302577364	3
423	Examen	2020-03-19 06:13:08	Cancer confirmé	237012302577364	3
424	Point de suture	2017-09-28 22:10:48	Personelle manquant	140088069682239	6
425	Depistage	2016-12-01 08:38:52	RAS	102050748294646	2
426	Infiltration	2020-07-10 05:03:57	RAS	173016545039252	2
427	Infiltration	2020-07-10 00:24:50	Cancer confirmé	173016545039252	2
428	Point de suture	2020-07-10 05:26:24	Le patient a pris la fuite	173016545039252	2
429	Infiltration	2020-07-10 02:58:55	RAS	173016545039252	2
430	Point de suture	2015-10-07 22:38:46	RAS	165011896866744	2
431	Point de suture	2016-09-14 05:04:25	Annule	150070518841138	2
432	Depistage	2016-09-04 00:13:36	RAS	150070518841138	2
433	Infiltration	2016-09-04 15:07:08	RAS	150070518841138	1
434	Infiltration	2016-09-04 16:01:04	Cancer confirmé	150070518841138	1
435	Point de suture	2017-02-11 18:23:26	Annule	171115439111771	2
436	Platre	2021-11-22 06:59:47	Personelle manquant	177037001185459	1
437	Infiltration	2019-02-10 13:39:16	Outils oublier (Programmer une réintervention)	299080308159168	1
438	Platre	2019-02-10 12:56:47	Personelle manquant	299080308159168	2
439	Point de suture	2016-11-05 07:49:03	Cancer confirmé	299080308159168	2
440	Chirurgie	2021-12-01 08:03:17	Le patient a pris la fuite	111069747504039	4
441	Point de suture	2019-05-06 16:01:06	Cancer confirmé	127103535268416	1
442	Point de suture	2017-07-24 21:47:39	Personelle manquant	127103535268416	1
443	Point de suture	2019-05-06 15:45:22	Membre couper par erreur	127103535268416	1
444	Infiltration	2019-05-06 03:42:10	Membre couper par erreur	127103535268416	1
445	Radio	2020-06-06 01:07:07	Cancer confirmé	297028710752743	2
446	Examen	2021-07-06 18:20:38	Le patient a pris la fuite	111094658103947	4
447	Point de suture	2019-01-24 07:17:45	RAS	216063297975659	2
448	Point de suture	2016-01-11 15:34:51	Personelle manquant	197114552893819	1
449	Depistage	2016-01-11 11:09:29	RAS	197114552893819	2
450	Depistage	2016-01-11 03:02:47	Personelle manquant	197114552893819	1
451	Depistage	2015-03-21 18:36:17	Le patient a pris la fuite	261095472962933	1
452	Infiltration	2015-09-13 11:09:46	Le patient a pris la fuite	102011564442610	2
453	Radio	2015-09-13 17:55:30	RAS	102011564442610	1
454	Depistage	2017-06-28 01:45:47	Annule	102011564442610	1
455	Infiltration	2015-09-13 03:41:33	RAS	102011564442610	2
456	Depistage	2021-10-21 14:42:09	RAS	126086148657250	2
457	Craniatomie	2019-06-24 04:31:49	RAS	126086148657250	5
458	Radio	2021-09-26 19:08:16	RAS	126086148657250	2
459	Point de suture	2021-09-25 00:46:31	RAS	126086148657250	2
460	Radio	2021-08-17 14:14:59	Personelle manquant	193091370484103	2
461	Depistage	2019-03-03 07:17:34	Le patient a pris la fuite	193091370484103	2
462	Radio	2016-01-22 03:22:08	RAS	136084997092352	1
463	Platre	2016-09-19 05:12:11	Cancer confirmé	136084997092352	1
464	Radio	2016-09-19 06:17:36	Outils oublier (Programmer une réintervention)	136084997092352	1
465	Platre	2016-09-19 12:33:35	Outils oublier (Programmer une réintervention)	136084997092352	2
466	Point de suture	2019-09-14 17:29:34	RAS	135101302110067	6
467	Point de suture	2019-08-01 00:58:51	RAS	135101302110067	7
468	Reanimation	2021-06-02 22:35:26	RAS	135101302110067	6
469	Chirurie	2021-03-21 10:48:51	RAS	135101302110067	6
470	Depistage	2021-12-01 23:00:43	Le patient a pris la fuite	133057388336451	1
471	Platre	2021-12-01 11:49:24	Cancer confirmé	133057388336451	2
472	Infiltration	2020-12-01 07:42:09	Outils oublier (Programmer une réintervention)	133057388336451	2
473	Radio	2021-04-23 13:12:51	Membre couper par erreur	108038498976924	4
474	Examen	2021-12-01 12:58:45	Outils oublier (Programmer une réintervention)	108038498976924	4
475	Radio	2021-08-07 12:27:33	RAS	108038498976924	3
476	Cardioversion	2019-12-06 02:39:24	Annule	108038498976924	8
477	Platre	2021-11-21 11:00:09	Outils oublier (Programmer une réintervention)	266012535044395	1
478	Infiltration	2020-09-26 04:16:47	Outils oublier (Programmer une réintervention)	266012535044395	2
479	Radio	2020-09-26 11:02:16	Personelle manquant	266012535044395	1
480	Point de suture	2019-09-01 22:16:29	Le patient a pris la fuite	235081064179459	2
481	Depistage	2019-09-01 20:45:49	RAS	235081064179459	2
482	Platre	2019-09-01 13:27:55	RAS	235081064179459	1
483	Radio	2019-07-22 07:19:40	Annule	189071551347808	2
484	Platre	2017-10-15 13:58:33	RAS	189071551347808	1
485	Depistage	2017-10-15 10:17:57	RAS	189071551347808	2
486	Platre	2019-07-10 20:32:16	Le patient a pris la fuite	294103109740262	1
487	Platre	2020-10-25 19:43:16	Annule	294103109740262	2
488	Point de suture	2020-10-25 02:42:57	Outils oublier (Programmer une réintervention)	294103109740262	1
489	Radio	2019-07-10 13:25:19	RAS	294103109740262	1
490	Radio	2018-01-24 05:26:40	RAS	147110710661853	1
491	Infiltration	2021-02-26 16:40:43	RAS	145077876002511	2
492	Point de suture	2016-03-21 17:20:01	Membre couper par erreur	145077876002511	2
493	Infiltration	2020-01-26 03:19:11	RAS	145077876002511	1
494	Platre	2018-12-01 17:48:06	RAS	221014625770907	1
495	Platre	2018-10-07 12:18:08	Outils oublier (Programmer une réintervention)	221014625770907	2
496	Depistage	2018-10-07 04:08:52	RAS	221014625770907	1
497	Radio	2018-09-03 10:42:33	RAS	221014625770907	1
498	Platre	2020-12-01 16:52:26	RAS	289077275942294	1
499	Radio	2020-10-14 07:47:12	Membre couper par erreur	289077275942294	2
500	Infiltration	2020-12-01 12:53:06	RAS	289077275942294	2
501	Infiltration	2021-06-27 00:28:13	RAS	230044759876745	1
502	Depistage	2021-06-27 15:58:57	RAS	230044759876745	1
503	Platre	2018-11-10 12:00:06	Outils oublier (Programmer une réintervention)	296119994996166	2
504	Depistage	2018-04-09 09:39:05	Cancer confirmé	296119994996166	2
505	Infiltration	2018-07-26 20:38:22	Personelle manquant	296119994996166	1
506	Radio	2018-01-26 11:24:34	Annule	296119994996166	1
507	Radio	2019-01-05 08:00:43	RAS	154034482837144	2
508	Point de suture	2019-01-05 10:29:19	RAS	154034482837144	1
509	Depistage	2019-01-05 20:17:23	RAS	154034482837144	1
510	Radio	2019-01-05 07:38:31	Membre couper par erreur	154034482837144	2
511	Depistage	2019-03-08 03:21:01	Annule	212069761197108	2
512	Depistage	2017-12-01 12:51:26	RAS	119034662639308	2
513	Platre	2017-11-27 17:54:58	RAS	119034662639308	1
514	Radio	2018-05-05 05:29:24	RAS	117097307536183	2
515	Radio	2018-05-05 04:02:07	RAS	117097307536183	2
516	Infiltration	2018-05-05 06:56:44	Le patient a pris la fuite	117097307536183	1
517	Depistage	2018-05-05 17:40:52	RAS	117097307536183	1
518	Platre	2020-06-25 12:06:11	RAS	260124860732275	1
519	Platre	2020-06-25 11:54:25	RAS	260124860732275	1
520	Infiltration	2019-02-11 15:58:18	RAS	172089291557913	2
521	Depistage	2018-10-26 19:47:34	Membre couper par erreur	172089291557913	2
522	Radio	2016-10-02 06:43:07	Le patient a pris la fuite	224129352103655	12
523	trepanation	2021-12-01 00:31:13	Membre couper par erreur	224129352103655	5
524	trepanation	2021-12-01 01:00:08	Membre couper par erreur	224129352103655	5
525	Examen	2021-11-27 10:41:49	Personelle manquant	224129352103655	10
526	Scanner	2021-04-18 11:47:42	RAS	186035821684512	11
527	Ecographie	2019-04-14 14:35:20	Membre couper par erreur	186035821684512	11
528	Ecographie	2018-05-03 11:23:54	RAS	186035821684512	12
529	Radio	2021-04-19 12:04:54	Annule	282116367172719	2
530	Radio	2021-04-19 04:23:44	Le patient a pris la fuite	282116367172719	1
531	Point de suture	2021-04-19 21:58:56	RAS	282116367172719	2
532	Infiltration	2017-08-07 21:52:56	Annule	282116367172719	1
533	Radio	2019-08-06 15:10:22	RAS	298063513226885	2
534	Radio	2021-03-16 15:52:31	RAS	298063513226885	2
535	Point de suture	2021-03-16 12:29:53	Outils oublier (Programmer une réintervention)	298063513226885	1
536	Point de suture	2018-06-20 03:52:45	Outils oublier (Programmer une réintervention)	257126563480430	2
537	Radio	2016-06-21 23:34:29	RAS	227101652934764	1
538	Instalation d un DCI	2016-05-03 16:53:32	RAS	117031740249272	8
539	Instalation d un DCI	2016-01-16 05:49:25	RAS	117031740249272	9
540	Cardioversion	2016-08-15 03:38:53	RAS	117031740249272	9
541	Reanimation	2020-08-22 06:33:58	Le patient a pris la fuite	117031740249272	7
542	Radio	2015-03-06 20:26:02	RAS	281027462517127	1
543	Point de suture	2015-03-06 15:03:06	RAS	281027462517127	2
544	IRM	2018-12-19 22:31:09	RAS	195098864552439	11
545	Chirurie	2021-11-20 23:04:21	Personelle manquant	195098864552439	6
546	Radio	2021-10-25 11:41:44	RAS	139077210843596	12
547	Infiltration	2021-12-01 02:52:50	Cancer confirmé	238051213766800	1
548	Radio	2020-11-20 13:52:37	RAS	238051213766800	2
549	Point de suture	2020-11-20 02:52:44	Personelle manquant	238051213766800	1
550	Radio	2018-08-08 13:30:06	Personelle manquant	180014450742418	1
551	Laminectomie	2019-10-13 23:55:51	Outils oublier (Programmer une réintervention)	282103173173307	5
552	trepanation	2021-06-20 21:31:06	Membre couper par erreur	282103173173307	10
553	Point de suture	2021-12-01 18:08:38	RAS	130032128540230	2
554	Point de suture	2021-11-15 02:20:43	Outils oublier (Programmer une réintervention)	282093945534106	6
555	Chirurie	2021-11-20 14:39:13	RAS	282093945534106	6
556	Laminectomie	2019-07-28 02:27:53	RAS	294041736505100	5
557	Examen	2020-09-16 11:54:40	Membre couper par erreur	294041736505100	10
558	Examen	2020-09-13 16:36:24	Le patient a pris la fuite	294041736505100	5
559	Examen	2019-06-17 15:12:22	Annule	294041736505100	5
560	Point de suture	2021-05-27 07:50:42	Cancer confirmé	160113579531989	2
561	Platre	2021-05-27 22:41:31	RAS	160113579531989	2
562	Infiltration	2021-05-27 21:22:38	RAS	160113579531989	1
563	Platre	2016-09-22 17:57:09	Le patient a pris la fuite	269032951239687	1
564	Radio	2016-05-20 11:26:54	RAS	269032951239687	1
565	Point de suture	2019-09-07 08:44:10	Outils oublier (Programmer une réintervention)	107087128682443	1
566	Depistage	2019-09-07 04:16:46	RAS	107087128682443	2
567	Infiltration	2020-06-06 08:25:52	RAS	289106989656446	2
568	Depistage	2020-06-06 17:03:41	RAS	289106989656446	2
569	Infiltration	2019-11-10 04:38:50	RAS	289106989656446	2
570	Depistage	2016-10-12 01:12:22	Personelle manquant	116100226032930	1
571	Point de suture	2016-10-12 07:15:43	Outils oublier (Programmer une réintervention)	116100226032930	1
572	Depistage	2016-10-12 01:27:10	Personelle manquant	116100226032930	2
573	Depistage	2016-10-12 17:12:38	Personelle manquant	116100226032930	1
574	Radio	2021-10-13 09:28:10	RAS	259056721582059	4
575	Point de suture	2021-08-27 00:06:20	Le patient a pris la fuite	259056721582059	6
576	Examen	2021-09-27 09:33:37	RAS	259056721582059	4
577	Radio	2016-08-28 16:55:11	Membre couper par erreur	259056721582059	11
578	Craniatomie	2021-12-01 14:57:28	RAS	296078344435443	5
579	Reanimation	2017-03-22 08:37:59	Cancer confirmé	296078344435443	7
580	Examen	2021-12-01 09:13:20	RAS	296078344435443	5
581	Reanimation	2019-02-18 19:44:56	Le patient a pris la fuite	296078344435443	6
582	Radio	2019-07-27 17:36:12	RAS	275101635834500	2
583	Platre	2019-07-27 02:48:23	Outils oublier (Programmer une réintervention)	275101635834500	2
584	Radio	2019-07-27 13:35:51	RAS	275101635834500	1
585	Radio	2020-01-17 22:58:42	Cancer confirmé	196104695126094	2
586	Radio	2020-01-17 21:56:04	RAS	196104695126094	1
587	Depistage	2019-03-28 07:10:30	RAS	196104695126094	2
588	Platre	2020-01-17 23:09:35	Annule	196104695126094	2
589	Infiltration	2018-01-25 16:48:05	Personelle manquant	104084767796763	1
590	Platre	2018-01-25 10:17:56	Annule	104084767796763	1
591	Platre	2019-08-20 01:18:11	RAS	173069866743140	2
592	Platre	2020-12-01 08:25:35	Outils oublier (Programmer une réintervention)	176026748099490	2
593	Radio	2018-03-22 07:41:30	RAS	103117548023800	1
594	Infiltration	2018-03-22 19:01:38	Le patient a pris la fuite	103117548023800	2
595	Platre	2021-03-22 04:08:09	Annule	148109232252267	1
596	Infiltration	2016-06-15 08:10:05	Cancer confirmé	194069349220315	2
597	Depistage	2016-06-15 15:19:27	Outils oublier (Programmer une réintervention)	194069349220315	1
598	Point de suture	2016-06-15 22:03:43	Personelle manquant	194069349220315	2
599	Radio	2016-06-15 21:55:53	Outils oublier (Programmer une réintervention)	194069349220315	2
600	Point de suture	2018-10-19 01:31:25	RAS	140123122489282	1
601	Platre	2020-11-26 13:37:46	Cancer confirmé	140123122489282	1
602	Platre	2018-10-19 03:38:59	Outils oublier (Programmer une réintervention)	140123122489282	1
603	Point de suture	2020-11-26 16:40:32	Cancer confirmé	140123122489282	1
604	Transplantation	2020-08-10 11:00:58	RAS	255125446859673	9
605	Instalation d un DCI	2019-11-12 06:04:07	RAS	255125446859673	8
606	Chirurgie cardiaque	2020-11-09 17:42:49	Outils oublier (Programmer une réintervention)	255125446859673	8
607	Cardioversion	2020-02-04 18:32:38	RAS	255125446859673	8
608	IRM	2021-10-16 20:37:18	RAS	230081205171029	11
609	Scanner	2021-10-21 14:28:53	RAS	230081205171029	12
610	Platre	2019-06-12 05:09:03	Le patient a pris la fuite	271094924607285	2
611	Point de suture	2019-06-12 14:07:32	RAS	271094924607285	1
612	Depistage	2018-10-19 12:04:35	Personelle manquant	132084756535784	1
613	Platre	2018-10-19 13:27:27	RAS	132084756535784	2
614	Infiltration	2020-05-17 12:01:47	Annule	196100412822638	2
615	Platre	2018-08-16 12:43:41	RAS	297013402217591	2
616	Infiltration	2018-08-16 19:10:31	RAS	297013402217591	2
617	Platre	2021-03-22 11:09:48	Outils oublier (Programmer une réintervention)	220122235099677	1
618	Depistage	2021-03-22 23:42:25	Le patient a pris la fuite	220122235099677	1
619	Radio	2021-03-22 02:03:52	Membre couper par erreur	220122235099677	1
620	Radio	2016-09-16 03:47:25	Annule	173096580101586	2
621	Point de suture	2016-09-16 21:42:57	Cancer confirmé	173096580101586	1
622	Point de suture	2021-10-28 07:16:46	RAS	173096580101586	1
623	Radio	2021-10-28 13:14:25	Le patient a pris la fuite	173096580101586	1
624	Infiltration	2020-01-02 20:31:10	Membre couper par erreur	282046629787403	1
625	Point de suture	2020-01-02 21:41:40	Membre couper par erreur	282046629787403	1
626	Infiltration	2020-01-02 06:41:44	RAS	282046629787403	2
627	Point de suture	2020-01-02 09:02:14	Personelle manquant	282046629787403	1
628	IRM	2021-07-01 11:11:46	Outils oublier (Programmer une réintervention)	231060729971548	12
629	IRM	2020-09-24 16:17:01	Le patient a pris la fuite	231060729971548	12
630	IRM	2020-07-01 16:49:45	Annule	231060729971548	11
631	Point de suture	2018-05-16 05:37:11	RAS	261043349444673	2
632	Radio	2018-05-16 08:55:39	Personelle manquant	261043349444673	2
633	Point de suture	2018-05-16 08:53:02	RAS	261043349444673	2
634	Radio	2021-02-22 18:29:27	RAS	261043349444673	1
635	Infiltration	2019-07-16 18:35:44	Outils oublier (Programmer une réintervention)	115012156909773	1
636	Infiltration	2019-10-12 04:50:03	RAS	115012156909773	1
637	Infiltration	2018-06-15 21:55:58	RAS	131107626638488	2
638	Point de suture	2018-06-15 04:47:48	RAS	131107626638488	1
639	Point de suture	2018-06-15 14:29:19	Membre couper par erreur	131107626638488	2
640	Infiltration	2021-03-15 05:41:42	Membre couper par erreur	251127256365773	1
641	Depistage	2019-06-16 19:35:06	RAS	251127256365773	1
642	trepanation	2021-09-28 08:49:36	Le patient a pris la fuite	267125703711841	10
643	Laminectomie	2021-10-11 11:10:13	RAS	267125703711841	10
644	Laminectomie	2021-09-09 19:41:03	RAS	267125703711841	5
645	Infiltration	2021-08-27 09:26:20	RAS	263084417717835	2
646	Point de suture	2021-08-27 17:06:23	Le patient a pris la fuite	263084417717835	2
647	Platre	2021-08-27 17:43:13	Personelle manquant	263084417717835	2
648	Point de suture	2021-08-27 19:57:16	Le patient a pris la fuite	263084417717835	2
649	Chirurgie	2021-12-01 06:25:56	RAS	244078512056467	4
650	Craniatomie	2021-11-18 15:45:50	Cancer confirmé	244078512056467	10
651	Infiltration	2019-12-14 21:30:58	RAS	244078512056467	1
652	Depistage	2021-04-09 12:51:06	RAS	244078512056467	2
653	Depistage	2019-06-14 04:53:37	RAS	218120988164777	2
654	Point de suture	2015-03-02 17:03:39	RAS	218120988164777	1
655	Depistage	2019-06-14 01:56:19	RAS	218120988164777	1
656	Infiltration	2021-02-17 01:47:50	Annule	257095588726569	1
657	Instalation d un DCI	2020-08-15 15:14:00	RAS	166065352240321	9
658	Transplantation	2020-06-12 06:36:45	RAS	166065352240321	8
659	Depistage	2021-07-28 20:15:12	Annule	166065352240321	2
660	Examen	2021-01-16 14:50:07	RAS	166065352240321	10
661	Depistage	2020-08-24 15:50:52	Outils oublier (Programmer une réintervention)	194012458189138	2
662	Depistage	2020-08-24 02:57:27	RAS	194012458189138	2
663	Transplantation	2021-10-05 14:07:03	RAS	270125888665229	9
664	Chirurgie cardiaque	2021-03-28 03:02:27	RAS	270125888665229	9
665	Platre	2021-01-09 18:17:42	Annule	158059952001652	1
666	Point de suture	2020-06-16 10:17:17	Outils oublier (Programmer une réintervention)	158059952001652	2
667	Infiltration	2020-06-16 15:49:30	Le patient a pris la fuite	158059952001652	2
668	Platre	2021-12-01 14:41:23	Annule	259026635921108	2
669	Infiltration	2021-12-01 01:18:57	Le patient a pris la fuite	259026635921108	2
670	Depistage	2021-12-01 18:25:10	Annule	259026635921108	1
671	Depistage	2016-11-18 12:06:53	RAS	222066223450293	1
672	Radio	2016-11-18 19:48:46	RAS	222066223450293	1
673	Point de suture	2016-11-18 10:17:48	RAS	222066223450293	2
674	Radio	2018-01-12 23:47:53	Le patient a pris la fuite	294035173348892	1
675	Cardioversion	2015-10-08 20:31:29	Membre couper par erreur	185012960779831	9
676	Chirurgie cardiaque	2017-02-03 16:14:57	RAS	185012960779831	9
677	Cardioversion	2018-11-10 13:21:46	Membre couper par erreur	185012960779831	8
678	Radio	2018-05-24 01:32:36	Cancer confirmé	272017325071928	4
679	Radio	2019-08-16 11:37:35	Membre couper par erreur	272017325071928	4
680	Radio	2016-08-01 04:55:33	RAS	272017325071928	4
681	Examen	2016-12-01 11:23:43	RAS	272017325071928	3
682	Radio	2015-06-11 00:03:56	Personelle manquant	290078809746561	2
683	Radio	2018-10-02 07:50:55	RAS	290078809746561	1
684	IRM	2021-03-12 22:12:40	Cancer confirmé	184054997914403	11
685	Laminectomie	2019-08-27 20:06:46	RAS	224036658465337	10
686	trepanation	2021-10-14 07:25:50	RAS	224036658465337	10
687	Radio	2021-11-09 14:29:54	RAS	224036658465337	3
688	Craniatomie	2020-07-03 05:22:07	Outils oublier (Programmer une réintervention)	224036658465337	5
689	Point de suture	2020-07-14 05:46:48	RAS	204063744707638	1
690	Radio	2020-11-11 19:30:19	RAS	133077951509022	2
691	Depistage	2021-01-27 09:29:49	RAS	279068550131477	1
692	Point de suture	2021-01-27 08:15:53	RAS	279068550131477	1
693	Radio	2021-01-27 21:07:44	Annule	279068550131477	1
694	Point de suture	2021-01-27 23:53:22	RAS	279068550131477	2
695	Infiltration	2021-10-01 15:13:27	RAS	140021429173584	1
696	Point de suture	2021-11-20 18:37:36	Membre couper par erreur	140021429173584	6
697	Infiltration	2021-06-04 21:50:48	Outils oublier (Programmer une réintervention)	140021429173584	1
698	Platre	2021-10-13 17:49:01	RAS	116087933558285	1
699	Platre	2021-09-14 03:31:27	RAS	116087933558285	2
700	Platre	2021-09-14 00:18:01	Le patient a pris la fuite	116087933558285	2
701	Infiltration	2015-11-16 13:14:55	Outils oublier (Programmer une réintervention)	184042816040471	2
702	Platre	2017-12-01 10:12:24	RAS	184042816040471	2
703	Radio	2015-11-16 01:31:40	RAS	184042816040471	1
704	Chirurie	2021-11-25 20:45:50	Le patient a pris la fuite	262065796255647	7
705	Point de suture	2016-08-25 17:22:51	RAS	289116874121144	1
706	Infiltration	2021-05-03 05:02:17	RAS	289116874121144	1
707	Radio	2016-09-08 07:09:35	RAS	254043611144658	1
708	Depistage	2020-06-22 07:29:08	RAS	268031648794265	1
709	Point de suture	2020-06-22 21:53:00	RAS	268031648794265	2
710	Point de suture	2020-06-22 09:34:13	Personelle manquant	268031648794265	2
711	Depistage	2020-06-22 15:51:32	Le patient a pris la fuite	268031648794265	2
712	Point de suture	2018-12-01 01:49:55	Cancer confirmé	287059122651264	2
713	Point de suture	2018-12-01 07:13:03	RAS	287059122651264	1
714	Point de suture	2018-12-01 18:47:01	RAS	287059122651264	2
715	Depistage	2018-12-01 11:41:50	Outils oublier (Programmer une réintervention)	287059122651264	2
716	Examen	2020-07-18 09:16:37	Membre couper par erreur	298073164942612	5
717	Platre	2020-07-20 16:32:12	RAS	131121957283294	2
718	Depistage	2020-07-20 14:33:57	RAS	131121957283294	1
719	Radio	2020-07-20 18:43:40	RAS	131121957283294	2
720	Platre	2020-07-20 21:25:00	Membre couper par erreur	131121957283294	1
721	Depistage	2019-09-10 07:00:07	Personelle manquant	188110658741765	2
722	Infiltration	2019-09-10 10:15:10	Annule	188110658741765	2
723	Point de suture	2019-09-10 06:58:48	Le patient a pris la fuite	188110658741765	1
724	Depistage	2019-06-02 06:36:50	RAS	172057142211349	2
725	Platre	2019-06-02 07:02:33	Outils oublier (Programmer une réintervention)	172057142211349	1
726	Platre	2019-05-28 20:14:51	Cancer confirmé	106029864328731	2
727	Radio	2020-03-06 00:23:14	Personelle manquant	106029864328731	2
728	Depistage	2020-11-25 03:37:42	Outils oublier (Programmer une réintervention)	297077289777229	2
729	Point de suture	2016-08-08 17:17:51	Cancer confirmé	297077289777229	1
730	Radio	2019-01-15 00:14:45	RAS	297077289777229	1
731	Platre	2019-11-18 03:09:13	Membre couper par erreur	159099939848446	2
732	Point de suture	2019-11-18 04:48:20	RAS	159099939848446	1
733	Depistage	2019-11-18 07:11:31	Cancer confirmé	159099939848446	1
734	Point de suture	2021-08-10 06:53:04	RAS	111129599402824	2
735	Platre	2021-08-10 06:54:46	RAS	111129599402824	1
736	Platre	2021-08-10 01:29:36	Membre couper par erreur	111129599402824	2
737	Radio	2018-06-28 10:56:09	RAS	115120226939995	2
738	Radio	2018-07-16 00:24:51	RAS	115120226939995	2
739	Platre	2018-12-01 09:42:43	Outils oublier (Programmer une réintervention)	115120226939995	1
740	Radio	2018-08-01 23:08:17	RAS	115120226939995	2
741	Infiltration	2021-03-18 02:28:44	Annule	178108944503402	1
742	Platre	2020-03-10 10:46:25	RAS	261023956555783	1
743	Infiltration	2021-09-07 23:53:09	RAS	235061978907881	1
744	Radio	2021-09-07 07:02:46	Outils oublier (Programmer une réintervention)	235061978907881	1
745	Infiltration	2021-09-07 09:31:47	RAS	235061978907881	2
746	Radio	2019-02-24 22:17:29	Cancer confirmé	160076989558266	1
747	Chirurgie	2021-05-21 14:46:41	RAS	237044696201755	3
748	Examen	2021-04-05 10:11:19	RAS	237044696201755	4
749	Radio	2020-08-15 18:01:39	RAS	237044696201755	2
750	Infiltration	2020-12-01 23:37:37	RAS	237044696201755	2
751	Point de suture	2020-06-02 11:01:58	RAS	147087143819012	2
752	Depistage	2019-01-04 11:16:29	Membre couper par erreur	147087143819012	1
753	Platre	2018-10-15 22:11:37	Cancer confirmé	181026482885579	1
754	Depistage	2018-10-15 07:23:56	Outils oublier (Programmer une réintervention)	181026482885579	2
755	Infiltration	2021-11-12 04:38:49	RAS	181026482885579	1
756	Radio	2018-02-04 08:20:34	Annule	129073106456222	1
757	Platre	2018-02-04 00:27:17	RAS	129073106456222	2
758	Infiltration	2018-02-04 21:28:15	RAS	129073106456222	1
759	Infiltration	2018-02-04 21:30:23	RAS	129073106456222	2
760	Platre	2020-11-01 10:33:23	Annule	241090757336013	2
761	Chirurgie cardiaque	2018-01-28 20:56:16	Cancer confirmé	171110762807449	8
762	Platre	2021-03-24 05:51:41	Personelle manquant	171110762807449	1
763	Chirurie	2021-10-07 19:08:47	RAS	171110762807449	7
764	Reanimation	2021-12-01 02:10:42	RAS	277093701187718	6
765	Examen	2020-09-21 06:42:01	RAS	277093701187718	10
766	trepanation	2020-09-18 11:55:59	RAS	277093701187718	5
767	Infiltration	2021-04-13 14:12:24	RAS	233024779652808	2
768	Point de suture	2016-12-01 05:42:28	Personelle manquant	233024779652808	2
769	Infiltration	2021-04-13 00:50:53	RAS	233024779652808	2
770	Infiltration	2021-04-13 20:16:19	RAS	233024779652808	1
771	Examen	2020-03-08 19:21:13	Membre couper par erreur	299090800746875	4
772	Radio	2020-03-23 20:50:30	Membre couper par erreur	299090800746875	4
773	Chirurgie	2020-06-06 15:03:47	Cancer confirmé	299090800746875	4
774	Radio	2019-01-17 13:18:39	RAS	299090800746875	4
775	Platre	2021-12-01 16:56:26	Annule	186033471783730	1
776	Point de suture	2021-12-01 12:31:34	Annule	186033471783730	1
777	Platre	2021-01-19 12:57:06	RAS	186033471783730	1
778	Radio	2021-02-10 20:33:52	RAS	186033471783730	1
779	Infiltration	2016-03-08 00:42:28	Cancer confirmé	124065145979904	1
780	Infiltration	2016-03-08 14:16:02	RAS	124065145979904	2
781	Point de suture	2016-03-08 10:58:10	RAS	124065145979904	2
782	Infiltration	2016-03-08 18:20:44	RAS	124065145979904	2
783	Infiltration	2019-10-23 21:09:34	Le patient a pris la fuite	249013256140217	2
784	Depistage	2016-08-25 16:49:11	RAS	249013256140217	1
785	Depistage	2016-08-25 16:32:23	Outils oublier (Programmer une réintervention)	249013256140217	1
786	Radio	2020-09-04 22:16:54	RAS	193118595042552	2
787	Radio	2017-12-01 17:45:21	RAS	193118595042552	1
788	Infiltration	2020-09-04 10:24:20	Cancer confirmé	193118595042552	2
789	Point de suture	2017-12-01 19:28:35	RAS	193118595042552	1
790	Chirurie	2021-04-26 18:24:07	Cancer confirmé	159081311543565	6
791	Reanimation	2021-04-23 10:54:00	Annule	159081311543565	6
792	Chirurie	2021-04-24 10:49:33	Le patient a pris la fuite	159081311543565	6
793	Cardioversion	2016-07-01 23:41:56	RAS	173038729083641	9
794	Chirurgie cardiaque	2016-06-24 16:14:43	Membre couper par erreur	173038729083641	8
795	Depistage	2019-07-11 22:35:05	RAS	173038729083641	2
796	Radio	2021-07-22 19:16:05	Annule	173038729083641	3
797	Radio	2020-01-05 08:31:24	Personelle manquant	221074080373957	1
798	Ecographie	2021-06-03 10:42:17	RAS	158060447338923	12
799	Point de suture	2021-12-01 04:28:56	Personelle manquant	191129347920866	6
800	Platre	2020-11-12 11:27:11	RAS	146033753292561	1
801	Platre	2020-11-12 11:48:12	Outils oublier (Programmer une réintervention)	146033753292561	2
802	Point de suture	2021-03-25 00:28:49	RAS	235048088880828	6
803	Chirurie	2020-07-27 22:05:39	RAS	235048088880828	6
804	Depistage	2021-05-25 17:39:46	Le patient a pris la fuite	232076673853214	2
805	Point de suture	2021-05-25 02:57:00	Membre couper par erreur	232076673853214	2
806	Radio	2021-05-25 01:18:57	RAS	232076673853214	1
807	Infiltration	2021-05-25 15:43:33	RAS	232076673853214	2
808	Platre	2020-12-01 06:58:23	Annule	286090186822302	2
809	Depistage	2020-11-24 06:11:10	Le patient a pris la fuite	286090186822302	1
810	Infiltration	2020-11-24 12:36:46	RAS	286090186822302	2
811	Platre	2020-12-01 13:46:30	Le patient a pris la fuite	286090186822302	2
812	Depistage	2018-02-22 13:35:44	Annule	118091053967656	2
813	Point de suture	2018-02-22 18:57:47	Personelle manquant	118091053967656	1
814	Infiltration	2015-06-17 00:18:26	Annule	118091053967656	1
815	Point de suture	2015-06-17 23:19:30	RAS	118091053967656	2
816	Point de suture	2020-12-01 20:18:52	RAS	158102532502789	2
817	Platre	2015-01-07 03:42:23	RAS	158102532502789	1
818	Point de suture	2017-09-13 07:41:21	RAS	234042453907063	2
819	Depistage	2017-09-13 17:59:57	Personelle manquant	234042453907063	2
820	Platre	2017-09-13 19:31:20	RAS	234042453907063	2
821	Infiltration	2020-10-21 04:13:03	Cancer confirmé	174108510634221	2
822	Point de suture	2020-10-21 17:36:39	Cancer confirmé	174108510634221	1
823	Depistage	2021-11-06 00:28:09	Cancer confirmé	106024732204736	2
824	Depistage	2021-11-09 10:51:20	Cancer confirmé	106024732204736	2
825	Infiltration	2021-11-09 13:13:44	RAS	106024732204736	2
826	Depistage	2021-11-09 16:49:35	Membre couper par erreur	106024732204736	2
827	Reanimation	2019-02-24 03:00:26	Annule	210082757893566	7
828	Depistage	2018-08-11 13:31:02	RAS	274074214651338	2
829	Point de suture	2019-02-09 06:41:41	RAS	274074214651338	1
830	Depistage	2019-02-09 16:19:58	Le patient a pris la fuite	274074214651338	1
831	Chirurgie cardiaque	2021-07-22 14:41:39	Membre couper par erreur	213049451577031	8
832	Chirurgie cardiaque	2021-08-25 08:21:59	Le patient a pris la fuite	213049451577031	8
833	Chirurgie cardiaque	2021-03-14 05:05:57	RAS	213049451577031	8
834	Transplantation	2021-01-14 10:52:19	Outils oublier (Programmer une réintervention)	213049451577031	8
835	Radio	2015-10-14 05:52:28	Outils oublier (Programmer une réintervention)	285020199679212	1
836	Infiltration	2015-10-14 16:51:59	Outils oublier (Programmer une réintervention)	285020199679212	2
837	Radio	2018-01-23 18:10:43	Membre couper par erreur	153094524936207	2
838	Platre	2018-01-23 17:08:54	RAS	153094524936207	2
839	Platre	2016-04-04 05:41:12	Cancer confirmé	132049184273634	2
840	Depistage	2021-10-10 22:59:08	Cancer confirmé	276037987247044	1
841	Platre	2021-10-10 06:07:54	Annule	276037987247044	2
842	Depistage	2018-04-16 03:41:44	RAS	242105257964173	2
843	Radio	2018-04-16 21:34:18	Annule	242105257964173	1
844	Platre	2018-04-16 16:35:05	RAS	242105257964173	2
845	Infiltration	2018-04-16 19:15:45	Personelle manquant	242105257964173	2
846	Platre	2021-01-17 22:43:14	RAS	173064457870768	2
847	Platre	2020-07-11 13:37:47	Membre couper par erreur	208025327926752	2
848	Infiltration	2019-01-17 06:11:12	Membre couper par erreur	208025327926752	1
849	Infiltration	2020-07-11 10:22:20	RAS	208025327926752	2
850	Reanimation	2021-03-24 05:37:15	Membre couper par erreur	150066519299853	7
851	Infiltration	2016-01-23 17:55:01	Annule	230101267074777	2
852	Radio	2016-01-23 07:21:40	Annule	230101267074777	2
853	Point de suture	2018-05-28 17:43:52	Cancer confirmé	249032164220679	2
854	Infiltration	2019-10-22 17:02:43	Personelle manquant	249032164220679	2
855	Point de suture	2019-02-20 09:34:59	RAS	128032363278916	6
856	Reanimation	2019-03-08 02:34:53	Personelle manquant	128032363278916	6
857	Chirurgie cardiaque	2021-10-28 09:02:46	Membre couper par erreur	128032363278916	8
858	Reanimation	2019-05-22 11:02:31	RAS	128032363278916	7
859	Point de suture	2020-03-28 14:52:56	Membre couper par erreur	220097402246683	7
860	Infiltration	2019-12-01 04:21:04	RAS	210054779062612	1
861	Infiltration	2019-12-01 00:43:22	Cancer confirmé	210054779062612	1
862	Depistage	2019-12-01 16:37:21	Personelle manquant	210054779062612	1
863	Infiltration	2021-02-17 16:58:20	RAS	231077978618248	1
864	Depistage	2021-02-17 10:14:23	RAS	231077978618248	2
865	Platre	2021-02-17 11:51:50	RAS	231077978618248	2
866	Point de suture	2021-02-17 02:43:04	RAS	231077978618248	1
867	Infiltration	2019-06-17 19:50:09	RAS	264057206314352	1
868	Point de suture	2019-06-17 19:20:26	Membre couper par erreur	264057206314352	2
869	Infiltration	2019-06-17 22:19:27	Cancer confirmé	264057206314352	2
870	Infiltration	2019-06-17 14:41:35	RAS	264057206314352	2
871	Point de suture	2021-08-11 21:42:21	Le patient a pris la fuite	288115135986478	1
872	Radio	2015-04-16 22:43:42	Cancer confirmé	288115135986478	1
873	Radio	2021-08-11 20:56:40	Cancer confirmé	288115135986478	2
874	Radio	2020-04-01 02:30:51	RAS	231076141443908	2
875	Radio	2017-05-09 12:28:53	Annule	139037968769029	1
876	Point de suture	2017-05-09 15:11:29	RAS	139037968769029	2
877	Depistage	2017-05-09 19:59:32	RAS	139037968769029	2
878	Point de suture	2017-05-09 16:09:22	Cancer confirmé	139037968769029	2
879	Platre	2018-02-12 13:21:10	RAS	188049194998024	2
880	Platre	2018-02-12 14:25:34	RAS	188049194998024	2
881	Radio	2018-02-12 05:54:01	RAS	188049194998024	1
882	Infiltration	2021-08-21 20:57:56	RAS	258065169240672	1
883	Point de suture	2020-10-12 08:07:17	RAS	258065169240672	1
884	Infiltration	2018-05-16 04:17:24	Outils oublier (Programmer une réintervention)	232129815038482	1
885	Point de suture	2020-01-14 19:45:53	RAS	232129815038482	1
886	Point de suture	2020-01-14 14:13:43	Cancer confirmé	232129815038482	1
887	Point de suture	2021-01-08 12:40:03	Cancer confirmé	145093900289545	2
888	Point de suture	2020-03-07 13:38:38	Cancer confirmé	145093900289545	2
889	Platre	2020-05-10 01:31:07	Membre couper par erreur	145093900289545	1
890	Radio	2020-05-01 06:02:58	Membre couper par erreur	145093900289545	2
891	Platre	2015-02-26 12:13:20	RAS	267121440433418	2
892	Chirurie	2016-04-02 07:28:35	Personelle manquant	227015778432519	6
893	Reanimation	2015-10-05 21:04:15	RAS	227015778432519	6
894	Reanimation	2016-05-20 23:53:08	RAS	227015778432519	6
895	Depistage	2017-06-08 03:07:11	Cancer confirmé	199129081130353	2
896	Infiltration	2017-02-06 01:28:17	Membre couper par erreur	199129081130353	2
897	Infiltration	2016-03-23 10:11:42	RAS	243121776162227	1
898	Depistage	2020-08-18 04:05:39	Cancer confirmé	259114157338055	2
899	Point de suture	2020-08-18 06:02:39	Annule	259114157338055	2
900	Radio	2020-04-27 09:01:15	RAS	262105941528540	2
901	Depistage	2020-04-27 01:08:48	RAS	262105941528540	2
902	Infiltration	2020-04-27 12:44:37	RAS	262105941528540	2
903	Cardioversion	2021-04-17 09:17:39	Personelle manquant	109028760703504	9
904	Point de suture	2021-11-19 06:36:57	RAS	109028760703504	2
905	Radio	2021-11-22 01:47:36	Annule	109028760703504	1
906	Infiltration	2020-10-12 09:15:05	RAS	109028760703504	1
907	Chirurie	2020-10-09 08:51:53	Personelle manquant	111061695359540	6
908	trepanation	2017-11-11 10:46:39	RAS	111061695359540	10
909	Laminectomie	2018-04-09 20:23:42	RAS	111061695359540	5
910	trepanation	2018-10-21 05:19:05	Membre couper par erreur	111061695359540	5
911	Radio	2020-09-26 17:22:52	RAS	104113276019870	2
912	Infiltration	2020-11-02 23:48:07	Cancer confirmé	104113276019870	2
913	Point de suture	2020-09-18 00:56:57	RAS	104113276019870	1
914	Radio	2020-06-22 06:48:04	Outils oublier (Programmer une réintervention)	283023385915710	2
915	Radio	2020-06-22 10:45:33	RAS	283023385915710	1
916	Point de suture	2020-06-22 15:42:21	Membre couper par erreur	283023385915710	1
917	Examen	2020-01-03 01:35:02	Le patient a pris la fuite	245093190848672	3
918	Radio	2020-07-12 12:01:34	RAS	245093190848672	4
919	Chirurgie	2021-02-14 17:08:58	RAS	245093190848672	3
920	Chirurgie	2019-04-24 13:25:05	Personelle manquant	245093190848672	3
921	Chirurgie	2021-05-28 15:07:17	RAS	204069532268616	4
922	Scanner	2021-12-01 22:58:35	Annule	204069532268616	11
923	Scanner	2021-12-01 11:00:52	RAS	204069532268616	12
924	Chirurgie cardiaque	2021-05-27 00:55:19	Personelle manquant	266125761809637	9
925	Scanner	2017-02-11 15:48:46	RAS	266125761809637	11
926	Point de suture	2021-05-10 10:29:07	RAS	179043377875534	1
927	Radio	2018-01-19 06:56:29	Personelle manquant	179043377875534	2
928	Radio	2020-06-08 06:13:40	RAS	179043377875534	1
929	Chirurie	2019-10-21 09:46:47	RAS	112012210565675	7
930	Depistage	2016-12-01 08:05:56	RAS	279090179414274	2
931	Point de suture	2020-09-02 04:47:05	RAS	279090179414274	1
932	Infiltration	2020-09-02 09:47:09	Membre couper par erreur	279090179414274	1
933	Depistage	2015-07-17 18:52:57	RAS	160121447322029	1
934	Depistage	2020-03-22 13:40:42	Annule	113013415022913	2
935	Infiltration	2019-09-04 23:40:07	Le patient a pris la fuite	265027129877746	1
936	Platre	2019-09-04 01:22:13	RAS	265027129877746	1
937	Radio	2015-09-02 22:22:10	RAS	265027129877746	1
938	IRM	2021-12-01 07:19:56	RAS	297052200312957	12
939	Radio	2021-12-01 08:00:08	RAS	297052200312957	12
940	Ecographie	2021-12-01 13:18:26	Le patient a pris la fuite	297052200312957	11
941	Platre	2017-04-14 19:15:17	RAS	122014663436309	1
942	Depistage	2015-05-27 19:27:39	Le patient a pris la fuite	187012554792695	2
943	Platre	2019-10-20 16:33:47	Outils oublier (Programmer une réintervention)	187012554792695	1
944	Point de suture	2018-01-08 13:08:16	RAS	180059188878011	2
945	Radio	2021-03-27 07:36:09	RAS	265029036567340	3
946	Depistage	2021-08-21 11:25:19	Le patient a pris la fuite	261121983306746	2
947	Examen	2021-11-25 09:09:11	Annule	250104194589654	4
948	Radio	2016-11-25 09:28:15	RAS	250104194589654	3
949	Instalation d un DCI	2020-06-11 13:45:33	Membre couper par erreur	250104194589654	9
950	Radio	2017-02-11 23:58:14	Cancer confirmé	250104194589654	3
951	Platre	2016-05-14 16:03:55	RAS	106061220442334	1
952	Radio	2016-05-14 19:54:49	RAS	106061220442334	1
953	Radio	2016-05-14 21:59:53	RAS	106061220442334	2
954	Point de suture	2016-05-14 11:05:51	Annule	106061220442334	1
955	Platre	2016-04-24 16:42:09	Annule	235045565580018	2
956	Radio	2016-04-24 23:22:26	RAS	235045565580018	1
957	Infiltration	2016-04-24 00:24:40	RAS	235045565580018	2
958	Point de suture	2016-04-24 16:37:01	Le patient a pris la fuite	235045565580018	1
959	Platre	2017-03-12 08:01:37	RAS	126078707125125	1
960	Point de suture	2017-03-12 18:09:38	Le patient a pris la fuite	126078707125125	2
961	Point de suture	2021-05-06 09:56:30	Outils oublier (Programmer une réintervention)	138016532409883	2
962	Radio	2021-05-06 11:41:58	RAS	138016532409883	1
963	Infiltration	2021-05-11 14:42:50	Annule	138016532409883	1
964	Depistage	2016-11-04 00:40:55	RAS	202065667224500	2
965	Reanimation	2021-12-01 16:08:19	Le patient a pris la fuite	202065667224500	7
966	Transplantation	2016-12-04 03:36:35	Annule	202065667224500	8
967	Transplantation	2017-05-18 20:23:18	RAS	202065667224500	8
968	Platre	2017-08-23 19:58:26	RAS	279028648982730	1
969	Infiltration	2018-10-27 08:18:38	RAS	167079831709246	1
970	Point de suture	2016-12-01 13:25:45	RAS	119040594612771	2
971	Infiltration	2016-12-01 10:44:51	RAS	119040594612771	1
972	Depistage	2016-12-01 21:21:06	RAS	119040594612771	2
973	Depistage	2016-12-01 14:46:08	RAS	119040594612771	1
974	Depistage	2019-04-06 11:08:27	Le patient a pris la fuite	119123584674924	2
975	Point de suture	2019-04-06 01:34:01	Personelle manquant	119123584674924	2
976	Infiltration	2019-04-06 03:16:29	RAS	119123584674924	2
977	Radio	2019-04-06 14:36:20	RAS	119123584674924	1
978	Radio	2020-10-23 01:00:41	RAS	111093957436571	1
979	Radio	2018-07-25 09:14:06	Annule	138117414994632	2
980	Depistage	2021-12-01 23:31:06	RAS	138117414994632	2
981	Chirurgie cardiaque	2020-10-02 18:47:37	RAS	108095378165916	8
982	Chirurgie cardiaque	2020-06-07 20:34:54	Personelle manquant	108095378165916	8
983	IRM	2021-05-21 17:25:13	Membre couper par erreur	108095378165916	12
984	Reanimation	2018-03-17 05:47:37	RAS	168127697496623	6
985	Radio	2017-05-27 19:35:32	Personelle manquant	106013559184560	1
986	Reanimation	2020-09-09 09:11:32	Personelle manquant	184058380356337	7
987	Point de suture	2020-06-26 09:48:02	RAS	184058380356337	6
988	Reanimation	2019-09-08 12:12:41	RAS	184058380356337	7
989	Reanimation	2018-09-13 23:01:23	Cancer confirmé	184058380356337	7
990	Platre	2016-01-02 13:29:11	Annule	198076664451368	2
991	Radio	2016-01-02 23:27:53	Cancer confirmé	198076664451368	2
992	Depistage	2016-01-02 21:45:00	Outils oublier (Programmer une réintervention)	198076664451368	2
993	Ecographie	2021-07-19 20:00:14	Outils oublier (Programmer une réintervention)	258048082897406	12
994	Ecographie	2021-12-01 12:20:21	Le patient a pris la fuite	258048082897406	12
995	Radio	2019-05-12 13:57:13	Personelle manquant	258048082897406	1
996	IRM	2020-11-13 08:50:45	Membre couper par erreur	258048082897406	12
997	Transplantation	2021-09-21 18:13:50	Outils oublier (Programmer une réintervention)	231126440314564	9
998	Infiltration	2018-05-06 16:23:31	Membre couper par erreur	204086878297454	2
999	Infiltration	2018-05-06 12:37:47	RAS	204086878297454	1
1000	Depistage	2018-05-06 04:00:29	RAS	204086878297454	1
1001	Platre	2018-05-06 09:03:05	Cancer confirmé	204086878297454	1
1002	Infiltration	2021-11-18 03:22:16	RAS	283093646958657	1
1003	Infiltration	2020-06-11 23:33:34	Outils oublier (Programmer une réintervention)	283093646958657	2
1004	Radio	2020-06-11 05:25:18	Annule	283093646958657	2
1005	Point de suture	2020-06-11 00:18:18	Annule	283093646958657	1
1006	Chirurie	2021-10-27 21:52:16	RAS	271061263635761	7
1007	Instalation d un DCI	2017-01-11 05:29:56	RAS	271061263635761	9
1008	Point de suture	2018-03-01 09:14:42	Le patient a pris la fuite	105118896795057	1
1009	Laminectomie	2019-06-21 23:49:01	Cancer confirmé	102105813093180	5
1010	trepanation	2018-09-15 04:11:57	Cancer confirmé	102105813093180	5
1011	Point de suture	2021-06-01 01:41:40	RAS	237017905332326	6
1012	Radio	2016-08-11 01:56:37	Membre couper par erreur	118077056581811	4
1013	Craniatomie	2021-11-28 04:46:12	Cancer confirmé	118077056581811	10
1014	Radio	2019-11-19 17:10:19	RAS	208044768997360	1
1015	Radio	2019-11-19 17:41:52	RAS	208044768997360	1
1016	Point de suture	2021-12-01 01:41:12	RAS	282129387212331	1
1017	Depistage	2021-12-01 05:40:56	RAS	282129387212331	2
1018	Infiltration	2021-12-01 01:04:09	RAS	220026006410436	1
1019	Ecographie	2018-02-14 02:59:45	RAS	220026006410436	12
1020	Radio	2019-08-26 17:24:14	RAS	167044562347780	1
1021	Radio	2021-07-12 12:03:48	RAS	104058028163037	1
1022	Radio	2021-07-12 16:45:08	Le patient a pris la fuite	104058028163037	2
1023	Infiltration	2021-08-23 01:50:16	Personelle manquant	104058028163037	1
1024	Infiltration	2019-02-11 09:09:51	Cancer confirmé	240055854166975	1
1025	Infiltration	2019-02-11 21:15:53	Outils oublier (Programmer une réintervention)	240055854166975	1
1026	Infiltration	2019-02-11 18:28:39	RAS	240055854166975	1
1027	Platre	2019-02-11 01:03:46	Outils oublier (Programmer une réintervention)	240055854166975	2
1028	Point de suture	2019-07-28 22:19:01	RAS	117037132207874	2
1029	Point de suture	2019-07-28 07:06:07	RAS	117037132207874	1
1030	Platre	2019-07-28 15:13:33	Personelle manquant	117037132207874	1
1031	Point de suture	2019-07-28 21:49:38	Personelle manquant	117037132207874	1
1032	Point de suture	2021-01-24 18:28:54	RAS	201045792556159	2
1033	Platre	2018-03-27 13:27:06	Le patient a pris la fuite	247076680160492	2
1034	Platre	2019-09-01 16:03:35	RAS	228021921390634	1
1035	Radio	2021-05-02 10:52:08	RAS	228021921390634	12
1036	Platre	2019-10-22 11:13:27	RAS	228021921390634	1
1037	Platre	2021-05-28 14:31:52	RAS	205021808810249	2
1038	Infiltration	2021-05-28 15:25:00	Le patient a pris la fuite	205021808810249	1
1039	Infiltration	2018-12-01 03:20:32	RAS	224110767613876	2
1040	Radio	2018-12-01 01:34:55	RAS	224110767613876	1
1041	Reanimation	2021-07-08 22:45:41	RAS	280018349144984	6
1042	Chirurie	2021-07-03 08:29:20	Personelle manquant	280018349144984	7
1043	Chirurie	2021-10-03 08:25:41	Outils oublier (Programmer une réintervention)	280018349144984	6
1044	Infiltration	2021-10-17 12:20:42	Cancer confirmé	196057096921758	1
1045	Depistage	2021-02-19 10:31:39	RAS	196057096921758	2
1046	Infiltration	2020-03-28 22:21:34	Outils oublier (Programmer une réintervention)	196057096921758	2
1047	Platre	2020-03-11 08:08:29	RAS	196057096921758	2
1048	Infiltration	2021-07-14 16:28:15	RAS	194011513570806	2
1049	Platre	2021-12-01 16:42:13	Outils oublier (Programmer une réintervention)	194011513570806	2
1050	Infiltration	2021-07-14 16:43:52	RAS	194011513570806	1
1051	Infiltration	2021-09-11 12:26:26	RAS	194011513570806	2
1052	Point de suture	2018-01-07 06:40:50	RAS	259035687657778	2
1053	Radio	2021-01-19 19:08:13	RAS	126057880251485	2
1054	Depistage	2017-09-21 17:29:09	RAS	103069351144655	1
1055	Depistage	2017-09-21 20:47:08	RAS	103069351144655	2
1056	Platre	2017-09-21 13:51:39	Outils oublier (Programmer une réintervention)	103069351144655	2
1057	Chirurgie	2021-12-01 09:43:10	RAS	196053106233543	3
1058	Depistage	2021-11-07 19:02:59	RAS	262111043702672	2
1059	Point de suture	2020-11-17 01:21:51	RAS	262111043702672	6
1060	Scanner	2021-12-01 23:01:06	Membre couper par erreur	262111043702672	12
1061	Point de suture	2017-04-03 11:33:26	Annule	197072095070400	2
1062	Infiltration	2018-07-25 10:57:00	Membre couper par erreur	197072095070400	2
1063	Point de suture	2017-04-03 06:49:32	Annule	197072095070400	2
1064	Examen	2021-10-22 15:37:04	Personelle manquant	257093009218404	5
1065	Examen	2021-11-03 15:33:53	Outils oublier (Programmer une réintervention)	257093009218404	10
1066	Depistage	2020-01-14 09:35:58	Outils oublier (Programmer une réintervention)	257093009218404	1
1067	Depistage	2020-02-19 01:16:47	Cancer confirmé	203066369133626	2
1068	Depistage	2017-07-26 03:52:48	RAS	111035950431815	2
1069	Radio	2017-07-26 23:41:48	Annule	111035950431815	1
1070	Radio	2017-07-26 23:15:07	Le patient a pris la fuite	111035950431815	1
1071	Platre	2018-02-23 05:46:49	Annule	263125259436378	2
1072	Platre	2018-02-23 17:48:07	Outils oublier (Programmer une réintervention)	263125259436378	2
1073	Infiltration	2019-04-22 21:05:57	RAS	263125259436378	1
1074	Platre	2020-05-20 23:30:42	Cancer confirmé	263125259436378	2
1075	Infiltration	2019-11-05 17:06:51	Cancer confirmé	134017162187334	1
1076	Depistage	2019-11-05 11:12:28	Personelle manquant	134017162187334	1
1077	Platre	2019-12-01 11:23:41	RAS	134017162187334	1
1078	Platre	2019-12-01 04:38:59	Membre couper par erreur	134017162187334	1
1079	Point de suture	2019-10-24 00:22:28	Personelle manquant	168030986226722	1
1080	Infiltration	2020-08-20 11:04:35	RAS	168021202642226	2
1081	Depistage	2020-08-20 23:56:39	Outils oublier (Programmer une réintervention)	168021202642226	2
1082	Platre	2020-08-20 15:29:48	RAS	168021202642226	2
1083	Chirurie	2021-11-23 13:13:17	Le patient a pris la fuite	172083246489015	6
1084	Examen	2021-12-01 02:56:02	RAS	172083246489015	4
1085	Examen	2021-10-03 07:28:13	Cancer confirmé	238058887249971	4
1086	Point de suture	2021-12-01 07:10:47	RAS	238058887249971	6
1087	Chirurie	2021-12-01 07:38:11	RAS	238058887249971	6
1088	Reanimation	2021-12-01 08:47:42	RAS	238058887249971	7
1089	Infiltration	2017-11-12 19:56:29	Annule	182121313633004	2
1090	Point de suture	2017-11-12 12:43:33	RAS	182121313633004	2
1091	Depistage	2017-11-12 02:33:54	Cancer confirmé	182121313633004	2
1092	Infiltration	2016-12-01 17:10:15	Membre couper par erreur	158024695395585	2
1093	Infiltration	2016-12-01 08:53:48	Le patient a pris la fuite	158024695395585	2
1094	Depistage	2016-12-01 17:12:17	RAS	158024695395585	2
1095	Point de suture	2021-12-01 08:57:20	Outils oublier (Programmer une réintervention)	143019130446016	1
1096	Radio	2018-12-01 19:53:01	RAS	232091464781612	2
1097	Platre	2018-12-01 22:31:38	RAS	232091464781612	2
1098	Radio	2018-12-01 07:00:19	RAS	232091464781612	2
1099	Depistage	2017-12-01 10:34:30	RAS	119054090697465	1
1100	Depistage	2017-12-01 18:58:58	RAS	119054090697465	1
1101	Infiltration	2017-12-01 15:12:12	RAS	119054090697465	2
1102	Infiltration	2017-12-01 22:31:06	RAS	119054090697465	1
1103	Laminectomie	2021-12-01 23:32:15	Cancer confirmé	224103773518604	10
1104	Transplantation	2017-12-07 09:28:54	RAS	224103773518604	8
1105	Examen	2021-12-01 11:07:05	RAS	224103773518604	10
1106	Radio	2018-05-02 18:33:08	RAS	187076588240535	2
1107	Platre	2018-06-21 10:29:45	Le patient a pris la fuite	187076588240535	2
1108	Examen	2021-12-01 17:05:19	Annule	195039141611720	3
1109	Platre	2021-08-25 14:14:11	RAS	195039141611720	2
1110	Point de suture	2021-08-20 18:50:34	Membre couper par erreur	195039141611720	2
1111	Chirurgie	2021-07-01 02:38:54	RAS	110079463566681	4
1112	Instalation d un DCI	2021-01-09 08:08:03	RAS	110079463566681	8
1113	Chirurgie cardiaque	2021-01-03 00:15:06	Membre couper par erreur	110079463566681	9
1114	Laminectomie	2021-07-22 08:46:53	Personelle manquant	146038235197769	5
1115	Laminectomie	2021-07-06 19:59:23	Le patient a pris la fuite	146038235197769	5
1116	Reanimation	2021-04-15 10:12:05	RAS	289037829621190	7
1117	Reanimation	2021-03-04 04:48:00	Le patient a pris la fuite	289037829621190	6
1118	Reanimation	2021-08-26 00:48:23	RAS	289037829621190	7
1119	Reanimation	2021-06-22 07:36:42	RAS	289037829621190	7
1120	Depistage	2017-08-04 00:16:28	RAS	103114111526792	2
1121	Point de suture	2018-05-04 19:31:32	RAS	103114111526792	1
1122	Point de suture	2016-12-01 06:26:44	RAS	103114111526792	2
1123	Platre	2018-11-25 10:51:13	Annule	256072702237635	1
1124	Platre	2018-11-25 07:39:54	Membre couper par erreur	256072702237635	1
1125	Radio	2021-08-10 04:55:14	Membre couper par erreur	287106613897037	1
1126	Radio	2021-08-10 21:58:39	Personelle manquant	287106613897037	1
1127	Radio	2019-12-01 20:24:50	RAS	287106613897037	1
1128	IRM	2021-10-08 11:54:08	Membre couper par erreur	261060456525634	11
1129	Radio	2021-09-06 09:15:04	Annule	261060456525634	11
1130	Infiltration	2021-10-15 13:16:30	Personelle manquant	196041514401521	2
1131	Instalation d un DCI	2020-08-24 18:28:51	Personelle manquant	196041514401521	9
1132	Depistage	2021-10-24 21:00:12	Personelle manquant	196041514401521	2
1133	Depistage	2021-12-01 06:01:53	Outils oublier (Programmer une réintervention)	196041514401521	2
1134	Point de suture	2016-10-11 17:51:11	RAS	131021682878445	2
1135	Depistage	2016-10-11 06:34:49	RAS	131021682878445	2
1136	Infiltration	2016-10-11 08:00:08	RAS	131021682878445	2
1137	Point de suture	2016-12-17 15:31:56	RAS	280096672979293	7
1138	Reanimation	2017-11-05 05:46:55	RAS	280096672979293	7
1139	Ecographie	2017-06-05 13:10:00	Personelle manquant	161110895952876	12
1140	Ecographie	2018-12-24 01:04:44	Cancer confirmé	161110895952876	11
1141	Point de suture	2020-09-21 11:34:45	Membre couper par erreur	161110895952876	2
1142	Radio	2017-11-19 09:02:18	RAS	161110895952876	11
1143	Depistage	2018-09-17 13:09:03	RAS	111028862692739	1
1144	Radio	2017-11-13 18:28:44	RAS	281033961629584	1
1145	Point de suture	2017-11-13 08:40:23	RAS	281033961629584	2
1146	Infiltration	2017-11-13 09:41:03	RAS	281033961629584	1
1147	Depistage	2017-11-13 04:41:29	Le patient a pris la fuite	281033961629584	2
1148	Chirurie	2019-02-05 21:59:18	RAS	283119762283310	7
1149	Examen	2019-09-13 10:02:08	Le patient a pris la fuite	291052955637911	5
1150	trepanation	2021-04-25 19:27:46	Cancer confirmé	291052955637911	5
1151	Platre	2021-09-24 00:22:04	RAS	186108833612501	1
1152	Depistage	2019-09-23 07:45:40	RAS	186108833612501	2
1153	Infiltration	2021-09-24 22:05:13	Personelle manquant	186108833612501	2
1154	Platre	2019-05-05 09:45:48	Membre couper par erreur	191087419601552	2
1155	Radio	2019-05-05 01:22:48	RAS	191087419601552	1
1156	Platre	2019-02-23 22:03:52	RAS	191087419601552	1
1157	Point de suture	2019-09-21 17:30:59	Outils oublier (Programmer une réintervention)	144032955003677	1
1158	Platre	2017-06-19 21:11:34	Membre couper par erreur	144032955003677	1
1159	Point de suture	2019-09-21 01:18:22	RAS	144032955003677	2
1160	Platre	2018-04-15 00:15:28	Membre couper par erreur	245031024735106	1
1161	Infiltration	2018-04-15 23:59:27	RAS	245031024735106	2
1162	Point de suture	2018-04-15 02:36:31	Le patient a pris la fuite	245031024735106	1
1163	Depistage	2019-10-14 05:19:31	Annule	244051103911471	2
1164	Radio	2019-10-01 05:59:54	Personelle manquant	244051103911471	2
1165	Depistage	2019-10-01 10:15:37	Membre couper par erreur	244051103911471	2
1166	Platre	2019-10-01 10:45:55	Cancer confirmé	244051103911471	1
1167	Point de suture	2021-01-28 09:03:23	Cancer confirmé	143024158070291	1
1168	IRM	2020-12-01 19:57:10	Cancer confirmé	296078260808814	11
1169	Scanner	2020-12-01 02:51:05	RAS	296078260808814	12
1170	Infiltration	2021-11-20 04:49:11	RAS	129036638333996	2
1171	Infiltration	2021-10-16 11:38:53	RAS	175084237674269	1
1172	Point de suture	2021-10-16 22:59:58	RAS	175084237674269	2
1173	Infiltration	2021-10-16 10:19:27	RAS	175084237674269	1
1174	Infiltration	2021-10-09 04:09:39	RAS	127109489453869	1
1175	Instalation d un DCI	2021-12-01 04:13:06	Outils oublier (Programmer une réintervention)	127109489453869	8
1176	Examen	2020-05-27 12:32:09	RAS	127109489453869	3
1177	Ecographie	2016-11-03 14:37:24	Annule	207121168949178	12
1178	Ecographie	2017-01-03 08:00:27	RAS	207121168949178	11
1179	Depistage	2021-05-08 20:16:57	RAS	162123090223760	2
1180	Ecographie	2021-12-01 14:59:05	RAS	196014599832638	11
1181	Platre	2021-09-08 05:57:00	Membre couper par erreur	196014599832638	2
1182	Ecographie	2021-10-28 15:08:53	Outils oublier (Programmer une réintervention)	196014599832638	12
1183	Depistage	2020-03-01 20:44:54	RAS	196014599832638	2
1184	Depistage	2017-03-24 08:28:10	RAS	249123962387030	2
1185	Radio	2019-12-01 11:54:22	Annule	249123962387030	1
1186	Platre	2019-12-01 10:01:02	Annule	249123962387030	1
1187	Radio	2019-12-01 19:14:15	Cancer confirmé	249123962387030	1
1188	Depistage	2017-09-14 00:50:25	RAS	180030334988128	2
1189	Infiltration	2017-09-14 07:58:34	RAS	180030334988128	2
1190	Point de suture	2017-09-14 14:03:12	Annule	180030334988128	2
1191	Point de suture	2018-08-01 18:08:37	RAS	160129415851720	6
1192	Cardioversion	2021-12-01 22:19:29	RAS	160129415851720	8
1193	Point de suture	2018-01-25 11:25:15	RAS	160129415851720	6
1194	Instalation d un DCI	2021-12-01 21:42:52	Annule	160129415851720	8
1195	Point de suture	2018-05-23 10:00:53	Cancer confirmé	290064596215313	2
1196	Infiltration	2020-10-20 17:50:12	Outils oublier (Programmer une réintervention)	290064596215313	2
1197	Craniatomie	2021-08-01 14:11:59	Annule	290064596215313	5
1198	Craniatomie	2021-09-07 02:42:38	RAS	290064596215313	10
1199	Infiltration	2020-01-04 21:21:04	Membre couper par erreur	162024029695095	2
1200	Platre	2019-03-15 00:28:08	Outils oublier (Programmer une réintervention)	162024029695095	2
1201	Platre	2019-08-16 01:03:36	Personelle manquant	162024029695095	1
1202	Platre	2020-01-03 03:31:39	RAS	162024029695095	1
1203	Platre	2020-02-08 07:07:28	RAS	256035745805285	1
1204	Infiltration	2020-02-08 14:35:10	Annule	256035745805285	1
1205	Infiltration	2021-10-07 05:54:08	Le patient a pris la fuite	299095883325694	1
1206	Radio	2020-09-25 13:52:56	RAS	299095883325694	1
1207	IRM	2015-09-10 01:46:32	Personelle manquant	299095883325694	11
1208	Scanner	2016-01-21 11:30:58	Membre couper par erreur	299095883325694	11
1209	Point de suture	2021-04-23 12:53:17	Personelle manquant	255010508757484	2
1210	Depistage	2021-04-23 11:39:47	RAS	255010508757484	1
1211	Point de suture	2018-06-05 21:48:08	RAS	255010508757484	2
1212	Depistage	2021-01-16 18:26:59	Membre couper par erreur	284025054958080	1
1213	Point de suture	2021-09-12 13:43:11	RAS	284025054958080	1
1214	Point de suture	2021-09-12 13:13:01	Outils oublier (Programmer une réintervention)	284025054958080	2
1215	Infiltration	2021-09-12 14:05:56	Membre couper par erreur	284025054958080	1
1216	Infiltration	2020-06-23 22:34:45	RAS	198115876820091	2
1217	Platre	2021-05-06 06:08:42	Annule	198115876820091	2
1218	Infiltration	2020-11-20 01:34:36	RAS	198115876820091	2
1219	Platre	2019-08-13 23:15:41	Membre couper par erreur	198115876820091	2
1220	Platre	2020-11-19 02:19:04	Le patient a pris la fuite	292127286360670	2
1221	Platre	2020-04-21 14:15:39	RAS	292127286360670	1
1222	Platre	2018-02-16 09:58:01	RAS	124125087042200	1
1223	Platre	2019-12-01 01:15:30	RAS	124125087042200	1
1224	Radio	2019-01-28 13:09:19	Cancer confirmé	104107459950188	2
1225	Radio	2019-01-28 02:33:35	RAS	104107459950188	1
1226	Point de suture	2019-01-28 19:00:12	RAS	104107459950188	2
1227	Chirurie	2019-11-10 01:46:20	RAS	266021326138534	7
1228	Depistage	2018-01-19 22:08:21	RAS	177099561621308	1
1229	Platre	2018-01-19 16:31:19	Personelle manquant	177099561621308	1
1230	Infiltration	2018-08-18 21:25:30	RAS	220057917231572	1
1231	Point de suture	2018-08-18 09:24:11	Personelle manquant	220057917231572	1
1232	Depistage	2018-08-18 00:20:53	Outils oublier (Programmer une réintervention)	220057917231572	2
1233	Platre	2018-08-18 16:07:13	Le patient a pris la fuite	220057917231572	1
1234	Infiltration	2021-07-13 01:55:24	RAS	115102762371703	1
1235	Depistage	2021-07-13 12:16:32	Outils oublier (Programmer une réintervention)	115102762371703	2
1236	Infiltration	2015-02-08 21:37:41	RAS	115102762371703	2
1237	Infiltration	2018-03-18 18:00:06	RAS	131109289872634	1
1238	Radio	2018-03-18 09:54:53	Annule	131109289872634	2
1239	Radio	2018-03-18 20:18:54	RAS	131109289872634	2
1240	Radio	2018-03-18 13:53:07	Personelle manquant	131109289872634	1
1241	Radio	2021-03-12 17:06:45	Outils oublier (Programmer une réintervention)	233068001860172	1
1242	Radio	2019-12-01 16:22:17	Membre couper par erreur	233068001860172	2
1243	Radio	2021-03-12 12:59:29	Cancer confirmé	233068001860172	1
1244	Radio	2018-01-13 08:17:30	Membre couper par erreur	189083343412684	1
1245	Depistage	2018-01-13 16:23:55	Cancer confirmé	189083343412684	2
1246	Depistage	2018-01-13 04:38:26	Cancer confirmé	189083343412684	2
1247	Laminectomie	2021-12-01 02:31:45	Outils oublier (Programmer une réintervention)	274017748986076	5
1248	Craniatomie	2021-12-01 09:58:31	Annule	274017748986076	5
1249	Radio	2015-07-18 01:34:00	Outils oublier (Programmer une réintervention)	274017748986076	11
1250	Radio	2021-09-11 16:54:48	Annule	203071505075882	2
1251	Chirurgie cardiaque	2020-11-18 18:23:55	RAS	203071505075882	9
1252	Chirurgie cardiaque	2020-11-17 20:40:01	RAS	203071505075882	8
1253	Depistage	2020-04-05 16:20:41	Le patient a pris la fuite	225046338616560	2
1254	Depistage	2020-04-05 09:03:43	RAS	225046338616560	2
1255	Point de suture	2021-11-22 10:43:03	Personelle manquant	282125089606113	2
1256	Radio	2019-11-06 04:03:08	Annule	282125089606113	2
1257	Platre	2019-11-06 17:33:33	RAS	282125089606113	1
1258	Scanner	2021-09-19 01:11:34	Personelle manquant	268067070083090	12
1259	Radio	2021-09-10 10:38:23	Annule	268067070083090	12
1260	trepanation	2021-12-01 13:08:08	Personelle manquant	219021809637382	5
1261	Radio	2021-07-20 08:10:37	RAS	219021809637382	11
1262	Craniatomie	2021-12-01 01:04:35	RAS	219021809637382	10
1263	Craniatomie	2019-10-26 10:05:24	RAS	148128918443996	5
1264	Point de suture	2021-11-26 02:50:13	Cancer confirmé	148128918443996	2
1265	Craniatomie	2019-10-25 02:05:03	RAS	148128918443996	10
1266	Platre	2016-07-12 10:58:47	Cancer confirmé	167073716399416	2
1267	Radio	2017-05-22 19:08:39	RAS	170026816597756	2
1268	Scanner	2016-03-15 04:01:58	Cancer confirmé	155041690002972	11
1269	IRM	2020-10-17 10:04:49	Membre couper par erreur	155041690002972	12
1270	Ecographie	2020-11-15 13:16:26	Membre couper par erreur	155041690002972	12
1271	Craniatomie	2021-10-15 06:09:42	Annule	155041690002972	10
1272	Radio	2016-01-03 16:52:56	RAS	240035852414745	2
1273	Depistage	2017-03-19 00:51:39	RAS	240035852414745	2
1274	Platre	2017-03-19 19:25:08	RAS	240035852414745	2
1275	Infiltration	2017-03-19 06:37:47	RAS	240035852414745	1
1276	Infiltration	2016-12-01 20:52:40	Personelle manquant	146016758089885	1
1277	Infiltration	2016-12-01 12:28:25	Le patient a pris la fuite	146016758089885	2
1278	Depistage	2016-06-01 23:30:29	RAS	161067172287541	2
1279	Point de suture	2016-06-01 05:06:59	RAS	161067172287541	2
1280	Infiltration	2015-04-02 03:57:25	RAS	161067172287541	2
1281	Infiltration	2018-11-16 21:28:07	Le patient a pris la fuite	111039511573819	2
1282	Radio	2018-09-20 21:23:27	RAS	111039511573819	1
1283	Radio	2018-11-16 15:31:47	RAS	111039511573819	1
1284	Radio	2018-12-01 14:36:46	Personelle manquant	225032278266803	1
1285	Point de suture	2021-09-10 19:13:44	Personelle manquant	217074086831428	1
1286	Platre	2021-10-16 04:19:12	RAS	217074086831428	2
1287	Depistage	2021-05-17 05:42:42	Cancer confirmé	217074086831428	2
1288	Infiltration	2017-08-23 06:07:56	RAS	229104969463987	2
1289	Point de suture	2018-02-07 05:35:56	RAS	229104969463987	2
1290	Platre	2017-08-23 12:51:09	Personelle manquant	229104969463987	2
1291	Point de suture	2018-02-07 22:54:45	Outils oublier (Programmer une réintervention)	229104969463987	1
1292	Point de suture	2016-10-11 17:35:39	Membre couper par erreur	211126925899180	2
1293	Infiltration	2016-10-11 05:30:55	RAS	211126925899180	2
1294	Depistage	2016-10-11 07:33:27	RAS	211126925899180	2
1295	Radio	2019-04-10 07:40:04	RAS	253097276162617	2
1296	Point de suture	2019-04-10 00:03:11	RAS	253097276162617	2
1297	Depistage	2019-04-10 05:10:39	Outils oublier (Programmer une réintervention)	253097276162617	2
1298	Depistage	2017-12-01 14:49:08	Le patient a pris la fuite	236036316584601	2
1299	Infiltration	2017-12-01 03:31:15	Membre couper par erreur	236036316584601	1
1300	Platre	2019-05-05 10:11:15	RAS	129054448109734	1
1301	Infiltration	2020-08-13 17:23:25	Personelle manquant	129054448109734	2
1302	Platre	2020-08-13 08:25:13	Membre couper par erreur	129054448109734	2
1303	Depistage	2020-08-13 23:47:07	Annule	129054448109734	2
1304	Platre	2021-10-21 18:17:40	RAS	209049564105921	2
1305	Radio	2021-10-21 23:55:31	RAS	209049564105921	1
1306	Infiltration	2021-11-28 12:00:09	Annule	209049564105921	1
1307	Point de suture	2021-11-28 00:47:12	Outils oublier (Programmer une réintervention)	209049564105921	1
1308	Point de suture	2021-09-01 20:55:36	Personelle manquant	271110105237227	1
1309	Radio	2019-05-20 19:34:04	Cancer confirmé	130071148664148	1
1310	Depistage	2019-02-25 21:55:56	RAS	130071148664148	2
1311	Point de suture	2015-12-01 19:00:41	Outils oublier (Programmer une réintervention)	193046098419989	1
1312	Platre	2021-08-10 18:33:08	Le patient a pris la fuite	108059912447754	1
1313	Depistage	2021-08-22 22:36:46	RAS	108059912447754	2
1314	Scanner	2017-06-28 20:27:06	RAS	221084521836196	11
1315	Scanner	2019-07-03 13:25:08	RAS	221084521836196	12
1316	Point de suture	2021-12-01 03:52:16	RAS	275010892493538	6
1317	Reanimation	2018-12-01 10:19:47	RAS	275010892493538	7
1318	Platre	2016-12-01 06:42:16	Outils oublier (Programmer une réintervention)	201104145535465	2
1319	Radio	2016-12-01 04:57:40	Cancer confirmé	201104145535465	2
1320	Infiltration	2016-12-01 03:21:02	RAS	201104145535465	2
1321	Point de suture	2016-12-01 06:53:39	Membre couper par erreur	201104145535465	2
1322	Radio	2015-01-10 07:04:21	RAS	238037295713009	2
1323	Depistage	2015-10-19 19:25:01	Membre couper par erreur	145028128718210	1
1324	Infiltration	2015-10-19 16:11:29	Cancer confirmé	145028128718210	1
1325	Radio	2015-10-19 21:37:26	Personelle manquant	145028128718210	1
1326	Point de suture	2015-10-19 18:49:10	Annule	145028128718210	2
1327	Infiltration	2018-02-19 22:31:47	RAS	294085279933523	1
1328	Infiltration	2017-02-17 14:58:58	Annule	294085279933523	1
1329	Point de suture	2018-02-19 18:42:45	RAS	294085279933523	1
1330	Platre	2018-02-19 01:55:27	Membre couper par erreur	294085279933523	1
1331	Radio	2017-07-11 07:22:13	RAS	292060159246061	2
1332	Depistage	2017-07-11 01:22:29	RAS	292060159246061	2
1333	Point de suture	2017-07-11 22:50:03	RAS	292060159246061	2
1334	Point de suture	2017-07-11 15:13:59	RAS	292060159246061	2
1335	Chirurgie	2021-12-01 04:12:33	Cancer confirmé	218012483586376	4
1336	Chirurgie	2021-12-01 01:51:03	RAS	218012483586376	3
1337	Radio	2021-12-01 07:59:41	Outils oublier (Programmer une réintervention)	218012483586376	4
1338	Infiltration	2020-01-17 03:47:10	Cancer confirmé	254082106848079	2
1339	Point de suture	2019-03-22 06:28:41	RAS	254082106848079	2
1340	Radio	2020-12-01 07:04:05	RAS	289038194355035	2
1341	Point de suture	2020-03-20 10:13:08	RAS	289038194355035	2
1342	Platre	2018-04-09 18:50:45	RAS	187070799370259	1
1343	Depistage	2021-08-28 17:52:55	Outils oublier (Programmer une réintervention)	108020934941188	2
1344	Platre	2021-08-28 01:51:05	RAS	108020934941188	2
1345	Infiltration	2020-03-08 16:07:18	Membre couper par erreur	108020934941188	1
1346	Infiltration	2019-06-13 19:06:10	Personelle manquant	259046387441327	2
1347	Infiltration	2019-06-13 07:59:05	RAS	259046387441327	2
1348	Depistage	2019-01-15 12:07:54	RAS	243080616823446	1
1349	Point de suture	2021-08-08 19:20:25	Annule	243080616823446	1
1350	Radio	2019-01-15 21:17:43	RAS	243080616823446	1
1351	Platre	2015-08-19 07:00:38	Membre couper par erreur	210117948182854	1
1352	Examen	2021-11-28 16:43:51	RAS	107028981594327	10
1353	Craniatomie	2021-11-26 21:45:47	RAS	107028981594327	5
1354	Point de suture	2021-07-15 21:31:32	RAS	107028981594327	1
1355	Radio	2019-11-09 19:12:38	RAS	107028981594327	2
1356	Depistage	2021-12-01 06:09:27	RAS	149063593850027	1
1357	Platre	2016-02-12 22:56:31	RAS	218121931897884	1
1358	Platre	2021-09-03 10:32:49	Le patient a pris la fuite	218121931897884	2
1359	Depistage	2021-09-03 19:34:14	RAS	218121931897884	2
1360	Depistage	2016-02-12 18:39:19	RAS	218121931897884	2
1361	Radio	2019-10-03 23:13:01	Le patient a pris la fuite	115073393844074	2
1362	Radio	2019-12-01 14:29:49	Le patient a pris la fuite	115073393844074	1
1363	Radio	2019-12-01 11:50:26	RAS	115073393844074	2
1364	Depistage	2019-10-03 19:36:07	RAS	115073393844074	1
1365	Radio	2021-12-01 10:13:30	RAS	262102954655333	2
1366	Point de suture	2021-12-01 16:19:03	Membre couper par erreur	262102954655333	2
1367	Depistage	2021-10-04 02:21:06	Le patient a pris la fuite	262102954655333	2
1368	Radio	2021-08-10 19:33:55	Membre couper par erreur	262102954655333	4
1369	Ecographie	2018-12-01 11:27:15	Personelle manquant	299075025982742	12
1370	Ecographie	2018-09-24 13:46:27	RAS	299075025982742	11
1371	Radio	2021-11-13 02:37:05	RAS	299075025982742	12
1372	IRM	2020-01-07 15:32:20	RAS	299075025982742	12
1373	Cardioversion	2021-12-01 06:35:55	RAS	216121985902635	9
1374	Cardioversion	2017-10-12 01:03:43	RAS	216121985902635	9
1375	Chirurgie cardiaque	2021-12-01 07:05:08	Cancer confirmé	216121985902635	8
1376	Infiltration	2018-01-03 16:46:43	RAS	120087250824191	1
1377	Infiltration	2019-07-19 17:45:59	Le patient a pris la fuite	120087250824191	1
1378	Radio	2015-05-18 15:36:49	RAS	159117903511347	2
1379	Depistage	2016-08-01 00:10:01	Cancer confirmé	159117903511347	1
1380	Transplantation	2015-11-24 05:11:19	RAS	151010535199329	8
1381	Transplantation	2015-11-25 12:24:43	RAS	151010535199329	9
1382	Ecographie	2018-01-25 04:05:13	Le patient a pris la fuite	202096545459216	12
1383	Transplantation	2019-11-27 21:58:59	Le patient a pris la fuite	202096545459216	8
1384	Platre	2019-06-16 11:27:57	Personelle manquant	202096545459216	1
1385	Laminectomie	2017-11-13 15:21:08	Personelle manquant	220036263058474	10
1386	Cardioversion	2020-01-10 08:33:19	RAS	220036263058474	8
1387	Chirurgie	2021-06-11 19:22:05	RAS	220036263058474	3
1388	Examen	2021-09-18 06:40:43	Membre couper par erreur	164072065506044	4
1389	Examen	2021-09-02 20:45:58	Annule	164072065506044	3
1390	Chirurgie	2021-10-06 13:36:55	RAS	164072065506044	4
1391	Radio	2021-06-12 21:49:11	RAS	225122828585441	1
1392	Radio	2021-12-01 12:46:03	Outils oublier (Programmer une réintervention)	146027101427837	2
1393	Radio	2021-12-01 16:03:32	Personelle manquant	146027101427837	1
1394	Radio	2019-08-10 08:44:59	Annule	157057144009934	1
1395	Platre	2019-08-10 21:06:05	RAS	157057144009934	1
1396	Radio	2019-08-10 10:27:41	RAS	157057144009934	1
1397	Platre	2019-08-10 14:38:41	RAS	157057144009934	1
1398	Radio	2015-06-17 02:14:31	RAS	272128938731412	2
1399	Point de suture	2021-05-13 17:38:34	Annule	272128938731412	2
1400	Examen	2020-07-25 01:56:17	RAS	123103048076517	3
1401	Examen	2019-04-12 09:56:45	Personelle manquant	123103048076517	3
1402	Transplantation	2021-06-20 21:18:50	RAS	123103048076517	8
1403	Chirurgie	2018-12-16 23:03:37	Annule	123103048076517	3
1404	Infiltration	2017-10-17 20:01:04	Membre couper par erreur	112067612324530	2
1405	Point de suture	2017-10-17 16:38:26	RAS	112067612324530	1
1406	Infiltration	2017-10-17 16:14:47	RAS	112067612324530	2
1407	Platre	2017-10-17 05:08:31	RAS	112067612324530	1
1408	Radio	2016-02-28 01:32:15	RAS	212021771119539	2
1409	Depistage	2016-02-28 04:16:32	Outils oublier (Programmer une réintervention)	212021771119539	2
1410	Infiltration	2016-02-28 07:41:38	Le patient a pris la fuite	212021771119539	1
1411	Depistage	2016-02-28 18:17:18	Personelle manquant	212021771119539	1
1412	Radio	2021-03-12 22:39:51	Membre couper par erreur	133043200981964	2
1413	Examen	2021-06-15 17:40:32	Outils oublier (Programmer une réintervention)	222062702780531	4
1414	Chirurgie	2021-06-08 20:20:54	Personelle manquant	222062702780531	3
1415	Radio	2021-06-12 21:31:33	Membre couper par erreur	222062702780531	3
1416	Examen	2020-01-13 16:50:47	Le patient a pris la fuite	116101580250637	3
1417	Ecographie	2020-08-21 18:01:48	RAS	116101580250637	11
1418	Laminectomie	2021-12-01 13:34:53	RAS	291012132330873	10
1419	Laminectomie	2018-11-27 22:47:06	RAS	291012132330873	5
1420	Radio	2020-08-01 10:23:12	RAS	266105404998405	2
1421	Point de suture	2020-08-01 00:43:55	Le patient a pris la fuite	266105404998405	2
1422	Radio	2019-11-06 01:06:55	Cancer confirmé	243101397269448	1
1423	Radio	2019-11-06 05:20:18	Cancer confirmé	243101397269448	1
1424	Infiltration	2019-11-06 21:18:54	RAS	243101397269448	1
1425	Infiltration	2021-06-26 10:03:55	Membre couper par erreur	119079086336263	1
1426	Radio	2021-06-26 02:28:36	RAS	119079086336263	2
1427	Radio	2021-06-26 21:52:07	Outils oublier (Programmer une réintervention)	119079086336263	2
1428	Platre	2021-06-26 14:34:03	RAS	119079086336263	2
1429	Depistage	2020-03-23 17:54:53	Le patient a pris la fuite	159049935527582	2
1430	Chirurie	2018-01-27 20:26:42	Cancer confirmé	233098228061700	6
1431	Chirurie	2016-04-02 02:09:54	Membre couper par erreur	233098228061700	7
1432	Infiltration	2017-12-01 09:07:55	RAS	105055073221067	2
1433	Depistage	2017-12-01 03:08:40	RAS	105055073221067	1
1434	Radio	2017-12-01 08:35:46	RAS	105055073221067	2
1435	Radio	2017-12-01 23:59:52	RAS	105055073221067	2
1436	Depistage	2019-03-24 04:34:38	Cancer confirmé	284070773359105	1
1437	Radio	2016-07-22 08:31:11	Cancer confirmé	284070773359105	2
1438	Infiltration	2019-03-24 15:08:50	RAS	284070773359105	2
1439	Platre	2020-02-15 02:43:50	Membre couper par erreur	128032992380904	2
1440	Platre	2021-12-01 04:07:48	RAS	107097295816255	2
1441	Platre	2019-08-09 01:41:28	RAS	151022965079221	1
1442	Point de suture	2020-08-13 13:12:27	Le patient a pris la fuite	151022965079221	2
1443	Point de suture	2017-05-19 16:23:09	Membre couper par erreur	151022965079221	1
1444	Point de suture	2015-06-28 11:47:01	RAS	213081650900924	1
1445	Depistage	2015-06-28 07:46:01	RAS	213081650900924	2
1446	Platre	2016-07-28 23:45:07	Le patient a pris la fuite	213081650900924	2
1447	Reanimation	2017-08-01 14:20:17	RAS	178052502185535	6
1448	Point de suture	2019-12-13 17:59:16	Outils oublier (Programmer une réintervention)	178052502185535	6
1449	Transplantation	2021-11-27 14:53:33	Outils oublier (Programmer une réintervention)	178052502185535	8
1450	Instalation d un DCI	2021-11-02 02:13:27	Membre couper par erreur	178052502185535	9
1451	Platre	2019-02-15 18:44:27	RAS	295070626140542	1
1452	Platre	2021-09-28 00:39:05	Personelle manquant	295070626140542	2
1453	Platre	2021-09-28 05:36:04	RAS	295070626140542	1
1454	Point de suture	2021-10-16 21:24:50	RAS	120058752255719	1
1455	trepanation	2021-09-27 02:17:29	Cancer confirmé	228101775407926	5
1456	Platre	2018-06-09 16:19:08	RAS	285115820360026	1
1457	Point de suture	2018-06-09 17:26:53	Membre couper par erreur	285115820360026	1
1458	Radio	2018-06-09 21:04:41	Cancer confirmé	285115820360026	2
1459	Platre	2018-06-09 07:06:43	RAS	285115820360026	1
1460	Infiltration	2020-12-01 04:41:14	RAS	283081998370622	2
1461	Radio	2020-07-06 07:57:14	Outils oublier (Programmer une réintervention)	283081998370622	2
1462	Depistage	2020-12-01 14:51:47	Annule	283081998370622	1
1463	Infiltration	2020-12-01 19:18:11	Personelle manquant	283081998370622	1
1464	Radio	2020-02-13 20:37:46	RAS	142051862949049	2
1465	Chirurie	2017-07-19 09:47:35	Personelle manquant	243014454534087	6
1466	Examen	2021-10-27 22:55:52	RAS	243014454534087	3
1467	Radio	2021-08-24 21:01:40	RAS	243014454534087	2
1468	Infiltration	2018-07-23 21:23:17	RAS	181023381093240	1
1469	Radio	2018-07-23 06:21:44	RAS	181023381093240	2
1470	Infiltration	2018-07-28 06:12:15	Personelle manquant	151099301859840	1
1471	Depistage	2015-09-12 09:13:46	Cancer confirmé	119011754998157	1
1472	Depistage	2015-06-09 15:56:56	Outils oublier (Programmer une réintervention)	253087209887583	2
1473	Radio	2016-10-06 03:57:57	Personelle manquant	253087209887583	1
1474	Radio	2016-10-06 03:06:38	RAS	253087209887583	2
1475	Radio	2016-10-06 20:10:33	Cancer confirmé	253087209887583	2
1476	Radio	2021-11-06 17:12:27	Outils oublier (Programmer une réintervention)	294083240333014	2
1477	Point de suture	2021-10-25 02:57:43	RAS	294083240333014	1
1478	Cardioversion	2020-07-15 14:55:47	RAS	139051080064928	9
1479	Instalation d un DCI	2020-09-25 21:03:43	Cancer confirmé	139051080064928	9
1480	Cardioversion	2020-09-23 07:54:18	RAS	139051080064928	9
1481	Point de suture	2021-11-15 13:47:31	Membre couper par erreur	139051080064928	2
1482	Platre	2021-09-22 05:10:11	Annule	102118325920402	1
1483	Platre	2016-02-01 08:28:11	RAS	102118325920402	1
1484	Depistage	2019-02-22 03:04:04	RAS	102118325920402	1
1485	Radio	2020-06-16 12:05:04	Annule	162128476044686	1
1486	Platre	2020-06-16 08:12:56	RAS	162128476044686	1
1487	Depistage	2015-08-20 21:12:38	Membre couper par erreur	162128476044686	2
1488	Point de suture	2020-06-16 16:20:12	RAS	162128476044686	2
1489	Radio	2021-11-28 09:01:21	Cancer confirmé	180097454476416	3
1490	Radio	2019-10-25 22:39:55	RAS	180097454476416	11
1491	Scanner	2019-10-24 14:25:49	Outils oublier (Programmer une réintervention)	180097454476416	12
1492	trepanation	2021-11-02 02:10:50	Annule	180097454476416	10
1493	Infiltration	2015-02-08 01:20:24	RAS	198019789185927	1
1494	Infiltration	2015-02-08 09:13:50	RAS	198019789185927	2
1495	Radio	2021-10-17 08:07:53	Annule	289075326321716	3
1496	Examen	2021-10-18 14:02:22	RAS	289075326321716	3
1497	Depistage	2021-04-17 19:11:05	RAS	204095944799952	2
1498	Point de suture	2021-04-17 00:44:33	Le patient a pris la fuite	204095944799952	2
1499	Radio	2016-05-13 18:51:08	Annule	160037973030119	3
1500	Chirurgie cardiaque	2019-04-06 03:09:59	Annule	160037973030119	8
1501	Chirurgie cardiaque	2019-12-01 03:42:42	RAS	160037973030119	9
1502	Instalation d un DCI	2021-04-09 12:12:05	RAS	160037973030119	9
1503	Radio	2015-01-09 01:51:18	Personelle manquant	204028909048229	2
1504	Radio	2021-12-01 10:09:07	RAS	279014234476269	11
1505	Infiltration	2020-01-18 16:50:41	Outils oublier (Programmer une réintervention)	279014234476269	2
1506	Chirurgie	2021-11-05 00:54:59	Cancer confirmé	279014234476269	3
1507	IRM	2021-12-01 07:48:59	RAS	279014234476269	11
1508	Radio	2021-11-27 07:31:15	RAS	105025228548532	2
1509	Platre	2018-04-27 07:48:36	Membre couper par erreur	105025228548532	2
1510	Infiltration	2021-11-27 13:42:15	RAS	105025228548532	1
1511	Platre	2017-12-01 21:16:06	RAS	236070319011481	2
1512	Platre	2017-12-01 07:52:41	Personelle manquant	236070319011481	1
1513	Depistage	2017-12-01 03:25:00	RAS	236070319011481	1
1514	Platre	2021-07-05 11:56:55	RAS	199105176991230	1
1515	Point de suture	2021-08-03 07:30:03	Le patient a pris la fuite	199105176991230	2
1516	Platre	2021-08-03 01:06:00	RAS	199105176991230	2
1517	Platre	2021-08-03 12:00:36	Le patient a pris la fuite	199105176991230	2
1518	Laminectomie	2018-12-01 07:20:15	Membre couper par erreur	161056533943893	5
1519	Laminectomie	2020-01-28 01:52:49	Cancer confirmé	161056533943893	10
1520	Craniatomie	2021-10-14 08:46:27	Outils oublier (Programmer une réintervention)	161056533943893	10
1521	Platre	2020-03-24 10:43:36	RAS	286062791711375	2
1522	Platre	2020-03-24 02:20:56	RAS	286062791711375	1
1523	Platre	2018-06-19 12:00:26	RAS	286062791711375	2
1524	Platre	2020-03-24 10:23:12	Outils oublier (Programmer une réintervention)	286062791711375	1
1525	Infiltration	2017-09-10 05:20:30	Cancer confirmé	272111238460186	1
1526	Infiltration	2021-04-07 00:46:08	Cancer confirmé	152111965056410	2
1527	Depistage	2021-06-20 13:36:17	RAS	165027813307360	2
1528	Platre	2020-01-13 20:42:08	Le patient a pris la fuite	104059069162387	2
1529	Platre	2019-03-26 20:05:54	RAS	104059069162387	2
1530	Point de suture	2019-03-26 15:45:19	RAS	104059069162387	2
1531	Infiltration	2015-09-09 17:40:55	Outils oublier (Programmer une réintervention)	121056692918082	1
1532	Platre	2015-08-27 16:00:25	Annule	121056692918082	1
1533	Examen	2021-10-14 06:59:21	RAS	232023864409457	4
1534	Chirurgie	2019-12-01 02:03:45	RAS	232023864409457	3
1535	Infiltration	2019-11-25 12:29:33	RAS	117071617626555	1
1536	Radio	2019-11-27 16:46:14	Le patient a pris la fuite	117071617626555	1
1537	Platre	2019-11-10 22:45:39	RAS	117071617626555	2
1538	Infiltration	2019-11-10 13:21:56	Cancer confirmé	117071617626555	2
1539	Depistage	2017-07-06 12:22:02	Annule	196036458217210	1
1540	Depistage	2017-09-02 05:28:10	RAS	139096044741391	1
1541	Radio	2017-09-02 14:08:14	Membre couper par erreur	139096044741391	1
1542	Platre	2017-05-17 10:43:33	RAS	284086505133848	2
1543	Radio	2017-05-17 14:51:25	RAS	284086505133848	2
1544	Infiltration	2021-01-26 06:35:51	Le patient a pris la fuite	161106377733801	1
1545	Platre	2021-01-26 12:36:03	Outils oublier (Programmer une réintervention)	161106377733801	1
1546	Platre	2021-01-26 11:20:04	Personelle manquant	161106377733801	1
1547	Point de suture	2021-01-26 22:22:57	RAS	161106377733801	2
1548	Platre	2018-08-26 16:34:13	RAS	266031774123621	1
1549	trepanation	2017-02-22 10:17:45	RAS	176083360458256	10
1550	Laminectomie	2018-08-16 08:36:48	Annule	176083360458256	5
1551	Radio	2017-01-20 14:25:16	Outils oublier (Programmer une réintervention)	238082768160123	2
1552	Infiltration	2021-05-03 10:40:27	Annule	238082768160123	2
1553	Depistage	2020-09-26 16:05:39	RAS	116089104911289	1
1554	Platre	2020-09-26 23:06:05	Outils oublier (Programmer une réintervention)	116089104911289	2
1555	Platre	2015-07-26 21:33:33	RAS	184013026653488	1
1556	Infiltration	2015-07-26 06:40:21	Le patient a pris la fuite	184013026653488	2
1557	Radio	2015-07-26 18:42:46	Outils oublier (Programmer une réintervention)	184013026653488	2
1558	Infiltration	2015-07-26 02:02:22	RAS	184013026653488	2
1559	Point de suture	2021-09-02 18:56:24	Membre couper par erreur	190062769594923	6
1560	Cardioversion	2021-06-28 23:16:17	Membre couper par erreur	190062769594923	8
1561	Infiltration	2016-04-01 19:24:53	Annule	129051166985007	1
1562	Depistage	2016-04-01 16:37:01	Membre couper par erreur	129051166985007	2
1563	Infiltration	2016-04-01 07:45:44	RAS	129051166985007	2
1564	Infiltration	2021-09-06 02:25:24	Outils oublier (Programmer une réintervention)	171110869020530	1
1565	Platre	2021-09-26 00:10:06	Le patient a pris la fuite	171110869020530	1
1566	Craniatomie	2021-03-28 13:24:40	RAS	170085720360240	5
1567	Infiltration	2018-05-23 20:56:27	Le patient a pris la fuite	170085720360240	1
1568	Infiltration	2019-04-11 20:32:55	RAS	170085720360240	1
1569	Examen	2021-03-27 11:03:42	RAS	170085720360240	5
1570	Point de suture	2017-04-04 01:24:24	RAS	128119566368842	2
1571	Depistage	2021-04-10 00:45:55	Outils oublier (Programmer une réintervention)	250072870574866	2
1572	Infiltration	2020-10-27 09:54:27	RAS	250072870574866	1
1573	Depistage	2020-10-27 04:03:33	RAS	250072870574866	2
1574	Infiltration	2020-12-01 07:48:10	RAS	275034106311549	2
1575	Platre	2020-11-02 05:44:53	Personelle manquant	275034106311549	2
1576	Radio	2021-10-03 00:12:27	Outils oublier (Programmer une réintervention)	275034106311549	1
1577	Infiltration	2021-10-03 11:39:51	Membre couper par erreur	275034106311549	2
1578	Radio	2017-03-11 16:29:30	Outils oublier (Programmer une réintervention)	293072659007230	1
1579	Infiltration	2017-03-11 05:49:36	RAS	293072659007230	2
1580	Depistage	2017-03-11 11:18:34	Annule	293072659007230	2
1581	Radio	2018-07-17 11:07:21	Le patient a pris la fuite	265047126015494	1
1582	Point de suture	2018-07-17 22:10:05	RAS	265047126015494	2
1583	Infiltration	2019-04-28 14:17:25	Annule	213077721801746	2
1584	Infiltration	2019-04-28 08:31:32	RAS	213077721801746	2
1585	Point de suture	2020-02-12 16:43:54	Le patient a pris la fuite	213077721801746	2
1586	Radio	2021-03-23 12:16:46	Personelle manquant	128087936474254	3
1587	Radio	2020-12-01 03:06:43	RAS	128087936474254	4
1588	Radio	2021-06-05 22:51:08	RAS	128087936474254	3
1589	Platre	2015-01-21 13:29:35	RAS	148013229831993	2
1590	Platre	2021-03-19 18:28:00	Annule	223120960061912	1
1591	Infiltration	2020-10-12 06:03:08	RAS	186033137213249	1
1592	Point de suture	2020-10-12 10:26:48	Membre couper par erreur	186033137213249	1
1593	Infiltration	2017-05-20 05:44:14	Outils oublier (Programmer une réintervention)	186033137213249	2
1594	Infiltration	2019-12-01 20:28:04	RAS	256115115514311	1
1595	Infiltration	2016-06-01 06:30:02	Le patient a pris la fuite	256115115514311	2
1596	Point de suture	2020-09-22 21:04:09	RAS	256115115514311	2
1597	Depistage	2020-09-22 13:45:26	RAS	256115115514311	2
1598	Instalation d un DCI	2021-11-17 16:03:15	Annule	244013618672814	8
1599	Transplantation	2016-12-28 07:09:35	Annule	244013618672814	8
1600	Cardioversion	2016-09-19 13:53:38	Annule	244013618672814	8
1601	Transplantation	2021-11-16 14:36:07	Cancer confirmé	244013618672814	9
1602	Chirurgie	2020-12-08 16:46:17	RAS	196061733484675	3
1603	Radio	2020-01-28 08:53:54	RAS	196061733484675	4
1604	Radio	2019-07-22 21:59:18	RAS	196061733484675	4
1605	Chirurgie cardiaque	2021-12-01 01:50:06	Cancer confirmé	106089885680755	8
1606	Radio	2020-09-02 05:41:18	RAS	106089885680755	4
1607	Radio	2020-09-18 20:09:34	Annule	106089885680755	4
1608	Radio	2020-08-04 14:10:52	Outils oublier (Programmer une réintervention)	106089885680755	4
1609	Platre	2021-08-23 21:05:32	RAS	139105087154042	1
1610	Infiltration	2021-05-06 00:24:02	Annule	158030363231988	2
1611	Infiltration	2020-03-21 04:27:20	Personelle manquant	297076719709643	2
1612	Platre	2016-05-11 02:11:22	RAS	222046381429882	2
1613	Infiltration	2016-05-11 23:18:30	Le patient a pris la fuite	222046381429882	2
1614	Point de suture	2016-05-11 01:50:15	Outils oublier (Programmer une réintervention)	222046381429882	1
1615	Radio	2021-07-21 17:42:27	Personelle manquant	265031930410776	2
1616	Chirurgie	2020-04-09 07:58:33	RAS	134049072360994	3
1617	Radio	2016-01-01 01:32:17	RAS	211086595791575	11
1618	Point de suture	2018-08-13 09:59:41	RAS	239043603031156	2
1619	Platre	2017-01-24 02:51:00	Le patient a pris la fuite	239043603031156	2
1620	Point de suture	2016-04-04 15:55:05	Annule	150017226774891	2
1621	Depistage	2015-09-01 13:36:53	Le patient a pris la fuite	150017226774891	2
1622	Depistage	2015-11-16 08:26:42	Outils oublier (Programmer une réintervention)	290060531145979	2
1623	Point de suture	2015-11-16 20:17:25	RAS	290060531145979	2
1624	Point de suture	2015-11-16 18:33:23	RAS	290060531145979	1
1625	Platre	2020-02-15 18:24:41	RAS	125043167496449	2
1626	Infiltration	2020-02-15 11:11:59	Le patient a pris la fuite	125043167496449	2
1627	Platre	2021-09-02 05:13:50	RAS	259029921552493	1
1628	Infiltration	2021-09-02 21:06:43	Cancer confirmé	259029921552493	2
1629	Depistage	2020-06-15 19:16:40	Cancer confirmé	259029921552493	2
1630	Radio	2020-04-28 02:23:05	Le patient a pris la fuite	165089604254636	2
1631	Point de suture	2016-04-10 16:50:55	RAS	169045466583502	1
1632	Radio	2016-08-28 05:03:50	Personelle manquant	169045466583502	2
1633	Infiltration	2016-08-28 21:04:41	RAS	169045466583502	2
1634	Radio	2020-10-19 05:22:24	Annule	155078862032976	2
1635	Platre	2020-10-19 04:34:49	Le patient a pris la fuite	155078862032976	1
1636	Point de suture	2020-10-19 22:43:16	RAS	155078862032976	1
1637	Point de suture	2020-04-17 09:45:51	Annule	155078862032976	1
1638	Ecographie	2018-09-07 18:03:03	RAS	236050817608085	12
1639	Examen	2017-08-02 05:56:52	RAS	228068017689713	4
1640	Radio	2017-08-01 07:06:14	RAS	228068017689713	3
1641	Radio	2017-07-26 18:31:24	Cancer confirmé	228068017689713	3
1642	Radio	2017-07-26 21:33:10	RAS	228068017689713	4
1643	Infiltration	2020-03-15 11:32:09	Membre couper par erreur	159097071302004	1
1644	Platre	2016-08-20 17:39:35	Annule	107046092147076	2
1645	Platre	2016-08-20 07:58:16	RAS	107046092147076	1
1646	Platre	2016-08-20 02:37:25	RAS	107046092147076	2
1647	Depistage	2018-08-20 09:13:35	RAS	256037369716944	2
1648	Depistage	2018-08-20 08:43:30	RAS	256037369716944	1
1649	Point de suture	2018-08-20 07:05:31	RAS	256037369716944	1
1650	Infiltration	2018-08-20 22:42:12	RAS	256037369716944	2
1651	Chirurie	2021-10-03 17:59:46	RAS	141030952640812	7
1652	Reanimation	2021-05-08 02:52:57	Cancer confirmé	141030952640812	7
1653	Chirurie	2021-06-22 02:23:40	Le patient a pris la fuite	141030952640812	7
1654	Point de suture	2018-03-02 07:07:45	RAS	281115596346204	2
1655	Infiltration	2018-03-02 15:29:07	RAS	281115596346204	1
1656	Depistage	2018-03-02 06:14:12	RAS	281115596346204	1
1657	Depistage	2020-02-12 01:26:32	Membre couper par erreur	264019381752416	2
1658	Radio	2018-03-10 03:38:02	Membre couper par erreur	264019381752416	1
1659	Transplantation	2021-02-26 21:00:59	RAS	206051413439664	8
1660	Depistage	2019-12-18 17:07:16	Cancer confirmé	206051413439664	1
1661	Point de suture	2021-08-09 07:21:47	Annule	117043894183463	1
1662	Instalation d un DCI	2020-12-14 17:45:16	Annule	117043894183463	9
1663	Cardioversion	2019-06-25 18:18:14	RAS	117043894183463	8
1664	Point de suture	2021-03-28 04:36:03	Le patient a pris la fuite	221079212138547	1
1665	Depistage	2021-03-28 20:01:43	RAS	221079212138547	2
1666	Infiltration	2021-02-03 17:52:07	Annule	126127518943951	1
1667	Point de suture	2021-12-01 07:32:28	RAS	126127518943951	7
1668	Chirurie	2021-12-01 07:37:40	RAS	126127518943951	6
1669	Ecographie	2018-06-25 11:24:07	Le patient a pris la fuite	126127518943951	12
1670	Platre	2021-11-25 03:36:17	Cancer confirmé	129088384201146	2
1671	Infiltration	2021-11-26 09:42:05	RAS	129088384201146	2
1672	Platre	2021-11-26 09:25:17	Personelle manquant	129088384201146	1
1673	Radio	2020-05-04 21:38:57	Le patient a pris la fuite	156127291989632	2
1674	Point de suture	2020-05-04 23:38:13	Annule	156127291989632	2
1675	Infiltration	2020-12-01 20:01:32	RAS	117064052014050	2
1676	Laminectomie	2021-10-26 02:18:09	Le patient a pris la fuite	201068456551393	10
1677	Laminectomie	2020-09-11 07:01:42	RAS	201068456551393	5
1678	Depistage	2016-11-25 19:32:58	Cancer confirmé	280013103555645	1
1679	Scanner	2021-07-26 11:58:11	RAS	280013103555645	12
1680	Craniatomie	2019-09-22 10:55:13	Le patient a pris la fuite	288106819148682	10
1681	trepanation	2019-09-10 09:27:38	Le patient a pris la fuite	288106819148682	5
1682	Examen	2019-10-02 20:20:21	Personelle manquant	288106819148682	5
1683	Depistage	2016-07-08 10:05:29	Personelle manquant	220068901669705	1
1684	Radio	2016-07-08 02:59:24	RAS	220068901669705	2
1685	Radio	2017-07-23 05:42:59	Annule	220068901669705	2
1686	Depistage	2020-01-02 06:29:34	Annule	218120824070079	1
1687	Point de suture	2020-01-02 09:01:40	Annule	218120824070079	1
1688	Point de suture	2020-11-05 02:57:27	RAS	153029896446820	1
1689	Infiltration	2019-01-28 10:00:58	RAS	153029896446820	2
1690	Platre	2019-02-28 15:51:43	Outils oublier (Programmer une réintervention)	153029896446820	2
1691	Radio	2021-06-12 19:07:40	RAS	194075342972573	11
1692	Scanner	2021-05-11 16:31:33	Annule	194075342972573	12
1693	Reanimation	2021-11-25 18:53:55	Cancer confirmé	296099765223309	7
1694	Chirurie	2021-11-25 15:08:53	Cancer confirmé	296099765223309	6
1695	Infiltration	2021-12-01 02:48:22	Le patient a pris la fuite	278094704116338	1
1696	Chirurie	2021-06-04 10:55:46	RAS	139105281222043	6
1697	Transplantation	2021-11-09 14:22:50	Le patient a pris la fuite	139105281222043	9
1698	Radio	2016-05-21 17:43:29	RAS	227083579705919	1
1699	Point de suture	2021-03-25 19:52:08	RAS	284090884921702	1
1700	Point de suture	2021-03-14 17:14:18	Membre couper par erreur	103075757697692	2
1701	Platre	2018-06-13 11:09:04	Cancer confirmé	195087761492606	1
1702	Platre	2020-09-07 09:16:46	Membre couper par erreur	195087761492606	2
1703	Radio	2020-08-28 04:25:42	Annule	195087761492606	2
1704	Radio	2016-07-19 09:27:28	Outils oublier (Programmer une réintervention)	127100875228221	1
1705	Platre	2021-06-16 09:02:02	Cancer confirmé	127100875228221	1
1706	Platre	2016-07-19 02:28:18	Personelle manquant	127100875228221	1
1707	Radio	2021-06-16 19:31:37	Le patient a pris la fuite	127100875228221	2
1708	Radio	2020-08-22 02:37:47	Cancer confirmé	215072902540441	1
1709	Radio	2021-05-08 13:39:51	Cancer confirmé	118111411157996	2
1710	Infiltration	2021-08-20 10:32:06	RAS	221021115240958	1
1711	Depistage	2021-08-20 19:45:02	Personelle manquant	221021115240958	2
1712	Radio	2021-11-15 05:38:11	RAS	221021115240958	2
1713	Cardioversion	2021-12-01 21:58:22	RAS	287051297819393	8
1714	Point de suture	2019-06-20 21:28:18	Personelle manquant	287051297819393	6
1715	Scanner	2021-09-11 11:22:03	RAS	287051297819393	11
1716	Radio	2015-10-15 11:40:13	RAS	236071547970159	2
1717	Radio	2015-10-15 07:31:32	Annule	236071547970159	1
1718	Point de suture	2017-07-22 17:54:50	RAS	236071547970159	1
1719	Depistage	2021-05-02 02:52:21	RAS	152074748442071	1
1720	Platre	2021-05-02 19:21:59	RAS	152074748442071	2
1721	Infiltration	2021-05-02 22:32:22	Annule	152074748442071	2
1722	Point de suture	2021-04-25 07:30:30	RAS	152074748442071	1
1723	IRM	2018-09-07 15:19:57	RAS	131084757421667	12
1724	Point de suture	2020-09-28 10:13:09	RAS	131084757421667	7
1725	Reanimation	2020-08-13 22:52:46	Membre couper par erreur	131084757421667	6
1726	Point de suture	2020-10-01 05:39:06	Membre couper par erreur	131084757421667	6
1727	Point de suture	2018-04-03 13:04:14	RAS	181017147729962	1
1728	Platre	2018-04-03 18:38:14	RAS	181017147729962	1
1729	Point de suture	2021-01-12 11:53:26	RAS	121071265687319	1
1730	Depistage	2019-09-03 17:56:00	Membre couper par erreur	156085302883246	2
1731	Examen	2021-09-19 10:58:12	RAS	115030403153781	4
1732	Reanimation	2021-07-02 15:46:23	Outils oublier (Programmer une réintervention)	115030403153781	6
1733	Radio	2021-12-01 15:26:34	RAS	115030403153781	4
1734	Radio	2021-11-04 04:46:12	Membre couper par erreur	115030403153781	4
1735	Reanimation	2021-11-19 23:30:31	Le patient a pris la fuite	175073159041662	7
1736	Radio	2021-12-01 14:17:18	Outils oublier (Programmer une réintervention)	175073159041662	3
1737	Point de suture	2018-11-24 21:47:29	Cancer confirmé	109030537258504	1
1738	Depistage	2020-08-09 13:38:41	Membre couper par erreur	109030537258504	2
1739	Platre	2016-04-22 15:47:17	Membre couper par erreur	109030537258504	2
1740	Infiltration	2020-08-09 04:34:12	RAS	109030537258504	1
1741	Infiltration	2020-10-19 10:05:59	RAS	223066675112456	2
1742	Examen	2021-09-21 10:35:33	Personelle manquant	282112984855467	3
1743	Cardioversion	2020-11-09 06:46:46	Annule	282112984855467	9
1744	Examen	2021-09-09 09:45:09	RAS	282112984855467	4
1745	Instalation d un DCI	2017-10-07 09:57:47	RAS	282112984855467	8
1746	Infiltration	2021-10-12 01:31:59	RAS	206015685037422	2
1747	Depistage	2019-10-06 17:51:29	RAS	206015685037422	2
1748	Depistage	2021-10-12 06:52:16	Outils oublier (Programmer une réintervention)	206015685037422	2
1749	Examen	2017-08-07 08:47:28	Outils oublier (Programmer une réintervention)	186069087679009	5
1750	Examen	2021-11-26 13:21:30	Outils oublier (Programmer une réintervention)	216040451818667	5
1751	Chirurgie	2020-03-27 09:32:07	RAS	216040451818667	4
1752	Craniatomie	2021-11-26 16:10:24	RAS	216040451818667	5
1753	Radio	2020-11-03 21:43:47	Outils oublier (Programmer une réintervention)	123107251805832	3
1754	Craniatomie	2020-12-27 07:01:53	RAS	123107251805832	5
1755	Point de suture	2021-07-28 14:47:07	RAS	252047407262592	6
1756	Point de suture	2021-08-24 01:46:04	RAS	252047407262592	7
1757	Platre	2017-09-03 21:27:15	Membre couper par erreur	273083395115649	2
1758	Infiltration	2019-02-14 16:52:51	RAS	273083395115649	1
1759	Radio	2017-09-03 21:02:43	Personelle manquant	273083395115649	2
1760	Infiltration	2018-08-14 23:27:24	Outils oublier (Programmer une réintervention)	113061066882595	1
1761	Radio	2018-09-25 22:42:19	RAS	113061066882595	1
1762	Depistage	2017-06-06 13:11:15	RAS	113061066882595	1
1763	Radio	2018-12-19 12:26:06	RAS	112032779042732	2
1764	Infiltration	2018-09-16 14:17:49	Le patient a pris la fuite	112032779042732	1
1765	Scanner	2021-12-01 20:01:03	RAS	183112049563783	11
1766	Ecographie	2021-11-21 03:53:37	RAS	183112049563783	12
1767	Platre	2021-05-08 11:43:54	RAS	162022779725514	2
1768	Platre	2021-02-18 03:50:49	RAS	162022779725514	1
1769	Point de suture	2020-07-07 18:18:10	RAS	235124605200969	2
1770	Infiltration	2020-05-11 18:35:00	RAS	235124605200969	1
1771	Platre	2019-06-24 06:31:22	Le patient a pris la fuite	187121135696356	2
1772	Depistage	2015-01-12 15:32:20	RAS	136097591466460	1
1773	Point de suture	2015-01-12 16:28:37	Outils oublier (Programmer une réintervention)	136097591466460	2
1774	Platre	2015-01-12 19:02:44	Cancer confirmé	136097591466460	1
1775	Radio	2021-05-07 04:54:10	RAS	145039104108865	1
1776	Radio	2021-05-07 19:32:50	Outils oublier (Programmer une réintervention)	145039104108865	2
1777	Chirurgie	2021-07-15 14:13:50	RAS	223115310429678	3
1778	Craniatomie	2021-12-01 21:07:31	Outils oublier (Programmer une réintervention)	223115310429678	5
1779	Examen	2021-08-13 09:18:56	Outils oublier (Programmer une réintervention)	223115310429678	4
1780	Infiltration	2020-09-05 12:01:14	Personelle manquant	281038699937926	1
1781	Platre	2020-09-05 11:31:21	RAS	281038699937926	2
1782	Depistage	2018-05-22 11:31:32	Annule	285039913209682	1
1783	Point de suture	2019-12-01 10:57:42	Cancer confirmé	285039913209682	2
1784	Depistage	2018-04-04 16:12:59	RAS	285039913209682	1
1785	Platre	2018-05-22 03:20:50	Annule	285039913209682	2
1786	Platre	2020-05-28 10:32:23	Annule	200052554875542	2
1787	Infiltration	2016-04-20 15:49:03	Le patient a pris la fuite	200052554875542	1
1788	Point de suture	2016-04-20 15:38:46	RAS	200052554875542	2
1789	Infiltration	2016-04-20 06:25:12	RAS	200052554875542	1
1790	Platre	2017-03-19 18:26:24	RAS	160103642429132	1
1791	Radio	2019-03-02 11:27:11	RAS	202123105157942	1
1792	Radio	2019-03-02 03:57:22	RAS	202123105157942	1
1793	Radio	2019-03-02 16:05:57	Cancer confirmé	202123105157942	1
1794	Radio	2015-04-07 01:38:35	Outils oublier (Programmer une réintervention)	204011935620841	1
1795	Depistage	2021-03-12 08:52:10	RAS	297096978369003	2
1796	Platre	2021-03-12 16:52:25	Cancer confirmé	297096978369003	2
1797	Transplantation	2021-08-28 02:18:51	Membre couper par erreur	186021649778788	8
1798	Examen	2018-02-24 18:22:22	RAS	186021649778788	4
1799	Chirurgie	2018-03-22 20:03:02	Le patient a pris la fuite	186021649778788	4
1800	Point de suture	2019-02-15 03:21:43	RAS	103095695159235	1
1801	Infiltration	2018-10-16 09:53:10	Le patient a pris la fuite	103095695159235	2
1802	Point de suture	2019-02-15 10:56:24	RAS	103095695159235	2
1803	Depistage	2020-09-09 00:28:11	RAS	113115246343642	2
1804	Platre	2018-08-09 17:32:52	Le patient a pris la fuite	113115246343642	1
1805	Platre	2017-12-01 12:36:22	RAS	142038048913513	2
1806	Point de suture	2017-12-01 16:33:25	RAS	142038048913513	2
1807	Infiltration	2017-12-01 13:15:54	RAS	142038048913513	2
1808	Depistage	2017-12-01 02:26:02	Outils oublier (Programmer une réintervention)	142038048913513	1
1809	Infiltration	2018-05-22 23:37:04	RAS	176078894344648	2
1810	Laminectomie	2019-03-17 06:26:21	RAS	255101453587957	5
1811	Laminectomie	2018-10-20 13:50:12	RAS	255101453587957	10
1812	Examen	2019-10-01 12:18:19	Le patient a pris la fuite	255101453587957	10
1813	Platre	2021-04-03 14:55:10	RAS	236060592944147	1
1814	Platre	2021-04-03 02:17:53	Membre couper par erreur	236060592944147	1
1815	Platre	2021-04-03 20:20:37	RAS	236060592944147	1
1816	Radio	2021-11-05 01:23:51	Personelle manquant	236060592944147	1
1817	Platre	2016-11-08 03:32:45	Outils oublier (Programmer une réintervention)	286032428338414	2
1818	Point de suture	2017-08-16 07:10:48	RAS	213092819479712	1
1819	Platre	2017-04-18 09:15:47	Annule	213092819479712	1
1820	Platre	2017-05-18 06:01:01	Outils oublier (Programmer une réintervention)	213092819479712	1
1821	Depistage	2017-09-01 18:30:33	RAS	213092819479712	1
1822	Point de suture	2020-11-15 03:10:09	RAS	287018725817056	1
1823	Infiltration	2018-10-22 17:37:01	Annule	205062269993651	1
1824	Point de suture	2016-10-28 10:57:33	RAS	158069665674107	2
1825	Point de suture	2018-08-28 00:23:35	Cancer confirmé	157073274149735	2
1826	Depistage	2015-06-26 04:43:41	Personelle manquant	157073274149735	1
1827	Point de suture	2015-06-26 09:23:50	RAS	157073274149735	1
1828	Depistage	2015-02-11 12:34:37	Membre couper par erreur	157073274149735	2
1829	Radio	2020-05-26 21:28:32	RAS	212100642731642	1
1830	Infiltration	2017-01-21 21:41:54	Annule	212100642731642	1
1831	Point de suture	2018-01-26 02:39:00	Le patient a pris la fuite	212100642731642	1
1832	Chirurgie cardiaque	2021-08-06 18:04:49	RAS	241049099179176	9
1833	Instalation d un DCI	2018-06-18 07:33:31	RAS	226122696935272	9
1834	Chirurgie	2021-12-01 06:25:17	Cancer confirmé	226122696935272	3
1835	Transplantation	2017-06-26 01:19:34	Membre couper par erreur	223113006500836	9
1836	Radio	2021-11-09 19:51:05	Personelle manquant	100109271865326	2
1837	Platre	2021-11-19 22:26:59	RAS	100109271865326	1
1838	Laminectomie	2019-09-01 19:38:11	RAS	100109271865326	5
1839	Laminectomie	2018-12-01 08:38:49	RAS	100109271865326	10
1840	Radio	2021-05-26 19:47:44	Membre couper par erreur	233039425007949	1
1841	Infiltration	2021-05-26 21:57:51	RAS	233039425007949	1
1842	Platre	2021-05-26 16:46:18	RAS	233039425007949	1
1843	Radio	2021-05-26 05:27:50	Cancer confirmé	233039425007949	2
1844	Depistage	2018-02-24 10:51:20	Annule	264107842330942	2
1845	Infiltration	2016-12-01 12:58:26	RAS	264107842330942	1
1846	Radio	2020-07-20 03:25:49	RAS	150038037909168	1
1847	Platre	2020-11-27 03:43:13	RAS	150038037909168	1
1848	Point de suture	2020-11-27 12:25:04	RAS	150038037909168	2
1849	Depistage	2018-09-11 23:43:52	RAS	114040705604665	1
1850	Craniatomie	2021-07-06 02:11:40	RAS	114040705604665	5
1851	trepanation	2021-07-06 01:19:00	Annule	114040705604665	5
1852	Depistage	2017-07-05 02:26:15	Personelle manquant	281011552942390	1
1853	Point de suture	2017-07-05 04:34:30	Le patient a pris la fuite	281011552942390	1
1854	Platre	2017-07-05 19:48:52	RAS	281011552942390	2
1855	Platre	2016-04-28 16:45:53	Annule	208073703603064	2
1856	Point de suture	2020-12-01 23:17:33	Membre couper par erreur	195124129077459	2
1857	Point de suture	2019-03-27 12:42:19	RAS	195124129077459	2
1858	Infiltration	2019-03-27 04:39:15	Outils oublier (Programmer une réintervention)	195124129077459	2
1859	Chirurgie	2020-09-23 13:56:53	Cancer confirmé	203042945551495	3
1860	Ecographie	2019-04-10 22:40:33	Annule	203042945551495	12
1861	Examen	2020-09-23 18:40:18	RAS	203042945551495	4
1862	Radio	2019-06-22 21:48:10	Le patient a pris la fuite	283058967147128	2
1863	Infiltration	2019-06-22 10:15:25	RAS	283058967147128	1
1864	Platre	2019-06-22 09:33:35	Outils oublier (Programmer une réintervention)	283058967147128	1
1865	Depistage	2019-06-22 03:11:25	RAS	283058967147128	1
1866	Infiltration	2015-08-23 21:11:30	Outils oublier (Programmer une réintervention)	118058843585359	1
1867	Point de suture	2020-03-09 00:23:48	RAS	118058843585359	1
1868	Point de suture	2021-02-08 12:21:19	Outils oublier (Programmer une réintervention)	118058843585359	1
1869	Point de suture	2020-04-05 02:27:08	Outils oublier (Programmer une réintervention)	118058843585359	2
1870	Infiltration	2019-08-01 14:36:08	Outils oublier (Programmer une réintervention)	245083736982839	1
1871	Radio	2019-05-04 06:18:49	Membre couper par erreur	113076417665792	3
1872	Chirurgie	2021-12-01 02:21:53	RAS	113076417665792	3
1873	Radio	2018-11-03 02:56:07	RAS	131120964176884	1
1874	Platre	2018-11-03 21:00:55	RAS	131120964176884	1
1875	Point de suture	2018-11-03 18:33:35	RAS	131120964176884	1
1876	Point de suture	2020-03-16 03:13:15	RAS	149111387041541	2
1877	Point de suture	2018-11-07 01:48:06	Outils oublier (Programmer une réintervention)	153128900719727	2
1878	Point de suture	2018-04-14 23:36:04	Le patient a pris la fuite	153128900719727	2
1879	Examen	2018-12-01 05:28:54	RAS	150034197947334	10
1880	Examen	2018-07-13 03:52:10	Outils oublier (Programmer une réintervention)	150034197947334	10
1881	Laminectomie	2020-08-15 04:41:54	Personelle manquant	150034197947334	10
1882	Examen	2021-04-23 22:04:53	RAS	150034197947334	10
1883	Infiltration	2016-10-05 04:24:32	RAS	245028537507582	2
1884	Point de suture	2016-10-05 11:10:43	Annule	245028537507582	1
1885	Platre	2016-10-05 22:09:10	RAS	245028537507582	1
1886	Depistage	2016-10-05 01:40:16	RAS	245028537507582	2
1887	Point de suture	2017-07-26 03:02:19	RAS	159013980820603	1
1888	trepanation	2021-11-16 12:54:06	Outils oublier (Programmer une réintervention)	163054889165115	5
1889	Laminectomie	2021-11-20 06:26:40	Annule	163054889165115	5
1890	Craniatomie	2021-11-22 21:35:22	Annule	163054889165115	5
1891	Laminectomie	2021-12-01 02:18:58	Outils oublier (Programmer une réintervention)	114092770726295	10
1892	Examen	2021-12-01 23:16:12	RAS	114092770726295	10
1893	Examen	2021-11-10 14:12:11	Le patient a pris la fuite	114092770726295	5
1894	Chirurie	2020-08-13 06:30:33	Annule	251123729430821	7
1895	Radio	2021-12-01 09:11:33	Annule	251123729430821	3
1896	Reanimation	2021-10-10 03:59:56	RAS	193071493716975	6
1897	Radio	2021-11-10 03:28:27	Membre couper par erreur	193071493716975	2
1898	Depistage	2021-11-16 01:54:03	Personelle manquant	193071493716975	1
1899	Reanimation	2021-10-06 02:40:08	RAS	193071493716975	7
1900	Platre	2017-07-18 19:24:00	Le patient a pris la fuite	106099937166117	2
1901	Depistage	2015-11-23 14:47:29	RAS	106099937166117	1
1902	Depistage	2015-12-01 06:51:36	RAS	106099937166117	2
1903	Radio	2017-07-13 04:45:59	Cancer confirmé	123032531483026	1
1904	Depistage	2017-07-13 09:14:48	Annule	123032531483026	2
1905	Radio	2021-10-05 18:07:26	Cancer confirmé	131084231150591	2
1906	Reanimation	2020-09-18 14:05:42	RAS	209027164298065	6
1907	Scanner	2021-12-01 11:34:35	RAS	209027164298065	12
1908	Depistage	2018-06-18 07:34:19	RAS	199078543975254	1
1909	Platre	2016-07-13 17:05:25	RAS	100049631898104	2
1910	Depistage	2016-07-13 03:55:30	Annule	100049631898104	2
1911	Chirurgie cardiaque	2019-06-12 19:05:56	Le patient a pris la fuite	184025786706731	9
1912	Cardioversion	2017-03-25 02:16:49	Personelle manquant	184025786706731	8
1913	Transplantation	2018-02-19 18:55:57	RAS	184025786706731	8
1914	Instalation d un DCI	2019-05-22 12:09:52	Annule	184025786706731	8
1915	Point de suture	2021-10-27 18:18:54	RAS	274022481152500	2
1916	Infiltration	2016-08-05 06:54:08	RAS	240026048838751	2
1917	Infiltration	2017-12-01 08:53:13	RAS	178054655023440	2
1918	Point de suture	2018-11-06 23:29:49	RAS	174030300877871	2
1919	Platre	2019-05-16 13:09:53	Membre couper par erreur	174030300877871	1
1920	Infiltration	2018-11-06 09:41:04	Membre couper par erreur	174030300877871	1
1921	Infiltration	2018-11-06 18:11:05	RAS	174030300877871	2
1922	Platre	2020-07-12 07:34:19	RAS	110080140197255	1
1923	Platre	2021-08-12 10:35:19	Le patient a pris la fuite	110080140197255	2
1924	Infiltration	2021-08-12 23:48:33	RAS	110080140197255	1
1925	Laminectomie	2021-10-24 10:29:39	Annule	161034008075245	10
1926	Platre	2020-12-01 20:48:48	Le patient a pris la fuite	188118883989333	1
1927	Platre	2020-12-01 22:54:15	Cancer confirmé	188118883989333	2
1928	Depistage	2020-12-01 19:19:39	RAS	188118883989333	2
1929	Point de suture	2020-12-01 07:15:21	Annule	188118883989333	1
1930	Platre	2017-10-21 06:26:57	RAS	107032841366591	2
1931	Depistage	2015-12-01 11:05:56	RAS	107032841366591	1
1932	Point de suture	2015-12-01 06:56:55	RAS	107032841366591	1
1933	Infiltration	2015-04-04 23:51:24	Personelle manquant	107032841366591	2
1934	Platre	2018-09-18 09:49:11	RAS	181044191868718	1
1935	Infiltration	2018-09-18 00:13:06	RAS	181044191868718	1
1936	Radio	2021-08-01 10:49:16	Le patient a pris la fuite	146084909826612	2
1937	Depistage	2021-07-15 08:51:08	RAS	146084909826612	1
1938	Radio	2016-04-05 22:20:59	RAS	259074697674603	1
1939	Radio	2021-10-10 08:15:29	RAS	259074697674603	1
1940	Infiltration	2021-10-11 21:11:15	Cancer confirmé	259074697674603	1
1941	Platre	2016-04-05 06:40:48	RAS	259074697674603	2
1942	Point de suture	2020-11-06 11:41:32	Outils oublier (Programmer une réintervention)	210030438953147	2
1943	Depistage	2020-11-06 21:38:52	RAS	210030438953147	2
1944	Platre	2020-11-06 01:34:14	Annule	210030438953147	2
1945	Platre	2021-06-11 13:29:16	Outils oublier (Programmer une réintervention)	210042436071478	2
1946	Point de suture	2021-06-11 17:44:47	RAS	210042436071478	1
1947	Platre	2020-04-15 12:15:30	Outils oublier (Programmer une réintervention)	210042436071478	1
1948	Depistage	2020-04-15 18:46:17	RAS	210042436071478	2
1949	Point de suture	2016-08-27 10:24:37	RAS	196018757049140	1
1950	Point de suture	2017-06-07 17:49:14	RAS	196018757049140	1
1951	Platre	2019-07-08 01:05:42	RAS	170115855210295	1
1952	trepanation	2019-11-01 13:07:35	RAS	176108949873359	5
1953	Examen	2016-01-03 07:18:09	RAS	176108949873359	5
1954	Craniatomie	2020-07-25 09:59:24	RAS	176108949873359	5
1955	Platre	2020-09-08 10:45:30	Membre couper par erreur	292032690622575	2
1956	Radio	2020-09-08 07:20:29	RAS	292032690622575	1
1957	Depistage	2020-09-08 00:25:15	RAS	292032690622575	1
1958	Platre	2019-11-28 18:25:18	Outils oublier (Programmer une réintervention)	297025448866853	2
1959	Radio	2019-11-28 05:01:43	Outils oublier (Programmer une réintervention)	297025448866853	2
1960	Depistage	2020-10-05 17:33:06	RAS	189061293903962	2
1961	Platre	2021-12-01 06:05:04	RAS	189061293903962	2
1962	Platre	2020-10-05 09:36:46	Annule	189061293903962	1
1963	Platre	2021-12-01 03:48:17	RAS	189061293903962	2
1964	Point de suture	2016-07-25 03:37:29	RAS	107021159794718	1
1965	Depistage	2016-07-25 06:41:54	RAS	107021159794718	1
1966	Infiltration	2016-07-25 00:55:44	Membre couper par erreur	107021159794718	1
1967	Radio	2021-08-12 06:50:32	Le patient a pris la fuite	107021159794718	2
1968	Radio	2020-09-23 13:44:28	Membre couper par erreur	225058455250413	1
1969	Platre	2016-08-21 04:47:48	Personelle manquant	150086595242939	2
1970	Depistage	2016-01-03 08:15:32	RAS	150086595242939	1
1971	Point de suture	2016-01-03 23:08:18	RAS	150086595242939	2
1972	Infiltration	2019-03-24 12:37:51	Le patient a pris la fuite	103076152831337	2
1973	Infiltration	2021-09-03 13:39:04	Outils oublier (Programmer une réintervention)	198080243696000	1
1974	Scanner	2017-12-01 21:37:46	RAS	198080243696000	11
1975	Platre	2021-08-23 05:28:44	Cancer confirmé	198080243696000	2
1976	IRM	2017-07-19 10:54:16	RAS	198080243696000	12
1977	Craniatomie	2021-11-22 01:27:24	Annule	185082755251667	5
1978	Chirurgie cardiaque	2019-10-20 17:50:15	Personelle manquant	185082755251667	8
1979	Platre	2017-06-04 21:26:06	RAS	152011275394961	2
1980	Point de suture	2021-06-20 21:13:15	Personelle manquant	152011275394961	1
1981	Infiltration	2021-06-20 20:58:17	Personelle manquant	152011275394961	1
1982	Depistage	2017-06-04 01:13:45	RAS	152011275394961	2
1983	Platre	2018-12-01 17:35:36	RAS	240121987869929	2
1984	Depistage	2018-06-26 18:05:09	RAS	240121987869929	1
1985	Radio	2018-12-01 00:08:36	Personelle manquant	240121987869929	2
1986	Radio	2021-11-06 06:17:40	RAS	121107075333327	1
1987	Radio	2016-09-02 05:23:31	Annule	290043665477208	1
1988	Infiltration	2016-09-02 13:42:10	Annule	290043665477208	2
1989	Depistage	2016-09-02 19:52:39	RAS	290043665477208	1
1990	Infiltration	2016-09-02 08:40:03	Membre couper par erreur	290043665477208	1
1991	Depistage	2015-02-28 06:26:43	Membre couper par erreur	255093111334747	1
1992	Platre	2015-02-28 09:04:09	Le patient a pris la fuite	255093111334747	1
1993	Platre	2015-02-28 07:24:19	Outils oublier (Programmer une réintervention)	255093111334747	1
1994	Platre	2018-08-24 09:44:23	Personelle manquant	255093111334747	2
1995	Platre	2019-09-06 18:40:07	Le patient a pris la fuite	154070228992208	2
1996	Platre	2021-04-02 14:39:16	Personelle manquant	154070228992208	1
1997	Radio	2021-01-14 12:50:08	RAS	279121641670735	1
1998	Infiltration	2015-03-22 16:18:33	Personelle manquant	279121641670735	2
1999	Infiltration	2021-04-07 07:36:25	Personelle manquant	279121641670735	1
2000	Scanner	2021-12-01 11:41:53	Membre couper par erreur	266092921839948	11
2001	Scanner	2020-12-01 04:11:51	Membre couper par erreur	266092921839948	12
2002	trepanation	2021-10-09 07:59:01	RAS	266092921839948	10
2003	Ecographie	2020-12-01 20:14:15	Annule	266092921839948	12
2004	Depistage	2018-09-12 12:47:24	Membre couper par erreur	283124185961943	1
2005	Depistage	2018-09-20 01:50:20	Le patient a pris la fuite	283124185961943	1
2006	Radio	2018-09-20 10:18:30	Personelle manquant	283124185961943	2
2007	Point de suture	2018-07-25 04:43:44	RAS	111013917857673	1
2008	Point de suture	2020-06-16 02:48:40	RAS	221111999395911	2
2009	Infiltration	2017-01-08 12:57:06	RAS	221111999395911	2
2010	Point de suture	2016-03-18 19:14:42	Outils oublier (Programmer une réintervention)	221111999395911	1
2011	Depistage	2021-03-26 10:16:10	RAS	131109142556613	2
2012	trepanation	2020-02-23 22:18:44	Personelle manquant	131109142556613	5
2013	Infiltration	2019-03-01 02:51:11	RAS	187014852065018	2
2014	Transplantation	2021-08-02 02:30:57	RAS	187014852065018	8
2015	Point de suture	2021-12-01 19:44:33	RAS	169025278120012	2
2016	Point de suture	2021-12-01 14:13:11	RAS	169025278120012	1
2017	Scanner	2019-10-10 06:17:21	Personelle manquant	143033632736665	11
2018	Radio	2019-11-11 06:52:44	RAS	143033632736665	11
2019	Ecographie	2021-03-18 22:24:47	Le patient a pris la fuite	143033632736665	11
2020	Radio	2019-12-01 09:36:32	Cancer confirmé	113072827979823	1
2021	Depistage	2019-12-01 20:16:15	RAS	113072827979823	2
2022	Platre	2019-09-26 13:37:17	RAS	113072827979823	1
2023	Radio	2021-10-06 10:23:44	RAS	174083131677691	1
2024	Depistage	2021-10-06 23:53:38	Cancer confirmé	174083131677691	2
2025	Depistage	2021-10-06 14:13:41	Outils oublier (Programmer une réintervention)	174083131677691	1
2026	Infiltration	2021-10-06 14:35:12	RAS	174083131677691	2
2027	Radio	2015-07-15 17:37:35	Outils oublier (Programmer une réintervention)	240030208771657	2
2028	Depistage	2017-11-04 09:16:00	RAS	240030208771657	2
2029	Infiltration	2017-11-04 21:04:38	Outils oublier (Programmer une réintervention)	240030208771657	2
2030	Instalation d un DCI	2020-09-25 21:05:11	RAS	147030287258403	8
2031	Instalation d un DCI	2020-09-23 07:27:00	Cancer confirmé	147030287258403	8
2032	Chirurgie cardiaque	2020-03-26 08:20:03	Le patient a pris la fuite	147030287258403	9
2033	Infiltration	2017-10-04 10:52:13	Annule	147030287258403	1
2034	Platre	2017-08-15 21:13:42	Outils oublier (Programmer une réintervention)	231072312146616	2
2035	Point de suture	2017-08-15 03:58:11	Annule	231072312146616	1
2036	Infiltration	2017-08-15 00:29:58	Le patient a pris la fuite	231072312146616	2
2037	Chirurie	2019-02-23 18:22:17	RAS	260059790196310	6
2038	Chirurie	2018-02-12 12:43:37	RAS	260059790196310	7
2039	Chirurie	2016-12-14 02:32:18	Personelle manquant	260059790196310	7
2040	Chirurgie	2021-12-01 05:22:44	Outils oublier (Programmer une réintervention)	145041267838254	3
2041	Chirurgie	2021-12-01 23:36:35	Le patient a pris la fuite	145041267838254	3
2042	Examen	2021-08-26 10:43:07	RAS	145041267838254	5
2043	Infiltration	2019-01-24 04:45:46	RAS	114014067183365	2
2044	Radio	2021-10-18 01:52:14	RAS	178067934684562	1
2045	Platre	2020-08-21 10:50:48	RAS	141125258291919	2
2046	Depistage	2020-07-16 03:59:54	Membre couper par erreur	142086019899660	1
2047	Radio	2018-01-09 13:12:30	RAS	142086019899660	2
2048	Depistage	2018-01-09 17:53:39	Outils oublier (Programmer une réintervention)	142086019899660	2
2049	Craniatomie	2017-01-27 03:40:42	RAS	180084675181912	5
2050	Craniatomie	2016-10-20 09:59:42	Personelle manquant	180084675181912	5
2051	Laminectomie	2015-11-13 13:29:52	RAS	180084675181912	10
2052	trepanation	2016-03-10 20:38:54	Outils oublier (Programmer une réintervention)	180084675181912	5
2053	IRM	2021-02-04 20:27:57	RAS	131125067536259	12
2054	Point de suture	2021-09-21 19:57:32	Le patient a pris la fuite	131125067536259	7
2055	Chirurie	2021-09-25 08:36:17	Cancer confirmé	131125067536259	6
2056	Chirurgie	2021-10-20 09:43:34	Le patient a pris la fuite	292042271914783	4
2057	Scanner	2019-11-09 00:58:38	RAS	292042271914783	11
2058	Examen	2021-10-09 03:29:08	Cancer confirmé	292042271914783	4
2059	Ecographie	2018-12-01 04:09:32	RAS	116032805072076	12
2060	Radio	2018-07-07 02:42:39	Outils oublier (Programmer une réintervention)	116032805072076	12
2061	Scanner	2021-06-10 00:24:43	RAS	224019865233132	12
2062	trepanation	2021-12-01 11:49:08	Le patient a pris la fuite	224019865233132	10
2063	Craniatomie	2021-12-01 21:57:56	Personelle manquant	224019865233132	10
2064	Platre	2019-09-17 15:11:19	RAS	224019865233132	1
2065	Laminectomie	2020-11-20 06:01:33	RAS	283097419522568	5
2066	Scanner	2021-12-01 07:06:09	Annule	283097419522568	12
2067	Examen	2021-09-07 09:16:39	RAS	283097419522568	5
2068	Cardioversion	2017-05-10 09:55:27	Cancer confirmé	283097419522568	8
2069	Platre	2020-03-21 10:27:44	RAS	279055788448335	2
2070	Point de suture	2017-03-21 06:21:20	RAS	279055788448335	1
2071	Infiltration	2018-09-18 06:58:48	RAS	139058121016456	2
2072	Examen	2019-12-01 16:05:02	Cancer confirmé	194094891582637	3
2073	Examen	2016-12-01 14:08:16	RAS	194094891582637	4
2074	Platre	2020-02-27 02:57:15	Personelle manquant	139011591930760	2
2075	Point de suture	2020-02-27 07:33:10	Membre couper par erreur	139011591930760	2
2076	Platre	2017-12-01 13:12:09	Cancer confirmé	139011591930760	2
2077	Depistage	2020-02-27 07:20:38	Cancer confirmé	139011591930760	2
2078	Scanner	2021-12-01 13:06:27	Cancer confirmé	252030424521689	11
2079	Examen	2021-09-25 13:19:38	RAS	252030424521689	3
2080	Point de suture	2019-03-16 15:25:54	Le patient a pris la fuite	280076300617446	7
2081	Platre	2020-01-26 16:52:52	Outils oublier (Programmer une réintervention)	221067612519950	2
2082	Depistage	2021-06-25 13:15:54	RAS	244027770559855	1
2083	Depistage	2021-09-27 04:16:08	RAS	244027770559855	1
2084	Point de suture	2020-01-15 13:56:04	RAS	244027770559855	2
2085	Depistage	2021-11-23 10:15:48	RAS	134044002643870	2
2086	Radio	2020-10-15 04:57:27	RAS	134044002643870	2
2087	Point de suture	2020-10-10 04:07:52	RAS	170084270924505	2
2088	Point de suture	2020-10-10 03:36:49	Annule	170084270924505	2
2089	Radio	2020-10-10 03:39:04	Cancer confirmé	170084270924505	1
2090	Chirurgie	2019-03-15 05:07:03	RAS	147037410601226	4
2091	Point de suture	2016-08-16 02:02:21	Cancer confirmé	187102210975946	1
2092	Depistage	2018-07-17 18:13:56	RAS	187102210975946	2
2093	Depistage	2017-12-19 09:10:20	RAS	187102210975946	2
2094	Platre	2019-06-04 09:40:08	RAS	230039788083545	1
2095	Depistage	2019-06-04 21:48:05	Le patient a pris la fuite	230039788083545	2
2096	Platre	2021-01-22 03:23:35	RAS	270061672667130	1
2097	Infiltration	2021-12-01 17:47:10	Annule	270061672667130	1
2098	Depistage	2021-01-22 20:30:45	Membre couper par erreur	270061672667130	1
2099	Radio	2018-03-24 09:40:58	RAS	278016346820968	1
2100	Infiltration	2021-09-21 01:49:06	Personelle manquant	278016346820968	1
2101	Point de suture	2021-10-08 12:28:32	RAS	133060383952590	2
2102	Point de suture	2021-10-08 03:06:12	RAS	133060383952590	2
2103	Infiltration	2021-10-08 13:28:41	Annule	133060383952590	1
2104	Platre	2019-03-24 15:06:21	RAS	193068126328431	2
2105	Platre	2019-03-24 14:24:20	RAS	193068126328431	1
2106	Infiltration	2021-10-28 13:42:26	RAS	193068126328431	2
2107	Infiltration	2021-10-28 00:47:49	RAS	193068126328431	1
2108	Infiltration	2021-12-01 12:22:21	RAS	148112887355343	2
2109	Radio	2021-02-22 16:26:05	RAS	175013717803592	1
2110	Platre	2021-02-22 05:18:51	Membre couper par erreur	175013717803592	1
2111	Depistage	2021-02-22 04:06:23	RAS	175013717803592	1
2112	Radio	2021-06-07 19:47:20	Membre couper par erreur	202017836106992	1
2113	Platre	2021-01-04 11:12:50	Membre couper par erreur	202017836106992	2
2114	Point de suture	2021-04-07 02:30:43	RAS	245102229936748	1
2115	trepanation	2019-12-01 10:19:19	RAS	245102229936748	10
2116	Chirurgie	2021-12-01 09:31:06	RAS	245102229936748	4
2117	Chirurgie cardiaque	2021-09-12 11:18:06	Outils oublier (Programmer une réintervention)	131054917320660	8
2118	Chirurgie cardiaque	2021-08-24 06:17:52	Membre couper par erreur	131054917320660	8
2119	Reanimation	2021-01-19 20:38:03	RAS	131054917320660	7
2120	Chirurie	2021-12-01 14:15:51	Personelle manquant	165118676503239	6
2121	Infiltration	2021-01-12 20:05:08	Cancer confirmé	165118676503239	1
2122	Platre	2020-12-01 19:40:33	Personelle manquant	117084718549821	2
2123	Depistage	2020-12-01 00:57:29	RAS	117084718549821	2
2124	Infiltration	2020-12-01 05:53:24	RAS	117084718549821	1
2125	Platre	2021-08-13 08:58:27	Le patient a pris la fuite	124041724420932	1
2126	Infiltration	2021-08-13 23:08:51	Personelle manquant	124041724420932	2
2127	Radio	2020-10-23 17:19:02	Annule	210070413119454	1
2128	Platre	2021-03-01 00:57:26	Outils oublier (Programmer une réintervention)	210070413119454	2
2129	Radio	2020-03-01 22:50:54	RAS	142078663953463	2
2130	Point de suture	2018-04-27 14:28:42	Annule	142078663953463	2
2131	Platre	2018-04-27 15:16:58	RAS	142078663953463	2
2132	Infiltration	2021-11-09 15:45:24	RAS	220033098580085	2
2133	Platre	2020-11-24 22:18:36	RAS	288072025161887	1
2134	Radio	2021-10-11 23:46:25	RAS	288072025161887	2
2135	Depistage	2021-10-11 00:02:42	Outils oublier (Programmer une réintervention)	288072025161887	2
2136	Laminectomie	2021-12-01 12:41:29	Personelle manquant	193020420013248	10
2137	Examen	2021-11-20 19:24:32	Le patient a pris la fuite	193020420013248	5
2138	Craniatomie	2021-09-27 01:13:50	Le patient a pris la fuite	193020420013248	10
2139	Depistage	2018-03-10 00:45:14	Outils oublier (Programmer une réintervention)	251083723773260	1
2140	Point de suture	2017-01-28 12:54:09	RAS	251083723773260	1
2141	Point de suture	2018-03-10 14:37:09	Cancer confirmé	251083723773260	2
2142	Point de suture	2018-03-10 04:15:03	RAS	251083723773260	2
2143	Infiltration	2016-12-01 08:03:50	RAS	117018876276701	2
2144	Radio	2018-01-04 04:56:32	RAS	211055538833854	1
2145	Infiltration	2021-06-12 16:45:28	Le patient a pris la fuite	228105308454888	1
2146	Platre	2021-06-12 01:15:40	RAS	228105308454888	2
2147	Depistage	2021-03-20 20:10:38	Le patient a pris la fuite	281086421940130	1
2148	Depistage	2021-03-20 10:22:02	Annule	281086421940130	2
2149	Platre	2020-04-22 06:03:10	RAS	173041596006042	1
2150	Depistage	2018-04-21 22:25:35	RAS	173041596006042	2
2151	Radio	2019-08-25 17:05:32	Membre couper par erreur	235103315320667	2
2152	Platre	2019-08-25 23:28:39	RAS	235103315320667	1
2153	Infiltration	2019-08-25 15:19:18	RAS	235103315320667	1
2154	Point de suture	2021-02-07 19:24:29	Annule	235103315320667	2
2155	Radio	2021-11-28 07:27:23	Membre couper par erreur	196066953664866	1
2156	Platre	2021-11-28 02:17:39	RAS	196066953664866	2
2157	Infiltration	2021-11-28 13:54:18	RAS	196066953664866	2
2158	Point de suture	2020-11-19 15:34:33	Cancer confirmé	196066953664866	1
2159	Infiltration	2021-10-28 22:47:43	RAS	100097374384987	1
2160	Point de suture	2019-01-13 04:20:32	Le patient a pris la fuite	100097374384987	1
2161	Platre	2018-09-11 08:58:28	Le patient a pris la fuite	281027685467381	2
2162	Infiltration	2018-09-11 02:18:46	Le patient a pris la fuite	281027685467381	2
2163	Radio	2018-09-11 07:27:42	Personelle manquant	281027685467381	2
2164	Reanimation	2021-04-08 14:22:29	Le patient a pris la fuite	288063479168564	7
2165	Platre	2021-07-24 00:10:30	Outils oublier (Programmer une réintervention)	244054666231017	1
2166	Infiltration	2017-04-06 17:00:15	RAS	145018037213375	2
2167	Infiltration	2016-10-25 23:11:27	RAS	145018037213375	1
2168	Platre	2016-10-25 17:34:22	Outils oublier (Programmer une réintervention)	145018037213375	2
2169	Platre	2016-10-25 01:47:29	RAS	145018037213375	1
2170	Depistage	2017-05-02 07:24:45	RAS	222071821111846	2
2171	Reanimation	2021-11-27 19:29:32	RAS	137014618658034	6
2172	Examen	2019-09-09 10:48:05	RAS	137014618658034	10
2173	Craniatomie	2021-06-22 05:47:43	RAS	137014618658034	5
2174	Examen	2020-05-24 04:29:10	RAS	137014618658034	5
2175	Radio	2018-02-25 15:48:35	Annule	117035495904467	2
2176	Point de suture	2018-02-25 14:03:03	RAS	117035495904467	2
2177	Radio	2019-07-17 10:56:10	Le patient a pris la fuite	120085453420861	2
2178	Point de suture	2020-11-28 23:20:07	RAS	120085453420861	1
2179	Point de suture	2020-04-21 20:40:12	RAS	120085453420861	1
2180	Radio	2020-08-19 18:18:56	Personelle manquant	120085453420861	1
2181	Infiltration	2021-12-01 07:15:58	RAS	107062454569949	2
2182	Point de suture	2021-12-01 06:40:39	Cancer confirmé	107062454569949	2
2183	Point de suture	2021-12-01 09:28:46	Cancer confirmé	107062454569949	2
2184	Radio	2018-06-27 11:09:11	Annule	174052321465035	2
2185	Point de suture	2018-06-27 15:48:26	Outils oublier (Programmer une réintervention)	174052321465035	2
2186	Point de suture	2018-06-27 15:04:47	Personelle manquant	174052321465035	1
2187	Depistage	2018-06-27 23:20:16	Membre couper par erreur	174052321465035	2
2188	Platre	2020-12-01 11:05:30	RAS	203082364962173	2
2189	Radio	2020-12-01 11:23:19	Outils oublier (Programmer une réintervention)	203082364962173	2
2190	Infiltration	2020-12-01 03:56:48	Membre couper par erreur	203082364962173	1
2191	Radio	2020-05-01 22:58:21	Le patient a pris la fuite	251041230601930	11
2192	Chirurgie cardiaque	2021-10-28 10:40:29	Outils oublier (Programmer une réintervention)	251041230601930	9
2193	IRM	2021-12-01 03:14:54	RAS	155032782058795	11
2194	Radio	2017-09-08 15:22:04	RAS	235018357073752	1
2195	Platre	2017-09-08 00:53:23	RAS	235018357073752	2
2196	Depistage	2017-09-12 07:08:24	Annule	235018357073752	2
2197	Radio	2018-11-05 04:39:27	RAS	242023117314654	2
2198	Infiltration	2018-11-05 00:31:20	RAS	242023117314654	1
2199	Depistage	2018-11-05 10:03:39	RAS	242023117314654	2
2200	Reanimation	2020-11-17 02:58:47	RAS	278024853925779	7
2201	Chirurie	2020-11-13 06:45:47	RAS	278024853925779	7
2202	Infiltration	2019-10-28 01:44:48	Personelle manquant	143056272653974	2
2203	Platre	2017-07-18 00:34:05	Cancer confirmé	143056272653974	2
2204	Point de suture	2019-10-28 02:18:01	RAS	143056272653974	1
2205	Radio	2019-07-07 21:37:20	RAS	111084417670770	2
2206	Depistage	2019-07-07 21:37:32	RAS	111084417670770	2
2207	Depistage	2019-03-01 15:02:19	RAS	111084417670770	2
2208	Point de suture	2019-01-20 06:05:48	Cancer confirmé	202082616139782	2
2209	Radio	2020-03-12 03:50:16	RAS	202082616139782	1
2210	Point de suture	2019-01-20 00:57:55	Annule	202082616139782	2
2211	Radio	2018-11-19 04:51:40	RAS	121119302153015	1
2212	Point de suture	2018-08-16 06:03:36	RAS	121119302153015	2
2213	Point de suture	2018-11-19 23:16:54	RAS	121119302153015	1
2214	Radio	2018-08-16 02:01:28	RAS	121119302153015	2
2215	Radio	2016-02-27 20:21:31	RAS	259073450270161	1
2216	Examen	2019-06-22 13:51:53	RAS	237063613562087	10
2217	Cardioversion	2021-12-01 14:30:24	RAS	237063613562087	8
2218	IRM	2021-12-01 09:10:26	Outils oublier (Programmer une réintervention)	210069408347984	11
2219	Examen	2018-11-17 13:42:07	RAS	210069408347984	3
2220	Radio	2020-11-23 04:49:54	RAS	210069408347984	3
2221	Platre	2020-12-01 23:52:29	RAS	150050950892813	2
2222	Platre	2016-12-01 08:11:05	RAS	150050950892813	1
2223	Depistage	2016-12-01 10:26:17	RAS	150050950892813	2
2224	Platre	2020-12-01 12:03:05	Membre couper par erreur	150050950892813	2
2225	Point de suture	2017-07-21 07:56:04	RAS	137017091980101	1
2226	Examen	2021-02-02 03:57:24	Cancer confirmé	138066290675800	4
2227	Radio	2021-11-03 12:04:59	Le patient a pris la fuite	138066290675800	4
2228	Point de suture	2020-03-22 00:25:08	RAS	162108651894204	1
2229	Point de suture	2020-03-22 11:15:22	Cancer confirmé	162108651894204	2
2230	Depistage	2020-03-22 21:13:09	RAS	162108651894204	1
2231	Depistage	2021-03-21 15:03:22	Annule	116057590333638	1
2232	Radio	2021-03-21 11:53:45	RAS	116057590333638	1
2233	Infiltration	2017-05-18 12:38:15	Personelle manquant	252102748808594	2
2234	Depistage	2018-08-08 08:50:49	RAS	134063838698377	2
2235	Point de suture	2018-08-08 15:12:29	Membre couper par erreur	134063838698377	1
2236	Infiltration	2018-08-08 11:30:00	Personelle manquant	134063838698377	1
2237	Radio	2018-08-08 19:08:31	RAS	134063838698377	2
2238	Radio	2021-03-07 16:39:03	RAS	271081608987354	4
2239	Instalation d un DCI	2016-01-09 06:35:05	Annule	271081608987354	8
2240	Infiltration	2021-09-28 18:21:35	RAS	213018169533032	1
2241	Infiltration	2016-10-14 13:13:23	RAS	213018169533032	2
2242	Cardioversion	2021-11-28 02:16:17	RAS	115101172827851	8
2243	Ecographie	2021-09-03 21:49:59	RAS	115101172827851	12
2244	Craniatomie	2021-11-21 00:31:46	Personelle manquant	115101172827851	5
2245	Infiltration	2017-06-16 02:17:18	Personelle manquant	224023519830794	1
2246	Infiltration	2020-11-02 02:09:53	Personelle manquant	224023519830794	1
2247	Radio	2017-06-16 15:37:33	RAS	224023519830794	2
2248	Platre	2020-11-02 05:58:19	RAS	224023519830794	1
2249	Point de suture	2021-10-24 10:11:37	Personelle manquant	113086414892889	2
2250	Platre	2021-10-24 09:58:41	Le patient a pris la fuite	113086414892889	2
2251	Radio	2021-07-17 09:50:37	Outils oublier (Programmer une réintervention)	113086414892889	1
2252	Platre	2018-12-01 04:15:43	RAS	113086414892889	1
2253	Instalation d un DCI	2018-12-10 04:28:16	RAS	134088596109320	8
2254	Transplantation	2018-12-02 22:09:41	Cancer confirmé	134088596109320	9
2255	Depistage	2018-03-08 09:02:59	Membre couper par erreur	283100127930094	2
2256	Radio	2018-11-05 21:32:06	RAS	283100127930094	1
2257	Point de suture	2018-03-08 13:45:15	Le patient a pris la fuite	283100127930094	2
2258	Point de suture	2019-12-01 21:16:51	Personelle manquant	108062368491491	2
2259	Depistage	2019-12-01 23:52:13	RAS	108062368491491	1
2260	Cardioversion	2021-12-01 18:03:47	Le patient a pris la fuite	295054346609627	9
2261	Laminectomie	2021-11-27 08:23:27	RAS	295054346609627	5
2262	Craniatomie	2021-11-27 15:02:59	Outils oublier (Programmer une réintervention)	295054346609627	5
2263	Examen	2021-11-27 03:18:44	Outils oublier (Programmer une réintervention)	295054346609627	5
2264	Infiltration	2019-03-15 15:03:05	Annule	175056307245608	1
2265	Radio	2019-11-03 02:00:05	Personelle manquant	175056307245608	1
2266	Infiltration	2019-03-15 14:36:47	Annule	175056307245608	2
2267	Depistage	2020-02-04 22:04:30	RAS	184026584934683	1
2268	Radio	2017-05-10 03:34:14	Annule	184026584934683	1
2269	Point de suture	2020-02-04 08:17:25	Le patient a pris la fuite	184026584934683	2
2270	Radio	2017-12-01 03:15:23	Membre couper par erreur	276109369398817	2
2271	Platre	2017-12-01 18:14:51	Membre couper par erreur	276109369398817	2
2272	Scanner	2021-11-12 13:46:59	RAS	258047954598738	12
2273	IRM	2021-11-02 20:30:09	RAS	258047954598738	11
2274	Examen	2021-12-01 23:23:58	Personelle manquant	258047954598738	4
2275	Radio	2021-12-01 20:22:15	RAS	258047954598738	4
2276	Infiltration	2021-05-22 12:03:05	Cancer confirmé	159026101937367	1
2277	Depistage	2021-10-25 02:35:29	RAS	159026101937367	1
2278	Infiltration	2021-05-27 20:26:55	RAS	159026101937367	2
2279	Depistage	2021-11-20 00:01:34	RAS	159026101937367	1
2280	Depistage	2021-06-05 16:26:46	RAS	172027357912624	2
2281	Depistage	2021-05-27 12:09:27	RAS	113090769708903	1
2282	Radio	2021-05-27 04:21:48	RAS	113090769708903	1
2283	Radio	2021-05-27 00:03:30	Cancer confirmé	113090769708903	2
2284	Platre	2021-05-27 23:36:35	Le patient a pris la fuite	113090769708903	1
2285	Infiltration	2015-06-20 22:15:55	Personelle manquant	285090329769836	2
2286	Radio	2021-03-05 18:31:35	Outils oublier (Programmer une réintervention)	235112226577695	2
2287	Platre	2021-11-27 19:47:13	RAS	235112226577695	2
2288	Point de suture	2021-03-05 09:09:13	Le patient a pris la fuite	235112226577695	1
2289	Transplantation	2021-10-28 01:27:56	Personelle manquant	146035915566546	9
2290	Transplantation	2019-12-06 12:22:06	Personelle manquant	146035915566546	8
2291	Infiltration	2019-08-18 02:01:38	RAS	146035915566546	1
2292	Radio	2019-09-13 19:28:12	RAS	146035915566546	2
2293	Platre	2016-03-16 02:16:41	RAS	127013049115072	1
2294	Radio	2021-12-01 14:45:37	Membre couper par erreur	127013049115072	2
2295	Point de suture	2020-10-07 15:19:42	RAS	274078327911985	1
2296	Point de suture	2020-10-07 21:37:58	RAS	274078327911985	2
2297	Platre	2020-06-11 11:03:46	Cancer confirmé	274078327911985	1
2298	Infiltration	2020-12-01 17:27:41	Membre couper par erreur	274078327911985	1
2299	Chirurgie cardiaque	2018-11-15 01:16:45	Cancer confirmé	266113030404841	9
2300	IRM	2021-11-12 15:09:12	Outils oublier (Programmer une réintervention)	266113030404841	11
2301	Chirurgie cardiaque	2019-05-07 03:39:48	Annule	266113030404841	9
2302	Radio	2021-10-25 13:24:34	RAS	266113030404841	12
2303	Point de suture	2018-04-02 10:08:49	RAS	278128075429694	1
2304	Infiltration	2021-09-09 21:16:47	RAS	278128075429694	2
2305	Platre	2021-11-20 10:20:54	Cancer confirmé	184012353692245	2
2306	Laminectomie	2019-11-09 18:15:23	RAS	184012353692245	5
2307	Examen	2020-12-15 18:22:15	Le patient a pris la fuite	184012353692245	3
2308	Examen	2021-03-06 11:35:54	Cancer confirmé	184012353692245	3
2309	Chirurie	2017-01-27 23:01:36	RAS	165068074963681	6
2310	Chirurie	2016-09-28 16:45:40	RAS	165068074963681	7
2311	Infiltration	2021-09-05 03:31:39	RAS	188018753555015	2
2312	Depistage	2021-12-01 15:00:05	Le patient a pris la fuite	188018753555015	2
2313	Depistage	2021-09-05 20:20:04	Le patient a pris la fuite	188018753555015	2
2314	Platre	2021-12-01 10:30:56	Annule	188018753555015	1
2315	Chirurie	2021-03-26 08:18:32	Membre couper par erreur	125027234720831	7
2316	Examen	2021-08-03 17:03:49	Le patient a pris la fuite	151119609719317	10
2317	Infiltration	2015-10-15 11:45:29	RAS	238102455584257	2
2318	Infiltration	2015-10-15 04:16:30	Personelle manquant	238102455584257	1
2319	Point de suture	2015-12-01 21:28:27	RAS	174110177212641	2
2320	Depistage	2015-12-01 16:59:04	RAS	174110177212641	2
2321	Point de suture	2015-04-23 13:48:56	Membre couper par erreur	238091262456688	2
2322	Radio	2015-04-23 05:13:06	Membre couper par erreur	238091262456688	2
2323	Chirurgie	2019-07-27 22:23:03	Cancer confirmé	247045170896320	3
2324	Platre	2018-05-27 13:03:30	RAS	182061185597144	2
2325	Platre	2021-06-24 10:13:55	Cancer confirmé	182061185597144	1
2326	Platre	2018-05-27 12:27:19	RAS	182061185597144	1
2327	Depistage	2018-01-14 22:40:09	RAS	177040756394858	2
2328	Platre	2021-11-11 15:20:52	Outils oublier (Programmer une réintervention)	216097269788636	2
2329	Radio	2018-03-09 07:10:00	RAS	216097269788636	2
2330	Platre	2021-11-11 03:38:32	RAS	216097269788636	2
2331	Platre	2018-07-18 07:09:50	RAS	223027723041314	1
2332	Platre	2021-09-28 20:59:42	Membre couper par erreur	142038029211702	2
2333	Point de suture	2019-12-02 23:42:21	Le patient a pris la fuite	142038029211702	1
2334	Laminectomie	2021-12-01 20:42:39	Personelle manquant	142038029211702	5
2335	Radio	2019-12-01 00:29:21	RAS	119073774022947	1
2336	Point de suture	2019-12-01 09:35:54	RAS	119073774022947	2
2337	Point de suture	2019-12-01 15:57:41	RAS	119073774022947	2
2338	Platre	2019-12-01 11:11:20	Le patient a pris la fuite	119073774022947	1
2339	Chirurgie	2019-08-28 19:05:58	Membre couper par erreur	203105428294586	3
2340	Radio	2019-05-01 06:23:50	Membre couper par erreur	127114505385305	2
2341	Radio	2019-05-01 14:51:30	RAS	127114505385305	2
2342	Depistage	2019-05-01 14:39:29	Cancer confirmé	127114505385305	1
2343	Radio	2020-02-27 10:35:30	Cancer confirmé	143047530576868	3
2344	Platre	2021-04-09 19:00:39	Cancer confirmé	158083284418230	1
2345	Radio	2021-12-01 06:54:07	Le patient a pris la fuite	158083284418230	1
2346	Platre	2021-04-09 13:33:21	Outils oublier (Programmer une réintervention)	158083284418230	1
2347	Radio	2016-05-03 08:02:25	Personelle manquant	184060750824654	1
2348	Infiltration	2021-12-01 12:30:30	RAS	287129112205056	1
2349	Infiltration	2021-12-01 14:39:14	Cancer confirmé	287129112205056	1
2350	Cardioversion	2017-12-16 20:58:56	RAS	108117505421653	8
2351	Radio	2021-11-06 08:12:46	Cancer confirmé	108117505421653	12
2352	Chirurgie	2019-05-12 14:13:57	Cancer confirmé	108117505421653	4
2353	Transplantation	2018-04-17 12:16:15	Personelle manquant	108117505421653	8
2354	Infiltration	2021-06-19 11:33:11	Cancer confirmé	296109313485906	1
2355	Infiltration	2018-06-17 12:02:10	RAS	296109313485906	2
2356	Platre	2021-06-19 10:40:17	RAS	296109313485906	1
2357	Platre	2018-06-17 06:21:50	Le patient a pris la fuite	296109313485906	1
2358	Depistage	2018-11-04 19:30:39	Personelle manquant	276060158258875	2
2359	Platre	2018-11-04 02:51:01	Le patient a pris la fuite	276060158258875	2
2360	Infiltration	2018-11-04 23:23:37	RAS	276060158258875	2
2361	Reanimation	2021-10-26 16:15:51	Membre couper par erreur	119071350672351	7
2362	Chirurie	2021-12-01 23:22:04	Outils oublier (Programmer une réintervention)	119071350672351	7
2363	Chirurie	2021-11-25 03:08:27	RAS	119071350672351	6
2364	Examen	2021-11-28 15:46:20	RAS	119071350672351	10
2365	Depistage	2020-02-16 05:46:55	RAS	287073546978367	1
2366	Platre	2020-10-10 17:36:33	Cancer confirmé	287073546978367	2
2367	Radio	2020-02-16 22:10:48	RAS	287073546978367	1
2368	Infiltration	2020-10-10 10:15:16	Outils oublier (Programmer une réintervention)	287073546978367	1
2369	Point de suture	2018-09-11 21:46:42	Cancer confirmé	216034868105920	2
2370	Radio	2020-10-16 13:25:25	Annule	216034868105920	1
2371	Infiltration	2018-05-02 19:08:08	RAS	240108256892560	2
2372	Chirurgie cardiaque	2021-06-18 09:12:36	Outils oublier (Programmer une réintervention)	144060491514938	9
2373	Reanimation	2021-09-28 14:53:11	RAS	144060491514938	7
2374	Transplantation	2019-10-09 21:25:20	Le patient a pris la fuite	144060491514938	9
2375	Depistage	2021-12-01 12:40:18	Outils oublier (Programmer une réintervention)	144060491514938	2
2376	trepanation	2019-07-17 11:06:08	RAS	139028225880780	5
2377	Point de suture	2021-10-12 02:07:41	RAS	139028225880780	1
2378	Cardioversion	2021-09-24 12:33:31	Personelle manquant	139044509081733	8
2379	Cardioversion	2019-10-06 01:48:30	Membre couper par erreur	139044509081733	9
2380	Examen	2019-12-01 02:22:45	RAS	139044509081733	10
2381	Transplantation	2021-09-21 20:30:06	Annule	139044509081733	8
2382	Platre	2015-07-03 07:32:43	RAS	286034536711317	1
2383	Infiltration	2015-07-03 02:52:16	RAS	286034536711317	2
2384	Point de suture	2021-10-25 06:43:05	Annule	275017674182759	6
2385	Chirurie	2021-10-25 07:58:25	RAS	275017674182759	6
2386	Point de suture	2018-01-02 01:13:26	RAS	275017674182759	2
2387	Radio	2018-01-02 15:30:45	RAS	275017674182759	2
2388	Depistage	2020-06-11 02:05:07	Le patient a pris la fuite	192125134535252	1
2389	Platre	2020-06-11 16:34:50	RAS	192125134535252	1
2390	Examen	2021-11-23 02:13:34	RAS	153128663886446	4
2391	Examen	2021-11-25 08:13:50	RAS	153128663886446	4
2392	Infiltration	2018-03-07 18:20:54	RAS	181028245089128	1
2393	Depistage	2018-03-07 08:10:41	RAS	181028245089128	1
2394	Infiltration	2020-10-26 12:23:31	Outils oublier (Programmer une réintervention)	205124133484803	1
2395	Depistage	2020-05-07 09:42:28	Annule	295109643093570	2
2396	Radio	2020-05-07 08:38:46	Annule	295109643093570	1
2397	Infiltration	2020-05-07 15:31:28	Le patient a pris la fuite	295109643093570	2
2398	Point de suture	2020-05-07 06:00:10	Membre couper par erreur	295109643093570	2
2399	Platre	2019-02-08 02:39:10	Cancer confirmé	100128404770065	2
2400	Platre	2017-01-16 03:19:20	RAS	100128404770065	1
2401	Platre	2017-01-16 02:07:06	Membre couper par erreur	100128404770065	1
2402	Radio	2017-01-16 09:11:51	RAS	100128404770065	1
2403	Depistage	2017-10-16 06:50:04	Outils oublier (Programmer une réintervention)	163114987429449	1
2404	Infiltration	2020-03-18 17:40:31	RAS	296123698284802	1
2405	Point de suture	2020-03-18 03:57:05	RAS	296123698284802	2
2406	Point de suture	2020-03-18 16:11:49	Membre couper par erreur	296123698284802	2
2407	Radio	2018-05-06 11:43:59	RAS	100120657067241	1
2408	Radio	2016-03-18 21:16:19	Le patient a pris la fuite	100120657067241	1
2409	Depistage	2018-05-06 13:14:53	RAS	100120657067241	1
2410	Radio	2021-09-11 17:52:26	RAS	220042537626746	2
2411	Platre	2021-07-10 01:10:40	RAS	117065165282646	1
2412	Radio	2021-07-10 20:30:02	Outils oublier (Programmer une réintervention)	117065165282646	1
2413	Infiltration	2021-07-10 21:39:07	Annule	117065165282646	2
2414	Radio	2021-07-17 12:43:00	RAS	209129284642422	2
2415	Point de suture	2021-11-28 23:02:01	RAS	209129284642422	1
2416	Reanimation	2021-12-01 13:46:30	Personelle manquant	209129284642422	6
2417	Depistage	2016-07-19 13:48:15	RAS	131018894086716	2
2418	Platre	2016-07-19 02:14:20	Cancer confirmé	131018894086716	1
2419	Point de suture	2016-05-21 22:03:39	RAS	148071204427033	1
2420	Infiltration	2016-03-20 01:16:25	Annule	215055219516728	2
2421	Platre	2017-07-11 15:46:00	RAS	288064789259254	2
2422	Platre	2021-12-01 05:33:54	Cancer confirmé	288064789259254	1
2423	Depistage	2021-02-26 10:06:45	Outils oublier (Programmer une réintervention)	288064789259254	1
2424	Depistage	2021-03-10 12:07:41	Personelle manquant	209027484439592	1
2425	Radio	2021-05-12 12:01:58	RAS	209027484439592	2
2426	Platre	2021-03-16 00:04:06	RAS	212112177557168	2
2427	Platre	2020-11-08 13:21:08	RAS	243019440286294	2
2428	Radio	2018-09-10 21:51:31	RAS	243019440286294	1
2429	Platre	2018-03-07 07:04:39	RAS	250120320255028	1
2430	Radio	2018-03-07 13:03:04	RAS	250120320255028	2
2431	Chirurgie	2021-12-01 07:33:12	Outils oublier (Programmer une réintervention)	168044544530751	4
2432	Infiltration	2018-08-16 05:58:26	Cancer confirmé	197085058533851	2
2433	Radio	2018-08-16 22:05:52	RAS	197085058533851	1
2434	Point de suture	2018-08-16 18:16:40	Annule	197085058533851	2
2435	Infiltration	2020-02-09 17:32:19	Cancer confirmé	172127121780306	1
2436	Radio	2021-09-24 02:04:35	Personelle manquant	257010508547422	1
2437	Craniatomie	2015-11-10 20:20:58	Cancer confirmé	288119294124480	5
2438	trepanation	2015-11-07 06:55:21	RAS	288119294124480	10
2439	Instalation d un DCI	2021-06-01 06:32:27	RAS	288119294124480	9
2440	Depistage	2021-09-06 15:12:20	Membre couper par erreur	263121043095750	2
2441	Radio	2017-03-14 12:34:56	Le patient a pris la fuite	169046777385625	1
2442	Point de suture	2017-03-14 18:54:52	Cancer confirmé	169046777385625	1
2443	Platre	2021-10-23 01:22:26	Membre couper par erreur	242118914204961	2
2444	IRM	2021-07-20 02:53:33	RAS	290073918728392	12
2445	Craniatomie	2021-12-01 08:52:41	Cancer confirmé	290073918728392	10
2446	Ecographie	2021-11-02 17:41:47	RAS	290073918728392	11
2447	Platre	2021-08-28 00:55:42	RAS	191058534487268	2
2448	Depistage	2021-08-28 23:01:53	Personelle manquant	191058534487268	2
2449	Platre	2021-08-28 01:42:58	Cancer confirmé	191058534487268	2
2450	Point de suture	2021-08-28 10:44:20	Personelle manquant	191058534487268	1
2451	Radio	2017-02-26 17:19:36	RAS	118059785875590	1
2452	Radio	2021-11-25 00:34:57	RAS	255123911821943	12
2453	Radio	2021-04-10 06:29:18	RAS	146083034518235	2
2454	Platre	2021-09-11 16:26:39	RAS	215115275923744	1
2455	Point de suture	2021-09-25 08:58:17	Outils oublier (Programmer une réintervention)	215115275923744	2
2456	Platre	2021-11-28 16:42:01	Cancer confirmé	215115275923744	2
2457	Examen	2018-11-05 05:22:12	RAS	255024434449320	10
2458	Ecographie	2020-12-01 00:00:08	Le patient a pris la fuite	255024434449320	11
2459	Ecographie	2021-02-20 00:41:03	Outils oublier (Programmer une réintervention)	255024434449320	12
2460	Radio	2019-04-25 14:03:32	Personelle manquant	292067301425678	3
2461	Point de suture	2018-01-01 05:20:19	Annule	292067301425678	7
2462	Radio	2019-04-23 22:52:30	RAS	292067301425678	3
2463	Platre	2021-10-11 16:55:23	RAS	238124835633617	1
2464	Point de suture	2016-02-01 07:05:08	RAS	238124835633617	2
2465	Infiltration	2021-12-01 07:46:04	Annule	269028582321089	2
2466	Radio	2015-12-01 12:52:49	RAS	269028582321089	1
2467	Point de suture	2015-12-01 12:03:28	Membre couper par erreur	269028582321089	2
2468	Point de suture	2015-12-01 23:23:31	Le patient a pris la fuite	269028582321089	2
2469	Platre	2021-08-22 14:31:51	RAS	228075544768360	1
2470	Infiltration	2021-02-23 16:23:07	Outils oublier (Programmer une réintervention)	228075544768360	1
2471	Depistage	2021-02-23 23:19:44	RAS	228075544768360	2
2472	Point de suture	2021-04-09 17:44:12	RAS	115090459564033	1
2473	Platre	2021-04-09 10:46:17	RAS	115090459564033	1
2474	Infiltration	2021-04-09 20:02:58	Le patient a pris la fuite	115090459564033	1
2475	Point de suture	2018-08-18 04:46:49	RAS	136060268614388	1
2476	Point de suture	2021-04-17 11:44:28	RAS	136060268614388	2
2477	Instalation d un DCI	2021-09-05 02:34:02	RAS	239107525820988	9
2478	Platre	2021-10-17 18:17:02	Le patient a pris la fuite	277082499925687	1
2479	Platre	2015-07-16 19:23:51	Personelle manquant	277082499925687	1
2480	Infiltration	2021-10-18 21:06:14	Membre couper par erreur	277082499925687	1
2481	Radio	2021-10-17 12:28:18	Cancer confirmé	277082499925687	2
2482	Point de suture	2018-05-05 09:23:48	RAS	249116658619254	1
2483	Depistage	2018-04-07 04:38:07	Membre couper par erreur	249116658619254	2
2484	Platre	2018-05-05 14:31:55	Le patient a pris la fuite	249116658619254	1
2485	Radio	2021-07-07 22:38:33	Annule	248098356838047	1
2486	Depistage	2021-07-07 01:28:38	Outils oublier (Programmer une réintervention)	248098356838047	2
2487	Radio	2021-07-07 04:40:55	RAS	248098356838047	1
2488	Radio	2021-12-01 13:56:01	Annule	248098356838047	1
2489	Depistage	2019-01-18 04:28:21	Le patient a pris la fuite	288015091637034	2
2490	Infiltration	2019-01-18 13:56:40	Le patient a pris la fuite	288015091637034	1
2491	Point de suture	2021-10-22 11:36:42	RAS	137113043274402	1
2492	Radio	2021-11-08 07:09:26	RAS	257028814268392	4
2493	Radio	2021-11-06 22:21:59	Personelle manquant	257028814268392	3
2494	Cardioversion	2021-12-01 08:11:12	Cancer confirmé	257028814268392	9
2495	Instalation d un DCI	2021-12-01 23:27:57	Membre couper par erreur	257028814268392	8
2496	Radio	2017-06-22 03:55:43	Le patient a pris la fuite	119062273668288	1
2497	Platre	2015-12-01 18:43:30	RAS	137028151113684	2
2498	Infiltration	2015-12-01 02:09:30	Outils oublier (Programmer une réintervention)	137028151113684	1
2499	Radio	2015-12-01 01:41:51	Personelle manquant	183109362671564	2
2500	Depistage	2015-12-01 12:29:47	RAS	183109362671564	2
2501	Point de suture	2016-04-15 12:44:40	Le patient a pris la fuite	177077015655367	2
2502	Infiltration	2016-04-13 15:07:08	Le patient a pris la fuite	177077015655367	2
2503	Infiltration	2016-04-13 03:52:51	Annule	177077015655367	2
2504	Depistage	2016-04-13 21:32:07	RAS	177077015655367	1
2505	Chirurie	2018-11-10 17:17:17	RAS	279049861076510	6
2506	Radio	2021-12-01 16:33:22	Cancer confirmé	279049861076510	11
2507	Chirurie	2020-01-14 22:43:22	Personelle manquant	279049861076510	6
2508	Platre	2020-04-12 19:01:16	Membre couper par erreur	105067076521029	2
2509	Point de suture	2020-04-12 09:23:22	Le patient a pris la fuite	105067076521029	2
2510	Point de suture	2020-04-12 09:44:22	RAS	105067076521029	1
2511	Platre	2020-04-12 15:10:45	RAS	105067076521029	1
2512	Infiltration	2021-09-26 22:46:21	RAS	234129579445893	2
2513	Depistage	2015-11-06 03:11:56	RAS	234129579445893	2
2514	Point de suture	2015-11-06 07:55:08	Cancer confirmé	234129579445893	1
2515	Infiltration	2015-11-02 21:14:30	RAS	289098686609121	2
2516	Radio	2021-10-27 18:36:19	Annule	261034304478401	4
2517	Infiltration	2016-08-21 02:30:59	RAS	261034304478401	1
2518	Depistage	2019-08-02 12:35:27	Cancer confirmé	135019316894863	1
2519	Depistage	2021-12-01 02:02:56	Cancer confirmé	143082928850324	1
2520	Point de suture	2021-12-01 00:28:30	Annule	143082928850324	2
2521	Infiltration	2021-12-01 23:53:19	Le patient a pris la fuite	143082928850324	2
2522	Infiltration	2021-01-16 12:01:47	Le patient a pris la fuite	143082928850324	2
2523	Radio	2021-11-18 05:14:23	RAS	194093230655172	2
2524	Radio	2021-11-18 07:35:52	RAS	194093230655172	2
2525	Platre	2015-10-23 05:33:10	RAS	194093230655172	1
2526	Radio	2021-11-18 20:31:44	Cancer confirmé	194093230655172	1
2527	Point de suture	2020-10-15 00:42:43	Annule	249028848217580	1
2528	Platre	2020-10-15 17:18:11	RAS	249028848217580	1
2529	Platre	2017-09-18 15:39:51	RAS	249028848217580	1
2530	Platre	2017-09-11 12:09:47	RAS	110062997134954	1
2531	Platre	2015-11-05 14:22:15	RAS	212049852961463	1
2532	Platre	2015-11-05 08:06:13	Annule	212049852961463	2
2533	Radio	2015-10-24 07:02:18	Personelle manquant	279106952353170	3
2534	Point de suture	2021-02-02 01:55:17	RAS	279106952353170	6
2535	Point de suture	2021-01-13 09:17:25	RAS	279106952353170	6
2536	Radio	2016-08-26 12:05:41	Membre couper par erreur	228118075183751	2
2537	Chirurgie cardiaque	2021-10-23 04:18:45	Personelle manquant	176079215128294	9
2538	Examen	2021-01-02 23:13:17	Le patient a pris la fuite	227031686466265	10
2539	Point de suture	2019-09-15 23:30:05	Personelle manquant	108095665815271	1
2540	Platre	2020-11-28 14:59:37	Cancer confirmé	108095665815271	1
2541	Point de suture	2019-11-14 11:43:18	Cancer confirmé	108095665815271	2
2542	Depistage	2019-09-15 17:16:50	RAS	108095665815271	1
2543	Radio	2021-04-03 12:26:28	Personelle manquant	146021627018427	2
2544	Depistage	2021-04-03 01:01:08	Outils oublier (Programmer une réintervention)	146021627018427	1
2545	Depistage	2021-10-01 18:56:39	Annule	224030202539094	1
2546	Infiltration	2021-10-01 21:32:10	RAS	224030202539094	2
2547	Infiltration	2021-09-21 22:07:22	RAS	224030202539094	1
2548	Depistage	2021-06-18 22:48:23	Annule	224030202539094	2
2549	IRM	2020-07-13 12:19:07	Personelle manquant	177029853259907	12
2550	Radio	2021-06-18 12:17:57	Cancer confirmé	177029853259907	11
2551	Chirurgie cardiaque	2021-12-01 16:51:01	RAS	170054073041927	8
2552	trepanation	2021-07-03 03:47:54	Le patient a pris la fuite	170054073041927	10
2553	Cardioversion	2021-12-01 23:05:18	Cancer confirmé	170054073041927	8
2554	trepanation	2021-06-12 12:27:30	RAS	170054073041927	5
2555	Infiltration	2021-01-22 18:47:04	RAS	187073819892261	1
2556	Radio	2018-12-01 05:16:43	Cancer confirmé	272100390058901	2
2557	Depistage	2018-12-01 16:26:38	Cancer confirmé	272100390058901	1
2558	Infiltration	2018-12-01 16:09:24	RAS	272100390058901	2
2559	Infiltration	2018-12-01 10:20:55	Membre couper par erreur	272100390058901	1
2560	Infiltration	2018-10-25 16:23:43	RAS	217039324734896	1
2561	trepanation	2021-10-05 15:55:53	RAS	169071676568835	5
2562	Radio	2021-12-01 19:13:16	RAS	285047209123387	2
2563	Depistage	2021-12-01 12:20:10	RAS	285047209123387	2
2564	Radio	2021-11-02 11:13:20	Cancer confirmé	285047209123387	1
2565	Radio	2021-12-01 21:18:02	Outils oublier (Programmer une réintervention)	285047209123387	2
2566	Transplantation	2021-09-26 01:25:18	Le patient a pris la fuite	272048448848606	9
2567	trepanation	2021-03-17 16:43:07	RAS	272048448848606	5
2568	IRM	2020-12-01 13:46:47	Outils oublier (Programmer une réintervention)	272048448848606	12
2569	Platre	2019-07-24 11:14:40	Cancer confirmé	116049935189022	1
2570	Infiltration	2019-12-01 21:34:48	Annule	216082764922433	2
2571	Platre	2020-05-27 06:32:48	RAS	216082764922433	1
2572	Point de suture	2020-05-27 08:58:28	Cancer confirmé	216082764922433	2
2573	Depistage	2020-05-27 23:03:52	Cancer confirmé	216082764922433	2
2574	Depistage	2020-06-04 22:36:14	RAS	224115970622441	2
2575	Depistage	2020-06-04 23:08:09	Outils oublier (Programmer une réintervention)	224115970622441	2
2576	Depistage	2016-03-18 17:53:55	RAS	224115970622441	2
2577	Platre	2020-06-04 07:41:46	Outils oublier (Programmer une réintervention)	224115970622441	1
2578	Platre	2021-10-23 09:09:39	Annule	285114788952558	1
2579	Point de suture	2021-10-23 20:26:19	RAS	285114788952558	1
2580	Depistage	2021-10-23 02:41:10	Personelle manquant	285114788952558	1
2581	Platre	2021-03-01 21:42:54	RAS	247075491328391	2
2582	Platre	2020-01-04 09:56:16	RAS	271022923220246	2
2583	Radio	2018-12-01 09:48:50	RAS	167021630244142	2
2584	Infiltration	2018-09-19 17:43:08	RAS	268088051496928	1
2585	Infiltration	2018-09-19 20:41:26	Personelle manquant	268088051496928	2
2586	Radio	2019-06-03 00:34:25	RAS	268088051496928	2
2587	Point de suture	2019-06-03 13:44:19	Personelle manquant	268088051496928	2
2588	Point de suture	2018-08-02 15:11:46	RAS	254068184803144	2
2589	Infiltration	2018-08-02 16:52:55	Personelle manquant	254068184803144	1
2590	Platre	2021-08-14 17:17:58	Cancer confirmé	254068184803144	2
2591	Infiltration	2018-10-28 18:01:52	Membre couper par erreur	236045389806266	2
2592	Depistage	2019-01-04 22:54:59	Personelle manquant	236045389806266	1
2593	Radio	2018-07-14 19:57:36	RAS	236045389806266	2
2594	Depistage	2018-12-01 20:08:40	RAS	236045389806266	1
2595	Platre	2017-11-07 03:57:12	Le patient a pris la fuite	145026259569030	1
2596	Radio	2017-01-09 10:32:58	RAS	145026259569030	2
2597	Infiltration	2017-11-07 03:18:56	Le patient a pris la fuite	145026259569030	2
2598	Depistage	2017-05-25 17:14:31	Membre couper par erreur	255091764125894	2
2599	Examen	2021-11-26 18:06:18	RAS	246079035822823	10
2600	Cardioversion	2020-11-25 02:51:42	RAS	246079035822823	8
2601	Transplantation	2020-11-25 07:17:47	RAS	246079035822823	8
2602	Cardioversion	2020-11-24 01:30:00	RAS	246079035822823	8
2692	Depistage	2021-09-13 04:57:55	Cancer confirmé	102019659160308	2
2603	Radio	2015-03-01 19:56:58	Outils oublier (Programmer une réintervention)	242043622468996	1
2604	Point de suture	2015-03-01 12:42:15	Cancer confirmé	242043622468996	1
2605	Platre	2015-09-25 20:45:13	RAS	242043622468996	1
2606	Radio	2018-10-02 05:35:11	Membre couper par erreur	103096383824071	1
2607	Infiltration	2018-10-02 12:08:05	RAS	103096383824071	1
2608	Radio	2016-06-28 18:28:53	Personelle manquant	268064292795561	1
2609	Point de suture	2016-06-28 16:42:59	RAS	268064292795561	2
2610	Depistage	2016-06-28 08:34:33	RAS	268064292795561	2
2611	Point de suture	2017-05-13 22:45:59	RAS	268064292795561	1
2612	Point de suture	2020-08-27 13:44:14	RAS	299111020477610	1
2613	Laminectomie	2021-11-09 04:25:28	RAS	299111020477610	10
2614	Infiltration	2020-09-07 16:40:16	Cancer confirmé	299111020477610	2
2615	Infiltration	2019-12-01 11:39:13	Outils oublier (Programmer une réintervention)	242012498306039	2
2616	Platre	2021-09-10 06:40:14	RAS	206099679755550	2
2617	Infiltration	2017-03-02 00:58:03	RAS	153107527788126	1
2618	Platre	2017-03-02 05:14:30	Annule	153107527788126	1
2619	Depistage	2017-03-02 18:59:33	RAS	153107527788126	2
2620	Infiltration	2017-03-02 01:46:50	Membre couper par erreur	153107527788126	1
2621	Radio	2017-09-16 09:00:51	RAS	288061199802041	2
2622	Platre	2017-01-15 21:56:14	RAS	288061199802041	2
2623	Platre	2017-09-16 03:26:37	Le patient a pris la fuite	288061199802041	1
2624	Radio	2017-09-16 17:35:42	RAS	288061199802041	1
2625	Platre	2015-06-02 01:22:57	Cancer confirmé	171059332834846	1
2626	Scanner	2021-05-09 19:33:04	RAS	106011084231378	12
2627	Scanner	2021-11-17 03:35:26	Le patient a pris la fuite	106011084231378	11
2628	Scanner	2021-06-02 20:38:53	RAS	106011084231378	11
2629	Infiltration	2016-01-17 07:19:26	RAS	192122702640673	1
2630	Instalation d un DCI	2019-10-16 14:31:50	Annule	144058651158085	9
2631	Point de suture	2020-06-10 09:19:01	RAS	104024782793871	2
2632	Platre	2018-10-10 00:19:45	RAS	104024782793871	1
2633	Radio	2015-03-07 04:30:48	Outils oublier (Programmer une réintervention)	256062556405124	2
2634	Radio	2015-03-07 12:43:11	RAS	256062556405124	1
2635	Point de suture	2015-03-07 19:54:53	Membre couper par erreur	256062556405124	1
2636	Point de suture	2019-02-10 03:50:57	RAS	188057492936580	1
2637	Point de suture	2018-04-18 08:02:11	Le patient a pris la fuite	188057492936580	1
2638	Infiltration	2019-02-10 03:56:11	RAS	188057492936580	1
2639	Radio	2021-06-07 07:19:26	RAS	100093386790971	3
2640	Instalation d un DCI	2021-09-10 13:54:52	RAS	145107728311572	8
2641	Instalation d un DCI	2021-09-07 11:35:49	RAS	145107728311572	8
2642	Examen	2019-11-20 20:43:59	RAS	145107728311572	5
2643	Scanner	2020-09-09 05:40:56	Cancer confirmé	256025976064713	11
2644	Scanner	2020-09-12 01:34:08	Cancer confirmé	256025976064713	11
2645	Radio	2021-09-10 06:24:11	RAS	256025976064713	11
2646	IRM	2020-10-26 01:38:31	Outils oublier (Programmer une réintervention)	256025976064713	11
2647	Infiltration	2020-01-10 14:07:05	Cancer confirmé	118041223330245	1
2648	Infiltration	2021-08-09 08:17:52	RAS	118041223330245	1
2649	Radio	2021-08-21 08:46:05	Le patient a pris la fuite	118041223330245	1
2650	Platre	2021-08-09 23:59:54	RAS	118041223330245	1
2651	Point de suture	2015-05-25 23:03:12	RAS	108097522748111	1
2652	Depistage	2015-05-25 15:53:00	RAS	108097522748111	1
2653	Radio	2015-05-25 07:43:21	Outils oublier (Programmer une réintervention)	108097522748111	2
2654	Point de suture	2015-05-25 07:22:37	Le patient a pris la fuite	108097522748111	2
2655	Craniatomie	2016-12-01 19:44:49	RAS	116026335121455	5
2656	Craniatomie	2016-12-01 04:40:36	RAS	116026335121455	5
2657	IRM	2020-01-04 05:29:24	RAS	116026335121455	11
2658	Infiltration	2018-10-24 03:36:39	RAS	193033556420427	1
2659	Radio	2016-01-21 15:28:22	Outils oublier (Programmer une réintervention)	193033556420427	1
2660	Radio	2016-01-21 17:07:28	Le patient a pris la fuite	193033556420427	1
2661	Depistage	2018-10-24 11:25:46	Personelle manquant	193033556420427	2
2662	Infiltration	2016-12-01 08:23:29	Outils oublier (Programmer une réintervention)	157103185444294	1
2663	Radio	2016-12-01 22:18:25	Le patient a pris la fuite	157103185444294	1
2664	Platre	2021-12-01 04:52:26	RAS	158125852966745	2
2665	Depistage	2021-12-01 05:28:14	Personelle manquant	158125852966745	2
2666	Depistage	2021-04-10 20:30:54	RAS	158125852966745	2
2667	Point de suture	2018-04-06 05:43:14	Le patient a pris la fuite	238087013966826	2
2668	Infiltration	2018-04-06 17:51:51	RAS	238087013966826	2
2669	trepanation	2021-11-16 17:09:25	Personelle manquant	245085054653774	10
2670	Infiltration	2019-07-08 00:39:12	RAS	129099269265203	1
2671	Platre	2019-07-08 05:02:53	Annule	129099269265203	2
2672	Radio	2019-07-08 06:43:55	RAS	129099269265203	2
2673	Infiltration	2019-07-08 02:48:32	Personelle manquant	129099269265203	1
2674	Chirurgie	2021-05-16 00:21:26	RAS	137067952932213	3
2675	Depistage	2019-11-21 10:46:57	Membre couper par erreur	181097995658562	2
2676	Platre	2019-11-20 02:51:31	RAS	181097995658562	1
2677	Point de suture	2017-03-21 21:18:13	RAS	129015333191150	2
2678	Depistage	2017-03-21 06:51:11	Personelle manquant	129015333191150	1
2679	Chirurie	2019-04-10 16:44:38	Le patient a pris la fuite	252076491934774	6
2680	Infiltration	2015-08-19 19:52:15	RAS	137084945054430	2
2681	Infiltration	2015-08-19 00:09:23	RAS	137084945054430	2
2682	Point de suture	2015-08-19 21:09:40	Cancer confirmé	137084945054430	1
2683	Radio	2020-08-19 10:43:46	Membre couper par erreur	284046374475926	2
2684	Infiltration	2020-08-19 10:52:47	Personelle manquant	284046374475926	1
2685	Infiltration	2020-08-19 19:33:20	Outils oublier (Programmer une réintervention)	284046374475926	1
2686	Platre	2018-06-20 21:27:25	Membre couper par erreur	284046374475926	2
2687	Infiltration	2015-04-23 00:27:52	Le patient a pris la fuite	162024692293914	1
2688	Infiltration	2015-04-23 21:27:42	Annule	162024692293914	2
2689	Laminectomie	2017-12-01 08:37:46	RAS	286071597914575	5
2690	Platre	2020-01-23 05:43:01	RAS	102019659160308	2
2691	Point de suture	2021-09-13 22:11:55	RAS	102019659160308	2
2693	Radio	2020-01-23 18:43:49	RAS	102019659160308	2
2694	Infiltration	2016-07-01 12:28:12	Outils oublier (Programmer une réintervention)	150081201116183	2
2695	Infiltration	2016-07-01 14:59:03	RAS	150081201116183	1
2696	Platre	2016-02-05 03:04:35	Annule	150081201116183	2
2697	Depistage	2016-07-01 08:04:54	RAS	150081201116183	1
2698	Platre	2020-12-01 10:19:13	Cancer confirmé	147085285282844	1
2699	Platre	2020-12-01 02:28:34	RAS	147085285282844	1
2700	Platre	2020-12-01 09:50:05	RAS	147085285282844	2
2701	Infiltration	2020-12-01 04:33:04	Personelle manquant	147085285282844	2
2702	Platre	2021-09-19 23:43:24	RAS	295012888306237	1
2703	Radio	2021-05-14 17:37:22	RAS	295012888306237	1
2704	Radio	2021-09-19 09:57:00	RAS	295012888306237	1
2705	Infiltration	2018-11-04 22:00:01	RAS	228121380869080	1
2706	Depistage	2021-03-25 04:42:22	Membre couper par erreur	228121380869080	2
2707	Radio	2017-02-22 03:04:50	RAS	209076917524931	2
2708	Infiltration	2017-02-22 05:11:11	Membre couper par erreur	209076917524931	2
2709	Infiltration	2017-02-22 09:11:56	RAS	209076917524931	1
2710	Platre	2017-02-22 02:55:58	RAS	209076917524931	1
2711	Scanner	2018-05-28 13:20:38	Cancer confirmé	114128201353291	12
2712	Ecographie	2018-08-11 00:11:02	Outils oublier (Programmer une réintervention)	114128201353291	11
2713	Radio	2018-06-28 22:17:23	Membre couper par erreur	114128201353291	11
2714	IRM	2018-06-07 10:01:31	Membre couper par erreur	114128201353291	12
2715	Infiltration	2019-11-06 04:48:58	RAS	122070309199973	1
2716	Infiltration	2020-06-09 07:19:41	Outils oublier (Programmer une réintervention)	122070309199973	2
2717	Platre	2018-06-02 10:16:16	Membre couper par erreur	262078078553170	2
2718	Platre	2018-06-02 02:39:24	Annule	262078078553170	1
2719	Point de suture	2018-06-02 07:07:21	Membre couper par erreur	262078078553170	2
2720	Point de suture	2021-08-26 12:33:06	Annule	214058422588031	2
2721	Point de suture	2021-08-26 04:15:40	Cancer confirmé	214058422588031	1
2722	Platre	2017-08-26 06:32:15	Membre couper par erreur	214058422588031	1
2723	Depistage	2021-08-26 05:02:43	RAS	214058422588031	2
2724	Point de suture	2021-05-08 11:17:31	RAS	297018588389986	7
2725	Reanimation	2020-11-15 14:00:05	Personelle manquant	297018588389986	6
2726	Reanimation	2020-10-14 08:12:57	Cancer confirmé	297018588389986	7
2727	Point de suture	2021-12-01 12:51:37	Cancer confirmé	270091948045432	2
2728	Radio	2016-10-17 01:09:38	RAS	270091948045432	2
2729	Depistage	2019-02-05 00:09:33	Annule	270091948045432	1
2730	Radio	2017-06-13 11:46:12	Cancer confirmé	217077302350914	2
2731	Radio	2015-11-20 09:20:40	RAS	217077302350914	1
2732	Depistage	2017-06-13 00:31:48	RAS	217077302350914	2
2733	Radio	2015-11-20 22:44:20	Le patient a pris la fuite	217077302350914	1
2734	Point de suture	2020-12-01 09:06:10	Cancer confirmé	247064950013140	6
2735	trepanation	2021-10-06 05:21:31	RAS	247064950013140	10
2736	Point de suture	2020-03-08 15:25:51	Annule	247064950013140	6
2737	Chirurie	2020-12-01 18:36:02	Cancer confirmé	247064950013140	7
2738	Depistage	2021-09-28 07:25:08	RAS	103065213906618	2
2739	Radio	2021-09-18 14:55:57	Annule	103065213906618	2
2740	Infiltration	2021-09-18 14:24:22	RAS	103065213906618	2
2741	Radio	2020-12-01 00:16:55	RAS	104110590911744	1
2742	Chirurgie	2021-12-01 05:34:35	RAS	104110590911744	3
2743	Radio	2020-12-01 16:37:43	Annule	104110590911744	1
2744	Radio	2020-04-02 17:11:58	RAS	272103843045703	2
2745	Radio	2020-04-02 22:17:48	RAS	272103843045703	2
2746	Depistage	2020-04-02 18:47:46	Le patient a pris la fuite	272103843045703	1
2747	Infiltration	2020-04-02 09:19:35	RAS	272103843045703	1
2748	trepanation	2021-11-01 01:16:46	Membre couper par erreur	257080110522152	5
2749	Reanimation	2019-11-09 23:23:15	Personelle manquant	257080110522152	7
2750	Point de suture	2019-07-02 12:34:44	RAS	257080110522152	7
2751	Chirurie	2019-11-27 19:57:54	Le patient a pris la fuite	257080110522152	7
2752	Depistage	2016-03-14 11:32:41	RAS	208118561794850	1
2753	Radio	2016-03-14 10:28:42	Cancer confirmé	208118561794850	2
2754	Depistage	2018-08-20 14:10:44	RAS	255088965332455	1
2755	Examen	2021-12-01 00:18:56	Le patient a pris la fuite	243013407647544	3
2756	Examen	2018-07-07 06:26:24	Outils oublier (Programmer une réintervention)	243013407647544	3
2757	Radio	2018-10-27 19:05:28	RAS	243013407647544	3
2758	Infiltration	2020-09-10 03:34:04	RAS	208089025109136	1
2759	Infiltration	2020-04-08 17:50:05	Outils oublier (Programmer une réintervention)	208089025109136	2
2760	Platre	2020-04-08 15:08:18	RAS	208089025109136	1
2761	Radio	2019-06-04 09:38:19	RAS	208089025109136	1
2762	Infiltration	2018-09-20 07:45:07	RAS	293129298699077	2
2763	Platre	2021-11-09 00:10:24	RAS	293129298699077	1
2764	Platre	2018-09-20 17:33:11	Cancer confirmé	293129298699077	2
2765	Radio	2017-01-09 22:26:07	RAS	261019617230168	1
2766	Depistage	2017-01-09 16:16:10	Le patient a pris la fuite	261019617230168	2
2767	Infiltration	2017-01-09 08:49:55	RAS	261019617230168	2
2768	Point de suture	2017-01-09 11:59:01	RAS	261019617230168	1
2769	Laminectomie	2021-11-11 02:49:45	Annule	243066968428847	10
2770	Radio	2019-11-17 07:28:43	RAS	243066968428847	4
2771	Craniatomie	2021-11-11 18:26:28	RAS	243066968428847	10
2772	Platre	2016-11-13 05:35:13	RAS	170080268839901	2
2773	Infiltration	2016-11-13 05:59:23	Le patient a pris la fuite	170080268839901	1
2774	Radio	2016-11-13 09:12:03	Le patient a pris la fuite	170080268839901	2
2775	Platre	2018-08-03 08:16:00	Membre couper par erreur	170080268839901	1
2776	Radio	2019-07-16 12:55:46	RAS	219116344306402	1
2777	Radio	2019-07-16 09:12:13	Cancer confirmé	219116344306402	1
2778	Depistage	2019-07-16 17:26:28	Annule	219116344306402	2
2779	Radio	2019-07-16 19:42:48	Annule	219116344306402	1
2780	IRM	2018-06-14 05:31:06	Membre couper par erreur	179098881632515	11
2781	Radio	2018-06-06 04:17:56	RAS	179098881632515	11
2782	Depistage	2016-12-01 13:19:46	Membre couper par erreur	144018384174747	2
2783	Depistage	2016-12-01 08:09:24	Outils oublier (Programmer une réintervention)	144018384174747	2
2784	Depistage	2016-12-01 16:42:17	Membre couper par erreur	144018384174747	1
2785	Radio	2016-10-15 15:26:12	RAS	136114138407278	1
2786	Platre	2016-10-15 18:56:24	RAS	136114138407278	1
2787	Infiltration	2016-09-21 09:34:27	RAS	136114138407278	2
2788	Depistage	2020-06-06 21:32:00	Annule	136114138407278	1
2789	Infiltration	2018-12-01 03:11:45	Outils oublier (Programmer une réintervention)	281019819289565	2
2790	Radio	2021-11-24 05:54:04	Outils oublier (Programmer une réintervention)	248115000202929	3
2791	Examen	2021-11-16 13:47:57	RAS	248115000202929	4
2792	Radio	2021-11-16 02:32:47	RAS	248115000202929	4
2793	Radio	2021-11-16 20:18:47	Membre couper par erreur	248115000202929	4
2794	Point de suture	2021-08-03 06:22:49	RAS	227073625053031	1
2795	Platre	2021-08-03 02:36:57	RAS	227073625053031	2
2796	Depistage	2021-03-21 02:33:46	RAS	227073625053031	1
2797	Point de suture	2021-03-21 06:16:10	RAS	227073625053031	2
2798	Radio	2021-09-16 16:34:41	Outils oublier (Programmer une réintervention)	137012739426413	1
2799	Depistage	2018-04-18 05:20:43	Outils oublier (Programmer une réintervention)	137012739426413	1
2800	Radio	2019-09-16 10:14:54	RAS	126068767532596	2
2801	Platre	2019-09-16 00:04:00	RAS	126068767532596	1
2802	Infiltration	2016-09-27 08:02:47	RAS	297118813515304	1
2803	Platre	2016-12-01 04:07:00	RAS	297118813515304	2
2804	Depistage	2020-10-07 01:14:44	RAS	297118813515304	1
2805	IRM	2019-12-08 02:56:22	Annule	192108415007283	12
2806	Transplantation	2019-01-22 01:34:26	Membre couper par erreur	192108415007283	8
2807	IRM	2021-08-23 20:13:08	RAS	192108415007283	11
2808	Depistage	2016-11-10 01:50:05	Personelle manquant	192108415007283	1
2809	Platre	2017-06-22 02:18:28	RAS	266105680605414	1
2810	Depistage	2019-01-02 12:52:59	RAS	255078204802254	1
2811	Radio	2017-05-02 21:25:52	Membre couper par erreur	255078204802254	1
2812	Radio	2018-03-13 07:34:38	RAS	255078204802254	1
2813	Point de suture	2016-07-12 02:39:16	RAS	118112410272245	2
2814	Radio	2016-07-12 14:52:18	RAS	118112410272245	2
2815	Radio	2016-07-12 05:38:03	RAS	118112410272245	1
2816	Ecographie	2021-12-01 10:24:02	RAS	184029967452706	11
2817	IRM	2021-12-01 11:46:26	RAS	184029967452706	11
2818	Point de suture	2020-08-20 12:41:37	Membre couper par erreur	102085689984553	2
2819	IRM	2020-04-06 16:11:40	RAS	164084503884247	11
2820	Ecographie	2020-07-11 16:25:06	RAS	164084503884247	12
2821	Radio	2021-04-28 15:11:08	Membre couper par erreur	199030716614074	2
2822	Platre	2021-04-28 11:57:15	Membre couper par erreur	199030716614074	1
2823	Infiltration	2021-04-28 07:39:51	RAS	199030716614074	1
2824	Depistage	2021-04-28 13:17:56	RAS	199030716614074	1
2825	Point de suture	2021-12-01 09:25:05	RAS	185079382958660	1
2826	Radio	2021-12-01 14:35:30	RAS	185079382958660	1
2827	Infiltration	2018-02-11 10:39:56	RAS	178092232278018	2
2828	Infiltration	2018-02-11 07:50:11	Annule	178092232278018	2
2829	Depistage	2016-10-01 09:36:44	RAS	169074773920796	1
2830	Radio	2016-03-22 00:14:58	Cancer confirmé	131070172653837	2
2831	Platre	2016-03-22 04:38:55	RAS	131070172653837	1
2832	Ecographie	2021-11-28 15:30:13	RAS	270049403545237	11
2833	Radio	2021-12-01 08:05:34	RAS	270049403545237	12
2834	Ecographie	2019-01-24 19:06:34	Annule	270049403545237	11
2835	IRM	2021-09-10 10:35:13	RAS	270049403545237	12
2836	Infiltration	2020-11-05 04:17:01	Outils oublier (Programmer une réintervention)	122013583993734	2
2837	Point de suture	2020-11-05 12:19:52	Annule	122013583993734	1
2838	Platre	2021-11-11 20:49:48	Le patient a pris la fuite	247064696896690	1
2839	Radio	2021-12-01 10:12:25	RAS	247064696896690	1
2840	Radio	2021-07-21 11:12:00	Cancer confirmé	247064696896690	4
2841	Examen	2021-12-01 04:47:51	RAS	211103396685063	10
2842	Craniatomie	2021-12-01 17:23:29	RAS	211103396685063	5
2843	Examen	2021-12-01 03:20:34	RAS	211103396685063	5
2844	Craniatomie	2021-12-01 21:37:47	Annule	211103396685063	10
2845	Platre	2020-12-01 11:07:48	RAS	124068718826168	1
2846	Radio	2019-02-11 16:22:52	Cancer confirmé	124068718826168	2
2847	Laminectomie	2021-10-17 11:03:00	Membre couper par erreur	190047473188512	10
2848	Chirurgie cardiaque	2019-05-14 08:46:34	RAS	190047473188512	9
2849	Point de suture	2021-12-01 15:29:26	Cancer confirmé	190047473188512	2
2850	Instalation d un DCI	2019-05-19 20:09:00	RAS	190047473188512	8
2851	Radio	2019-02-11 21:01:30	RAS	209038216146851	11
2852	Radio	2018-12-16 08:53:40	RAS	209038216146851	12
2853	Infiltration	2016-05-21 15:07:45	Annule	118099632841858	2
2854	Depistage	2016-05-21 21:59:31	Cancer confirmé	118099632841858	1
2855	Radio	2019-05-05 21:13:43	RAS	153023371372412	1
2856	Depistage	2019-05-05 02:58:55	RAS	153023371372412	2
2857	Depistage	2016-08-17 17:51:04	RAS	153023371372412	2
2858	Point de suture	2016-08-17 13:32:29	RAS	153023371372412	2
2859	Infiltration	2021-11-13 02:59:51	Cancer confirmé	220035719909604	2
2860	Infiltration	2021-10-08 04:53:39	RAS	299128835735359	2
2861	Depistage	2018-09-14 10:29:18	Membre couper par erreur	171096323748369	1
2862	Depistage	2018-09-14 12:00:24	RAS	171096323748369	2
2863	Point de suture	2018-09-14 03:03:24	Personelle manquant	171096323748369	1
2864	Point de suture	2020-08-28 22:58:14	Cancer confirmé	249118020522088	2
2865	Infiltration	2020-08-28 15:15:06	RAS	249118020522088	1
2866	Radio	2019-11-05 13:17:42	RAS	279037176177857	1
2867	Depistage	2015-08-26 10:14:30	RAS	194123870040526	2
2868	Point de suture	2015-08-26 05:46:24	Outils oublier (Programmer une réintervention)	194123870040526	2
2869	Point de suture	2015-08-26 03:14:36	RAS	194123870040526	2
2870	Infiltration	2015-08-26 16:39:35	Personelle manquant	194123870040526	2
2871	Radio	2021-09-17 08:16:14	RAS	216050588792452	2
2872	Depistage	2021-09-17 08:25:40	RAS	216050588792452	2
2873	Radio	2017-09-03 03:45:01	Outils oublier (Programmer une réintervention)	101027766706912	1
2874	Infiltration	2017-09-03 12:55:01	Annule	101027766706912	2
2875	Cardioversion	2021-08-19 00:05:36	RAS	259024064714624	9
2876	Transplantation	2020-08-18 19:35:33	Annule	259024064714624	9
2877	Examen	2021-08-17 21:46:10	RAS	270014064481086	10
2879	Infiltration	2016-10-04 15:59:45	RAS	152050826723518	2
2880	Platre	2016-10-04 08:35:36	RAS	152050826723518	1
2881	Radio	2015-12-01 18:39:22	RAS	231078668662003	1
2882	Platre	2015-12-01 19:43:13	Cancer confirmé	231078668662003	2
2883	Point de suture	2015-12-01 13:54:04	Le patient a pris la fuite	231078668662003	1
2884	Infiltration	2015-12-01 14:37:52	Annule	231078668662003	1
2885	Point de suture	2020-01-16 16:57:10	RAS	182014842853195	2
2886	Point de suture	2020-05-23 18:59:03	RAS	182014842853195	1
2887	Radio	2019-07-15 21:39:26	RAS	292083432286212	1
2888	Platre	2019-07-15 10:37:46	Le patient a pris la fuite	292083432286212	2
2889	Platre	2019-07-15 12:51:48	RAS	292083432286212	1
2890	Depistage	2019-07-15 13:09:25	Cancer confirmé	292083432286212	2
2891	Radio	2021-11-26 02:06:25	RAS	261055944395226	1
2892	Radio	2019-09-16 18:59:28	Cancer confirmé	128055781153403	4
2893	Radio	2018-12-18 19:29:42	RAS	128055781153403	4
2894	Infiltration	2020-12-01 18:01:28	Le patient a pris la fuite	224059146621395	2
2895	Depistage	2017-08-18 06:32:09	RAS	283114678495021	2
2896	Platre	2019-04-16 18:54:44	Annule	283114678495021	1
2897	Infiltration	2021-10-15 16:12:06	RAS	283114678495021	1
2898	Platre	2021-10-15 04:28:35	Le patient a pris la fuite	283114678495021	2
2899	Point de suture	2019-04-23 12:43:57	Personelle manquant	178014634707159	2
2900	Chirurie	2021-12-01 05:33:13	Outils oublier (Programmer une réintervention)	178014634707159	6
2901	Platre	2018-12-09 19:49:13	RAS	178014634707159	1
2902	Reanimation	2021-09-05 06:45:49	Annule	178014634707159	6
2903	Platre	2018-07-22 04:51:22	RAS	213083916917722	1
2904	Radio	2017-01-13 05:54:13	Cancer confirmé	213083916917722	1
2905	Examen	2016-01-06 16:16:08	Membre couper par erreur	107084739343784	3
2906	Examen	2016-03-13 13:41:25	RAS	107084739343784	3
2907	Examen	2016-03-01 22:03:10	RAS	107084739343784	4
2908	Chirurgie	2016-01-19 04:04:48	RAS	107084739343784	4
2909	Examen	2021-12-01 05:49:41	Le patient a pris la fuite	272071958103759	5
2910	Cardioversion	2021-09-18 10:58:26	RAS	272071958103759	8
2911	Transplantation	2021-09-12 05:50:32	RAS	272071958103759	9
2912	Examen	2021-12-01 20:30:31	RAS	272071958103759	5
2913	Depistage	2018-11-15 13:46:58	RAS	202046097430545	1
2914	Point de suture	2017-03-14 10:13:44	RAS	202046097430545	2
2915	Depistage	2018-11-15 08:39:28	Cancer confirmé	202046097430545	2
2916	Radio	2019-02-20 22:52:14	Annule	143094758250605	2
2917	Infiltration	2019-02-20 01:36:30	RAS	143094758250605	1
2918	Point de suture	2018-06-28 01:07:50	RAS	135013147654144	2
2919	Platre	2018-06-28 05:08:02	Annule	135013147654144	1
2920	Point de suture	2020-11-03 04:49:52	Membre couper par erreur	149056744712258	1
2921	Point de suture	2020-07-19 22:29:59	RAS	241091337496952	7
2922	Reanimation	2020-07-24 18:43:32	Outils oublier (Programmer une réintervention)	241091337496952	7
2923	Chirurie	2020-07-25 03:30:38	RAS	241091337496952	6
2924	Chirurie	2020-07-26 01:45:42	RAS	241091337496952	6
2925	Platre	2020-05-21 08:48:08	Outils oublier (Programmer une réintervention)	237123674082614	2
2926	Depistage	2018-07-20 20:13:35	RAS	237123674082614	2
2927	Point de suture	2017-09-12 20:50:30	RAS	188107331612463	2
2928	Radio	2019-06-27 04:42:38	Membre couper par erreur	146038139963472	2
2929	Radio	2019-06-27 22:17:39	RAS	146038139963472	2
2930	Platre	2019-06-27 05:02:36	Membre couper par erreur	146038139963472	1
2931	Point de suture	2018-10-06 11:17:46	RAS	275071720303360	1
2932	Point de suture	2020-08-15 06:26:55	Annule	275071720303360	2
2933	trepanation	2017-11-03 15:13:24	RAS	282064682723343	10
2934	Point de suture	2019-09-14 21:01:26	RAS	282064682723343	2
2935	trepanation	2019-03-10 13:29:17	Membre couper par erreur	282064682723343	5
2936	Infiltration	2021-11-02 14:58:41	Cancer confirmé	282064682723343	2
2937	Radio	2015-05-09 23:24:24	Le patient a pris la fuite	114101952090739	12
2938	Depistage	2020-02-16 20:43:14	RAS	207107994278129	2
2939	Radio	2020-04-01 02:16:18	Cancer confirmé	260055549848885	1
2940	Depistage	2020-04-01 00:53:48	RAS	260055549848885	2
2941	Depistage	2020-04-01 05:01:30	Membre couper par erreur	260055549848885	1
2942	Infiltration	2021-08-23 12:29:21	Le patient a pris la fuite	135100709107338	1
2943	Radio	2021-08-23 08:51:20	Membre couper par erreur	135100709107338	2
2944	Radio	2021-12-01 12:04:02	Le patient a pris la fuite	278106956056295	11
2945	Radio	2021-12-01 17:59:47	Annule	278106956056295	12
2946	Scanner	2021-12-01 06:02:09	RAS	278106956056295	12
2947	Chirurie	2020-04-25 09:51:12	Le patient a pris la fuite	196044090469523	6
2948	Point de suture	2020-06-18 12:17:11	Membre couper par erreur	196044090469523	6
2949	Platre	2018-06-07 17:36:40	Le patient a pris la fuite	223077011150247	1
2950	Infiltration	2019-11-08 20:05:56	Le patient a pris la fuite	223077011150247	1
2951	Platre	2018-06-07 07:15:20	Outils oublier (Programmer une réintervention)	223077011150247	2
2952	Point de suture	2019-11-08 05:48:56	RAS	223077011150247	2
2953	Chirurgie cardiaque	2021-11-20 21:25:29	RAS	170032191239838	9
2954	Examen	2020-02-17 17:19:11	Membre couper par erreur	170032191239838	3
2955	Radio	2021-12-01 16:52:28	Cancer confirmé	262094703954561	12
2956	Transplantation	2020-09-24 06:49:41	Outils oublier (Programmer une réintervention)	262094703954561	9
2957	Platre	2016-04-16 09:00:45	Annule	293098735454683	1
2958	Radio	2017-09-23 05:15:51	RAS	293098735454683	1
2959	Point de suture	2018-07-13 05:17:34	RAS	114031662892732	1
2960	Infiltration	2019-07-15 12:42:14	RAS	114031662892732	1
2961	Infiltration	2016-10-03 03:32:18	Le patient a pris la fuite	142027529465492	2
2962	Point de suture	2016-06-12 19:11:10	Cancer confirmé	268081386395744	1
2963	Infiltration	2021-04-07 04:27:33	RAS	119125003483214	1
2964	Depistage	2021-04-07 03:29:13	RAS	119125003483214	1
2965	Depistage	2020-10-20 14:41:46	RAS	119125003483214	2
2966	Platre	2021-04-07 16:39:11	RAS	119125003483214	2
2967	Infiltration	2019-04-20 18:35:04	RAS	260083942923902	2
2968	Platre	2019-04-20 15:03:37	Membre couper par erreur	260083942923902	2
2969	Point de suture	2019-04-20 10:32:47	RAS	260083942923902	1
2970	Platre	2021-11-22 18:58:17	RAS	281111914382515	1
2971	Infiltration	2020-06-25 15:09:34	RAS	281111914382515	1
2972	Platre	2021-11-22 14:25:38	Outils oublier (Programmer une réintervention)	281111914382515	2
2973	Infiltration	2021-11-22 21:24:48	RAS	281111914382515	2
2974	Depistage	2016-12-01 07:21:46	Personelle manquant	271010916937233	1
2975	Point de suture	2021-07-14 17:25:28	RAS	271010916937233	1
2976	Infiltration	2020-12-01 05:15:37	RAS	131052658062338	1
2977	Point de suture	2018-06-26 18:15:01	RAS	131052658062338	1
2978	Depistage	2020-12-01 09:56:38	RAS	131052658062338	2
2979	Infiltration	2020-04-20 06:55:45	Le patient a pris la fuite	174018102858594	2
2980	Radio	2017-09-07 16:37:33	Cancer confirmé	150072095960502	1
2981	Depistage	2020-01-26 18:53:24	RAS	150072095960502	1
2982	Radio	2017-09-07 13:48:35	RAS	150072095960502	1
2983	Platre	2020-01-26 15:33:58	RAS	150072095960502	1
2984	Platre	2018-03-02 07:11:14	Personelle manquant	156112101254314	2
2985	Radio	2021-10-08 15:36:42	RAS	156112101254314	2
2986	Platre	2021-10-08 03:36:00	Cancer confirmé	156112101254314	1
2987	Examen	2021-09-13 15:44:18	Membre couper par erreur	118094258078427	10
2988	Transplantation	2020-09-08 12:16:28	RAS	118094258078427	9
2989	Instalation d un DCI	2021-06-17 14:25:15	RAS	118094258078427	9
2990	Ecographie	2021-07-28 16:57:46	RAS	224043336251390	11
2991	Examen	2021-11-19 13:20:09	RAS	224043336251390	4
2992	Chirurgie cardiaque	2021-12-01 01:03:03	Annule	261077305981665	9
2993	Chirurgie cardiaque	2021-12-01 10:32:02	RAS	261077305981665	8
2994	Cardioversion	2021-12-01 07:10:53	RAS	261077305981665	9
2995	Chirurie	2021-10-23 01:02:43	Le patient a pris la fuite	261077305981665	7
2996	Infiltration	2017-03-09 08:09:55	RAS	115016947696529	2
2997	Point de suture	2018-07-22 11:00:11	RAS	115016947696529	1
2998	Infiltration	2018-04-09 13:52:49	RAS	245044833929736	1
2999	Point de suture	2018-05-27 11:24:50	RAS	245044833929736	1
3000	Radio	2020-08-17 17:52:35	Personelle manquant	297073818905849	1
3001	Infiltration	2021-12-01 13:22:23	RAS	297073818905849	1
3002	Radio	2021-11-15 08:51:02	RAS	218112782420475	2
3003	Platre	2021-08-07 13:17:51	Cancer confirmé	218112782420475	2
3004	Infiltration	2021-08-07 07:20:48	Annule	218112782420475	2
3005	Radio	2018-08-21 16:14:13	RAS	203124780561391	2
3006	Infiltration	2018-08-21 16:05:25	RAS	203124780561391	1
3007	Radio	2018-08-21 20:31:52	RAS	203124780561391	2
3008	Infiltration	2015-07-23 21:35:29	RAS	158036596308209	1
3009	Radio	2015-07-23 05:42:31	RAS	158036596308209	1
3010	Infiltration	2020-11-22 20:51:13	RAS	158036596308209	2
3011	Radio	2016-09-22 03:31:15	RAS	204038320321261	2
3012	Point de suture	2016-09-22 15:28:20	Membre couper par erreur	204038320321261	2
3013	Radio	2021-11-28 08:52:49	RAS	269054468621668	2
3014	Radio	2021-11-19 04:17:09	RAS	269054468621668	1
3015	Depistage	2021-07-17 03:29:31	RAS	121086804762872	2
3016	Infiltration	2021-07-17 02:41:44	Le patient a pris la fuite	121086804762872	1
3017	Platre	2021-07-17 14:45:10	Outils oublier (Programmer une réintervention)	121086804762872	1
3018	Point de suture	2016-12-01 10:09:11	RAS	237061640815392	1
3019	Platre	2016-12-01 02:31:08	RAS	237061640815392	1
3020	Cardioversion	2021-11-05 08:25:55	RAS	126033690529208	9
3021	Infiltration	2016-10-09 19:52:18	Cancer confirmé	299035859508254	1
3022	Depistage	2017-01-02 15:37:17	Annule	216089371391561	2
3023	Depistage	2021-09-13 15:35:00	Annule	216089371391561	2
3024	Platre	2017-01-02 00:58:17	Annule	216089371391561	2
3025	Infiltration	2020-07-15 09:23:29	RAS	159034821642031	2
3026	Point de suture	2021-12-01 06:56:53	Le patient a pris la fuite	159034821642031	2
3027	Infiltration	2018-02-20 19:05:37	Cancer confirmé	197098764923639	1
3028	Radio	2016-10-09 06:18:27	Outils oublier (Programmer une réintervention)	239085554893582	2
3029	Depistage	2016-10-09 09:03:07	RAS	239085554893582	1
3030	Point de suture	2021-08-28 07:21:31	RAS	276113638415091	1
3031	Infiltration	2017-07-08 10:12:41	Le patient a pris la fuite	276113638415091	1
3032	Radio	2017-07-08 09:02:44	RAS	276113638415091	1
3033	Platre	2021-08-28 20:44:25	Membre couper par erreur	276113638415091	2
3034	Platre	2016-08-09 00:11:38	RAS	148053879024132	1
3035	Depistage	2016-08-09 11:00:37	RAS	148053879024132	2
3036	Radio	2021-01-03 05:53:59	RAS	160036331293193	2
3037	Point de suture	2019-10-17 14:34:06	Annule	160036331293193	2
3038	Point de suture	2019-10-17 14:27:06	Outils oublier (Programmer une réintervention)	160036331293193	2
3039	Infiltration	2019-10-17 04:25:15	RAS	160036331293193	2
3040	Chirurie	2017-03-26 22:16:10	RAS	149012807148886	6
3041	Point de suture	2020-12-01 08:10:45	RAS	292069883843039	2
3042	Point de suture	2020-12-01 23:34:32	Le patient a pris la fuite	292069883843039	2
3043	Depistage	2020-12-01 16:32:12	Outils oublier (Programmer une réintervention)	292069883843039	1
3044	Point de suture	2020-12-01 22:42:07	RAS	292069883843039	1
3045	Transplantation	2021-02-25 10:09:44	Annule	102013760217462	8
3046	Instalation d un DCI	2021-06-18 02:34:58	RAS	102013760217462	9
3047	Chirurie	2017-05-10 03:14:35	RAS	102013760217462	6
3048	Platre	2021-04-02 17:24:06	RAS	175032006668491	1
3049	Infiltration	2018-03-24 01:20:25	Annule	186042352386031	2
3050	Laminectomie	2021-12-01 01:29:26	Annule	133057183683629	5
3051	trepanation	2021-04-02 08:59:46	Membre couper par erreur	133057183683629	5
3052	Craniatomie	2021-11-03 02:33:47	Le patient a pris la fuite	133057183683629	10
3053	Examen	2021-12-01 04:42:36	Personelle manquant	133057183683629	10
3054	Platre	2021-02-01 08:21:29	Annule	239091146729071	2
3055	Platre	2019-03-22 08:16:18	Outils oublier (Programmer une réintervention)	239091146729071	2
3056	Radio	2018-03-05 07:48:26	RAS	263101694819786	1
3057	Radio	2018-03-05 04:48:57	RAS	263101694819786	1
3058	Infiltration	2018-03-05 03:07:35	RAS	263101694819786	2
3059	Radio	2020-10-16 07:29:31	Outils oublier (Programmer une réintervention)	161030812581007	2
3060	Platre	2021-02-06 08:46:10	RAS	161030812581007	1
3061	Depistage	2021-02-06 10:38:57	RAS	161030812581007	1
3062	Infiltration	2021-08-01 11:25:38	Annule	107093235177704	2
3063	Infiltration	2020-01-05 03:38:36	RAS	107093235177704	2
3064	Infiltration	2021-08-01 18:10:52	Cancer confirmé	107093235177704	2
3065	Radio	2021-08-01 04:42:41	RAS	107093235177704	2
3066	Radio	2020-09-16 17:37:14	RAS	212107700291388	1
3067	Radio	2021-02-03 05:03:10	Cancer confirmé	212107700291388	2
3068	Platre	2021-12-01 21:36:42	Outils oublier (Programmer une réintervention)	185068654919823	1
3069	Platre	2019-03-21 21:49:04	Outils oublier (Programmer une réintervention)	185068654919823	2
3070	Platre	2018-05-01 00:05:45	RAS	186124469172237	2
3071	Platre	2021-08-22 21:04:49	RAS	186124469172237	1
3072	Infiltration	2021-11-20 00:34:29	Cancer confirmé	186124469172237	1
3073	Depistage	2019-05-25 15:36:16	RAS	166063604370140	1
3074	Radio	2016-09-22 03:14:16	Personelle manquant	265124877010950	2
3075	Radio	2016-11-15 14:05:19	Outils oublier (Programmer une réintervention)	265124877010950	2
3076	Instalation d un DCI	2017-12-01 01:47:37	RAS	242082419543236	9
3077	Craniatomie	2021-12-01 18:53:07	Outils oublier (Programmer une réintervention)	231055267153739	5
3078	trepanation	2021-11-01 01:14:59	RAS	231055267153739	10
3079	Laminectomie	2021-10-09 06:10:37	RAS	231055267153739	5
3080	Craniatomie	2021-12-01 00:15:13	RAS	231055267153739	5
3081	Point de suture	2021-12-01 18:27:13	RAS	183027292071405	2
3082	Radio	2018-06-12 00:53:09	RAS	183027292071405	1
3083	Reanimation	2020-08-20 07:56:46	Personelle manquant	119062521839354	6
3084	Reanimation	2020-05-12 09:46:45	Annule	119062521839354	6
3085	Depistage	2021-06-03 17:45:41	RAS	192109954988377	2
3086	Point de suture	2021-09-22 08:35:35	RAS	192109954988377	1
3087	Platre	2021-09-22 05:13:26	Membre couper par erreur	192109954988377	2
3088	Point de suture	2021-06-03 09:35:05	Membre couper par erreur	192109954988377	2
3089	Radio	2021-03-10 06:48:18	Cancer confirmé	202103092588087	2
3090	Depistage	2021-05-22 16:06:38	RAS	134055750788867	1
3091	Radio	2017-11-27 03:50:44	RAS	175064419494236	3
3092	Examen	2021-02-17 01:14:18	Membre couper par erreur	175064419494236	5
3093	Point de suture	2020-02-18 10:38:53	RAS	270096529380286	1
3094	Depistage	2021-01-07 20:26:43	Outils oublier (Programmer une réintervention)	270096529380286	1
3095	Depistage	2021-11-07 19:59:55	RAS	270096529380286	2
3096	Depistage	2021-12-01 23:51:16	RAS	270096529380286	1
3097	Infiltration	2021-04-08 09:30:41	RAS	201052199619458	2
3098	Depistage	2021-10-06 03:23:59	Membre couper par erreur	231043870437419	2
3099	Depistage	2019-11-03 04:47:27	Outils oublier (Programmer une réintervention)	231043870437419	1
3100	Radio	2019-11-03 17:17:15	RAS	231043870437419	2
3101	Depistage	2020-12-01 13:28:58	RAS	164109917354484	1
3102	Infiltration	2020-12-01 11:27:17	RAS	164109917354484	2
3103	Platre	2016-10-03 05:58:22	Membre couper par erreur	185031273229975	2
3104	Infiltration	2017-10-04 08:53:43	RAS	165015991694361	1
3105	Platre	2020-06-22 10:46:02	RAS	165015991694361	1
3106	Platre	2017-04-10 18:01:17	RAS	181010871674560	1
3107	Depistage	2017-04-10 12:40:48	RAS	181010871674560	2
3108	Radio	2017-04-10 12:57:47	Membre couper par erreur	181010871674560	1
3109	Point de suture	2017-04-10 08:37:51	RAS	181010871674560	1
3110	Platre	2019-04-10 20:50:12	RAS	139050580745001	1
3111	Infiltration	2021-08-14 01:57:49	Outils oublier (Programmer une réintervention)	277041387830758	1
3112	Platre	2021-08-14 11:55:58	RAS	277041387830758	1
3113	Radio	2021-05-21 03:11:15	Membre couper par erreur	277041387830758	2
3114	Point de suture	2021-05-21 07:15:06	Le patient a pris la fuite	277041387830758	2
3115	Point de suture	2015-01-06 01:53:19	RAS	115069364634634	1
3116	Radio	2015-01-06 19:01:52	Annule	115069364634634	1
3117	Depistage	2021-10-28 22:49:11	Cancer confirmé	241096000702739	2
3118	Infiltration	2016-01-18 04:48:04	RAS	216048982722935	2
3119	Point de suture	2020-11-27 20:21:50	RAS	276043885107833	2
3120	Point de suture	2020-11-27 21:46:03	Membre couper par erreur	276043885107833	2
3121	Platre	2020-11-27 10:57:38	RAS	276043885107833	2
3122	Point de suture	2018-12-01 18:59:07	RAS	257065888851792	1
3123	Platre	2018-12-01 17:04:29	RAS	257065888851792	1
3124	Infiltration	2018-12-01 02:09:49	RAS	257065888851792	1
3125	Radio	2018-12-01 00:34:19	RAS	257065888851792	1
3126	Depistage	2021-10-15 15:39:29	Le patient a pris la fuite	116047632185619	1
3127	Infiltration	2021-11-13 21:50:35	RAS	116047632185619	2
3128	Depistage	2021-08-14 12:24:26	RAS	116047632185619	2
3129	Point de suture	2021-10-18 21:51:01	Le patient a pris la fuite	116047632185619	2
3130	Radio	2017-03-07 11:56:13	Personelle manquant	237016326038243	2
3131	Point de suture	2017-03-07 00:48:06	RAS	237016326038243	1
3132	Ecographie	2021-12-01 09:26:25	RAS	177084821772201	11
3133	Ecographie	2021-12-01 13:45:02	RAS	177084821772201	12
3134	Radio	2020-10-09 10:11:51	RAS	132111902031658	1
3135	Depistage	2021-10-18 02:06:51	RAS	212077306419001	2
3136	Depistage	2021-10-18 17:11:05	RAS	212077306419001	1
3137	Platre	2021-10-18 19:02:39	Membre couper par erreur	212077306419001	2
3138	Point de suture	2021-02-25 22:56:05	RAS	265128593710036	2
3139	Radio	2021-02-25 09:15:48	RAS	265128593710036	2
3140	Reanimation	2021-12-01 04:29:45	Outils oublier (Programmer une réintervention)	240070875310729	7
3141	Chirurie	2021-12-01 07:20:35	Cancer confirmé	240070875310729	7
3142	Chirurie	2021-12-01 11:50:23	RAS	240070875310729	7
3143	Reanimation	2021-11-23 22:24:51	Cancer confirmé	293085789640582	7
3144	Cardioversion	2021-04-21 13:28:04	RAS	293085789640582	9
3145	Depistage	2018-07-02 18:00:45	Outils oublier (Programmer une réintervention)	197028693449711	1
3146	Radio	2020-05-09 09:36:29	Annule	248050431160701	3
3147	Examen	2017-10-26 11:20:08	Le patient a pris la fuite	248050431160701	10
3148	Laminectomie	2017-12-01 16:01:12	RAS	248050431160701	5
3149	Examen	2021-06-28 13:16:14	Le patient a pris la fuite	248050431160701	4
3150	Platre	2020-05-22 17:47:49	Annule	291044306186509	2
3151	Platre	2021-02-23 06:13:03	Membre couper par erreur	291044306186509	1
3152	Depistage	2019-08-13 02:37:36	RAS	291044306186509	1
3153	Radio	2019-08-13 03:20:25	Annule	291044306186509	2
3154	Chirurgie cardiaque	2021-08-20 22:33:06	RAS	212033837523152	8
3155	Cardioversion	2021-08-17 18:15:41	RAS	212033837523152	8
3156	Depistage	2019-03-21 06:30:05	Personelle manquant	108080499169703	1
3157	Radio	2019-03-21 15:32:31	Personelle manquant	108080499169703	1
3158	Radio	2019-03-21 00:02:10	RAS	108080499169703	2
3159	Radio	2019-12-01 07:59:34	RAS	264072212482013	2
3160	Infiltration	2016-06-03 05:20:28	RAS	264072212482013	1
3161	Depistage	2019-12-01 20:45:53	RAS	264072212482013	2
3162	Radio	2021-12-01 05:09:29	Outils oublier (Programmer une réintervention)	281076355672170	2
3163	Platre	2021-12-01 07:58:36	RAS	281076355672170	2
3164	Point de suture	2021-12-01 23:27:52	Personelle manquant	281076355672170	2
3165	Point de suture	2019-02-23 23:40:30	RAS	206068251343504	1
3166	Infiltration	2019-02-23 21:15:59	Outils oublier (Programmer une réintervention)	206068251343504	2
3167	Platre	2019-02-23 19:44:29	RAS	206068251343504	2
3168	Point de suture	2021-10-24 06:53:34	RAS	270109148488384	1
3169	Examen	2019-07-12 09:57:22	Personelle manquant	270109148488384	4
3170	Chirurie	2021-06-02 09:18:53	Membre couper par erreur	270109148488384	6
3171	Chirurie	2021-06-06 15:06:12	RAS	270109148488384	6
3172	Radio	2015-06-17 15:12:57	Personelle manquant	298094244775878	2
3173	Infiltration	2015-06-17 15:32:06	RAS	298094244775878	2
3174	Infiltration	2015-06-17 13:23:10	Cancer confirmé	298094244775878	1
3175	Platre	2015-06-17 18:35:43	Annule	298094244775878	2
3176	Radio	2018-01-09 04:27:47	Membre couper par erreur	166108820419376	11
3177	Point de suture	2019-05-25 16:52:35	Le patient a pris la fuite	166108820419376	1
3178	Depistage	2019-12-01 17:39:23	Membre couper par erreur	294016552422681	2
3179	Radio	2019-12-01 11:45:42	Membre couper par erreur	294016552422681	2
3180	Point de suture	2019-12-01 02:44:16	Annule	294016552422681	2
3181	Platre	2021-08-17 11:25:25	RAS	199101967924971	1
3182	Point de suture	2021-09-26 01:51:02	RAS	199101967924971	2
3183	Infiltration	2021-06-13 18:54:01	RAS	199101967924971	1
3184	Depistage	2021-06-13 10:43:24	RAS	199101967924971	1
3185	Point de suture	2021-12-01 06:56:30	RAS	124068661103286	6
3186	Point de suture	2021-09-28 05:42:09	RAS	124068661103286	7
3187	Chirurie	2021-09-28 05:11:08	RAS	124068661103286	7
3188	Chirurie	2021-09-28 10:33:23	RAS	124068661103286	7
3189	Depistage	2021-07-03 05:16:18	RAS	260044683856244	2
3190	Depistage	2021-07-03 10:19:38	Personelle manquant	260044683856244	2
3191	Depistage	2021-09-15 05:43:57	RAS	260044683856244	2
3192	Point de suture	2021-09-15 15:48:53	Personelle manquant	260044683856244	2
3193	Depistage	2019-11-23 01:20:09	RAS	276076882663621	1
3194	Radio	2018-11-16 13:19:47	RAS	289010155406208	2
3195	Radio	2021-09-23 00:08:50	RAS	289010155406208	3
3196	Depistage	2018-08-26 16:14:24	RAS	289010155406208	2
3197	Radio	2019-01-28 01:01:10	RAS	289010155406208	2
3198	Point de suture	2021-07-25 11:37:38	RAS	294060407584149	1
3199	Platre	2018-12-01 11:13:12	Outils oublier (Programmer une réintervention)	139065443729140	2
3200	Point de suture	2021-10-07 06:25:48	Annule	166091666520458	2
3201	Point de suture	2021-12-01 17:18:53	Annule	166091666520458	6
3202	Infiltration	2021-09-22 21:39:36	RAS	166091666520458	2
3203	Radio	2020-04-02 23:01:21	RAS	226058344946712	2
3204	Depistage	2020-04-02 11:59:44	RAS	226058344946712	1
3205	Depistage	2016-02-02 04:22:43	RAS	119108066223991	2
3206	Platre	2016-02-02 00:50:19	RAS	119108066223991	2
3207	Point de suture	2016-02-02 13:55:24	RAS	119108066223991	1
3208	Radio	2017-03-03 15:37:38	Le patient a pris la fuite	119108066223991	2
3209	Radio	2019-06-16 10:35:12	RAS	166120368218553	2
3210	Depistage	2019-06-16 05:55:52	Outils oublier (Programmer une réintervention)	166120368218553	2
3211	Infiltration	2019-12-01 03:37:05	Annule	166120368218553	2
3212	Reanimation	2021-04-27 13:09:54	Cancer confirmé	196063036979567	7
3213	Chirurie	2021-04-26 18:24:09	RAS	196063036979567	7
3214	Chirurie	2021-04-27 15:53:54	RAS	196063036979567	7
3215	Point de suture	2021-04-28 22:27:32	RAS	196063036979567	6
3216	Platre	2019-06-08 13:24:04	RAS	287018783401310	1
3217	Depistage	2019-06-08 14:47:40	Outils oublier (Programmer une réintervention)	287018783401310	2
3218	Infiltration	2019-11-22 07:11:01	RAS	287018783401310	2
3219	Radio	2019-12-01 09:36:06	RAS	169123667085745	2
3220	Radio	2021-12-01 11:52:57	Annule	169123667085745	1
3221	Infiltration	2021-10-22 21:45:31	RAS	169123667085745	1
3222	Depistage	2021-12-01 10:35:19	Membre couper par erreur	169123667085745	2
3223	Point de suture	2018-08-19 15:15:01	RAS	291045917238489	1
3224	Depistage	2015-12-01 13:09:53	RAS	291045917238489	1
3225	Radio	2017-04-23 04:00:16	RAS	291045917238489	2
3226	Radio	2015-07-11 00:30:41	Personelle manquant	203129749597569	2
3227	Radio	2021-11-22 21:51:17	RAS	239107910465394	1
3228	Point de suture	2017-07-20 02:41:44	Le patient a pris la fuite	107013876121908	1
3229	Radio	2017-07-20 22:54:09	RAS	107013876121908	2
3230	Infiltration	2017-07-20 01:57:26	RAS	107013876121908	2
3231	Depistage	2017-07-20 04:34:39	Outils oublier (Programmer une réintervention)	107013876121908	1
3232	Radio	2017-02-21 03:38:26	RAS	122055679266216	2
3233	Infiltration	2020-04-20 19:19:45	Le patient a pris la fuite	118086297555680	2
3234	Infiltration	2017-10-20 18:07:42	Cancer confirmé	118086297555680	1
3235	Infiltration	2021-05-13 22:50:44	Membre couper par erreur	250115721904451	1
3236	Depistage	2021-07-26 16:10:25	RAS	250115721904451	2
3237	Depistage	2021-05-13 02:43:14	Outils oublier (Programmer une réintervention)	250115721904451	1
3238	Depistage	2021-05-13 16:12:03	Outils oublier (Programmer une réintervention)	250115721904451	2
3239	Platre	2021-01-23 13:55:58	Annule	280060191300313	1
3240	Infiltration	2021-01-23 16:07:12	Le patient a pris la fuite	280060191300313	2
3241	Point de suture	2021-01-23 21:45:04	RAS	280060191300313	2
3242	Radio	2021-01-23 19:37:32	RAS	280060191300313	1
3243	Point de suture	2020-04-28 00:39:47	RAS	117126688058062	1
3244	Infiltration	2018-05-20 04:03:55	RAS	200031594053188	2
3245	Radio	2019-05-11 04:30:20	RAS	179067984929908	4
3246	Radio	2019-05-15 00:35:35	Membre couper par erreur	179067984929908	3
3247	trepanation	2020-05-24 08:35:31	RAS	193102778541743	5
3248	Chirurgie	2021-12-01 18:33:47	Personelle manquant	193102778541743	4
3249	Infiltration	2021-03-25 18:45:50	Personelle manquant	106034249755113	1
3250	Infiltration	2021-07-26 10:44:45	RAS	106034249755113	2
3251	Infiltration	2021-07-26 05:05:47	Membre couper par erreur	106034249755113	2
3252	Infiltration	2021-07-26 01:21:03	Membre couper par erreur	106034249755113	2
3253	Platre	2020-01-06 21:13:15	RAS	288021514521235	2
3254	Point de suture	2019-11-27 08:29:16	RAS	288021514521235	2
3255	Platre	2020-01-06 21:35:38	RAS	288021514521235	2
3256	Depistage	2016-06-16 15:13:46	RAS	288021514521235	1
3257	Infiltration	2020-10-23 07:02:14	RAS	219047723431704	2
3258	Infiltration	2020-10-23 05:47:27	RAS	219047723431704	2
3259	Depistage	2019-03-23 12:16:25	RAS	219047723431704	2
3260	Point de suture	2020-10-23 11:47:24	RAS	219047723431704	2
3261	Depistage	2020-12-01 00:35:55	Cancer confirmé	105064525567135	1
3262	Depistage	2020-12-01 01:38:57	RAS	105064525567135	1
3263	Infiltration	2016-08-18 21:11:32	Le patient a pris la fuite	143018820407138	2
3264	Depistage	2017-09-08 18:22:55	RAS	154103299728937	2
3265	Radio	2021-10-18 01:27:10	Le patient a pris la fuite	206113724192459	1
3266	Infiltration	2020-10-23 01:55:59	RAS	247065902055612	1
3267	Infiltration	2020-02-26 18:08:17	Annule	247065902055612	1
3268	Platre	2017-11-26 21:33:29	Annule	137119435589253	2
3269	Point de suture	2017-11-26 21:57:19	RAS	137119435589253	1
3270	Infiltration	2017-11-26 15:18:02	Personelle manquant	137119435589253	1
3271	Infiltration	2017-11-17 20:32:51	RAS	137119435589253	1
3272	Chirurgie cardiaque	2020-06-06 03:41:57	RAS	210057188504519	9
3273	Cardioversion	2021-01-02 23:16:31	Cancer confirmé	210057188504519	8
3274	Chirurgie	2017-06-24 22:34:06	Le patient a pris la fuite	210057188504519	4
3275	Transplantation	2021-01-04 02:00:15	Outils oublier (Programmer une réintervention)	210057188504519	8
3276	Platre	2021-11-21 20:37:20	Outils oublier (Programmer une réintervention)	168092323808223	2
3277	Radio	2021-11-21 19:32:06	Membre couper par erreur	168092323808223	1
3278	Radio	2020-04-12 19:15:53	RAS	168092323808223	2
3279	Depistage	2020-04-04 17:26:28	Cancer confirmé	121079326716109	2
3280	Depistage	2015-09-12 09:55:23	Cancer confirmé	208095993143744	1
3281	Platre	2015-03-24 12:23:41	Annule	208095993143744	1
3282	Infiltration	2021-07-26 20:11:32	Outils oublier (Programmer une réintervention)	217109204772961	1
3283	Radio	2019-06-16 21:51:13	RAS	250020760833943	1
3284	Depistage	2019-06-16 05:18:19	Cancer confirmé	250020760833943	1
3285	Point de suture	2019-06-16 10:06:07	Annule	250020760833943	2
3286	Examen	2021-12-01 05:44:04	RAS	297112356304318	5
3287	Laminectomie	2021-12-01 10:21:19	RAS	297112356304318	5
3288	Craniatomie	2021-12-01 23:19:22	Cancer confirmé	297112356304318	5
3289	Infiltration	2016-01-13 12:06:01	Cancer confirmé	190083588374214	2
3290	Infiltration	2016-01-13 00:43:38	RAS	190083588374214	1
3291	Point de suture	2015-10-07 04:48:14	RAS	179094720815996	1
3292	Platre	2015-10-07 19:18:20	Personelle manquant	179094720815996	1
3293	Radio	2015-10-07 07:58:57	RAS	179094720815996	2
3294	Platre	2019-04-09 01:38:56	Cancer confirmé	129033616838358	2
3295	Infiltration	2019-04-09 16:21:38	Membre couper par erreur	129033616838358	2
3296	Radio	2019-04-09 19:09:39	RAS	129033616838358	2
3297	Infiltration	2019-04-09 03:25:59	RAS	129033616838358	1
3298	Radio	2017-12-01 16:55:39	RAS	138120841735658	1
3299	Point de suture	2020-12-01 06:31:24	Membre couper par erreur	138120841735658	2
3300	Platre	2020-12-01 20:48:13	Le patient a pris la fuite	138120841735658	1
3301	Depistage	2018-05-18 00:27:54	Personelle manquant	259123094684548	2
3302	Infiltration	2018-05-18 04:18:48	RAS	259123094684548	1
3303	Radio	2020-11-20 14:39:29	RAS	111055160566338	1
3304	Platre	2021-08-07 04:04:34	Membre couper par erreur	113107456390850	1
3305	Radio	2021-10-12 11:27:18	RAS	184023991391628	2
3306	Platre	2021-10-07 04:59:25	RAS	184023991391628	2
3307	Depistage	2020-04-25 21:40:37	Cancer confirmé	276029793747273	2
3308	Point de suture	2020-04-25 04:12:03	Outils oublier (Programmer une réintervention)	276029793747273	2
3309	Depistage	2020-04-25 10:26:09	RAS	276029793747273	2
3310	Point de suture	2020-04-25 23:05:28	Personelle manquant	276029793747273	2
3311	Radio	2021-10-09 02:49:46	Le patient a pris la fuite	134078170944188	2
3312	Depistage	2020-03-07 10:47:22	Cancer confirmé	172094668047237	2
3313	Point de suture	2020-03-07 17:48:41	Annule	172094668047237	2
3314	Point de suture	2019-03-05 23:47:15	RAS	172094668047237	1
3315	Platre	2019-03-05 04:57:19	RAS	172094668047237	1
3316	Chirurie	2019-09-22 08:28:25	Outils oublier (Programmer une réintervention)	134042462939733	7
3317	Reanimation	2019-09-09 10:48:21	RAS	134042462939733	7
3318	Chirurie	2019-08-28 19:20:57	Outils oublier (Programmer une réintervention)	134042462939733	6
3319	Infiltration	2020-04-15 04:42:04	RAS	180128995054010	1
3320	Infiltration	2021-11-06 03:47:20	RAS	210052462712009	2
3321	Point de suture	2016-01-05 20:30:08	RAS	210052462712009	2
3322	Platre	2021-11-06 08:41:36	Membre couper par erreur	210052462712009	2
3323	Infiltration	2016-01-05 02:39:52	RAS	210052462712009	1
3324	Platre	2017-02-15 11:35:05	RAS	117024346707693	1
3325	Platre	2020-05-12 07:28:09	RAS	115103061446648	1
3326	Point de suture	2020-05-12 23:30:51	RAS	115103061446648	2
3327	Radio	2018-01-08 11:02:36	RAS	292081637038605	2
3328	Radio	2020-09-07 15:19:02	Cancer confirmé	153109335398179	3
3329	Instalation d un DCI	2017-01-01 10:58:13	RAS	153109335398179	9
3330	Depistage	2020-04-06 23:56:24	Annule	126109239418435	1
3331	Platre	2020-04-06 09:48:31	RAS	126109239418435	2
3332	Radio	2020-04-06 08:59:33	Personelle manquant	126109239418435	2
3333	Depistage	2021-11-25 18:09:54	RAS	201072681226547	1
3334	Depistage	2019-02-19 12:13:43	Membre couper par erreur	239120237800324	2
3335	Depistage	2019-09-22 00:54:43	RAS	248126817619060	1
3336	Point de suture	2019-09-22 06:41:30	Personelle manquant	248126817619060	2
3337	Infiltration	2019-09-22 16:04:01	Cancer confirmé	248126817619060	2
3338	Depistage	2017-08-11 09:57:08	Cancer confirmé	248126817619060	1
3339	Transplantation	2018-12-15 11:16:55	Personelle manquant	261113788102102	9
3340	Instalation d un DCI	2020-07-07 22:49:00	Membre couper par erreur	261113788102102	8
3341	Laminectomie	2021-12-01 13:33:20	Le patient a pris la fuite	182011321936788	5
3342	Radio	2016-01-22 14:21:22	RAS	270022191753200	2
3343	Depistage	2020-01-27 13:34:07	RAS	270022191753200	1
3344	Radio	2020-01-27 08:18:28	RAS	270022191753200	2
3345	Radio	2016-01-22 12:24:56	RAS	270022191753200	1
3346	Radio	2017-07-19 15:49:02	RAS	225028099609560	1
3347	Radio	2019-01-03 12:42:46	RAS	225028099609560	1
3348	Depistage	2017-07-11 03:20:12	RAS	225028099609560	2
3349	Platre	2017-07-19 08:37:02	RAS	225028099609560	1
3350	Scanner	2021-11-14 05:28:52	Membre couper par erreur	116066809892335	11
3351	Chirurie	2021-04-19 08:41:13	RAS	116066809892335	6
3352	Ecographie	2021-11-15 12:30:53	RAS	116066809892335	12
3353	Chirurgie cardiaque	2018-11-25 15:42:18	RAS	116066809892335	8
3354	Depistage	2021-11-25 16:56:05	RAS	116106724777292	1
3355	Radio	2021-12-01 20:38:47	Membre couper par erreur	116106724777292	2
3356	Instalation d un DCI	2021-08-14 08:31:45	Le patient a pris la fuite	116106724777292	8
3357	Transplantation	2018-10-12 12:39:46	RAS	146083500358210	8
3358	Scanner	2021-12-01 07:42:14	Membre couper par erreur	146083500358210	11
3359	Radio	2021-12-01 16:03:57	Personelle manquant	146083500358210	11
3360	Radio	2021-02-23 02:37:00	RAS	157036866353328	2
3361	Platre	2019-02-07 16:12:53	RAS	268040221926572	2
3362	Radio	2019-02-07 04:20:28	Annule	268040221926572	1
3363	Radio	2019-02-07 14:02:51	Le patient a pris la fuite	268040221926572	2
3364	Point de suture	2019-02-07 08:24:29	RAS	268040221926572	2
3365	Platre	2019-06-12 16:52:02	Le patient a pris la fuite	259029201046904	2
3366	Infiltration	2019-06-12 12:43:20	RAS	259029201046904	1
3367	Platre	2020-08-22 11:35:16	Annule	259029201046904	1
3368	Point de suture	2021-12-01 05:54:14	RAS	282038251008033	6
3369	Radio	2020-06-09 22:11:00	RAS	282038251008033	11
3370	Scanner	2021-09-24 15:21:54	RAS	282038251008033	12
3371	Ecographie	2018-03-07 06:02:41	Cancer confirmé	129031456728988	12
3372	Infiltration	2021-06-19 08:35:46	RAS	136023021781523	1
3373	Radio	2015-11-14 22:48:01	RAS	147110274507518	1
3374	Point de suture	2021-03-09 08:37:46	Le patient a pris la fuite	243077956746269	2
3375	Radio	2021-03-09 12:44:50	RAS	243077956746269	2
3376	Depistage	2021-03-09 08:39:18	RAS	243077956746269	1
3377	Point de suture	2018-12-01 03:42:35	RAS	291079297260025	2
3378	Platre	2021-05-08 00:23:24	Outils oublier (Programmer une réintervention)	291079297260025	2
3379	Depistage	2015-09-12 08:03:04	Personelle manquant	291079297260025	1
3380	Point de suture	2015-09-12 16:38:36	Outils oublier (Programmer une réintervention)	291079297260025	2
3381	Point de suture	2019-12-01 01:31:07	RAS	262088041353654	2
3382	Point de suture	2019-12-01 08:55:18	Annule	262088041353654	2
3383	Platre	2017-05-28 15:57:52	RAS	227042980363902	1
3384	Radio	2017-05-28 02:08:28	RAS	227042980363902	2
3385	Depistage	2017-05-28 12:51:17	Cancer confirmé	227042980363902	2
3386	Radio	2017-05-28 18:28:39	Membre couper par erreur	227042980363902	1
3387	Point de suture	2021-03-02 11:38:55	RAS	225085330862476	1
3388	Radio	2019-12-01 11:20:28	Personelle manquant	225085330862476	2
3389	Infiltration	2021-03-02 20:00:25	RAS	225085330862476	1
3390	Infiltration	2019-12-01 13:42:46	RAS	225085330862476	1
3391	Radio	2021-02-12 07:16:26	Cancer confirmé	217081379554035	2
3392	Infiltration	2021-02-12 22:11:13	RAS	217081379554035	1
3393	Radio	2021-03-14 07:08:12	Le patient a pris la fuite	217081379554035	1
3394	Platre	2018-05-08 13:45:33	RAS	298098122213462	2
3395	Point de suture	2018-06-26 02:26:31	Le patient a pris la fuite	276023787980654	1
3396	Platre	2018-07-02 03:08:18	Cancer confirmé	276023787980654	1
3397	Infiltration	2019-04-20 01:12:30	Le patient a pris la fuite	236110135097393	1
3398	Depistage	2019-04-20 07:20:09	RAS	236110135097393	2
3399	Radio	2021-05-02 06:03:01	Cancer confirmé	236110135097393	1
3400	Point de suture	2020-06-08 02:15:40	RAS	220113495911050	1
3401	Point de suture	2021-08-15 05:50:06	RAS	220113495911050	2
3402	Depistage	2021-08-15 19:06:58	Outils oublier (Programmer une réintervention)	220113495911050	2
3403	Point de suture	2018-07-04 18:17:58	Annule	209118599554171	1
3404	Radio	2018-07-04 21:12:33	Cancer confirmé	209118599554171	2
3405	Radio	2019-09-08 20:28:09	Outils oublier (Programmer une réintervention)	271021954120932	1
3406	Depistage	2019-09-08 14:47:53	RAS	271021954120932	2
3407	Platre	2019-09-08 06:46:43	Personelle manquant	271021954120932	1
3408	Platre	2019-09-08 11:34:52	RAS	271021954120932	1
3409	IRM	2018-07-15 06:13:13	Le patient a pris la fuite	237107264212189	12
3410	Infiltration	2018-10-25 18:35:53	RAS	251020364469865	2
3411	Platre	2018-10-25 01:43:15	RAS	251020364469865	1
3412	Radio	2018-10-25 16:14:43	RAS	251020364469865	2
3413	Platre	2017-03-22 14:40:42	Personelle manquant	122125838145935	2
3414	Radio	2020-03-26 06:31:39	Annule	122125838145935	2
3415	Platre	2017-03-22 08:27:28	Cancer confirmé	122125838145935	1
3416	Platre	2017-03-22 22:21:24	RAS	122125838145935	2
3417	Point de suture	2018-08-06 17:57:38	RAS	179045444422744	2
3418	Platre	2018-08-06 23:45:36	Outils oublier (Programmer une réintervention)	179045444422744	2
3419	Platre	2018-08-06 06:36:15	RAS	179045444422744	1
3420	Infiltration	2018-08-06 03:25:34	Membre couper par erreur	179045444422744	2
3421	Depistage	2019-04-19 18:37:30	RAS	166062449407106	1
3422	Depistage	2019-04-19 12:22:36	Annule	166062449407106	2
3423	Infiltration	2019-04-19 21:40:58	Personelle manquant	166062449407106	2
3424	Infiltration	2021-10-08 15:42:44	Membre couper par erreur	197069985519854	1
3425	Radio	2021-10-08 04:47:36	RAS	197069985519854	1
3426	Point de suture	2021-10-24 05:42:37	Cancer confirmé	197069985519854	2
3427	Depistage	2021-10-08 22:49:23	RAS	197069985519854	2
3428	Infiltration	2021-08-07 09:35:49	RAS	190029314791340	2
3429	Point de suture	2019-04-06 14:31:57	Le patient a pris la fuite	227126597924105	1
3430	Depistage	2020-12-01 23:34:51	Personelle manquant	227126597924105	1
3431	Radio	2019-06-23 21:27:56	RAS	227126597924105	2
3432	Infiltration	2020-12-01 05:06:40	Annule	227126597924105	2
3433	Point de suture	2018-06-27 08:09:19	RAS	157121022621522	1
3434	Examen	2020-11-04 05:26:18	Cancer confirmé	143092918371476	3
3435	Radio	2020-04-03 03:06:19	Membre couper par erreur	222042520288908	1
3436	Platre	2020-04-03 06:43:37	Personelle manquant	222042520288908	2
3437	Depistage	2020-04-03 17:58:17	Cancer confirmé	222042520288908	1
3438	Radio	2020-04-03 08:09:37	Le patient a pris la fuite	222042520288908	1
3439	Craniatomie	2019-07-12 22:15:55	Membre couper par erreur	202071437767230	10
3440	IRM	2021-11-17 16:43:42	Personelle manquant	202071437767230	12
3441	Examen	2018-07-13 13:20:00	RAS	202071437767230	10
3442	Craniatomie	2018-08-10 15:14:01	Cancer confirmé	202071437767230	10
3443	Point de suture	2021-02-02 15:53:15	RAS	189086144171587	2
3444	Point de suture	2021-02-02 03:01:17	Membre couper par erreur	189086144171587	1
3445	Platre	2015-02-27 21:25:12	RAS	256063692412136	2
3446	Platre	2015-02-27 09:49:18	Le patient a pris la fuite	256063692412136	2
3447	Radio	2015-02-27 07:38:30	Membre couper par erreur	256063692412136	1
3448	Depistage	2021-08-11 20:33:29	Personelle manquant	170086700455011	1
3449	Depistage	2016-12-25 23:23:18	RAS	131057674892840	2
3450	Radio	2021-10-10 14:00:52	RAS	131057674892840	11
3451	Point de suture	2017-09-23 18:56:53	RAS	131057674892840	1
3452	Point de suture	2016-11-28 13:58:48	RAS	131057674892840	2
3453	Infiltration	2020-02-16 09:00:01	Outils oublier (Programmer une réintervention)	240023495790364	1
3454	Infiltration	2020-02-16 01:09:55	Cancer confirmé	240023495790364	2
3455	Radio	2020-02-16 21:53:51	RAS	240023495790364	2
3456	Depistage	2020-03-15 19:50:43	RAS	268014305680881	1
3457	Instalation d un DCI	2019-12-01 04:37:27	RAS	272065307866110	9
3458	Depistage	2018-05-10 10:07:58	Outils oublier (Programmer une réintervention)	165094296199095	1
3459	Point de suture	2018-05-10 21:59:00	RAS	165094296199095	1
3460	Platre	2018-05-10 04:15:59	RAS	165094296199095	2
3461	Chirurie	2021-05-25 10:04:55	RAS	121079926115784	6
3462	Examen	2021-07-20 18:11:39	Cancer confirmé	121079926115784	3
3463	Chirurie	2015-12-14 12:11:26	Outils oublier (Programmer une réintervention)	121079926115784	7
3464	Examen	2021-07-20 23:52:52	Annule	121079926115784	4
3465	Craniatomie	2018-09-25 03:59:04	Cancer confirmé	231090596408156	10
3466	Chirurie	2021-03-24 05:00:22	Cancer confirmé	231090596408156	6
3467	Chirurie	2021-07-21 08:55:23	Cancer confirmé	231090596408156	7
3468	trepanation	2021-12-01 00:29:33	Personelle manquant	231090596408156	10
3469	Infiltration	2019-08-05 19:59:59	Outils oublier (Programmer une réintervention)	286109172934315	1
3470	Depistage	2021-10-03 01:30:27	Cancer confirmé	286109172934315	2
3471	Depistage	2021-10-03 10:35:28	RAS	286109172934315	1
3472	Depistage	2021-10-03 13:28:19	RAS	286109172934315	1
3473	Infiltration	2015-12-01 18:44:08	Annule	271077285006735	1
3474	Infiltration	2015-12-01 16:02:46	Annule	271077285006735	2
3475	Point de suture	2015-12-01 18:19:48	Personelle manquant	271077285006735	2
3476	Depistage	2021-08-27 05:17:01	Membre couper par erreur	190075925899731	2
3477	Radio	2021-08-27 08:43:11	RAS	190075925899731	1
3478	Radio	2019-06-24 07:18:47	RAS	120119820079715	1
3479	Point de suture	2018-09-09 02:18:17	Personelle manquant	120119820079715	2
3480	Infiltration	2018-12-01 11:25:11	RAS	120119820079715	1
3481	Infiltration	2021-12-01 11:55:14	Personelle manquant	271125052129400	1
3482	Infiltration	2021-11-28 06:51:52	RAS	271125052129400	1
3483	Depistage	2015-12-01 05:09:57	Le patient a pris la fuite	155035914169601	2
3484	Depistage	2015-12-01 21:28:08	Personelle manquant	155035914169601	1
3485	Platre	2015-12-01 17:16:27	RAS	155035914169601	1
3486	Infiltration	2015-12-01 09:06:31	Cancer confirmé	155035914169601	1
3487	Radio	2020-12-25 11:58:08	RAS	196099311916690	12
3488	Chirurgie	2021-10-28 03:14:31	Annule	196099311916690	3
3489	Chirurgie	2021-09-13 06:49:47	Outils oublier (Programmer une réintervention)	196099311916690	3
3490	Platre	2019-05-08 10:10:00	RAS	278090644287533	1
3491	Radio	2019-05-08 00:56:04	RAS	278090644287533	2
3492	Point de suture	2019-05-08 08:56:26	Membre couper par erreur	278090644287533	1
3493	Point de suture	2016-05-02 23:00:07	RAS	133052277550638	1
3494	Infiltration	2016-05-02 12:16:25	Annule	133052277550638	1
3495	Infiltration	2016-05-02 00:08:47	Le patient a pris la fuite	133052277550638	1
3496	Platre	2016-05-02 11:04:20	Membre couper par erreur	133052277550638	1
3497	Point de suture	2017-02-19 04:50:35	Cancer confirmé	292121669134423	2
3498	Infiltration	2021-04-09 10:54:18	RAS	292121669134423	1
3499	Radio	2017-02-19 02:27:54	Cancer confirmé	292121669134423	2
3500	Depistage	2017-02-19 23:24:24	RAS	292121669134423	2
3501	Platre	2016-04-22 12:23:45	RAS	253024126306890	2
3502	Depistage	2016-04-22 15:08:45	Le patient a pris la fuite	253024126306890	2
3503	Infiltration	2016-07-04 18:33:13	Annule	228082057152542	1
3504	Depistage	2016-07-04 23:36:02	Annule	228082057152542	2
3505	Point de suture	2016-07-04 00:38:41	Membre couper par erreur	228082057152542	1
3506	Radio	2016-07-04 00:41:59	Le patient a pris la fuite	228082057152542	1
3507	Point de suture	2020-10-17 08:23:07	Cancer confirmé	125117547327936	7
3508	Instalation d un DCI	2021-12-01 07:06:24	Personelle manquant	125117547327936	8
3509	Transplantation	2021-11-14 05:30:09	Cancer confirmé	125117547327936	9
3510	Chirurgie cardiaque	2021-10-25 07:17:57	Annule	125117547327936	8
3511	Infiltration	2021-12-01 08:56:00	RAS	290035800595956	1
3512	Depistage	2021-12-01 10:34:18	Personelle manquant	290035800595956	1
3513	Infiltration	2021-12-01 06:02:08	RAS	290035800595956	2
3514	Chirurgie	2021-08-24 06:29:15	RAS	254107648685692	4
3515	Chirurgie	2021-09-14 22:50:54	Annule	254107648685692	4
3516	Examen	2021-08-24 20:33:56	Cancer confirmé	254107648685692	4
3517	Examen	2021-11-26 00:35:07	RAS	254107648685692	3
3518	Radio	2020-05-18 18:56:10	RAS	147068405424686	1
3519	Infiltration	2019-11-07 19:25:27	Le patient a pris la fuite	147068405424686	2
3520	Point de suture	2019-04-04 01:45:50	Personelle manquant	201122582689823	2
3521	Depistage	2019-04-04 09:14:07	Annule	201122582689823	2
3522	Depistage	2019-04-04 01:06:35	RAS	201122582689823	1
3523	Infiltration	2020-02-18 02:01:54	Cancer confirmé	234042399113177	1
3524	Platre	2020-02-18 19:35:31	Personelle manquant	234042399113177	2
3525	Radio	2019-02-17 02:47:45	Cancer confirmé	166036483219145	1
3526	Depistage	2019-02-17 09:55:39	RAS	166036483219145	2
3527	Depistage	2019-02-17 21:03:48	RAS	166036483219145	1
3528	Depistage	2019-06-03 02:25:03	Annule	257074140156085	2
3529	Infiltration	2021-11-25 11:03:54	Outils oublier (Programmer une réintervention)	257074140156085	1
3530	Point de suture	2019-06-03 13:30:37	RAS	257074140156085	2
3531	Point de suture	2020-05-13 02:24:27	RAS	241102233744196	1
3532	Point de suture	2020-05-13 09:43:04	Outils oublier (Programmer une réintervention)	241102233744196	1
3533	Infiltration	2020-05-13 07:18:52	Personelle manquant	241102233744196	1
3534	Infiltration	2020-05-13 04:19:59	Outils oublier (Programmer une réintervention)	241102233744196	2
3535	Chirurie	2021-10-24 18:07:58	Personelle manquant	235041796027551	6
3536	Reanimation	2021-09-28 02:41:00	RAS	235041796027551	6
3537	Reanimation	2021-11-12 04:17:01	RAS	235041796027551	6
3538	Reanimation	2021-11-08 06:58:45	RAS	235041796027551	6
3539	IRM	2019-11-10 11:57:40	RAS	280030696037033	12
3540	Point de suture	2016-12-01 18:48:06	Cancer confirmé	258052232199718	1
3541	Chirurgie	2020-08-08 02:40:56	RAS	258052232199718	3
3542	Radio	2021-10-21 03:49:50	Membre couper par erreur	195089048997652	1
3543	Infiltration	2019-04-12 11:56:43	Annule	224012297078722	1
3544	Depistage	2021-07-08 11:55:19	Cancer confirmé	133096044501013	1
3545	Point de suture	2021-07-08 05:59:12	RAS	133096044501013	1
3546	Point de suture	2021-12-01 05:28:17	RAS	105079641276488	6
3547	Point de suture	2021-12-01 18:39:59	Annule	105079641276488	6
3548	Chirurie	2021-12-01 22:44:32	Personelle manquant	105079641276488	7
3549	Infiltration	2019-10-26 19:19:55	RAS	265037138611063	1
3550	Radio	2020-05-25 17:46:49	RAS	265037138611063	1
3551	Infiltration	2019-10-26 13:02:00	Annule	265037138611063	2
3552	Point de suture	2020-05-25 02:46:03	RAS	265037138611063	1
3553	Platre	2016-05-27 04:54:23	Outils oublier (Programmer une réintervention)	269061340475625	2
3554	Infiltration	2017-05-02 05:57:36	Membre couper par erreur	289038293978883	1
3555	Point de suture	2021-07-01 07:17:13	Membre couper par erreur	289038293978883	2
3556	Radio	2016-10-03 04:51:05	RAS	118097743275289	1
3557	Examen	2021-08-15 14:59:01	Annule	118097743275289	3
3558	Laminectomie	2021-12-01 12:25:59	RAS	118097743275289	5
3559	Depistage	2017-06-23 03:43:21	RAS	268102515480863	2
3560	Radio	2017-06-23 19:28:58	Le patient a pris la fuite	268102515480863	2
3561	Platre	2017-06-23 07:10:36	RAS	268102515480863	2
3562	Radio	2017-06-23 16:58:03	RAS	268102515480863	2
3563	Reanimation	2021-03-27 00:21:07	RAS	262017315373034	6
3564	Reanimation	2021-04-11 23:01:34	RAS	262017315373034	6
3565	Infiltration	2021-04-05 13:43:03	RAS	294015158916742	2
3566	Point de suture	2021-04-05 18:36:02	RAS	294015158916742	2
3567	Depistage	2021-12-01 10:54:06	Cancer confirmé	229049188967727	1
3568	Cardioversion	2019-02-11 19:37:10	Cancer confirmé	229049188967727	9
3569	Depistage	2018-02-07 05:17:08	RAS	261061517818802	2
3570	Radio	2020-03-16 06:38:22	Annule	218067839543144	1
3571	Depistage	2020-03-16 10:06:01	RAS	218067839543144	1
3572	Infiltration	2020-03-16 19:03:41	RAS	218067839543144	2
3573	Point de suture	2020-03-16 20:22:15	Le patient a pris la fuite	218067839543144	2
3574	Infiltration	2020-06-27 17:20:13	RAS	137035076043920	1
3575	Depistage	2020-05-17 08:18:41	RAS	137035076043920	1
3576	Radio	2020-05-17 05:02:08	RAS	137035076043920	2
3577	Point de suture	2021-11-08 12:20:38	Annule	258016165795720	2
3578	Depistage	2017-09-26 23:54:14	Le patient a pris la fuite	284075289727096	1
3579	Infiltration	2016-04-28 15:32:02	Le patient a pris la fuite	238100948951460	1
3580	Infiltration	2016-04-28 03:40:00	RAS	238100948951460	2
3581	Infiltration	2016-04-28 21:54:14	RAS	238100948951460	1
3582	Depistage	2016-04-28 06:53:09	Le patient a pris la fuite	238100948951460	2
3583	Infiltration	2015-08-12 13:39:07	RAS	147094894800840	1
3584	Platre	2017-04-07 02:51:53	Annule	243102394343966	2
3585	Point de suture	2017-04-07 11:30:55	Membre couper par erreur	243102394343966	1
3586	Transplantation	2015-11-21 19:22:49	Annule	235015710631442	8
3587	Cardioversion	2020-11-23 03:03:00	Personelle manquant	235015710631442	9
3588	Transplantation	2020-11-27 14:45:41	Le patient a pris la fuite	235015710631442	9
3589	Infiltration	2018-01-22 05:38:10	RAS	139028752544809	1
3590	Chirurie	2019-05-21 14:44:04	Personelle manquant	292110340538775	7
3591	Reanimation	2018-01-09 03:57:24	RAS	292110340538775	6
3592	Platre	2018-02-21 15:44:09	Outils oublier (Programmer une réintervention)	172044633042546	2
3593	Infiltration	2018-02-21 01:42:59	RAS	172044633042546	2
3594	Depistage	2018-02-21 20:07:21	Outils oublier (Programmer une réintervention)	172044633042546	2
3595	Point de suture	2021-01-07 00:53:45	Annule	272074630342514	1
3596	Platre	2019-10-28 20:41:44	RAS	272074630342514	2
3597	Point de suture	2021-01-07 17:26:46	Outils oublier (Programmer une réintervention)	272074630342514	2
3598	Depistage	2021-04-13 04:52:58	Le patient a pris la fuite	205106177189757	2
3599	Depistage	2015-08-19 11:34:44	Le patient a pris la fuite	118066904629610	2
3600	Platre	2018-02-28 08:23:00	RAS	293097683511915	2
3601	Platre	2016-05-23 14:47:54	Membre couper par erreur	288019756939738	2
3602	Point de suture	2016-05-23 12:53:24	Cancer confirmé	288019756939738	1
3603	Platre	2016-05-23 01:58:07	RAS	288019756939738	2
3604	Platre	2020-03-18 01:11:54	Cancer confirmé	118055407721077	1
3605	Point de suture	2020-03-18 16:59:32	RAS	118055407721077	2
3606	Depistage	2018-04-11 15:05:29	RAS	209086618622243	1
3607	Platre	2018-04-11 01:19:22	Outils oublier (Programmer une réintervention)	209086618622243	2
3608	Infiltration	2018-04-11 18:04:54	Membre couper par erreur	209086618622243	2
3609	Platre	2018-04-11 01:42:45	Cancer confirmé	209086618622243	2
3610	Infiltration	2015-01-11 09:27:07	RAS	211052198016337	1
3611	Point de suture	2018-09-25 14:23:07	Membre couper par erreur	211052198016337	1
3612	Depistage	2019-04-12 21:02:36	RAS	269041356249776	1
3613	Infiltration	2019-04-12 13:19:50	RAS	269041356249776	1
3614	Point de suture	2019-04-12 21:07:13	RAS	269041356249776	2
3615	Laminectomie	2021-12-01 13:33:09	RAS	166084097850130	10
3616	Radio	2018-11-17 21:56:22	RAS	239129600838387	1
3617	Platre	2019-01-05 13:36:10	Cancer confirmé	144020579570087	1
3618	Ecographie	2016-07-04 01:59:58	RAS	160078524507383	11
3619	Chirurgie	2020-07-28 17:55:10	RAS	160078524507383	4
3620	Examen	2021-02-03 12:53:25	Personelle manquant	160078524507383	4
3621	Chirurgie	2020-08-27 13:35:29	RAS	160078524507383	4
3622	Depistage	2016-03-06 03:27:56	RAS	157129459270583	1
3623	Depistage	2016-03-06 15:14:01	RAS	157129459270583	2
3624	Infiltration	2016-06-09 17:42:27	RAS	197028070992122	1
3625	Platre	2016-06-09 05:10:56	RAS	197028070992122	1
3626	Radio	2016-06-09 04:08:30	Annule	197028070992122	2
3627	Depistage	2018-05-15 13:31:08	Annule	225106058149347	2
3628	Platre	2020-06-24 15:12:03	Cancer confirmé	225106058149347	1
3629	Depistage	2018-05-15 08:51:17	RAS	225106058149347	1
3630	Depistage	2018-05-15 22:57:25	Outils oublier (Programmer une réintervention)	225106058149347	1
3631	Point de suture	2017-04-22 17:14:21	Personelle manquant	153022679819804	2
3632	Infiltration	2017-04-22 18:50:19	Annule	153022679819804	2
3633	Depistage	2021-05-23 17:48:49	RAS	153022679819804	2
3634	Infiltration	2017-04-22 07:08:15	RAS	153022679819804	1
3635	Infiltration	2019-07-15 00:10:01	RAS	122117120832828	2
3636	Platre	2015-10-03 15:48:42	RAS	108105169006820	2
3637	Radio	2020-11-15 03:48:57	Personelle manquant	108105169006820	2
3638	Infiltration	2015-10-03 10:58:03	Membre couper par erreur	108105169006820	2
3639	Radio	2021-05-28 09:54:55	RAS	133085507042722	1
3640	Depistage	2020-10-21 06:28:43	RAS	299032100194543	2
3641	Point de suture	2020-10-21 14:39:44	Cancer confirmé	299032100194543	2
3642	Depistage	2020-10-21 12:21:14	RAS	299032100194543	2
3643	Depistage	2020-12-01 03:11:53	RAS	299032100194543	2
3644	Infiltration	2015-01-28 11:51:45	RAS	285111122122687	2
3645	Depistage	2015-01-28 20:38:53	RAS	285111122122687	2
3646	Depistage	2015-01-28 15:53:38	RAS	285111122122687	1
3647	Platre	2015-01-28 18:04:52	RAS	285111122122687	1
3648	Examen	2018-06-05 20:07:50	Annule	106069855306956	5
3649	Examen	2019-09-27 08:26:07	RAS	106069855306956	5
3650	Examen	2020-09-01 16:30:16	RAS	106069855306956	5
3651	Laminectomie	2018-09-26 10:39:25	Le patient a pris la fuite	106069855306956	10
3652	Depistage	2018-07-12 01:00:06	Membre couper par erreur	235025043023266	2
3653	Infiltration	2018-07-12 19:54:54	RAS	235025043023266	1
3654	Infiltration	2018-09-24 04:51:27	Cancer confirmé	259031305534854	2
3655	Depistage	2018-09-24 14:09:56	RAS	259031305534854	1
3656	Point de suture	2018-09-24 06:27:06	Le patient a pris la fuite	259031305534854	1
3657	Radio	2018-09-24 04:53:49	Cancer confirmé	259031305534854	2
3658	Depistage	2016-01-02 01:45:11	RAS	164018247653927	2
3659	Platre	2016-01-02 00:34:14	RAS	164018247653927	2
3660	Platre	2017-11-13 23:13:00	Cancer confirmé	164018247653927	2
3661	Infiltration	2016-01-02 08:22:50	RAS	164018247653927	2
3662	Depistage	2018-11-03 12:04:07	Personelle manquant	255111462999163	1
3663	Depistage	2018-11-03 00:26:43	Le patient a pris la fuite	255111462999163	1
3664	Depistage	2018-11-03 22:32:19	RAS	255111462999163	2
3665	Platre	2017-02-17 19:25:41	Le patient a pris la fuite	149016464115574	2
3666	Radio	2019-03-25 03:29:36	Outils oublier (Programmer une réintervention)	149016464115574	1
3667	Infiltration	2017-02-17 11:22:51	Personelle manquant	149016464115574	1
3668	Radio	2016-11-08 04:33:14	RAS	218028916522993	1
3669	Point de suture	2016-11-08 01:49:58	Le patient a pris la fuite	218028916522993	1
3670	Infiltration	2016-11-08 23:59:08	Le patient a pris la fuite	218028916522993	2
3671	Radio	2016-11-08 18:41:47	RAS	218028916522993	1
3672	Radio	2017-07-15 04:29:32	Outils oublier (Programmer une réintervention)	132104189563779	2
3673	Point de suture	2020-01-11 19:34:31	Le patient a pris la fuite	103078742854508	1
3674	Infiltration	2020-01-11 08:26:04	RAS	103078742854508	2
3675	Chirurie	2021-07-08 05:53:21	Annule	176038914084519	6
3676	Chirurie	2021-02-08 12:40:19	Annule	176038914084519	6
3677	Depistage	2019-02-06 19:04:59	RAS	274016315753078	2
3678	Depistage	2019-02-06 05:37:42	RAS	274016315753078	2
3679	Depistage	2019-02-06 02:43:44	Cancer confirmé	274016315753078	1
3680	Platre	2020-08-27 07:41:22	Personelle manquant	286059858756226	2
3681	Infiltration	2020-08-27 21:05:58	RAS	286059858756226	1
3682	Point de suture	2021-10-16 09:38:00	Outils oublier (Programmer une réintervention)	144104148447610	2
3683	Depistage	2021-11-24 21:12:33	Personelle manquant	144104148447610	1
3684	Depistage	2021-10-16 22:28:20	RAS	144104148447610	2
3685	Chirurie	2016-09-09 09:40:54	RAS	129092551504840	6
3686	Chirurie	2021-10-22 20:26:06	Personelle manquant	129092551504840	7
3687	Chirurie	2019-09-11 09:09:46	Outils oublier (Programmer une réintervention)	129092551504840	6
3688	Chirurie	2017-08-20 09:09:56	Membre couper par erreur	129092551504840	6
3689	Point de suture	2019-12-01 12:08:23	RAS	170104318565314	6
3690	Infiltration	2019-03-17 19:45:03	RAS	274114292533681	1
3691	Point de suture	2020-07-21 03:02:55	Cancer confirmé	237072348150692	2
3692	Radio	2020-06-23 08:27:33	RAS	237072348150692	2
3693	Examen	2020-12-14 02:12:49	RAS	283124902489728	5
3694	Radio	2021-09-26 09:48:31	RAS	283124902489728	2
3695	Laminectomie	2021-06-16 16:47:35	RAS	283124902489728	5
3696	Radio	2018-04-07 08:28:22	RAS	140010920647767	2
3697	Depistage	2018-04-07 18:36:27	Outils oublier (Programmer une réintervention)	140010920647767	1
3698	Radio	2018-04-07 11:17:56	RAS	140010920647767	2
3699	Point de suture	2021-09-12 11:44:29	RAS	174054333800157	6
3700	Chirurie	2021-08-28 08:08:49	RAS	174054333800157	6
3701	Platre	2021-03-08 06:16:26	Personelle manquant	236033297541443	1
3702	Radio	2019-06-25 11:10:31	Cancer confirmé	236033297541443	2
3703	Radio	2017-09-28 04:49:12	RAS	117072352261008	1
3704	Platre	2017-09-17 19:13:13	RAS	253108676231602	2
3705	Radio	2018-11-20 19:55:32	Personelle manquant	253108676231602	1
3706	Infiltration	2017-09-17 15:38:47	RAS	253108676231602	1
3707	Point de suture	2017-05-10 18:32:59	RAS	253108676231602	2
3708	Point de suture	2015-06-12 18:23:03	RAS	214048310374407	1
3709	Depistage	2016-10-13 01:13:28	RAS	214048310374407	2
3710	Radio	2015-06-12 07:04:43	Cancer confirmé	214048310374407	2
3711	Infiltration	2016-10-13 21:35:30	RAS	214048310374407	2
3712	Radio	2021-05-13 05:30:12	Personelle manquant	283034579380856	1
3713	Radio	2016-12-01 01:21:15	RAS	283034579380856	1
3714	Platre	2020-11-09 13:52:25	Outils oublier (Programmer une réintervention)	283034579380856	2
3715	Platre	2016-03-25 23:46:21	Annule	239040683301450	1
3716	Platre	2016-03-25 13:15:04	RAS	239040683301450	1
3717	Depistage	2020-10-16 11:56:09	RAS	142112061521891	2
3718	Chirurgie	2021-03-10 17:11:59	Le patient a pris la fuite	228102829065978	3
3719	Radio	2021-12-01 03:06:38	Annule	228102829065978	11
3720	Radio	2021-12-01 07:09:06	Cancer confirmé	228102829065978	11
3721	Infiltration	2015-07-25 06:20:11	RAS	161114713933201	2
3722	Radio	2015-04-12 18:03:54	Membre couper par erreur	161114713933201	1
3723	Infiltration	2015-04-12 22:07:56	Membre couper par erreur	161114713933201	1
3724	Infiltration	2021-08-25 06:24:45	RAS	271024262039407	2
3725	Depistage	2021-08-25 08:08:22	RAS	271024262039407	1
3726	Infiltration	2021-08-25 05:57:42	RAS	271024262039407	1
3727	Radio	2015-06-05 11:39:22	Cancer confirmé	271024262039407	2
3728	Depistage	2018-03-21 11:11:51	Membre couper par erreur	116071026258730	2
3729	Platre	2021-04-08 22:07:38	RAS	116071026258730	2
3730	Radio	2015-05-02 20:34:14	Cancer confirmé	116071026258730	2
3731	Platre	2015-05-02 05:36:21	Personelle manquant	116071026258730	2
3732	Depistage	2017-09-24 00:44:16	Cancer confirmé	299083781186978	1
3733	Radio	2017-09-24 11:14:46	Membre couper par erreur	299083781186978	2
3734	Radio	2017-09-24 08:08:48	Personelle manquant	299083781186978	2
3735	Radio	2017-09-24 09:25:30	RAS	299083781186978	1
3736	Depistage	2020-05-11 05:58:12	Annule	197104772238319	1
3737	Point de suture	2020-12-24 10:06:34	Membre couper par erreur	221021276653204	7
3738	Point de suture	2021-05-12 05:29:31	RAS	221021276653204	6
3739	Platre	2021-11-28 18:42:59	Annule	221021276653204	1
3740	Laminectomie	2015-08-27 04:23:29	Membre couper par erreur	221021276653204	5
3741	Depistage	2018-11-26 06:57:26	Le patient a pris la fuite	133119344929516	1
3742	Infiltration	2021-12-01 14:18:24	RAS	133119344929516	1
3743	Point de suture	2015-09-01 19:31:47	RAS	166049821238905	1
3744	Infiltration	2015-09-01 08:01:10	Le patient a pris la fuite	166049821238905	1
3745	Laminectomie	2021-12-01 23:44:53	RAS	102046285253211	10
3746	Instalation d un DCI	2021-11-10 14:23:30	RAS	102046285253211	9
3747	Chirurgie cardiaque	2021-05-25 18:18:30	RAS	102046285253211	9
3748	Infiltration	2015-05-11 17:04:53	Cancer confirmé	137121652381278	2
3749	Depistage	2016-03-27 04:33:33	Membre couper par erreur	137121652381278	2
3750	Infiltration	2020-04-24 10:06:07	Outils oublier (Programmer une réintervention)	155077696371044	2
3751	Infiltration	2020-04-24 13:31:19	Annule	155077696371044	1
3752	Platre	2020-04-24 03:19:34	RAS	155077696371044	1
3753	Infiltration	2019-12-01 02:21:14	Le patient a pris la fuite	161010244798916	1
3754	Radio	2020-02-15 21:56:07	Membre couper par erreur	151110869486625	1
3755	Infiltration	2020-02-15 03:53:27	Outils oublier (Programmer une réintervention)	151110869486625	2
3756	Depistage	2017-02-25 10:42:58	RAS	277044366026913	1
3757	Point de suture	2017-02-25 16:29:25	Le patient a pris la fuite	277044366026913	2
3758	Point de suture	2017-02-25 06:38:47	Personelle manquant	277044366026913	1
3759	Point de suture	2017-02-25 14:29:02	RAS	277044366026913	1
3760	Infiltration	2020-04-15 18:07:02	RAS	144035676655040	2
3761	Infiltration	2018-09-25 16:57:54	RAS	189098056291549	2
3762	Point de suture	2018-09-25 22:22:28	Le patient a pris la fuite	189098056291549	2
3763	Depistage	2018-09-25 06:08:07	Membre couper par erreur	189098056291549	2
3764	Depistage	2018-09-25 03:33:59	RAS	189098056291549	2
3765	Laminectomie	2019-08-02 06:39:05	Le patient a pris la fuite	278089373283395	5
3766	Craniatomie	2017-05-06 20:12:53	RAS	278089373283395	5
3767	Examen	2016-03-21 06:25:14	Cancer confirmé	278089373283395	10
3768	Craniatomie	2017-01-17 19:57:28	Cancer confirmé	278089373283395	5
3769	Depistage	2019-05-25 12:09:15	RAS	178071952498324	2
3770	Radio	2019-05-25 23:41:31	Annule	178071952498324	1
3771	Radio	2019-05-25 05:32:31	RAS	178071952498324	1
3772	Platre	2021-07-22 05:57:25	RAS	156074123250805	1
3773	Cardioversion	2020-12-01 23:04:08	RAS	156074123250805	8
3774	Scanner	2019-10-15 08:54:23	Le patient a pris la fuite	156074123250805	11
3775	Scanner	2020-01-01 13:43:56	Personelle manquant	156074123250805	12
3776	Point de suture	2018-11-07 16:04:45	Cancer confirmé	135110615927304	1
3777	Depistage	2017-02-24 05:22:31	RAS	135110615927304	2
3778	Point de suture	2017-02-24 09:10:05	Le patient a pris la fuite	135110615927304	2
3779	Radio	2018-11-07 05:41:22	Annule	135110615927304	1
3780	Point de suture	2021-04-11 09:43:17	Outils oublier (Programmer une réintervention)	248069614540301	1
3781	Infiltration	2016-01-03 10:34:22	RAS	248069614540301	1
3782	Platre	2016-08-21 23:10:56	Le patient a pris la fuite	248069614540301	1
3783	Radio	2021-04-11 10:27:53	RAS	248069614540301	1
3784	Depistage	2020-01-19 00:06:45	Membre couper par erreur	169097507276185	2
3785	Depistage	2020-08-15 00:44:55	Cancer confirmé	169097507276185	2
3786	Point de suture	2021-03-05 08:41:45	RAS	299048039616883	2
3787	Depistage	2018-03-18 16:11:00	RAS	299048039616883	2
3788	Infiltration	2021-03-05 19:10:56	RAS	299048039616883	1
3789	Infiltration	2018-03-18 21:35:03	Cancer confirmé	299048039616883	1
3790	Point de suture	2015-06-16 05:37:52	Personelle manquant	224081724300171	1
3791	Infiltration	2015-06-16 11:16:46	RAS	224081724300171	1
3792	Radio	2015-06-16 04:43:46	RAS	224081724300171	1
3793	Point de suture	2018-06-25 21:22:05	Annule	150060303807110	2
3794	Point de suture	2021-12-01 08:39:57	RAS	126109435891127	1
3795	Point de suture	2021-11-23 04:20:21	RAS	126109435891127	2
3796	Platre	2019-09-20 11:46:37	Personelle manquant	275063951087350	2
3797	Radio	2019-09-20 12:37:02	RAS	275063951087350	1
3798	Radio	2019-09-20 17:43:17	RAS	275063951087350	2
3799	Radio	2021-09-20 02:46:21	RAS	194015343162633	2
3800	Point de suture	2019-06-28 05:12:48	RAS	194015343162633	2
3801	Radio	2020-01-15 09:10:10	RAS	194015343162633	2
3802	Radio	2021-03-12 15:56:35	Outils oublier (Programmer une réintervention)	194015343162633	1
3803	Radio	2021-06-05 18:40:03	Outils oublier (Programmer une réintervention)	251119575893548	12
3804	Platre	2015-10-02 06:02:18	RAS	154068499542428	2
3805	Depistage	2015-10-02 23:06:00	Cancer confirmé	154068499542428	1
3806	Radio	2015-10-02 23:47:18	Personelle manquant	154068499542428	1
3807	Depistage	2015-10-02 11:05:37	Personelle manquant	154068499542428	2
3808	Infiltration	2021-10-17 01:48:24	RAS	141079769804035	1
3809	Radio	2021-07-26 00:28:48	RAS	141079769804035	2
3810	Examen	2021-02-22 22:17:09	Cancer confirmé	240073988379421	5
3811	Examen	2020-12-01 02:36:23	RAS	240073988379421	5
3812	Infiltration	2019-09-01 04:26:23	Outils oublier (Programmer une réintervention)	120056823338977	2
3813	Depistage	2019-10-11 14:23:04	Annule	119109623992764	2
3814	Infiltration	2020-08-14 17:57:26	RAS	119109623992764	2
3815	Point de suture	2019-10-11 08:13:16	RAS	119109623992764	2
3816	Craniatomie	2021-05-14 17:09:39	RAS	101039612534949	5
3817	Radio	2021-11-23 11:37:32	Annule	101039612534949	3
3818	Radio	2021-12-01 14:38:56	RAS	101039612534949	4
3819	Radio	2020-09-25 04:05:16	RAS	239023073644392	4
3820	Radio	2019-12-11 00:52:55	Outils oublier (Programmer une réintervention)	239023073644392	3
3821	Radio	2017-12-15 09:43:19	RAS	239023073644392	4
3822	Point de suture	2018-04-25 08:15:29	Annule	252106418593026	2
3823	Infiltration	2018-04-25 05:19:54	Outils oublier (Programmer une réintervention)	252106418593026	1
3824	Platre	2018-12-01 21:10:13	RAS	252092112764860	2
3825	Radio	2021-11-27 01:45:10	Annule	252092112764860	2
3826	Depistage	2017-05-06 03:30:04	Cancer confirmé	157070363992818	2
3827	Radio	2017-03-28 04:10:44	Membre couper par erreur	157070363992818	2
3828	IRM	2017-05-10 17:23:38	RAS	195106011080181	11
3829	Chirurie	2021-11-27 09:38:46	RAS	195106011080181	7
3830	Ecographie	2018-08-23 05:31:55	Le patient a pris la fuite	195106011080181	12
3831	Scanner	2020-05-27 22:03:05	Annule	195106011080181	12
3832	Instalation d un DCI	2021-11-28 04:12:06	RAS	253095437283501	8
3833	Chirurgie	2019-12-01 17:18:01	Membre couper par erreur	229097103116120	3
3834	Chirurgie	2021-12-01 21:30:49	Personelle manquant	229097103116120	3
3835	Examen	2019-12-01 06:33:10	RAS	229097103116120	3
3836	Radio	2020-12-01 18:45:33	RAS	203038685064147	2
3837	Point de suture	2016-10-04 10:55:51	RAS	244106583543744	1
3838	Depistage	2016-10-04 22:47:02	RAS	244106583543744	2
3839	Infiltration	2016-10-08 02:56:37	Annule	244106583543744	1
3840	Point de suture	2018-04-17 16:28:28	RAS	127015812688118	1
3841	Depistage	2019-10-22 12:26:39	Membre couper par erreur	174126989550917	1
3842	Platre	2016-01-05 03:52:56	Cancer confirmé	174126989550917	1
3843	Point de suture	2019-10-22 00:35:18	RAS	174126989550917	2
3844	Depistage	2019-10-22 06:02:32	Le patient a pris la fuite	174126989550917	2
3845	Point de suture	2021-12-01 07:41:03	RAS	148071526597476	1
3846	Platre	2017-12-01 07:15:08	RAS	148071526597476	2
3847	Infiltration	2017-12-01 20:44:41	RAS	148071526597476	2
3848	Depistage	2017-12-01 23:39:01	RAS	148071526597476	1
3849	Point de suture	2021-06-28 01:04:25	RAS	206067332177665	1
3850	Radio	2020-06-20 04:54:23	RAS	265053211557745	1
3851	Point de suture	2020-06-20 02:26:05	RAS	265053211557745	2
3852	Depistage	2020-06-20 07:10:29	RAS	265053211557745	1
3853	Depistage	2015-04-24 10:56:16	Personelle manquant	262016873894611	1
3854	Point de suture	2015-04-24 09:56:41	Le patient a pris la fuite	262016873894611	1
3855	Infiltration	2017-02-05 17:41:37	Annule	262016873894611	2
3856	Examen	2019-05-07 08:39:13	Le patient a pris la fuite	267109108065202	4
3857	Radio	2017-06-26 20:58:15	RAS	267109108065202	3
3858	Radio	2016-11-22 03:07:52	Outils oublier (Programmer une réintervention)	267109108065202	3
3859	Examen	2021-10-14 03:03:18	RAS	266019956812570	5
3860	trepanation	2021-05-28 02:58:31	RAS	266019956812570	5
3861	Craniatomie	2021-04-27 06:38:24	RAS	266019956812570	10
3862	Point de suture	2015-04-24 02:17:33	RAS	266019956812570	7
3863	Chirurie	2019-12-01 06:03:24	RAS	252111777841915	6
3864	Chirurie	2019-10-26 03:40:20	RAS	252111777841915	7
3865	Reanimation	2019-02-09 11:47:56	Membre couper par erreur	252111777841915	6
3866	Chirurie	2020-10-28 07:34:02	RAS	252111777841915	7
3867	Radio	2015-02-16 10:24:53	RAS	164038608632119	1
3868	Radio	2015-02-16 11:24:50	RAS	164038608632119	1
3869	Infiltration	2015-02-16 12:25:49	Outils oublier (Programmer une réintervention)	164038608632119	2
3870	Platre	2020-11-24 21:47:00	Membre couper par erreur	131101434250337	1
3871	Infiltration	2019-03-08 04:00:19	Le patient a pris la fuite	230124336513645	1
3872	Point de suture	2019-08-06 14:15:56	RAS	230124336513645	1
3873	Platre	2019-03-08 14:30:50	RAS	230124336513645	2
3874	Radio	2020-08-14 02:24:05	Le patient a pris la fuite	212051079375206	1
3875	Radio	2020-08-14 11:53:52	RAS	212051079375206	2
3876	Infiltration	2021-09-07 00:17:42	RAS	207036199333762	2
3877	Depistage	2021-05-27 10:28:08	RAS	195039969007673	1
3878	Radio	2021-05-27 16:49:45	RAS	195039969007673	1
3879	Depistage	2017-01-28 06:28:02	Cancer confirmé	221029479428090	2
3880	Infiltration	2021-04-01 02:49:11	Annule	110066257611314	2
3881	Platre	2017-03-27 07:30:03	RAS	223078053552461	1
3882	Depistage	2018-06-26 05:33:20	Personelle manquant	223078053552461	1
3883	Infiltration	2018-06-26 04:25:26	Outils oublier (Programmer une réintervention)	223078053552461	1
3884	Radio	2021-04-11 07:32:36	RAS	243017583288790	1
3885	Chirurgie	2021-12-01 19:20:20	Outils oublier (Programmer une réintervention)	201073789759321	4
3886	Depistage	2017-05-25 21:45:24	Le patient a pris la fuite	266073845226430	2
3887	Platre	2021-06-24 00:21:09	RAS	266073845226430	2
3888	Point de suture	2021-02-02 09:01:42	RAS	145056354127107	2
3889	Platre	2021-02-02 19:20:41	Outils oublier (Programmer une réintervention)	145056354127107	2
3890	Platre	2019-08-08 15:27:46	Cancer confirmé	145056354127107	2
3891	Depistage	2019-08-08 15:58:05	RAS	145056354127107	1
3892	Infiltration	2021-11-23 17:26:17	Annule	289040697244116	1
3893	Platre	2020-03-20 21:07:12	RAS	289040697244116	1
3894	Radio	2017-09-09 19:54:03	RAS	245106940503490	2
3895	Ecographie	2021-11-24 15:08:59	Personelle manquant	179073352261725	11
3896	Ecographie	2021-11-13 18:58:26	Outils oublier (Programmer une réintervention)	179073352261725	11
3897	Scanner	2021-11-26 16:50:15	RAS	179073352261725	12
3898	Ecographie	2021-12-01 05:22:54	RAS	179073352261725	12
3899	Radio	2019-10-03 21:10:10	Personelle manquant	298032738731346	2
3900	Radio	2021-10-05 19:19:51	Personelle manquant	298032738731346	1
3901	Radio	2019-10-03 13:20:01	RAS	298032738731346	1
3902	Radio	2020-05-05 09:59:54	RAS	243082614270684	4
3903	Chirurgie	2020-05-02 15:01:34	Annule	243082614270684	4
3904	Radio	2020-11-18 18:11:01	Annule	255086087623452	2
3905	Depistage	2020-11-18 09:55:41	Membre couper par erreur	255086087623452	1
3906	Point de suture	2020-11-18 23:43:18	Personelle manquant	255086087623452	1
3907	Depistage	2017-01-21 14:01:51	RAS	255086087623452	2
3908	Platre	2019-01-14 00:47:42	Le patient a pris la fuite	144015615260843	2
3909	Point de suture	2021-08-07 20:11:33	Annule	144015615260843	1
3910	Depistage	2019-01-14 18:43:42	RAS	144015615260843	1
3911	Depistage	2021-08-07 17:23:37	Annule	144015615260843	1
3912	Examen	2021-06-25 16:18:15	RAS	212101169913710	5
3913	Reanimation	2021-04-08 09:44:40	Annule	195068695146738	7
3914	Point de suture	2021-06-16 15:41:10	Cancer confirmé	195068695146738	7
3915	Point de suture	2019-05-02 04:58:01	RAS	180088976677729	1
3916	Point de suture	2019-05-02 11:12:49	RAS	180088976677729	2
3917	Point de suture	2019-05-02 12:54:11	Le patient a pris la fuite	180088976677729	2
3918	Infiltration	2019-04-27 07:32:43	Personelle manquant	109015975211104	2
3919	Depistage	2019-02-07 10:57:44	Le patient a pris la fuite	109015975211104	2
3920	Point de suture	2017-06-26 04:59:49	RAS	110114341425639	1
3921	Infiltration	2017-06-26 06:46:25	RAS	110114341425639	2
3922	Point de suture	2017-06-26 05:38:15	RAS	110114341425639	2
3923	Point de suture	2017-06-26 07:54:30	RAS	110114341425639	1
3924	Transplantation	2020-12-01 15:21:46	Outils oublier (Programmer une réintervention)	269071637551546	9
3925	Chirurgie cardiaque	2021-10-19 03:35:48	RAS	269071637551546	9
3926	Platre	2021-11-23 18:31:42	Personelle manquant	206033830025756	1
3927	Radio	2021-11-23 06:33:09	RAS	206033830025756	2
3928	Radio	2021-11-23 00:33:08	Membre couper par erreur	206033830025756	1
3929	Point de suture	2021-11-23 21:21:12	Membre couper par erreur	206033830025756	1
3930	Platre	2015-04-01 19:45:36	RAS	258112655293107	2
3931	Infiltration	2019-12-01 20:02:16	RAS	258086115253449	1
3932	Platre	2019-12-01 05:55:00	Cancer confirmé	258086115253449	2
3933	Radio	2017-09-03 07:41:36	Personelle manquant	122128399094364	2
3934	Radio	2016-08-02 14:39:51	RAS	122128399094364	1
3935	Depistage	2016-08-02 05:09:00	RAS	122128399094364	2
3936	Infiltration	2015-09-15 19:59:57	Le patient a pris la fuite	180020359139629	1
3937	Infiltration	2015-09-15 18:28:34	Le patient a pris la fuite	180020359139629	1
3938	Radio	2015-09-15 00:50:54	RAS	180020359139629	2
3939	Radio	2021-02-02 22:48:22	RAS	121034314107191	3
3940	IRM	2017-01-13 06:04:54	Personelle manquant	121034314107191	11
3941	Radio	2021-12-01 21:19:59	Annule	227024560069053	11
3942	Instalation d un DCI	2021-12-01 01:15:32	RAS	156060915698166	8
3943	Reanimation	2021-11-07 15:54:01	Cancer confirmé	156060915698166	6
3944	Transplantation	2021-12-01 23:47:34	RAS	156060915698166	9
3945	Radio	2021-05-04 07:55:32	Le patient a pris la fuite	177103352992307	1
3946	Infiltration	2021-09-11 19:33:46	Annule	177103352992307	2
3947	Infiltration	2021-05-04 00:05:44	Annule	177103352992307	2
3948	Radio	2019-07-07 12:42:14	Membre couper par erreur	177103352992307	2
3949	Platre	2017-04-09 04:00:45	RAS	255099147198042	1
3950	Platre	2017-04-09 11:15:45	RAS	255099147198042	1
3951	Radio	2015-05-24 07:20:48	Outils oublier (Programmer une réintervention)	173088238558496	2
3952	Radio	2015-05-24 12:03:47	Cancer confirmé	173088238558496	2
3953	Infiltration	2015-05-24 22:57:58	Personelle manquant	173088238558496	2
3954	Radio	2019-02-08 05:33:21	RAS	156119474815307	2
3955	Platre	2020-10-24 03:13:00	RAS	166081296763649	2
3956	Platre	2019-04-19 22:56:18	Annule	251011333261627	2
3957	Infiltration	2019-04-19 00:03:20	RAS	251011333261627	2
3958	Point de suture	2020-08-27 20:36:58	Personelle manquant	251011333261627	2
3959	Platre	2020-08-27 07:41:16	RAS	251011333261627	1
3960	Infiltration	2020-09-13 20:16:01	RAS	138074248401105	1
3961	Radio	2020-12-01 02:15:12	Personelle manquant	138074248401105	2
3962	Point de suture	2020-09-13 22:36:35	Personelle manquant	138074248401105	2
3963	Point de suture	2017-12-01 21:49:34	RAS	140119959250877	1
3964	Depistage	2019-12-01 20:54:08	RAS	172051108200956	1
3965	Radio	2019-12-01 20:58:27	RAS	172051108200956	2
3966	Depistage	2021-02-09 18:32:06	Annule	172051108200956	1
3967	Depistage	2021-02-09 12:45:22	RAS	172051108200956	2
3968	Depistage	2020-02-02 16:48:11	Le patient a pris la fuite	198111260505320	1
3969	Platre	2020-02-02 20:42:36	RAS	198111260505320	1
3970	Infiltration	2020-02-02 21:10:16	RAS	198111260505320	2
3971	Radio	2020-02-02 07:11:54	RAS	198111260505320	2
3972	Chirurgie	2017-03-19 00:32:30	Le patient a pris la fuite	256074987484479	4
3973	Radio	2015-08-15 09:57:44	Membre couper par erreur	256074987484479	3
3974	Chirurgie	2016-02-22 04:24:45	Le patient a pris la fuite	256074987484479	3
3975	Chirurgie	2020-11-17 10:22:37	RAS	256074987484479	4
3976	Infiltration	2020-12-01 09:34:40	RAS	199127252136345	2
3977	Radio	2020-12-01 09:50:18	RAS	199127252136345	1
3978	Platre	2015-04-06 05:47:04	Cancer confirmé	262038778938203	1
3979	Point de suture	2016-04-26 03:05:28	Membre couper par erreur	262038778938203	2
3980	Point de suture	2020-04-27 19:55:14	RAS	262038778938203	2
3981	Platre	2015-04-06 05:47:04	Le patient a pris la fuite	262038778938203	1
3982	Point de suture	2017-05-05 18:46:16	Personelle manquant	282066379868584	1
3983	Platre	2017-05-05 01:23:15	RAS	282066379868584	2
3984	Point de suture	2017-05-05 12:40:55	RAS	282066379868584	1
3985	Depistage	2017-02-01 12:49:11	Le patient a pris la fuite	233109092062205	1
3986	Depistage	2017-02-01 12:48:34	RAS	233109092062205	1
3987	Radio	2017-02-01 04:06:08	Le patient a pris la fuite	233109092062205	2
3988	Infiltration	2017-03-03 17:24:00	RAS	176106513315003	2
3989	Platre	2017-03-03 22:34:02	Personelle manquant	176106513315003	1
3990	Point de suture	2017-03-03 18:04:40	RAS	176106513315003	2
3991	Point de suture	2015-02-17 21:30:56	Outils oublier (Programmer une réintervention)	180057367414637	1
3992	Point de suture	2015-02-17 11:45:22	RAS	180057367414637	2
3993	Point de suture	2015-02-17 08:36:51	RAS	180057367414637	2
3994	Infiltration	2016-04-16 08:04:34	RAS	117121559056457	2
3995	Infiltration	2016-04-16 14:57:31	RAS	117121559056457	2
3996	Radio	2016-04-16 17:09:27	Outils oublier (Programmer une réintervention)	117121559056457	2
3997	Radio	2016-04-16 06:05:09	RAS	117121559056457	1
3998	Platre	2015-09-27 04:05:02	RAS	240022636962670	1
3999	Radio	2017-12-01 18:44:22	Outils oublier (Programmer une réintervention)	240022636962670	1
4000	Depistage	2016-08-07 04:00:29	Personelle manquant	266025004527670	1
4001	Platre	2019-05-17 17:16:54	Le patient a pris la fuite	127081156734983	1
4002	Point de suture	2017-09-03 12:52:14	RAS	127081156734983	1
4003	Radio	2019-05-17 08:46:46	Outils oublier (Programmer une réintervention)	127081156734983	1
4004	Radio	2016-10-25 02:36:05	Cancer confirmé	127081156734983	2
4005	Depistage	2019-01-26 10:47:27	RAS	288119690626128	1
4006	Point de suture	2021-02-06 09:28:33	Outils oublier (Programmer une réintervention)	288119690626128	1
4007	Infiltration	2021-05-16 03:02:04	Cancer confirmé	101073163220911	1
4008	Point de suture	2021-05-14 06:57:14	Outils oublier (Programmer une réintervention)	101073163220911	1
4009	Point de suture	2021-05-16 21:48:35	RAS	101073163220911	1
4010	Radio	2021-05-14 20:15:02	Cancer confirmé	101073163220911	2
4011	Radio	2021-09-22 13:52:29	Le patient a pris la fuite	286058534258713	3
4012	Radio	2021-09-28 14:41:25	RAS	286058534258713	3
4013	IRM	2020-07-28 17:47:05	Cancer confirmé	149061136795769	12
4014	Ecographie	2020-07-25 20:16:32	Annule	149061136795769	11
4015	Radio	2019-01-20 02:33:52	Cancer confirmé	245070516446550	1
4016	Radio	2019-01-20 14:25:57	Membre couper par erreur	245070516446550	1
4017	Depistage	2021-07-26 13:59:31	RAS	245070516446550	2
4018	Infiltration	2020-11-28 12:27:14	RAS	230026753623669	2
4019	Platre	2016-05-24 12:42:10	Outils oublier (Programmer une réintervention)	230026753623669	1
4020	Point de suture	2020-11-28 22:22:19	Le patient a pris la fuite	230026753623669	1
4021	Chirurie	2021-08-22 18:39:34	Membre couper par erreur	102035825373803	6
4022	trepanation	2020-05-03 19:06:56	RAS	102035825373803	10
4023	Point de suture	2021-08-20 16:36:57	RAS	102035825373803	7
4024	Radio	2021-11-15 22:48:38	RAS	102035825373803	2
4025	Depistage	2018-10-21 11:15:33	RAS	180028509811169	2
4026	Depistage	2018-01-14 04:45:21	Le patient a pris la fuite	180028509811169	1
4027	Point de suture	2018-01-14 17:37:45	RAS	180028509811169	1
4028	Radio	2021-04-24 04:02:55	RAS	216074033954453	4
4029	Point de suture	2021-12-01 18:10:09	Outils oublier (Programmer une réintervention)	216074033954453	1
4030	Depistage	2016-11-06 12:55:45	Outils oublier (Programmer une réintervention)	293094751937192	2
4031	Depistage	2020-08-01 02:06:54	Cancer confirmé	293094751937192	1
4032	Infiltration	2020-08-01 07:29:41	Cancer confirmé	293094751937192	1
4033	Infiltration	2017-11-27 00:30:03	Le patient a pris la fuite	147061886221913	1
4034	Point de suture	2021-02-10 10:45:50	Le patient a pris la fuite	223028798999363	1
4035	Infiltration	2018-05-08 06:32:34	Membre couper par erreur	101120424360755	2
4036	Radio	2015-11-03 09:18:07	RAS	101120424360755	4
4037	Depistage	2021-12-01 03:21:09	RAS	101120424360755	1
4038	Chirurgie cardiaque	2020-11-16 03:11:53	Personelle manquant	221067551980230	9
4039	Point de suture	2021-11-25 17:08:38	Cancer confirmé	221067551980230	6
4040	Depistage	2016-12-01 18:45:31	RAS	218015653051373	1
4041	Depistage	2020-12-01 13:06:25	RAS	240114616700691	1
4042	Point de suture	2020-08-12 20:04:45	Personelle manquant	240114616700691	1
4043	Point de suture	2020-08-12 10:04:50	RAS	240114616700691	2
4044	Radio	2020-12-01 20:08:49	RAS	240114616700691	1
4045	Point de suture	2020-12-01 13:09:03	Le patient a pris la fuite	193077753289249	1
4046	Platre	2021-05-12 19:35:55	Cancer confirmé	193077753289249	2
4047	Platre	2021-05-12 04:47:25	RAS	193077753289249	1
4048	Depistage	2018-01-08 19:03:19	Personelle manquant	265116744621785	2
4049	Radio	2018-09-18 21:25:51	RAS	265116744621785	1
4050	Infiltration	2018-09-18 21:52:02	RAS	265116744621785	1
4051	Point de suture	2019-06-08 17:49:46	RAS	133057095110202	2
4052	Point de suture	2021-05-25 09:24:51	Membre couper par erreur	119118453408165	6
4053	Reanimation	2021-05-25 15:23:22	Membre couper par erreur	119118453408165	7
4054	Point de suture	2021-05-24 07:33:23	Membre couper par erreur	119118453408165	7
4055	Reanimation	2021-05-25 02:07:49	Personelle manquant	119118453408165	7
4056	Platre	2019-12-01 16:56:53	RAS	235051633057734	2
4057	Radio	2021-11-13 12:43:51	Membre couper par erreur	278090615498741	1
4058	Platre	2021-11-13 16:50:32	RAS	278090615498741	2
4059	Platre	2021-11-13 16:09:42	RAS	278090615498741	1
4060	Infiltration	2021-11-13 23:14:38	RAS	278090615498741	2
4061	Infiltration	2021-12-01 06:18:52	Le patient a pris la fuite	147106883665481	2
4062	Infiltration	2019-02-28 06:08:55	Le patient a pris la fuite	147106883665481	1
4063	Infiltration	2020-09-09 17:00:42	Outils oublier (Programmer une réintervention)	167087766989559	2
4064	Infiltration	2018-01-26 17:15:27	Annule	167087766989559	1
4065	Platre	2017-09-13 04:55:45	Annule	291031559371140	1
4066	Infiltration	2017-09-13 09:16:34	Cancer confirmé	291031559371140	1
4067	Platre	2017-09-13 09:37:04	Personelle manquant	291031559371140	2
4068	Point de suture	2018-11-07 05:49:12	Membre couper par erreur	247087976437659	1
4069	Radio	2021-10-27 08:50:28	RAS	195091425437937	4
4070	Examen	2021-07-27 21:15:45	RAS	194060824711882	5
4071	Cardioversion	2017-12-01 05:15:49	RAS	185098166371591	9
4072	Depistage	2021-11-12 00:26:32	Outils oublier (Programmer une réintervention)	246029028617827	1
4073	Radio	2021-12-01 06:31:46	RAS	246029028617827	12
4074	Radio	2021-12-01 21:24:11	Cancer confirmé	246029028617827	11
4075	Chirurie	2016-12-01 11:00:40	RAS	246029028617827	7
4076	Infiltration	2018-10-05 15:55:40	RAS	221067001545141	1
4077	Platre	2018-10-05 11:17:58	RAS	221067001545141	1
4078	Point de suture	2018-05-01 17:54:05	Annule	200125523886081	1
4079	Depistage	2018-05-01 08:33:18	RAS	200125523886081	2
4080	Platre	2018-05-01 05:49:38	Cancer confirmé	200125523886081	1
4081	Infiltration	2016-04-22 17:34:07	RAS	200125523886081	1
4082	Chirurgie	2021-05-04 16:16:26	RAS	260094752288347	4
4083	Chirurgie	2021-04-05 07:43:14	RAS	260094752288347	3
4084	Examen	2021-05-05 02:01:36	Membre couper par erreur	260094752288347	4
4085	Depistage	2018-01-21 03:14:25	RAS	260094752288347	1
4086	Point de suture	2016-09-10 01:33:01	Membre couper par erreur	272070106053457	2
4087	Depistage	2016-09-19 11:07:48	RAS	272070106053457	2
4088	Infiltration	2021-03-15 21:55:27	Cancer confirmé	145021483919530	1
4089	Depistage	2021-12-01 14:25:59	RAS	145021483919530	2
4090	Radio	2021-12-01 18:55:26	RAS	145021483919530	1
4091	Radio	2017-05-18 19:55:01	RAS	175025581397787	1
4092	Radio	2017-05-18 20:26:36	Le patient a pris la fuite	175025581397787	1
4093	Infiltration	2017-05-18 08:38:06	RAS	175025581397787	1
4094	Point de suture	2017-05-18 19:58:03	Annule	175025581397787	2
4095	Radio	2016-04-24 10:56:57	Annule	157014415900863	11
4096	Depistage	2019-01-25 17:55:12	RAS	189058437714714	1
4097	Platre	2019-01-25 11:44:58	Membre couper par erreur	189058437714714	1
4098	Point de suture	2019-01-25 07:06:04	RAS	189058437714714	1
4099	Point de suture	2017-09-28 02:49:51	RAS	205061346129578	2
4100	Depistage	2020-09-28 14:02:15	Personelle manquant	205061346129578	2
4101	Infiltration	2021-10-13 02:54:37	Cancer confirmé	205061346129578	2
4102	Depistage	2017-09-28 23:23:01	Membre couper par erreur	205061346129578	2
4103	Point de suture	2016-01-22 12:01:15	RAS	287110819788543	1
4104	Depistage	2016-01-22 20:50:19	RAS	287110819788543	1
4105	Depistage	2018-02-21 16:38:26	RAS	287110819788543	1
4106	Depistage	2018-02-21 10:54:17	RAS	287110819788543	2
4107	Point de suture	2020-01-18 17:44:45	Cancer confirmé	230112913478191	2
4108	Platre	2020-05-28 03:39:03	RAS	230112913478191	2
4109	Point de suture	2021-01-24 15:23:10	Membre couper par erreur	194108897647962	1
4110	Depistage	2019-09-08 07:18:49	Le patient a pris la fuite	194108897647962	1
\.


--
-- Data for Name: allergies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allergies (code, niv) FROM stdin;
POLN	1
LAV	2
ARA	3
MOISI	3
POILE	4
lATEX	4
GLUTN	5
BLATE	6
BEE	7
PENIC	8
ASPIR	8
GUEPE	10
\.


--
-- Data for Name: dateentre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.dateentre (datee) FROM stdin;
2021-09-29
2020-09-09
2021-05-15
2021-10-25
2017-03-04
2019-06-14
2018-01-17
2020-08-25
2021-12-01
2015-08-27
2020-10-17
2016-09-02
2019-01-23
2021-03-10
2019-12-01
2021-10-28
2016-08-27
2016-09-03
2021-04-27
2017-04-28
2019-09-10
2021-09-23
2021-11-17
2015-06-16
2020-07-16
2021-01-15
2021-06-07
2021-11-25
2020-12-01
2021-02-27
2021-08-02
2019-05-27
2021-03-03
2020-09-10
2021-01-16
2021-07-28
2021-09-18
2017-09-06
2018-01-02
2018-04-13
2015-10-22
2015-11-12
2021-04-22
2021-11-12
2018-12-01
2020-09-14
2021-07-08
2019-02-16
2019-07-05
2018-06-12
2020-10-24
2020-11-04
2017-11-05
2021-04-24
2021-07-04
2019-11-19
2020-08-12
2017-11-26
2016-03-07
2021-07-06
2021-10-01
2021-11-01
2016-08-09
2019-07-04
2015-07-10
2015-11-27
2020-04-17
2021-04-09
2021-10-23
2019-02-07
2020-08-27
2016-05-23
2016-04-16
2017-02-02
2021-07-19
2016-05-17
2018-01-04
2020-03-16
2021-07-07
2017-03-23
2017-03-14
2017-02-05
2021-09-12
2021-10-08
2016-04-17
2020-03-27
2021-07-02
2015-01-22
2019-01-24
2020-01-26
2017-10-17
2018-01-01
2019-11-24
2018-10-10
2015-02-15
2017-06-19
2019-04-06
2020-02-13
2017-10-08
2017-07-22
2017-07-28
2016-08-28
2019-01-27
2020-02-10
2021-02-11
2017-01-13
2021-11-26
2017-05-19
2019-10-20
2021-06-27
2020-11-05
2021-10-24
2018-06-03
2020-11-17
2017-06-06
2021-11-11
2021-06-25
2018-03-26
2021-05-01
2016-09-15
2019-04-18
2020-08-20
2015-12-01
2017-04-10
2017-09-14
2015-10-03
2015-06-18
2019-02-05
2019-09-23
2021-03-24
2021-09-01
2021-04-15
2020-04-13
2020-01-14
2020-02-19
2021-05-09
2015-02-03
2015-05-10
2018-01-28
2020-04-10
2021-08-06
2017-08-09
2021-01-24
2021-07-13
2016-08-16
2019-08-22
2015-09-20
2021-11-27
2016-01-14
2016-01-05
2018-11-04
2021-05-19
2021-08-17
2020-07-12
2021-01-17
2021-11-28
2016-02-04
2020-06-02
2021-07-12
2020-10-16
2021-07-17
2019-07-24
2016-03-13
2021-03-19
2021-10-26
2017-01-25
2019-01-09
2019-08-11
2020-09-28
2016-07-28
2021-03-06
2021-11-06
2020-01-01
2020-08-19
2021-11-02
2015-08-03
2016-04-01
2016-06-23
2017-03-06
2019-11-12
2021-01-18
2021-11-24
2016-05-26
2016-09-19
2021-08-27
2019-03-03
2019-09-05
2020-07-01
2020-10-01
2017-03-02
2018-10-22
2019-01-21
2019-09-27
2016-09-11
2019-06-28
2021-09-21
2015-11-16
2015-09-19
2019-09-24
2015-04-24
2017-03-20
2016-10-20
2021-10-22
2019-02-21
2019-02-26
2018-04-12
2020-10-20
2020-10-22
2019-06-24
2021-08-14
2016-07-18
2021-03-07
2018-11-16
2015-02-20
2018-01-10
2018-03-10
2016-08-10
2021-03-05
2021-09-10
2019-01-03
2019-06-05
2019-11-06
2018-09-01
2020-09-23
2021-09-09
2015-02-21
2021-02-14
2018-02-08
2018-01-11
2021-05-11
2019-02-23
2021-03-17
2020-01-22
2021-04-08
2016-01-17
2019-08-20
2018-03-03
2015-06-10
2019-03-09
2019-04-24
2018-11-23
2019-07-18
2017-11-25
2018-05-01
2021-05-10
2019-10-12
2021-11-22
2020-09-24
2016-01-07
2016-06-20
2020-02-11
2015-07-18
2017-02-06
2017-10-05
2021-10-21
2020-10-15
2018-04-07
2020-06-27
2021-04-25
2017-04-14
2021-07-24
2021-09-27
2021-07-18
2021-09-02
2021-10-07
2017-03-24
2019-04-27
2015-02-11
2016-09-18
2017-04-08
2020-02-20
2020-03-05
2021-08-22
2017-08-19
2016-06-22
2020-07-05
2018-06-20
2021-11-16
2019-08-10
2020-05-17
2021-10-14
2017-04-19
2021-05-26
2021-09-24
2021-11-09
2017-06-13
2016-11-18
2016-12-01
2021-02-19
2016-07-10
2021-04-02
2021-05-13
2019-05-09
2019-09-02
2019-10-03
2017-02-11
2019-05-15
2016-08-20
2018-10-18
2018-07-23
2021-08-09
2016-04-08
2017-11-11
2015-01-26
2020-09-12
2016-10-26
2016-10-27
2020-03-21
2017-06-26
2017-06-27
2018-05-12
2018-09-27
2017-10-24
2021-05-02
2021-10-02
2016-10-10
2016-07-12
2021-03-18
2017-08-24
2020-10-14
2020-10-02
2021-11-08
2020-04-14
2020-06-25
2021-02-05
2021-06-01
2021-08-21
2020-07-02
2017-01-26
2019-11-11
2021-05-03
2021-11-15
2019-01-26
2019-04-26
2020-11-10
2019-03-17
2015-02-19
2020-08-23
2015-09-14
2020-07-10
2015-06-27
2015-10-07
2015-04-22
2016-09-04
2016-09-14
2018-10-08
2018-10-17
2021-05-17
2016-11-05
2019-02-10
2017-07-24
2019-05-06
2020-06-06
2021-06-18
2020-05-21
2016-01-11
2015-03-21
2015-09-13
2017-06-28
2018-06-11
2021-09-17
2020-08-11
2016-04-11
2017-03-18
2016-01-22
2021-03-15
2019-06-07
2021-02-03
2020-09-26
2021-05-23
2021-11-21
2019-09-01
2017-10-15
2019-07-22
2019-07-10
2020-10-19
2020-10-25
2018-01-24
2018-11-28
2016-03-21
2021-02-26
2018-09-03
2018-10-07
2020-05-07
2015-02-13
2021-02-15
2020-05-22
2019-01-05
2019-03-08
2017-11-27
2017-12-01
2018-05-05
2018-08-22
2018-10-26
2019-02-11
2015-03-22
2018-11-24
2021-10-03
2017-08-07
2021-04-19
2017-03-10
2021-01-19
2021-02-13
2019-08-06
2021-03-16
2018-05-13
2015-09-24
2015-10-17
2018-07-09
2015-04-28
2016-06-21
2020-03-19
2021-11-18
2015-04-14
2020-08-05
2015-03-06
2016-02-27
2017-05-16
2015-04-12
2018-07-06
2021-11-19
2021-11-23
2020-11-20
2021-06-14
2018-08-08
2019-09-25
2019-07-21
2021-11-13
2021-05-27
2017-02-08
2021-08-16
2021-10-16
2016-05-20
2016-09-22
2019-09-07
2020-08-09
2017-07-20
2019-11-10
2016-10-12
2020-08-06
2016-08-19
2019-11-26
2021-08-26
2021-09-26
2019-07-27
2020-06-13
2017-09-11
2019-03-28
2020-01-17
2016-04-22
2018-01-25
2021-05-04
2019-06-01
2020-03-02
2020-08-21
2020-01-19
2020-09-21
2018-03-22
2021-03-22
2016-06-15
2019-06-20
2020-10-11
2015-03-28
2018-02-27
2020-11-26
2018-10-19
2019-09-14
2015-04-27
2016-11-13
2019-06-12
2019-05-21
2018-08-16
2016-09-12
2016-09-16
2020-01-02
2020-05-27
2021-08-23
2018-05-16
2021-02-22
2018-09-17
2018-06-15
2019-06-16
2021-08-13
2018-08-26
2021-11-14
2015-03-02
2021-02-17
2020-06-01
2020-09-20
2021-02-21
2019-07-17
2020-06-09
2020-08-24
2016-11-17
2017-06-10
2017-09-17
2021-03-28
2019-11-17
2020-06-16
2021-01-09
2018-07-20
2018-01-12
2015-07-28
2015-04-10
2018-04-10
2019-10-22
2019-11-01
2015-06-11
2018-10-02
2020-01-18
2020-05-28
2021-10-05
2019-08-07
2020-05-08
2020-07-14
2020-11-11
2021-01-27
2020-03-09
2021-09-14
2021-10-13
2015-11-11
2015-03-18
2017-06-03
2016-08-25
2021-01-04
2015-05-12
2016-09-08
2020-06-22
2015-08-21
2019-07-20
2019-09-26
2020-07-20
2019-06-02
2019-01-07
2015-06-28
2019-05-08
2019-05-28
2020-03-06
2016-08-08
2019-01-15
2020-11-25
2018-10-14
2019-01-02
2020-11-18
2019-11-18
2020-09-06
2021-07-15
2021-08-10
2019-10-11
2020-06-08
2018-06-28
2019-09-13
2018-07-05
2020-05-09
2021-10-20
2021-10-17
2020-03-10
2021-09-07
2019-02-24
2020-01-20
2021-01-06
2019-01-04
2021-08-03
2018-10-28
2018-10-15
2018-02-04
2020-11-01
2021-01-02
2021-06-05
2019-05-12
2020-09-18
2021-04-13
2017-10-26
2020-02-25
2017-01-01
2021-01-12
2015-08-17
2016-03-08
2019-10-23
2020-09-04
2021-04-23
2016-06-14
2017-03-25
2020-01-05
2021-04-01
2017-08-11
2021-02-24
2017-08-20
2020-11-12
2020-03-25
2021-05-25
2020-11-24
2015-06-17
2018-02-22
2020-01-16
2021-05-12
2015-01-07
2017-09-13
2020-11-27
2020-10-21
2021-03-08
2018-04-15
2021-06-06
2018-08-11
2019-02-09
2016-01-21
2019-05-11
2018-02-18
2019-02-20
2015-10-14
2018-01-23
2016-02-01
2016-04-04
2021-10-10
2016-05-24
2018-04-16
2015-06-05
2020-11-16
2021-01-07
2019-01-17
2020-07-11
2020-08-26
2021-10-11
2016-01-23
2018-05-28
2019-02-18
2019-03-21
2015-04-03
2018-09-20
2016-06-24
2017-02-23
2019-06-17
2015-04-16
2021-08-11
2020-04-01
2017-05-09
2017-06-22
2016-05-25
2016-11-26
2018-02-12
2018-03-08
2018-07-21
2020-10-12
2016-08-17
2015-02-26
2015-02-02
2017-08-04
2015-08-20
2020-04-26
2015-11-05
2016-05-06
2020-08-15
2017-06-08
2016-03-23
2016-06-08
2017-06-17
2018-08-12
2020-08-18
2015-09-07
2020-04-27
2021-08-18
2016-10-06
2016-10-03
2018-08-05
2020-09-11
2017-10-13
2017-04-06
2016-11-09
2021-05-24
2018-01-19
2020-06-14
2020-11-22
2020-09-02
2015-07-17
2020-03-22
2021-06-22
2021-11-04
2015-09-02
2019-09-04
2016-08-11
2021-05-05
2015-05-27
2018-01-08
2016-06-13
2020-04-18
2016-11-02
2020-06-11
2016-05-14
2016-04-24
2017-03-12
2021-05-06
2017-08-23
2018-10-27
2020-10-23
2018-07-25
2020-06-07
2016-02-10
2018-11-19
2021-10-04
2017-05-27
2018-07-18
2016-01-02
2019-02-01
2020-10-27
2018-05-06
2016-07-09
2017-09-24
2018-03-01
2016-04-10
2017-04-25
2016-11-23
2019-08-26
2020-05-06
2019-11-13
2019-07-28
2018-01-18
2018-03-27
2021-06-28
2019-05-17
2021-05-28
2018-04-14
2018-07-10
2020-11-14
2016-06-16
2019-10-10
2018-05-17
2020-09-17
2021-06-02
2021-07-14
2021-09-11
2016-09-20
2019-03-14
2020-04-24
2017-09-21
2016-07-15
2019-11-03
2017-04-03
2021-10-18
2019-11-15
2020-06-17
2017-07-26
2018-02-23
2019-04-22
2020-05-20
2019-11-05
2019-10-24
2016-07-21
2019-03-26
2021-02-08
2017-11-12
2018-02-19
2021-01-11
2021-09-28
2018-05-02
2018-06-21
2016-02-05
2016-03-16
2021-06-19
2020-08-10
2020-10-28
2020-10-09
2016-10-19
2018-10-21
2018-11-25
2019-03-25
2019-06-09
2016-04-26
2021-07-21
2017-01-27
2020-08-16
2017-07-23
2016-10-11
2017-03-08
2020-09-15
2021-11-20
2018-08-23
2021-10-12
2017-11-13
2019-01-28
2021-06-09
2018-10-13
2017-01-12
2019-05-05
2019-07-07
2020-02-01
2019-09-21
2019-10-01
2019-10-14
2021-01-28
2020-01-04
2020-05-26
2021-09-03
2016-10-28
2021-05-08
2016-07-14
2019-09-22
2021-04-20
2018-03-28
2021-07-16
2019-08-13
2020-02-08
2015-03-10
2020-02-15
2020-09-19
2018-06-05
2019-08-02
2018-11-20
2020-04-21
2020-11-19
2018-07-01
2018-02-16
2016-07-27
2018-08-18
2015-02-08
2018-03-18
2016-05-27
2021-03-12
2018-01-13
2020-08-02
2021-06-13
2020-04-05
2015-05-20
2017-11-06
2019-10-18
2015-09-04
2021-10-19
2016-03-27
2017-05-22
2018-10-20
2020-10-08
2021-02-16
2020-03-12
2016-01-03
2017-03-19
2015-04-02
2016-06-01
2018-01-21
2018-02-07
2019-04-10
2020-08-13
2015-04-20
2019-02-25
2019-05-20
2015-10-16
2017-04-16
2015-01-10
2019-04-15
2015-10-19
2017-02-17
2017-07-11
2015-02-07
2019-03-22
2020-03-20
2020-07-24
2018-04-09
2020-03-08
2021-08-28
2019-06-13
2018-04-04
2020-01-11
2015-05-02
2017-04-24
2021-08-08
2015-08-19
2016-07-16
2018-07-24
2015-04-05
2016-02-12
2019-08-15
2015-05-07
2018-09-10
2017-09-26
2020-09-03
2018-01-03
2019-07-19
2015-05-18
2016-08-01
2017-06-09
2015-11-24
2019-04-13
2017-10-03
2019-09-28
2021-06-04
2021-08-19
2021-06-12
2017-05-03
2016-02-28
2019-02-03
2020-08-14
2021-05-14
2021-06-26
2020-08-01
2019-03-15
2020-03-23
2021-11-07
2016-07-22
2019-03-24
2021-07-10
2019-08-09
2021-08-05
2019-02-15
2018-05-27
2021-11-10
2016-07-24
2018-06-09
2020-07-06
2017-07-18
2018-05-22
2020-02-03
2018-07-28
2015-08-07
2015-09-12
2015-06-09
2019-02-22
2021-09-22
2021-11-05
2019-05-18
2016-05-16
2018-11-05
2021-04-17
2016-05-13
2017-01-05
2019-11-27
2015-01-09
2018-04-27
2015-06-14
2021-07-05
2018-06-19
2020-03-24
2016-08-07
2017-09-10
2021-04-07
2015-08-26
2020-01-13
2015-09-09
2021-08-01
2018-08-25
2021-04-21
2016-10-17
2020-09-01
2016-01-01
2019-11-25
2017-07-06
2017-09-02
2017-05-17
2021-01-26
2015-06-19
2017-01-20
2015-07-26
2018-09-05
2016-07-05
2021-09-06
2021-03-27
2021-05-16
2017-04-04
2021-04-10
2020-11-02
2017-03-11
2018-07-17
2020-04-22
2015-03-24
2016-08-04
2021-09-20
2019-04-28
2020-02-12
2017-08-17
2015-01-21
2017-05-20
2020-09-22
2016-09-07
2018-06-17
2020-07-03
2021-07-11
2017-11-20
2021-06-11
2016-05-11
2016-07-02
2020-04-08
2015-07-25
2015-04-26
2017-01-24
2018-08-13
2015-09-01
2020-06-15
2020-04-28
2020-02-18
2015-11-15
2018-10-03
2017-02-21
2018-10-06
2016-02-13
2020-06-04
2020-03-15
2018-08-20
2018-03-02
2019-11-22
2021-02-18
2021-07-26
2015-05-23
2018-09-07
2016-02-11
2021-01-25
2019-11-23
2020-05-04
2021-02-07
2016-07-23
2020-03-14
2016-07-08
2019-02-28
2020-04-12
2021-08-24
2018-09-22
2015-06-15
2019-10-16
2021-09-19
2016-05-21
2021-03-25
2021-03-26
2018-05-15
2021-03-14
2018-06-13
2020-08-28
2020-09-07
2016-07-19
2021-06-16
2020-08-22
2017-08-05
2021-08-20
2015-10-15
2018-08-24
2018-04-03
2020-01-07
2019-09-03
2017-01-18
2017-03-17
2021-03-09
2020-08-07
2016-02-22
2021-09-08
2019-10-06
2017-07-14
2017-10-25
2016-06-28
2019-07-06
2018-05-08
2020-10-10
2021-07-09
2017-09-03
2019-02-14
2018-08-14
2018-09-25
2017-06-25
2020-05-11
2020-07-07
2020-01-21
2017-04-23
2015-01-12
2021-05-07
2020-09-05
2016-04-20
2020-09-25
2019-03-02
2015-04-07
2021-08-25
2018-10-16
2018-10-25
2017-11-10
2021-07-03
2015-07-02
2018-08-09
2021-04-03
2016-11-08
2017-04-11
2017-07-08
2018-06-18
2020-11-15
2021-01-08
2016-04-13
2018-08-28
2015-06-26
2017-01-21
2018-01-26
2015-11-21
2021-08-04
2015-10-24
2021-06-08
2021-10-09
2015-08-09
2015-06-02
2018-04-26
2021-02-12
2018-02-24
2017-10-12
2020-09-13
2018-09-11
2017-07-05
2016-04-28
2018-07-15
2019-03-27
2015-02-18
2019-06-22
2019-08-01
2017-01-14
2017-06-16
2017-11-01
2018-11-03
2020-01-27
2018-11-07
2016-10-05
2019-06-08
2018-01-20
2015-11-23
2017-07-13
2016-07-13
2019-06-27
2021-10-27
2018-07-19
2016-08-05
2018-11-06
2019-05-16
2021-08-12
2015-04-04
2017-10-21
2017-06-24
2021-03-13
2015-10-06
2015-11-26
2017-05-05
2018-09-18
2019-06-23
2016-04-05
2020-10-05
2019-10-21
2020-11-06
2020-04-15
2019-01-22
2021-05-21
2019-05-03
2019-07-08
2020-09-08
2019-07-11
2019-11-28
2015-06-20
2021-02-09
2016-07-25
2015-01-20
2016-08-21
2019-03-07
2017-06-04
2021-06-20
2018-06-26
2015-02-28
2019-09-06
2021-01-14
2018-09-12
2020-11-13
2015-07-15
2021-02-20
2016-09-01
2019-09-11
2018-09-23
2021-10-06
2017-11-04
2018-04-23
2017-05-04
2018-05-24
2017-08-15
2016-06-18
2018-01-09
2015-01-11
2019-06-03
2016-01-13
2020-10-03
2021-10-15
2017-03-21
2019-02-12
2019-08-23
2020-02-27
2018-06-23
2021-11-03
2018-11-18
2020-01-15
2018-02-20
2020-02-17
2016-08-14
2019-06-04
2017-02-19
2019-01-01
2021-01-22
2019-08-18
2018-03-24
2020-05-02
2016-01-04
2021-01-13
2020-11-28
2021-03-01
2020-02-07
2020-03-01
2021-06-23
2017-01-28
2021-04-16
2021-03-20
2018-04-21
2019-08-25
2019-01-13
2021-01-10
2015-08-24
2021-01-20
2016-10-25
2017-05-02
2019-04-01
2018-02-25
2019-04-17
2015-05-22
2018-06-27
2018-06-22
2015-07-24
2017-09-08
2017-09-12
2015-05-14
2018-11-08
2019-10-28
2019-03-01
2019-01-20
2016-10-22
2021-06-24
2017-07-21
2015-09-17
2016-03-02
2021-03-21
2018-02-10
2020-06-19
2020-07-18
2017-05-18
2017-01-10
2016-10-14
2021-01-23
2017-05-10
2020-02-04
2017-09-09
2021-04-12
2017-09-19
2017-04-05
2019-06-19
2019-10-05
2020-10-07
2021-09-15
2016-11-25
2019-10-26
2018-04-02
2021-09-25
2019-04-14
2020-02-16
2021-09-05
2019-01-10
2020-03-26
2015-04-23
2018-01-14
2018-03-09
2016-03-10
2018-02-03
2019-05-01
2017-05-23
2016-05-03
2015-07-03
2019-07-25
2018-03-07
2015-06-12
2020-10-26
2015-07-12
2017-01-16
2019-02-08
2017-10-16
2020-03-18
2016-03-18
2020-04-16
2016-11-27
2015-03-08
2019-02-13
2016-03-20
2017-11-02
2017-11-18
2019-01-19
2020-02-09
2018-11-09
2015-10-26
2021-05-20
2016-01-10
2016-11-03
2017-02-26
2017-02-10
2017-07-10
2018-09-13
2021-02-04
2019-04-23
2020-06-05
2018-04-05
2017-04-18
2021-02-23
2015-07-16
2021-07-23
2019-01-18
2015-06-01
2018-09-15
2016-04-15
2017-03-28
2016-09-10
2015-11-06
2020-07-22
2015-11-02
2016-06-17
2017-11-08
2015-10-23
2015-11-07
2017-09-18
2017-04-01
2015-10-13
2016-08-26
2019-09-16
2019-09-15
2019-11-14
2018-06-08
2020-05-23
2021-02-01
2016-09-28
2019-03-12
2020-02-24
2020-03-11
2016-10-01
2019-06-06
2018-09-19
2018-08-02
2017-10-04
2017-01-09
2017-11-07
2017-05-25
2021-06-10
2015-03-01
2015-09-25
2017-05-13
2016-08-23
2017-09-05
2020-02-23
2020-02-26
2017-01-15
2017-09-16
2017-10-09
2016-08-22
2016-07-01
2020-06-10
2015-03-07
2018-02-06
2018-04-18
2020-01-10
2015-05-25
2020-01-12
2021-03-04
2018-10-24
2018-04-06
2018-04-08
2016-08-15
2017-04-07
2021-04-05
2019-11-20
2019-11-21
2016-02-07
2015-10-04
2017-03-15
2019-06-18
2020-01-23
2021-09-13
2016-08-12
2017-02-22
2017-08-26
2019-07-09
2018-06-02
2018-08-01
2016-06-02
2015-11-20
2021-03-23
2020-04-02
2016-03-14
2016-08-18
2018-08-03
2018-07-22
2019-07-16
2016-09-21
2016-10-15
2021-09-16
2019-05-10
2016-09-27
2019-10-15
2015-06-13
2018-03-13
2020-05-10
2018-02-17
2018-11-21
2018-05-23
2021-07-27
2021-04-28
2018-02-11
2016-03-22
2017-04-22
2018-09-14
2017-03-01
2016-11-11
2015-05-16
2020-05-12
2016-01-08
2019-04-12
2020-05-05
2020-04-20
2015-11-08
2020-11-21
2016-10-04
2019-07-15
2017-08-18
2019-04-16
2021-08-15
2018-11-15
2020-07-19
2019-05-19
2019-07-02
2018-06-07
2019-11-08
2020-08-04
2017-09-23
2018-07-13
2016-06-12
2018-11-11
2019-04-20
2016-04-09
2017-09-07
2020-07-23
2017-10-23
2020-08-17
2021-08-07
2018-08-21
2015-07-23
2019-05-26
2020-05-25
2016-10-09
2015-06-08
2017-01-02
2018-05-11
2020-04-19
2019-10-17
2021-01-03
2016-10-07
2015-01-16
2018-11-10
2018-03-05
2021-02-06
2020-09-16
2015-09-15
2019-05-25
2016-11-15
2015-05-06
2021-06-03
2021-05-22
2020-07-15
2018-03-20
2015-01-06
2016-01-18
2017-01-04
2020-05-03
2017-03-07
2020-11-23
2021-02-25
2021-04-11
2018-07-02
2018-06-24
2016-06-03
2017-10-18
2019-05-23
2017-03-16
2021-04-18
2016-07-17
2021-07-25
2016-02-02
2017-03-03
2021-04-26
2018-08-19
2015-07-11
2017-10-20
2018-05-20
2019-03-04
2020-05-14
2020-02-05
2020-01-06
2019-03-23
2017-11-17
2016-10-02
2020-05-18
2020-04-04
2019-04-09
2018-05-18
2016-06-25
2019-04-05
2020-04-25
2019-10-04
2020-07-09
2019-03-13
2016-11-14
2019-03-05
2020-03-07
2017-02-15
2018-04-22
2020-04-06
2020-01-28
2019-02-19
2017-07-19
2016-05-01
2017-02-16
2015-11-14
2017-05-28
2021-03-02
2019-04-19
2017-05-11
2018-07-04
2019-09-08
2018-07-03
2017-03-22
2020-04-23
2021-03-11
2018-08-06
2017-02-03
2020-04-03
2021-02-02
2015-02-27
2018-05-10
2020-02-22
2015-07-13
2019-08-05
2019-04-03
2018-09-09
2016-05-02
2019-08-24
2019-08-27
2016-07-04
2019-11-07
2019-04-04
2019-02-17
2020-05-13
2018-05-04
2020-02-02
2021-07-01
2016-03-04
2017-06-23
2017-11-19
2017-11-22
2019-07-01
2020-03-04
2017-10-28
2015-03-26
2019-04-07
2019-05-02
2015-08-12
2016-11-04
2017-10-02
2015-07-20
2018-01-22
2015-01-03
2018-02-21
2016-04-14
2018-02-28
2020-01-25
2021-06-21
2018-04-11
2021-02-28
2018-11-17
2015-08-14
2020-07-25
2016-03-06
2016-06-09
2020-06-24
2020-04-09
2015-01-28
2017-01-19
2018-07-12
2018-09-24
2017-07-15
2015-02-09
2019-02-06
2016-04-03
2020-07-08
2019-06-25
2017-09-28
2016-10-13
2020-11-09
2016-03-25
2018-03-21
2018-07-07
2015-05-21
2018-11-26
2015-05-11
2017-02-25
2017-02-24
2019-09-18
2015-11-18
2018-06-25
2019-09-20
2015-10-02
2016-01-19
2020-05-24
2015-02-14
2018-04-25
2019-08-17
2016-10-08
2015-10-27
2018-04-17
2016-02-21
2020-06-20
2016-01-25
2016-11-22
2015-02-16
2017-01-17
2015-02-01
2017-03-27
2019-08-08
2019-01-14
2021-04-14
2019-02-02
2021-07-20
2015-04-01
2016-08-02
2015-07-21
2017-08-13
2018-08-15
2017-04-09
2015-05-24
2016-03-19
2018-10-11
2020-04-11
2015-04-09
2015-04-06
2017-02-01
2015-02-17
2015-09-27
2016-11-06
2021-02-10
2017-04-26
2019-09-09
2015-08-05
2018-10-05
2015-08-08
2016-09-06
2016-01-15
2020-04-07
2019-01-25
\.


--
-- Data for Name: fichier; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fichier (nom, lien, descr, actemed) FROM stdin;
Radio_poignet_DESLACS	https://image.jimcdn.com/app/cms/image/transf/none/path/s4d31f2fccfc3b171/image/iccc64fbf1faaf445/version/1500213757/chirurgie-du-sport-fracture-poignet-toulouse-chirurgie-orthopédique-dr-rémi.jpg	Poignet bien casser comme il faut !	1
\.


--
-- Data for Name: medecinh; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medecinh (idm, nom, prenom, adresse, mdp) FROM stdin;
1	ATTIG	Leo	45 Avenue Forestiere Champs-sur-Marne	10e3f153b4de898b01f25a011520ba74
2	FOURIER	Transformer	9 Rue Du Puis Profond Paris	3d2a9e7d89b863362b9c2acd61378900
3	ISAACSON	Walter	109 Rue Du Livre Paris	9a40164cde5de879bf21dbab5d727ec6
4	HOUSE	Grégorie	22 Baker Street Princeton	a3396d7f732ba4aec72126ba575e9362
5	DE COS	Hippocrate	1 Rue Du Savoir Kos	6ef1070aaa008d1405df14b07e67f1dd
6	JOBS	Steev	2066 Crist Drive Los Altos	a4eb064bf11c923a69f12b1fbf5b45fe
7	MACRON	Emmanuel	55 Rue du Faubourg Saint-Honoré Paris	c7654fe81f545c577d821897005be4b0
8	GLUBUX	Loux	2 Base Lunaire Lune	25721d2f25c600ac7a164f92f59d84f1
9	JEAN	Alex	2 Rue des pavees Paris	49103fc76f253a2a385519966f6b57e4
10	BOROWIEC	Chloe	45 Avenue Forestiere Champs-sur-Marne	a62a1629a54602176381f52006948a89
11	CAPET	Lucile	6 Rue des vierges Marseille	8ef52acadd1bafa017ef0b501a8e92c1
12	JEAN	Alix	2 Rue des pavees Paris	923371ad7b52ce153610453b568c8ed8
\.


--
-- Data for Name: medecint; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.medecint (npro, nom, prenom, adresse) FROM stdin;
125548762	MARTIN	Luc	14 Boulevard Truf Paris
125884787	ROBERTE	Gerard	2 Rue paver Paris
264481274	GOUBIX	Julie	123 Rue de la porte Paris
157845587	SAUTIER	Sebastien	12 Villa Saint-Pierre Charenton
\.


--
-- Data for Name: passepar; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.passepar (patient, services, datee, dates) FROM stdin;
102099406908259	2	2021-09-29	2021-10-01
219099814993817	4	2020-09-09	2020-09-26
219099814993817	4	2021-05-15	2021-10-10
219099814993817	3	2021-10-25	2021-12-01
160099160424193	1	2017-03-04	2017-03-04
160099160424193	1	2019-06-14	2019-06-14
260070857162645	1	2018-01-17	2018-01-17
260070857162645	1	2020-08-25	2020-08-25
260070857162645	1	2021-12-01	2021-12-01
296060410603476	1	2015-08-27	2015-08-27
296060410603476	1	2020-10-17	2020-10-17
110075202910187	1	2016-09-02	2016-09-02
110075202910187	1	2019-01-23	2019-01-23
110075202910187	1	2021-03-10	2021-03-10
256105595097885	1	2019-12-01	2019-12-01
256105595097885	1	2021-10-28	2021-10-28
214072889800551	1	2016-08-27	2016-08-27
214072889800551	1	2016-09-03	2016-09-03
214072889800551	1	2021-04-27	2021-04-27
193012735171474	1	2017-04-28	2017-04-28
193012735171474	1	2019-09-10	2019-09-10
193012735171474	1	2019-12-01	2019-12-01
248042148685557	1	2021-09-23	2021-09-23
248042148685557	1	2021-11-17	2021-11-17
152027306574655	1	2015-06-16	2015-06-16
279061486384848	6	2020-07-16	2020-10-01
279061486384848	2	2021-01-15	2021-04-05
287073840279994	1	2021-06-07	2021-06-07
287073840279994	1	2021-11-25	2021-11-25
287073840279994	1	2021-12-01	2021-12-01
114046512153391	1	2020-12-01	2020-12-01
114046512153391	1	2021-02-27	2021-02-27
114046512153391	1	2021-08-02	2021-08-02
277092607082177	1	2019-05-27	2019-05-27
277092607082177	1	2021-03-03	2021-03-03
299072728963532	1	2021-12-01	2021-12-01
206104038258974	1	2020-09-10	2020-09-10
206104038258974	1	2021-12-01	2021-12-01
275033015197248	3	2021-01-16	2021-07-23
275033015197248	2	2021-07-28	2021-09-10
275033015197248	2	2021-09-18	2021-12-01
222124053073274	1	2017-09-06	2017-09-06
199073894063622	1	2018-01-02	2018-01-02
199073894063622	1	2018-04-13	2018-04-13
261037687526684	1	2015-10-22	2015-10-22
112017646417282	2	2015-11-12	2019-11-14
112017646417282	4	2021-04-22	2021-09-03
112017646417282	3	2021-11-12	\N
174054006457994	1	2018-12-01	2018-12-01
174054006457994	1	2020-09-14	2020-09-14
174054006457994	1	2021-07-08	2021-07-08
129096634267071	4	2018-12-01	2020-02-03
159078258577790	1	2019-02-16	2019-02-16
159078258577790	1	2019-07-05	2019-07-05
289117971785167	1	2018-06-12	2018-06-12
289117971785167	1	2020-10-24	2020-10-24
289117971785167	1	2020-11-04	2020-11-04
142101422071437	1	2017-11-05	2017-11-05
142101422071437	1	2021-04-24	2021-04-24
142101422071437	1	2021-07-04	2021-07-04
268125207178893	1	2019-11-19	2019-11-19
268125207178893	1	2020-08-12	2020-08-12
252083456811832	1	2017-11-26	2017-11-26
200047009218824	5	2016-03-07	2019-02-10
200047009218824	3	2021-07-06	2021-07-11
200047009218824	3	2021-10-01	2021-10-02
200047009218824	3	2021-11-01	2021-12-01
143019800299320	1	2016-08-09	2016-08-09
143019800299320	1	2019-07-04	2019-07-04
211074534119340	1	2015-07-10	2015-07-10
211074534119340	1	2021-12-01	2021-12-01
103125323589468	6	2015-11-27	2015-11-27
103125323589468	6	2020-04-17	2020-09-25
103125323589468	6	2021-04-09	2021-06-01
103125323589468	3	2021-10-23	2021-10-23
106087597638186	1	2019-02-07	2019-02-07
106087597638186	1	2020-08-27	2020-08-27
272058275424815	5	2016-05-23	\N
273129609433214	1	2016-04-16	2016-04-16
273129609433214	1	2017-02-02	2017-02-02
273129609433214	1	2021-07-19	2021-07-19
190103324064033	1	2016-05-17	2016-05-17
190103324064033	1	2018-01-04	2018-01-04
234097079083817	1	2020-03-16	2020-03-16
234097079083817	1	2021-07-04	2021-07-04
234097079083817	1	2021-07-07	2021-07-07
136127094573707	1	2021-12-01	2021-12-01
186117248253373	1	2017-03-23	2017-03-23
155103596746626	1	2017-03-14	2017-03-14
191039387061932	1	2017-02-05	2017-02-05
191039387061932	1	2021-09-12	2021-09-12
191039387061932	1	2021-10-08	2021-10-08
205088470224121	1	2016-04-17	2016-04-17
205088470224121	1	2020-03-27	2020-03-27
205088470224121	1	2021-07-02	2021-07-02
168084074496066	1	2015-01-22	2015-01-22
168084074496066	1	2019-01-24	2019-01-24
168084074496066	1	2020-01-26	2020-01-26
295113751469259	1	2017-10-17	2017-10-17
295113751469259	1	2018-01-01	2018-01-01
295113751469259	1	2019-11-24	2019-11-24
224076688820310	1	2018-10-10	2018-10-10
238113830884391	1	2015-02-15	2015-02-15
219023373245959	6	2017-06-19	\N
260079595038944	1	2019-04-06	2019-04-06
260079595038944	1	2019-12-01	2019-12-01
260079595038944	1	2020-02-13	2020-02-13
269017040525206	1	2017-10-08	2017-10-08
236056972976895	1	2017-07-22	2017-07-22
236056972976895	1	2017-07-28	2017-07-28
110026458507876	1	2016-08-28	2016-08-28
247127106036787	1	2019-01-27	2019-01-27
247127106036787	1	2020-02-10	2020-02-10
247127106036787	1	2021-02-11	2021-02-11
138114541205136	6	2017-01-13	2017-02-25
138114541205136	2	2021-10-01	2021-11-25
138114541205136	6	2021-11-26	2021-12-01
222038976800500	5	2017-05-19	2018-01-10
222038976800500	2	2019-10-20	2021-05-16
222038976800500	1	2021-06-27	2021-11-11
222038976800500	5	2021-12-01	2021-12-01
220061225495182	3	2020-11-05	2020-11-06
220061225495182	4	2021-10-24	\N
240033187603968	1	2019-12-01	2019-12-01
272070825829025	4	2018-06-03	2020-04-18
272070825829025	3	2020-11-17	2021-03-10
157087167057385	5	2017-06-06	2020-06-10
157087167057385	1	2020-12-01	\N
133032823100292	1	2021-11-11	2021-11-11
133032823100292	1	2021-12-01	2021-12-01
106119496166800	1	2021-06-25	2021-06-25
127115565413833	5	2018-03-26	2020-03-28
188029343169600	1	2021-08-02	2021-08-02
224064678226352	1	2021-05-01	2021-05-01
116109407794060	1	2016-09-15	2018-01-08
116109407794060	1	2019-04-18	2019-08-20
116109407794060	4	2020-08-20	\N
272039140869355	1	2015-12-01	2015-12-01
272039140869355	1	2017-04-10	2017-04-10
272039140869355	1	2017-09-14	2017-09-14
208074951895256	1	2015-10-03	2015-10-03
262015291294848	1	2015-06-18	2015-06-18
262015291294848	1	2019-02-05	2019-02-05
262015291294848	1	2019-09-23	2019-09-23
213106211666187	6	2021-03-24	2021-05-01
213106211666187	6	2021-09-01	2021-10-17
213106211666187	4	2021-12-01	2021-12-01
118087215592174	1	2021-04-15	2021-04-15
234067373357213	1	2020-04-13	2020-04-13
188045887135447	1	2020-01-14	2020-01-14
188045887135447	1	2020-02-19	2020-02-19
188045887135447	1	2021-05-09	2021-05-09
241080926692571	1	2015-02-03	2015-02-03
241080926692571	1	2015-05-10	2015-05-10
241080926692571	1	2018-01-28	2018-01-28
264097854809707	1	2020-04-10	2020-04-10
264097854809707	1	2020-12-01	2020-12-01
264097854809707	1	2021-08-06	2021-08-06
144046178449562	1	2017-08-09	2017-08-09
144046178449562	1	2021-01-24	2021-01-24
144046178449562	1	2021-07-13	2021-07-13
178111533112086	1	2016-08-16	2016-08-16
178111533112086	1	2019-08-22	2019-08-22
178111533112086	1	2019-12-01	2019-12-01
189095171291580	4	2015-09-20	2019-06-04
189095171291580	4	2021-12-01	2021-12-01
175015762007662	6	2019-09-23	2020-11-19
175015762007662	2	2021-07-02	2021-08-28
175015762007662	1	2021-11-11	2021-11-16
175015762007662	4	2021-11-27	2021-11-27
175015762007662	1	2021-12-01	2021-12-01
284053711527533	4	2016-01-14	\N
105050100550524	1	2016-01-05	2016-01-05
105050100550524	1	2020-12-01	2020-12-01
105050100550524	1	2018-11-04	2018-11-04
227064841682823	1	2021-05-19	2021-05-19
227064841682823	1	2021-08-17	2021-08-17
292109226948564	1	2020-07-12	2020-07-12
292109226948564	1	2021-01-17	2021-01-17
155095540067981	2	2021-11-27	2021-11-27
155095540067981	3	2021-11-28	\N
225125232448434	1	2016-02-04	2018-10-08
225125232448434	6	2020-06-02	2020-06-08
225125232448434	4	2021-01-17	2021-06-07
225125232448434	2	2021-07-12	\N
228088926039612	6	2020-10-16	2021-08-24
228088926039612	3	2021-12-01	2021-12-01
238070277696152	1	2021-07-17	2021-07-17
257117887417480	1	2018-12-01	2018-12-01
257117887417480	1	2019-07-24	2019-07-24
225031944898819	1	2016-03-13	2016-03-13
225031944898819	1	2021-03-19	2021-03-19
225031944898819	1	2021-10-26	2021-10-26
293079221586080	1	2017-01-25	2017-01-25
185092827286780	1	2019-01-09	2019-01-09
185092827286780	1	2019-08-11	2019-08-11
185092827286780	1	2020-09-28	2020-09-28
264043437527700	2	2016-07-28	2019-08-04
264043437527700	1	2021-03-06	2021-08-19
264043437527700	4	2021-11-06	2021-12-01
245015721956300	1	2020-01-01	2020-01-01
245015721956300	1	2020-08-19	2020-08-19
245015721956300	1	2021-11-02	2021-11-02
231046716894840	1	2015-08-03	2015-08-03
231046716894840	1	2016-04-01	2016-04-01
231046716894840	1	2016-06-23	2016-06-23
140063743131455	2	2017-03-06	2017-08-24
140063743131455	6	2019-11-12	2020-06-04
140063743131455	5	2021-01-18	2021-03-13
140063743131455	4	2021-10-25	2021-10-27
140063743131455	6	2021-10-28	2021-10-28
171022452464038	1	2021-01-15	2021-01-15
171022452464038	1	2021-11-24	2021-11-24
279097002609694	1	2016-05-26	2016-12-01
279097002609694	3	2019-08-11	2021-01-02
279097002609694	4	2021-12-01	2021-12-01
187070500246915	6	2021-12-01	2021-12-01
110122942077957	6	2016-09-19	2017-03-04
110122942077957	1	2021-08-27	\N
212072855963112	1	2018-12-01	2018-12-01
212072855963112	1	2019-03-03	2019-03-03
212072855963112	1	2019-09-05	2019-09-05
262091838145236	3	2020-07-01	2020-09-07
262091838145236	2	2020-10-01	2021-12-01
276029947381735	6	2017-03-02	2018-10-20
276029947381735	6	2018-10-22	\N
259078280957764	1	2019-01-21	2019-01-21
259078280957764	1	2019-09-27	2019-09-27
279017621953618	1	2016-09-11	2016-09-11
279017621953618	1	2019-06-28	2019-06-28
291059430428428	1	2020-12-01	2020-12-01
291059430428428	1	2021-09-21	2021-09-21
225088516583057	1	2015-11-16	2015-11-16
225088516583057	1	2021-04-09	2021-04-09
254036634248290	1	2015-09-19	2015-09-19
254036634248290	1	2019-09-24	2019-09-24
199055493956493	1	2015-04-24	2015-04-24
251044262482430	1	2017-03-20	2017-03-20
230107599623686	4	2016-10-20	2018-10-20
230107599623686	2	2021-10-22	2021-11-01
157028597172844	1	2019-02-21	2019-02-21
214072768854685	1	2019-02-26	2019-02-26
214072768854685	1	2021-12-01	2021-12-01
280026155058522	1	2018-04-12	2018-04-12
280026155058522	1	2020-10-20	2020-10-20
280026155058522	1	2020-10-22	2020-10-22
135091467058684	1	2019-06-24	2019-06-24
135091467058684	1	2021-08-14	2021-08-14
299096402146261	1	2016-07-18	2016-07-18
123079019442742	1	2021-03-07	2021-03-07
123079019442742	1	2021-07-19	2021-07-19
123079019442742	1	2021-08-27	2021-08-27
285073076628400	1	2018-11-16	2018-11-16
122076067789172	1	2015-02-20	2015-02-20
164104498311563	1	2018-01-10	2018-01-10
164104498311563	1	2018-03-10	2018-03-10
223079798264179	1	2016-08-10	2016-08-10
287128641152343	6	2021-03-05	2021-07-06
287128641152343	1	2021-09-10	2021-12-01
124064655533453	1	2019-01-03	2019-01-03
124064655533453	1	2019-06-05	2019-06-05
124064655533453	1	2019-11-06	2019-11-06
177087933217555	1	2021-10-28	2021-10-28
178083543213634	3	2018-09-01	2020-06-08
178083543213634	6	2020-09-23	2021-06-16
178083543213634	5	2021-09-09	\N
193052131885364	3	2015-02-21	2018-10-14
193052131885364	1	2021-02-14	2021-07-25
230034748673362	5	2018-02-08	2019-02-27
234081951792054	3	2018-01-11	2020-05-20
234081951792054	5	2020-10-22	2020-11-05
234081951792054	6	2021-05-11	2021-07-23
234081951792054	4	2021-12-01	2021-12-01
138021076527659	1	2019-02-23	2019-02-23
138021076527659	1	2021-03-17	2021-03-17
138021076527659	1	2021-07-19	2021-07-19
112011349625910	1	2020-01-22	2020-01-22
130110933481910	4	2015-06-16	2016-09-23
130110933481910	3	2019-09-24	2020-03-17
130110933481910	4	2021-04-08	2021-10-08
130110933481910	1	2021-12-01	2021-12-01
200036971177056	1	2016-01-17	2016-07-12
200036971177056	1	2019-08-20	2020-10-19
248026335038972	1	2018-03-03	2018-03-03
108014463737146	2	2020-12-01	2021-08-21
113087786480165	5	2015-06-10	2015-08-02
113087786480165	3	2019-03-09	\N
279045756456236	1	2019-04-24	2019-04-24
158031664828007	1	2018-11-23	2018-11-23
158031664828007	1	2019-07-18	2019-07-18
158031664828007	1	2021-11-27	2021-11-27
253107320548282	1	2017-11-25	2017-11-25
159112943567608	1	2019-02-26	2021-12-01
249024680955619	1	2018-05-01	2018-12-01
249024680955619	6	2021-05-10	2021-05-10
249024680955619	5	2021-12-01	2021-12-01
192057011550036	6	2019-10-12	2021-10-20
192057011550036	4	2021-11-22	2021-12-01
256083287261288	1	2020-09-24	2020-09-24
256083287261288	1	2021-12-01	2021-12-01
248098049506176	1	2016-01-07	2016-01-07
248098049506176	1	2016-06-20	2016-06-20
130029464135944	1	2020-02-10	2020-02-10
130029464135944	1	2020-02-11	2020-02-11
232123044977541	1	2015-07-18	2015-07-18
232123044977541	1	2017-02-06	2017-02-06
232123044977541	1	2017-11-05	2017-11-05
148074826149072	4	2017-10-05	2017-12-01
148074826149072	6	2021-11-06	2021-11-06
148074826149072	3	2021-12-01	\N
199051568162490	1	2021-12-01	2021-12-01
192091009413573	1	2019-02-16	2019-02-16
192091009413573	1	2021-03-05	2021-03-05
192091009413573	1	2021-10-21	2021-10-21
167024655249766	1	2020-10-15	2020-10-15
167024655249766	1	2020-10-17	2020-10-17
292071211633603	1	2018-04-07	2020-11-04
292071211633603	5	2021-07-12	2021-09-09
279082331012316	1	2020-06-27	2020-06-27
279082331012316	1	2021-04-25	2021-04-25
174110385863580	1	2017-04-14	2017-04-14
160017115802452	1	2021-07-24	2021-07-24
160017115802452	1	2021-09-27	2021-09-27
100043305622465	1	2021-07-18	2021-07-18
100043305622465	1	2021-09-02	2021-09-02
100043305622465	1	2021-10-07	2021-10-07
194128800296508	5	2019-03-09	2021-09-18
194128800296508	2	2021-12-01	2021-12-01
153016273510071	1	2017-03-24	2017-03-24
153016273510071	1	2021-07-02	2021-07-02
144047443721909	1	2019-04-27	2019-04-27
230073061835012	5	2015-02-11	2019-11-23
230073061835012	5	2021-09-23	\N
242060173510692	1	2016-09-18	2016-09-18
242060173510692	1	2017-04-08	2017-04-08
242060173510692	1	2020-02-20	2020-02-20
118017450826990	1	2020-03-05	2020-03-05
118017450826990	1	2021-08-22	2021-08-22
118017450826990	1	2021-11-24	2021-11-24
289048180276376	1	2017-08-19	2017-08-19
245116596868850	1	2016-06-22	2016-06-22
245116596868850	1	2020-07-05	2020-07-05
168076338524481	1	2018-06-20	2020-06-26
168076338524481	3	2021-03-05	2021-04-15
168076338524481	2	2021-11-16	2021-11-24
112059565719842	1	2019-08-10	2019-12-01
112059565719842	3	2020-05-17	2021-10-12
112059565719842	1	2021-10-14	2021-11-23
112059565719842	1	2021-12-01	2021-12-01
136076785900286	1	2017-04-19	2017-04-19
103024280047064	1	2021-05-26	2021-05-26
103024280047064	1	2021-09-24	2021-09-24
103024280047064	1	2021-11-09	2021-11-09
268075069028143	1	2017-06-13	2017-06-13
249111185011005	1	2016-11-18	2016-11-18
249111185011005	1	2016-12-01	2016-12-01
249111185011005	1	2021-02-19	2021-02-19
185059544397412	1	2016-07-10	2016-07-10
101115361637735	1	2021-04-02	2021-04-02
101115361637735	1	2021-05-13	2021-05-13
101115361637735	1	2021-05-26	2021-05-26
223064299968133	1	2019-05-09	2019-05-09
223064299968133	1	2019-09-02	2019-09-02
290030296252649	4	2019-10-03	2021-12-01
183096237207201	1	2017-02-11	2017-02-11
183096237207201	1	2019-05-15	2019-05-15
257102630986082	1	2016-08-20	2016-08-20
257102630986082	1	2018-10-18	2018-10-18
139058252403158	3	2018-07-23	2019-04-25
139058252403158	6	2021-08-09	2021-08-12
139058252403158	4	2021-09-27	2021-12-01
197092256134117	1	2016-04-08	2016-04-08
197092256134117	1	2017-11-11	2017-11-11
167073348121233	4	2015-01-26	2018-10-16
167073348121233	2	2020-09-12	2020-11-19
257084916573371	1	2016-10-26	2016-10-26
257084916573371	1	2016-10-27	2016-10-27
269064890143438	1	2020-03-21	2020-03-21
107063793494291	1	2017-06-26	2017-06-26
107063793494291	1	2017-06-27	2017-06-27
107063793494291	1	2018-05-12	2018-05-12
172057342339830	1	2018-09-27	2018-09-27
179076282691743	1	2017-10-24	2017-10-24
179076282691743	1	2021-05-02	2021-05-02
179076282691743	1	2021-10-02	2021-10-02
125053714364144	1	2015-08-03	2015-08-03
125053714364144	1	2020-10-16	2020-10-16
125053714364144	1	2021-09-21	2021-09-21
107116261245646	1	2016-10-10	2016-10-10
222095362060135	1	2016-07-12	2016-07-12
164087084249753	1	2019-09-02	2019-09-02
164087084249753	1	2021-03-18	2021-03-18
164087084249753	1	2021-05-15	2021-05-15
117126263944457	1	2017-08-24	2017-08-24
117126263944457	1	2017-11-05	2017-11-05
117126263944457	1	2020-10-14	2020-10-14
286095607481988	1	2020-10-02	2020-10-02
286095607481988	1	2021-11-08	2021-11-08
286095607481988	1	2021-11-12	2021-11-12
154100549674560	1	2015-12-01	2015-12-01
154100549674560	1	2020-04-14	2020-04-14
154100549674560	1	2020-06-25	2020-06-25
243124767698205	1	2021-02-05	2021-02-05
243124767698205	1	2021-06-01	2021-06-01
243124767698205	1	2021-08-21	2021-08-21
240055800882855	1	2015-12-01	2015-12-01
240055800882855	1	2020-07-02	2020-07-02
213114441086169	1	2017-01-26	2017-01-26
250022187467305	3	2019-11-11	2020-02-06
250022187467305	2	2021-05-03	2021-11-12
250022187467305	3	2021-11-15	2021-12-01
109039206294408	1	2019-01-26	2019-01-26
109039206294408	1	2019-04-26	2019-04-26
109039206294408	1	2020-11-10	2020-11-10
160026095111549	1	2020-12-01	2020-12-01
237012302577364	2	2019-03-17	2021-03-27
140088069682239	4	2015-02-19	2018-04-25
140088069682239	2	2020-08-23	2021-12-01
102050748294646	1	2016-12-01	2016-12-01
102050748294646	1	2015-09-14	2015-09-14
173016545039252	1	2020-07-10	2020-07-10
236010256267941	6	2016-03-07	2019-12-01
236010256267941	6	2021-12-01	2021-12-01
165011896866744	1	2015-06-27	2015-06-27
165011896866744	1	2015-10-07	2015-10-07
165011896866744	1	2017-11-05	2017-11-05
150070518841138	1	2015-04-22	2015-04-22
150070518841138	1	2016-09-04	2016-09-04
150070518841138	1	2016-09-14	2016-09-14
171115439111771	1	2017-02-11	2017-02-11
171115439111771	1	2018-10-08	2018-10-08
171115439111771	1	2018-10-17	2018-10-17
177037001185459	1	2021-05-17	2021-05-17
177037001185459	1	2021-11-22	2021-11-22
177037001185459	1	2021-12-01	2021-12-01
299080308159168	1	2016-11-05	2016-11-05
299080308159168	1	2019-02-10	2019-02-10
111069747504039	5	2017-06-06	2021-11-06
111069747504039	2	2021-12-01	2021-12-01
127103535268416	1	2017-07-24	2017-07-24
127103535268416	1	2019-05-06	2019-05-06
297028710752743	1	2020-06-06	2020-06-06
111094658103947	2	2021-06-18	2021-07-12
216063297975659	1	2019-01-24	2019-01-24
216063297975659	1	2020-05-21	2020-05-21
216063297975659	1	2021-12-01	2021-12-01
197114552893819	1	2016-01-11	2016-01-11
261095472962933	1	2015-03-21	2015-03-21
102011564442610	1	2015-09-13	2015-09-13
102011564442610	1	2017-06-28	2017-06-28
126086148657250	3	2018-06-11	2019-07-05
126086148657250	1	2021-09-17	2021-12-01
122100732156095	1	2020-08-11	2020-08-11
122100732156095	1	2021-04-27	2021-04-27
122100732156095	1	2021-12-01	2021-12-01
193091370484103	1	2019-03-03	2019-03-03
193091370484103	1	2020-12-01	2020-12-01
193091370484103	1	2021-08-17	2021-08-17
278086882390588	1	2016-04-11	2016-04-11
278086882390588	1	2017-03-18	2017-03-18
136084997092352	1	2016-01-22	2016-01-22
136084997092352	1	2016-09-19	2016-09-19
135101302110067	4	2019-06-24	2019-12-01
135101302110067	4	2021-03-15	\N
133057388336451	1	2020-12-01	2020-12-01
133057388336451	1	2021-11-26	2021-11-26
133057388336451	1	2021-12-01	2021-12-01
108038498976924	5	2019-06-07	2020-05-23
108038498976924	2	2021-02-03	2021-08-13
108038498976924	2	2021-12-01	2021-12-01
266012535044395	1	2020-09-26	2020-09-26
266012535044395	1	2021-05-23	2021-05-23
266012535044395	1	2021-11-21	2021-11-21
235081064179459	1	2019-09-01	2019-09-01
189071551347808	1	2017-10-15	2017-10-15
189071551347808	1	2019-07-22	2019-07-22
294103109740262	1	2019-07-10	2019-07-10
294103109740262	1	2020-10-19	2020-10-19
294103109740262	1	2020-10-25	2020-10-25
147110710661853	1	2018-01-24	2018-01-24
147110710661853	1	2018-11-28	2018-11-28
145077876002511	1	2016-03-21	2016-03-21
145077876002511	1	2020-01-26	2020-01-26
145077876002511	1	2021-02-26	2021-02-26
221014625770907	1	2018-09-03	2018-09-03
221014625770907	1	2018-10-07	2018-10-07
221014625770907	1	2018-12-01	2018-12-01
289077275942294	1	2020-05-07	2020-05-07
289077275942294	1	2020-10-14	2020-10-14
289077275942294	1	2020-12-01	2020-12-01
230044759876745	1	2015-02-13	2015-02-13
230044759876745	1	2021-06-27	2021-06-27
296119994996166	1	2018-01-11	2018-11-10
289045790842034	1	2021-02-15	2021-02-15
257084245336102	1	2020-05-22	2020-05-22
154034482837144	1	2019-01-05	2019-01-05
212069761197108	1	2019-03-08	2019-03-08
119034662639308	1	2017-11-27	2017-11-27
119034662639308	1	2017-12-01	2017-12-01
117097307536183	1	2018-05-05	2018-05-05
260124860732275	1	2018-08-22	2018-08-22
260124860732275	1	2020-06-25	2020-06-25
172089291557913	1	2018-10-26	2018-10-26
172089291557913	1	2019-02-11	2019-02-11
172089291557913	1	2021-09-23	2021-09-23
224129352103655	6	2015-03-22	2018-10-27
224129352103655	5	2018-11-24	2019-07-23
224129352103655	3	2021-10-03	2021-12-01
186035821684512	6	2018-02-08	\N
282116367172719	1	2017-08-07	2017-08-07
282116367172719	1	2021-04-19	2021-04-19
207076163837556	1	2017-03-10	2017-03-10
207076163837556	1	2021-01-19	2021-01-19
207076163837556	1	2021-02-13	2021-02-13
298063513226885	1	2019-08-06	2019-08-06
298063513226885	1	2021-03-16	2021-03-16
213056577719720	1	2018-05-13	2018-05-13
213056577719720	1	2019-12-01	2019-12-01
257126563480430	1	2015-09-24	2015-09-24
257126563480430	1	2018-06-20	2018-06-20
161066859251464	1	2015-10-17	2015-10-17
161066859251464	1	2016-10-26	2016-10-26
161066859251464	1	2018-07-09	2018-07-09
227101652934764	1	2015-04-28	2015-04-28
227101652934764	1	2016-06-21	2016-06-21
255066466547116	5	2020-03-19	2021-04-10
255066466547116	5	2021-05-10	2021-08-27
255066466547116	4	2021-11-18	\N
117031740249272	5	2015-04-14	2017-07-17
117031740249272	4	2020-08-05	2020-11-01
117031740249272	3	2020-12-01	2020-12-01
117031740249272	6	2021-12-01	\N
281027462517127	1	2015-03-06	2015-03-06
281027462517127	1	2016-02-27	2016-02-27
281027462517127	1	2017-05-16	2017-05-16
195098864552439	4	2015-04-12	2015-09-21
195098864552439	6	2018-07-06	2021-04-27
195098864552439	4	2021-11-19	2021-11-20
195098864552439	6	2021-11-23	2021-11-26
195098864552439	5	2021-11-28	\N
139077210843596	4	2018-12-01	2020-05-12
139077210843596	6	2021-10-25	2021-11-11
139077210843596	2	2021-12-01	2021-12-01
248015103890538	1	2021-12-01	2021-12-01
238051213766800	1	2020-11-20	2020-11-20
238051213766800	1	2021-06-14	2021-06-14
238051213766800	1	2021-12-01	2021-12-01
180014450742418	1	2018-08-08	2018-08-08
282103173173307	3	2019-09-25	\N
130032128540230	1	2021-03-07	2021-03-07
130032128540230	1	2021-12-01	2021-12-01
160081840144512	6	2016-12-01	2018-07-17
160081840144512	5	2019-07-21	2021-12-01
282093945534106	4	2021-11-13	2021-12-01
185086534132201	4	2017-04-14	\N
294041736505100	3	2019-04-06	\N
160113579531989	1	2021-05-27	2021-05-27
160113579531989	1	2021-12-01	2021-12-01
204025670523878	4	2017-02-08	2020-06-22
204025670523878	2	2021-08-16	2021-08-25
204025670523878	4	2021-10-16	\N
269032951239687	1	2016-05-20	2016-05-20
269032951239687	1	2016-09-22	2016-09-22
107087128682443	1	2019-09-07	2019-09-07
107087128682443	1	2020-08-09	2020-08-09
289106989656446	1	2017-07-20	2017-07-20
289106989656446	1	2019-11-10	2019-11-10
289106989656446	1	2020-06-06	2020-06-06
116100226032930	1	2016-10-12	2016-10-12
116100226032930	1	2020-08-06	2020-08-06
126029294716045	1	2016-08-19	2016-08-19
126029294716045	1	2019-11-26	2019-11-26
259056721582059	6	2016-08-28	2016-12-01
259056721582059	4	2021-08-26	2021-09-19
259056721582059	2	2021-09-26	2021-12-01
296078344435443	4	2016-10-20	2019-08-07
296078344435443	3	2021-11-12	2021-12-01
275101635834500	1	2019-07-27	2019-07-27
275101635834500	1	2020-06-13	2020-06-13
275101635834500	1	2020-12-01	2020-12-01
253097588009331	1	2017-09-11	2017-09-11
173115356247302	1	2016-01-14	2016-01-14
173115356247302	1	2019-12-01	2019-12-01
173115356247302	1	2021-07-24	2021-07-24
196104695126094	1	2019-03-28	2019-03-28
196104695126094	1	2020-01-17	2020-01-17
104084767796763	1	2016-04-22	2016-04-22
104084767796763	1	2018-01-25	2018-01-25
173069866743140	1	2019-08-20	2019-08-20
173069866743140	1	2021-05-04	2021-05-04
104038552688549	1	2019-06-01	2019-06-01
104038552688549	1	2020-03-02	2020-03-02
104038552688549	1	2020-08-21	2020-08-21
176026748099490	1	2020-01-19	2020-01-19
176026748099490	1	2020-09-21	2020-09-21
176026748099490	1	2020-12-01	2020-12-01
103117548023800	1	2018-03-22	2018-03-22
148109232252267	1	2021-03-22	2021-03-22
194069349220315	1	2016-06-15	2016-06-15
126095603806820	1	2019-01-09	2019-01-09
126095603806820	1	2019-06-20	2019-06-20
126095603806820	1	2020-10-11	2020-10-11
268125032408842	1	2015-03-28	2015-03-28
268125032408842	1	2021-05-15	2021-05-15
268125032408842	1	2021-09-26	2021-09-26
140123122489282	1	2018-02-27	2018-02-27
140123122489282	1	2020-11-26	2020-11-26
140123122489282	1	2018-10-19	2018-10-19
255125446859673	5	2019-09-14	\N
230081205171029	6	2021-10-14	2021-10-26
196072465567305	1	2015-04-27	2015-04-27
196072465567305	1	2016-11-13	2016-11-13
271094924607285	1	2019-06-12	2019-06-12
132084756535784	1	2018-10-19	2018-10-19
132084756535784	1	2019-05-21	2019-05-21
196100412822638	1	2020-05-17	2020-05-17
297013402217591	1	2015-01-22	2015-01-22
297013402217591	1	2018-08-16	2018-08-16
206088289892884	1	2016-09-12	2016-09-12
220122235099677	1	2021-03-22	2021-03-22
220122235099677	1	2021-05-19	2021-05-19
173096580101586	1	2016-09-16	2016-09-16
173096580101586	1	2021-10-28	2021-10-28
282046629787403	1	2020-01-02	2020-01-02
231060729971548	6	2020-05-27	2021-07-06
231060729971548	2	2021-08-23	2021-08-25
261043349444673	1	2018-05-16	2018-05-16
261043349444673	1	2021-02-22	2021-02-22
115012156909773	1	2019-02-05	2019-11-27
115012156909773	2	2019-12-01	2021-11-08
115012156909773	2	2021-12-01	\N
261038771759746	1	2018-09-17	2018-09-17
131107626638488	1	2018-06-15	2018-06-15
251127256365773	1	2019-06-16	2019-06-16
251127256365773	1	2021-03-15	2021-03-15
267125703711841	3	2021-08-13	2021-11-09
267125703711841	3	2021-12-01	2021-12-01
263084417717835	1	2021-08-27	2021-08-27
244078512056467	1	2018-08-26	2021-09-17
244078512056467	3	2021-11-14	2021-11-27
244078512056467	2	2021-12-01	2021-12-01
218120988164777	1	2015-03-02	2015-03-02
218120988164777	1	2019-06-14	2019-06-14
218120988164777	1	2020-12-01	2020-12-01
257095588726569	1	2021-02-17	2021-02-17
257095588726569	1	2021-12-01	2021-12-01
166065352240321	5	2020-06-01	2020-08-24
166065352240321	3	2020-09-20	2021-02-07
166065352240321	1	2021-02-21	\N
194012458189138	1	2019-07-17	2019-07-17
194012458189138	1	2020-06-09	2020-06-09
194012458189138	1	2020-08-24	2020-08-24
247031441605135	1	2016-11-17	2016-11-17
247031441605135	1	2017-06-10	2017-06-10
270125888665229	1	2017-09-17	2017-12-01
270125888665229	5	2021-03-28	2021-10-11
158059952001652	1	2019-11-17	2019-11-17
158059952001652	1	2020-06-16	2020-06-16
158059952001652	1	2021-01-09	2021-01-09
259026635921108	1	2021-12-01	2021-12-01
222066223450293	1	2016-11-18	2016-11-18
222066223450293	1	2018-07-20	2018-07-20
294035173348892	1	2018-01-12	2018-01-12
185012960779831	5	2015-07-28	2020-08-01
272017325071928	2	2015-04-10	\N
226039430004407	1	2018-04-10	2018-04-10
226039430004407	1	2019-10-22	2019-10-22
200070224267018	1	2019-08-06	2019-08-06
200070224267018	1	2019-11-01	2019-11-01
290078809746561	1	2015-06-11	2015-06-11
290078809746561	1	2018-10-02	2018-10-02
184054997914403	6	2020-01-18	2021-03-21
231095254215790	1	2018-06-11	2018-06-11
231095254215790	1	2020-05-28	2020-05-28
224036658465337	3	2016-12-01	2020-07-20
224036658465337	3	2021-10-05	2021-10-16
224036658465337	2	2021-10-23	2021-11-19
224036658465337	5	2021-11-27	\N
204063744707638	1	2019-08-07	2019-08-07
204063744707638	1	2020-05-08	2020-05-08
204063744707638	1	2020-07-14	2020-07-14
133077951509022	1	2020-11-11	2020-11-11
279068550131477	1	2021-01-27	2021-01-27
140021429173584	6	2020-03-09	2021-01-15
140021429173584	1	2021-04-25	2021-10-04
140021429173584	4	2021-11-08	2021-12-01
116087933558285	1	2021-09-14	2021-09-14
116087933558285	1	2021-10-13	2021-10-13
184042816040471	1	2015-11-11	2015-11-11
184042816040471	1	2015-11-16	2015-11-16
184042816040471	1	2017-12-01	2017-12-01
262065796255647	6	2015-03-18	2017-01-06
262065796255647	3	2017-06-03	2020-12-01
262065796255647	6	2021-05-10	2021-06-05
262065796255647	4	2021-11-14	2021-12-01
289116874121144	1	2016-08-25	2016-08-25
289116874121144	1	2021-01-04	2021-01-04
289116874121144	1	2021-05-03	2021-05-03
242112406964207	1	2015-05-12	2015-05-12
254043611144658	1	2016-09-08	2016-09-08
268031648794265	1	2020-06-22	2020-06-22
173100893513653	1	2015-08-21	2015-08-21
173100893513653	1	2019-07-20	2019-07-20
287059122651264	1	2018-12-01	2018-12-01
298073164942612	3	2019-09-26	\N
131121957283294	1	2020-07-20	2020-07-20
188110658741765	1	2019-09-10	2019-09-10
112048414030269	1	2015-02-13	2015-02-13
172057142211349	1	2019-06-02	2019-06-02
247081496882220	4	2019-01-07	2020-01-20
247081496882220	5	2021-11-12	\N
295057117847588	1	2015-06-28	2015-06-28
295057117847588	1	2020-12-01	2020-12-01
106029864328731	1	2019-05-08	2019-05-08
106029864328731	1	2019-05-28	2019-05-28
106029864328731	1	2020-03-06	2020-03-06
297077289777229	1	2016-08-08	2016-08-08
297077289777229	1	2019-01-15	2019-01-15
297077289777229	1	2020-11-25	2020-11-25
157092099718462	1	2018-02-27	2018-02-27
157092099718462	1	2019-04-24	2019-04-24
117017034544064	5	2018-10-14	2018-10-18
134040655044942	1	2019-01-02	2019-01-02
134040655044942	1	2019-12-01	2019-12-01
166012754054480	1	2020-06-16	2020-10-06
166012754054480	4	2020-11-18	2021-06-15
166012754054480	1	2021-11-02	2021-11-21
166012754054480	5	2021-12-01	2021-12-01
159099939848446	1	2019-11-18	2019-11-18
111129599402824	1	2020-09-06	2020-09-06
111129599402824	1	2021-07-15	2021-07-15
111129599402824	1	2021-08-10	2021-08-10
180080247750688	1	2019-10-11	2019-10-11
180080247750688	1	2019-11-06	2019-11-06
180080247750688	1	2020-06-08	2020-06-08
115120226939995	1	2018-06-28	2018-12-01
115120226939995	2	2019-09-13	2021-12-01
178108944503402	1	2018-07-05	2018-07-05
178108944503402	1	2020-05-09	2020-05-09
178108944503402	1	2021-03-18	2021-03-18
159059689722694	5	2021-10-20	2021-12-01
179036643060955	1	2021-10-17	2021-10-17
179036643060955	1	2021-10-26	2021-10-26
261023956555783	1	2016-01-14	2016-01-14
261023956555783	1	2020-03-10	2020-03-10
235061978907881	1	2021-09-07	2021-09-07
160076989558266	1	2019-02-24	2019-02-24
237044696201755	1	2020-01-20	2020-12-01
237044696201755	2	2021-01-06	2021-06-05
147087143819012	1	2019-01-04	2019-01-04
147087143819012	1	2020-06-02	2020-06-02
147087143819012	1	2021-08-03	2021-08-03
177040491302245	1	2018-10-28	2018-10-28
181026482885579	1	2018-10-15	2018-10-15
181026482885579	1	2021-11-12	2021-11-12
129073106456222	1	2018-02-04	2018-02-04
241090757336013	1	2020-11-01	2020-11-01
171110762807449	5	2018-01-28	2020-03-17
171110762807449	4	2020-11-04	2020-12-01
171110762807449	1	2021-01-02	2021-04-08
171110762807449	4	2021-06-05	\N
132105298375429	1	2019-05-12	2019-05-12
277093701187718	3	2020-09-18	2020-09-21
277093701187718	4	2021-08-03	2021-12-01
233024779652808	1	2016-12-01	2016-12-01
233024779652808	1	2021-04-13	2021-04-13
299090800746875	2	2017-10-26	2019-02-07
299090800746875	2	2020-02-25	2020-08-19
299090800746875	3	2021-02-22	2021-06-07
158129815961864	1	2017-01-01	2017-01-01
186033471783730	1	2021-01-12	2021-08-19
186033471783730	1	2021-12-01	2021-12-01
124065145979904	1	2015-08-17	2015-08-17
124065145979904	1	2016-03-08	2016-03-08
249013256140217	1	2016-08-25	2016-08-25
249013256140217	1	2019-10-23	2019-10-23
193118595042552	1	2017-12-01	2017-12-01
193118595042552	1	2020-09-04	2020-09-04
159081311543565	4	2021-04-23	2021-04-26
173038729083641	5	2016-06-14	2016-12-01
173038729083641	1	2018-06-11	2019-12-01
173038729083641	2	2021-04-22	2021-11-05
173038729083641	3	2021-11-15	2021-11-17
173038729083641	4	2021-12-01	\N
125025454240765	3	2017-03-25	2018-12-01
221074080373957	1	2020-01-05	2020-01-05
221074080373957	1	2021-04-01	2021-04-01
158060447338923	3	2017-08-11	2017-12-01
158060447338923	6	2021-02-24	2021-07-20
158060447338923	2	2021-08-06	2021-12-01
191129347920866	6	2017-08-20	2021-11-23
191129347920866	4	2021-12-01	2021-12-01
146033753292561	1	2020-11-12	2020-11-12
235048088880828	4	2020-03-25	2021-12-01
232076673853214	1	2021-05-25	2021-05-25
286090186822302	1	2020-11-24	2020-11-24
286090186822302	1	2020-12-01	2020-12-01
118091053967656	1	2015-06-17	2015-06-17
118091053967656	1	2018-02-22	2018-02-22
178068445869714	1	2020-01-16	2020-01-16
178068445869714	1	2020-09-21	2020-09-21
178068445869714	1	2021-05-12	2021-05-12
158102532502789	1	2020-12-01	2020-12-01
158102532502789	1	2015-01-07	2015-01-07
234042453907063	1	2017-09-13	2017-09-13
234042453907063	1	2020-11-27	2020-11-27
174108510634221	1	2019-11-01	2019-11-01
174108510634221	1	2020-10-21	2020-10-21
106024732204736	1	2021-03-08	2021-03-08
106024732204736	1	2021-11-06	2021-11-06
106024732204736	1	2021-11-09	2021-11-09
210082757893566	4	2018-04-15	2019-11-15
210082757893566	6	2021-06-06	2021-12-01
274074214651338	1	2018-08-11	2018-08-11
274074214651338	1	2019-02-09	2019-02-09
213049451577031	5	2021-01-12	2021-10-01
110117968136108	1	2016-01-21	2017-03-17
110117968136108	5	2019-05-11	2019-08-08
110117968136108	3	2021-03-16	2021-12-01
165121074783476	1	2017-12-01	2017-12-01
165121074783476	1	2018-02-18	2018-02-18
165121074783476	1	2019-02-20	2019-02-20
285020199679212	1	2015-10-14	2015-10-14
153094524936207	1	2018-01-23	2018-01-23
132049184273634	1	2016-02-01	2016-02-01
132049184273634	1	2016-04-04	2016-04-04
276037987247044	1	2017-06-28	2017-06-28
276037987247044	1	2021-10-10	2021-10-10
228106833603672	1	2016-05-24	2016-05-24
242105257964173	1	2018-04-16	2018-04-16
138014247515067	1	2015-06-05	2015-06-05
173064457870768	1	2020-11-16	2020-11-16
173064457870768	1	2021-01-07	2021-01-07
173064457870768	1	2021-01-17	2021-01-17
208025327926752	1	2019-01-17	2019-01-17
208025327926752	1	2020-07-11	2020-07-11
208025327926752	1	2020-08-26	2020-08-26
200121336505714	1	2021-02-05	2021-02-05
200121336505714	1	2021-10-11	2021-10-11
150066519299853	4	2020-01-19	2021-03-24
150066519299853	5	2021-08-09	\N
230101267074777	1	2016-01-23	2016-01-23
249032164220679	1	2018-05-28	2018-05-28
249032164220679	1	2019-10-22	2019-10-22
128032363278916	4	2019-02-18	2019-08-13
128032363278916	5	2021-10-25	2021-12-01
220097402246683	4	2019-03-21	2021-06-09
220097402246683	1	2021-09-27	2021-10-08
220097402246683	5	2021-12-01	2021-12-01
124080612389525	1	2015-04-03	2019-07-21
124080612389525	5	2020-02-25	\N
210054779062612	1	2019-12-01	2019-12-01
231077978618248	1	2018-09-20	2018-09-20
231077978618248	1	2021-02-17	2021-02-17
111087875486253	1	2016-06-24	2016-06-24
111087875486253	1	2020-08-12	2020-08-12
145093359860917	1	2017-02-23	2017-02-23
264057206314352	1	2019-06-17	2019-06-17
288115135986478	1	2015-04-16	2015-04-16
288115135986478	1	2021-08-11	2021-08-11
231076141443908	1	2020-04-01	2020-04-01
108039523482436	1	2015-03-22	2015-03-22
139037968769029	1	2017-05-09	2017-05-09
139037968769029	1	2017-06-22	2017-06-22
111020282740019	1	2016-05-25	2016-05-25
188049194998024	1	2016-11-26	2016-11-26
188049194998024	1	2018-02-12	2018-02-12
188049194998024	1	2018-03-08	2018-03-08
258065169240672	1	2018-07-21	2018-07-21
258065169240672	1	2020-10-12	2020-10-12
258065169240672	1	2021-08-21	2021-08-21
232129815038482	1	2016-08-17	2016-08-17
232129815038482	1	2018-05-16	2018-05-16
232129815038482	1	2020-01-14	2020-01-14
145093900289545	1	2018-01-25	2020-07-09
145093900289545	1	2020-09-10	\N
267121440433418	1	2015-02-26	2015-02-26
267121440433418	1	2015-04-14	2015-04-14
227015778432519	4	2015-02-02	2016-05-20
227015778432519	4	2017-08-04	\N
192048701289850	1	2021-09-21	2021-09-21
142077321716367	5	2015-08-20	2015-10-08
142077321716367	1	2020-04-26	\N
286055345126560	1	2015-11-05	2015-11-05
200021889427908	4	2016-05-06	2020-04-05
200021889427908	1	2020-08-15	2021-03-15
200021889427908	6	2021-12-01	\N
199129081130353	1	2017-02-06	2017-02-06
199129081130353	1	2017-06-08	2017-06-08
243121776162227	1	2016-03-23	2016-03-23
243121776162227	1	2016-06-08	2016-06-08
243121776162227	1	2017-06-17	2017-06-17
259114157338055	1	2018-08-12	2018-08-12
259114157338055	1	2020-08-18	2020-08-18
262105941528540	1	2015-09-07	2015-09-07
262105941528540	1	2020-04-27	2020-04-27
262105941528540	1	2021-08-18	2021-08-18
109028760703504	1	2016-10-06	2020-10-13
109028760703504	5	2021-02-13	2021-09-11
109028760703504	1	2021-11-06	\N
111061695359540	3	2016-10-03	2018-10-26
111061695359540	4	2020-09-04	2021-10-19
104113276019870	1	2018-08-05	2018-11-24
104113276019870	1	2020-09-11	2020-12-01
283023385915710	1	2017-10-13	2017-10-13
283023385915710	1	2020-06-22	2020-06-22
245093190848672	2	2019-03-17	2021-09-22
204069532268616	2	2017-04-06	2018-09-19
204069532268616	2	2020-11-04	2021-11-10
204069532268616	6	2021-12-01	2021-12-01
266125761809637	6	2016-11-09	2021-04-15
266125761809637	5	2021-05-24	2021-07-26
266125761809637	4	2021-11-16	2021-12-01
179043377875534	1	2018-01-19	2018-01-19
179043377875534	1	2020-06-08	2020-06-08
179043377875534	1	2021-05-10	2021-05-10
112012210565675	4	2019-09-14	\N
235043385743272	6	2020-06-14	2020-11-11
235043385743272	1	2020-11-22	2020-12-01
279090179414274	1	2016-12-01	2016-12-01
279090179414274	1	2020-09-02	2020-09-02
160121447322029	1	2015-07-17	2015-07-17
113013415022913	1	2020-03-22	2020-03-22
113013415022913	1	2021-06-22	2021-06-22
113013415022913	1	2021-11-04	2021-11-04
265027129877746	1	2015-09-02	2015-09-02
265027129877746	1	2019-09-04	2019-09-04
297052200312957	2	2019-06-28	2020-01-17
297052200312957	6	2021-12-01	2021-12-01
122014663436309	1	2017-04-14	2017-04-14
129038681181682	1	2016-08-11	2016-08-11
129038681181682	1	2021-05-05	2021-05-05
129038681181682	1	2021-08-06	2021-08-06
134020806670324	1	2017-12-01	2017-12-01
187012554792695	1	2015-05-27	2015-05-27
187012554792695	1	2019-10-20	2019-10-20
180059188878011	1	2018-01-08	2018-01-08
297125523160096	1	2018-05-16	2018-05-16
265029036567340	5	2016-06-13	2017-01-21
265029036567340	2	2021-03-05	2021-07-12
265029036567340	1	2021-12-01	2021-12-01
261121983306746	1	2020-04-18	2020-04-18
261121983306746	1	2021-05-24	2021-05-24
261121983306746	1	2021-08-21	2021-08-21
250104194589654	2	2016-11-02	2017-02-19
250104194589654	5	2020-06-11	2021-07-09
250104194589654	2	2021-11-19	2021-12-01
106061220442334	1	2016-05-14	2016-05-14
235045565580018	1	2016-04-24	2016-04-24
126078707125125	1	2017-03-12	2017-03-12
138016532409883	1	2021-05-06	2021-05-06
138016532409883	1	2021-05-11	2021-05-11
202065667224500	1	2016-10-03	2016-11-08
202065667224500	5	2016-12-01	2021-07-28
202065667224500	4	2021-12-01	\N
279028648982730	1	2017-08-23	2017-08-23
279028648982730	1	2017-12-01	2017-12-01
167079831709246	1	2018-10-27	2018-10-27
167079831709246	1	2021-11-06	2021-11-06
119040594612771	1	2016-12-01	2016-12-01
119123584674924	1	2019-04-06	2019-04-06
111093957436571	1	2020-10-23	2020-10-23
138117414994632	1	2018-07-25	2018-07-25
138117414994632	1	2021-12-01	2021-12-01
108095378165916	5	2020-06-07	2020-10-07
108095378165916	6	2020-11-22	2021-06-08
108095378165916	4	2021-12-01	2021-12-01
168127697496623	4	2016-02-10	2018-07-25
168127697496623	6	2018-11-19	2021-07-25
168127697496623	4	2021-10-04	2021-12-01
106013559184560	1	2017-05-27	2017-05-27
184058380356337	4	2018-07-18	2021-05-16
184058380356337	1	2021-12-01	2021-12-01
198076664451368	1	2016-01-02	2016-01-02
258048082897406	1	2018-01-10	2019-10-14
258048082897406	6	2020-06-01	\N
231126440314564	2	2019-02-01	2021-02-22
231126440314564	5	2021-08-26	2021-09-21
138012682483624	4	2020-10-27	\N
204086878297454	1	2018-05-06	2018-05-06
283093646958657	1	2020-06-11	2020-06-11
283093646958657	1	2021-11-18	2021-11-18
271061263635761	5	2016-07-09	2017-05-01
271061263635761	4	2021-10-21	2021-12-01
105118896795057	1	2017-09-24	2017-09-24
105118896795057	1	2017-10-17	2017-10-17
105118896795057	1	2018-03-01	2018-03-01
102105813093180	3	2016-12-01	\N
237017905332326	1	2016-12-01	2019-09-18
237017905332326	1	2020-08-21	2021-04-05
237017905332326	4	2021-05-26	2021-06-18
118077056581811	2	2016-04-10	2021-01-03
118077056581811	3	2021-06-14	2021-12-01
263034571304887	1	2016-09-22	2016-09-22
208044768997360	1	2019-11-19	2019-11-19
122079075675007	1	2021-03-28	2021-03-28
122079075675007	1	2021-05-10	2021-05-10
282129387212331	6	2018-08-22	2021-07-18
282129387212331	1	2021-12-01	2021-12-01
115026863697543	1	2017-04-25	2017-04-25
115026863697543	1	2021-10-13	2021-10-13
115026863697543	1	2021-12-01	2021-12-01
220026006410436	6	2017-01-25	2020-06-11
220026006410436	1	2021-07-18	\N
167044562347780	1	2016-11-23	2016-11-23
167044562347780	1	2019-08-26	2019-08-26
167044562347780	1	2020-02-10	2020-02-10
299037133754616	1	2020-02-11	2020-02-11
299037133754616	1	2020-05-06	2020-05-06
103031465371271	1	2019-11-13	2019-11-13
103031465371271	1	2020-12-01	2020-12-01
104058028163037	1	2018-12-01	2018-12-01
104058028163037	1	2021-07-12	2021-07-12
104058028163037	1	2021-08-23	2021-08-23
240055854166975	1	2019-02-11	2019-02-11
117037132207874	1	2019-07-28	2019-07-28
201045792556159	1	2021-01-24	2021-01-24
247076680160492	1	2018-01-18	2018-01-18
247076680160492	1	2018-03-27	2018-03-27
182106998943886	4	2021-06-28	\N
228021921390634	4	2017-11-11	2018-06-17
228021921390634	1	2019-05-17	2019-12-01
228021921390634	6	2020-12-01	\N
287096364247345	1	2021-10-21	2021-10-21
287096364247345	1	2021-11-24	2021-11-24
205021808810249	1	2021-05-28	2021-05-28
266118269787392	1	2017-02-02	2017-02-02
266118269787392	1	2018-04-14	2018-04-14
266118269787392	1	2018-07-10	2018-07-10
184122205851230	6	2020-11-14	2020-11-14
184122205851230	6	2020-12-01	2021-06-07
184122205851230	1	2021-12-01	2021-12-01
122079030744910	5	2016-06-16	2018-08-27
122079030744910	2	2021-10-03	\N
224110767613876	1	2018-12-01	2018-12-01
224110767613876	1	2019-10-10	2019-10-10
241037377974214	1	2018-05-17	2018-05-17
241037377974214	1	2020-12-01	2020-12-01
108092681347765	3	2020-09-17	2020-10-01
108092681347765	6	2021-09-24	\N
280018349144984	4	2021-06-02	2021-12-01
196057096921758	1	2020-01-26	\N
194011513570806	1	2021-07-14	2021-07-14
194011513570806	1	2021-09-11	2021-09-11
194011513570806	1	2021-12-01	2021-12-01
259035687657778	1	2016-09-20	2018-04-06
259035687657778	1	2019-03-14	\N
126057880251485	1	2020-04-24	2021-07-05
126057880251485	2	2021-10-07	2021-11-23
126057880251485	2	2021-11-28	2021-11-28
126057880251485	2	2021-12-01	2021-12-01
199093654141463	1	2017-08-07	2017-08-07
103069351144655	1	2017-09-21	2017-09-21
124112836245324	1	2016-07-15	2016-07-15
124112836245324	1	2018-09-17	2018-09-17
196053106233543	3	2021-04-13	2021-08-20
196053106233543	2	2021-12-01	2021-12-01
262111043702672	4	2019-11-03	2021-08-04
262111043702672	1	2021-09-12	2021-11-24
262111043702672	6	2021-12-01	2021-12-01
197072095070400	1	2017-04-03	2017-04-03
197072095070400	1	2018-07-25	2018-07-25
197072095070400	1	2019-03-28	2019-03-28
257093009218404	1	2018-04-07	2021-06-05
257093009218404	3	2021-10-18	2021-12-01
203066369133626	1	2019-11-15	2020-03-03
203066369133626	1	2020-06-17	2020-09-28
111035950431815	1	2017-07-26	2017-07-26
263125259436378	1	2018-02-23	2018-02-23
263125259436378	1	2019-04-22	2019-04-22
263125259436378	1	2020-05-20	2020-05-20
134017162187334	1	2019-11-05	2019-11-05
134017162187334	1	2019-12-01	2019-12-01
168030986226722	1	2019-10-24	2019-10-24
168021202642226	1	2020-07-10	2020-07-10
168021202642226	1	2020-08-20	2020-08-20
201079687531493	6	2016-07-21	2017-01-17
201079687531493	5	2021-04-25	2021-11-18
201079687531493	6	2021-11-26	2021-12-01
172083246489015	2	2021-08-13	2021-11-10
172083246489015	4	2021-11-22	2021-11-25
172083246489015	1	2021-11-27	2021-11-27
172083246489015	2	2021-12-01	2021-12-01
238058887249971	1	2019-03-26	2019-09-21
238058887249971	2	2021-02-08	2021-10-07
238058887249971	4	2021-12-01	2021-12-01
182121313633004	1	2017-11-12	2017-11-12
158024695395585	1	2016-12-01	2016-12-01
158024695395585	1	2018-02-12	2018-02-12
143019130446016	1	2021-08-23	2021-08-23
143019130446016	1	2021-11-18	2021-11-18
143019130446016	1	2021-12-01	2021-12-01
232091464781612	1	2018-12-01	2018-12-01
119054090697465	1	2017-12-01	2017-12-01
286096550018864	3	2018-02-19	2019-03-13
286096550018864	2	2021-01-11	2021-06-06
286096550018864	4	2021-09-07	2021-09-25
286096550018864	2	2021-09-28	2021-09-28
286096550018864	2	2021-10-14	\N
224103773518604	5	2017-03-23	2021-06-16
224103773518604	3	2021-12-01	2021-12-01
187076588240535	1	2018-05-02	2018-05-02
187076588240535	1	2018-06-21	2018-06-21
111117128024918	1	2016-02-05	2016-02-05
111117128024918	1	2017-05-16	2017-05-16
195039141611720	5	2016-03-16	2016-06-01
195039141611720	1	2021-08-16	2021-08-25
195039141611720	1	2021-11-04	2021-11-24
195039141611720	2	2021-12-01	2021-12-01
110079463566681	5	2020-07-10	2021-01-15
110079463566681	2	2021-06-19	2021-12-01
146038235197769	2	2020-08-10	2021-05-13
146038235197769	3	2021-06-28	2021-12-01
277056664098252	1	2018-01-17	2018-01-17
277056664098252	1	2020-10-28	2020-10-28
277056664098252	1	2020-12-01	2020-12-01
289037829621190	2	2018-10-08	2020-09-06
289037829621190	4	2020-10-09	2021-12-01
103114111526792	1	2016-10-19	2019-12-01
256072702237635	1	2018-10-21	2018-10-21
256072702237635	1	2018-11-25	2018-11-25
256072702237635	1	2020-10-23	2020-10-23
215109609078559	1	2019-03-25	2019-03-25
215109609078559	1	2019-06-09	2019-06-09
287106613897037	1	2019-12-01	2019-12-01
287106613897037	1	2021-08-10	2021-08-10
246037149657382	1	2016-04-26	2016-04-26
246037149657382	1	2021-07-21	2021-07-21
260121787044371	3	2017-01-27	2019-05-20
260121787044371	4	2020-08-16	2020-08-22
270012241493705	6	2017-07-23	2021-11-26
261060456525634	6	2021-06-25	2021-12-01
196041514401521	5	2020-06-01	2020-10-09
196041514401521	1	2021-08-27	2021-12-01
131021682878445	1	2016-10-11	2016-10-11
280096672979293	4	2016-12-01	2020-04-07
280096672979293	6	2021-12-01	2021-12-01
161110895952876	6	2017-03-08	2020-08-03
161110895952876	1	2020-09-15	2021-11-07
161110895952876	5	2021-11-20	2021-12-01
111028862692739	1	2018-08-23	2018-09-25
111028862692739	4	2021-07-07	2021-10-10
111028862692739	1	2021-10-12	2021-12-01
281033961629584	1	2017-11-13	2017-11-13
283119762283310	4	2019-01-28	2021-01-28
283119762283310	6	2021-10-21	2021-12-01
171037193876663	6	2016-12-01	2019-08-16
171037193876663	6	2019-10-03	2019-10-24
171037193876663	5	2021-06-09	2021-12-01
291052955637911	3	2018-10-13	2021-12-01
186108833612501	1	2017-01-12	2017-01-12
186108833612501	1	2019-09-23	2019-09-23
186108833612501	1	2021-09-24	2021-09-24
191087419601552	1	2019-02-23	2019-02-23
191087419601552	1	2019-05-05	2019-05-05
191087419601552	1	2019-07-07	2019-07-07
208108168434507	1	2020-02-01	2020-02-01
144032955003677	1	2017-06-19	2017-06-19
144032955003677	1	2019-09-21	2019-09-21
245031024735106	1	2018-04-15	2018-04-15
244051103911471	1	2019-10-01	2019-10-01
244051103911471	1	2019-10-14	2019-10-14
143024158070291	1	2021-01-28	2021-01-28
143024158070291	1	2021-12-01	2021-12-01
296078260808814	6	2020-12-01	\N
129036638333996	1	2020-01-04	2021-04-16
129036638333996	1	2021-11-08	2021-12-01
175084237674269	1	2021-10-16	2021-10-16
127109489453869	2	2020-05-26	2021-02-22
127109489453869	1	2021-09-03	2021-10-24
127109489453869	5	2021-12-01	2021-12-01
207121168949178	6	2016-10-28	2017-01-22
162123090223760	1	2021-05-08	2021-05-08
162123090223760	1	2021-08-11	2021-08-11
196014599832638	2	2016-07-14	2018-10-21
196014599832638	1	2019-09-22	2020-04-06
196014599832638	1	2021-04-20	2021-09-24
196014599832638	6	2021-10-28	\N
249123962387030	1	2017-03-24	2017-03-24
249123962387030	1	2019-06-28	2019-06-28
249123962387030	1	2019-12-01	2019-12-01
191098072780944	4	2021-06-27	2021-10-27
191098072780944	5	2021-12-01	2021-12-01
180030334988128	1	2017-09-14	2017-09-14
233095184464913	3	2019-05-28	\N
160129415851720	4	2015-11-12	2018-08-01
160129415851720	5	2021-12-01	\N
290064596215313	1	2018-03-28	2019-12-01
290064596215313	1	2020-10-14	2020-12-01
290064596215313	3	2021-07-16	2021-09-26
290064596215313	2	2021-10-28	\N
162024029695095	1	2018-05-05	2020-01-04
256035745805285	1	2019-08-13	2019-08-13
256035745805285	1	2020-02-08	2020-02-08
299095883325694	6	2015-03-10	2017-11-08
299095883325694	3	2020-02-15	2020-07-01
299095883325694	1	2020-09-19	2021-10-10
255010508757484	1	2018-06-05	2018-06-05
255010508757484	1	2021-04-23	2021-04-23
284025054958080	1	2021-01-16	2021-01-16
284025054958080	1	2021-09-12	2021-09-12
198115876820091	1	2019-08-02	2021-09-04
292127286360670	1	2018-11-20	2018-11-20
292127286360670	1	2020-04-21	2020-04-21
292127286360670	1	2020-11-19	2020-11-19
238106074150665	1	2018-03-08	2018-03-08
238106074150665	1	2020-12-01	2020-12-01
238106074150665	1	2018-07-01	2018-07-01
124125087042200	1	2018-02-16	2018-02-16
124125087042200	1	2019-12-01	2019-12-01
104107459950188	1	2019-01-28	2019-01-28
266021326138534	4	2019-08-06	2021-07-13
266021326138534	1	2021-12-01	2021-12-01
177099561621308	1	2016-07-27	2016-07-27
177099561621308	1	2018-01-19	2018-01-19
220057917231572	1	2018-08-18	2018-08-18
127109276206342	1	2021-06-01	2021-06-01
127109276206342	1	2021-08-26	2021-08-26
127109276206342	1	2021-10-13	2021-10-13
285041428779415	5	2015-12-01	2020-02-18
285041428779415	5	2020-06-02	2020-11-12
285041428779415	1	2020-11-17	2020-12-01
285041428779415	6	2021-10-14	\N
115102762371703	1	2015-02-08	2015-02-08
115102762371703	1	2021-07-13	2021-07-13
131109289872634	1	2018-03-18	2018-03-18
199069886261876	1	2016-05-27	2016-05-27
233068001860172	1	2019-12-01	2019-12-01
233068001860172	1	2021-03-12	2021-03-12
233068001860172	1	2021-05-11	2021-05-11
189083343412684	1	2018-01-13	2018-01-13
274017748986076	6	2015-07-10	2015-10-03
274017748986076	3	2021-11-18	2021-12-01
203071505075882	4	2020-08-02	2020-09-01
203071505075882	5	2020-11-17	2020-11-18
203071505075882	1	2021-06-13	2021-09-28
203071505075882	1	2021-11-02	2021-12-01
225046338616560	1	2018-08-12	2018-08-12
225046338616560	1	2020-04-05	2020-04-05
282125089606113	1	2019-11-06	2019-11-06
282125089606113	1	2021-11-22	2021-11-22
268067070083090	6	2021-09-07	2021-09-25
219021809637382	1	2015-05-20	2018-01-01
219021809637382	6	2021-07-14	2021-07-23
219021809637382	6	2021-10-20	2021-10-23
219021809637382	3	2021-12-01	2021-12-01
148128918443996	4	2017-11-06	2019-06-21
148128918443996	3	2019-10-18	2019-10-26
148128918443996	4	2019-12-01	2020-12-01
148128918443996	1	2021-11-25	\N
134060133645153	1	2015-09-04	2018-12-01
134060133645153	6	2020-09-18	2021-07-26
134060133645153	6	2021-10-19	\N
167073716399416	1	2016-03-27	2016-03-27
167073716399416	1	2016-07-12	2016-07-12
170026816597756	1	2017-05-22	2017-05-22
170026816597756	1	2020-03-19	2020-03-19
239112027995661	1	2018-10-20	2018-10-20
155041690002972	6	2015-12-01	2019-11-17
155041690002972	6	2020-10-08	2020-12-01
155041690002972	3	2021-02-16	\N
248092200396476	1	2020-03-12	2021-04-10
248092200396476	2	2021-11-27	2021-12-01
240035852414745	1	2016-01-03	2016-01-03
240035852414745	1	2017-03-19	2017-03-19
146016758089885	1	2016-12-01	2016-12-01
161067172287541	1	2015-04-02	2015-04-02
161067172287541	1	2016-06-01	2016-06-01
111039511573819	1	2018-09-20	2018-09-20
111039511573819	1	2018-11-16	2018-11-16
225032278266803	1	2018-12-01	2018-12-01
225032278266803	1	2021-12-01	2021-12-01
217074086831428	1	2021-05-15	2021-12-01
293067026576534	1	2015-08-21	2015-08-21
293067026576534	1	2018-01-21	2018-01-21
229104969463987	1	2017-08-23	2017-08-23
229104969463987	1	2018-02-07	2018-02-07
211126925899180	1	2016-10-11	2016-10-11
253097276162617	1	2019-04-10	2019-04-10
236036316584601	1	2017-12-01	2017-12-01
236036316584601	1	2019-03-03	2019-03-03
279104322668824	1	2021-02-26	2021-02-26
279104322668824	1	2021-12-01	2021-12-01
129054448109734	1	2019-05-05	2019-05-05
129054448109734	1	2020-01-26	2020-01-26
129054448109734	1	2020-08-13	2020-08-13
209049564105921	1	2021-10-21	2021-10-21
209049564105921	1	2021-11-28	2021-11-28
271110105237227	1	2015-04-20	2017-03-10
271110105237227	1	2021-03-28	2021-12-01
130071148664148	1	2019-02-25	2019-02-25
130071148664148	1	2019-05-20	2019-05-20
130071148664148	1	2020-10-21	2020-10-21
193046098419989	1	2015-12-01	2015-12-01
193046098419989	1	2015-10-16	2015-10-16
108059912447754	1	2021-08-10	2021-08-10
108059912447754	1	2021-08-22	2021-08-22
108059912447754	1	2021-12-01	2021-12-01
221084521836196	6	2017-04-16	2019-10-09
221084521836196	5	2021-09-03	2021-10-27
275010892493538	4	2018-12-01	\N
201104145535465	1	2016-12-01	2016-12-01
238037295713009	1	2015-01-10	2015-01-10
238037295713009	1	2019-04-15	2019-04-15
145028128718210	1	2015-10-19	2015-10-19
294085279933523	1	2017-02-17	2017-02-17
294085279933523	1	2018-02-19	2018-02-19
292060159246061	1	2017-07-11	2017-07-11
218012483586376	2	2021-09-28	2021-12-01
254082106848079	1	2015-02-07	2015-02-07
254082106848079	1	2019-03-22	2019-03-22
254082106848079	1	2020-01-17	2020-01-17
289038194355035	1	2020-03-20	2020-03-20
289038194355035	1	2020-07-24	2020-07-24
289038194355035	1	2020-12-01	2020-12-01
187070799370259	1	2018-04-09	2018-04-09
108020934941188	1	2020-03-08	2020-03-08
108020934941188	1	2021-02-27	2021-02-27
108020934941188	1	2021-08-28	2021-08-28
259046387441327	1	2017-07-20	2017-07-20
259046387441327	1	2019-06-13	2019-06-13
233066555514390	1	2018-04-04	2018-04-04
233066555514390	1	2020-01-11	2020-01-11
137021233550200	5	2018-03-08	\N
167088138223313	1	2015-05-02	2015-05-02
167088138223313	1	2017-04-24	2017-04-24
243080616823446	1	2019-01-15	2019-01-15
243080616823446	1	2021-08-08	2021-08-08
210117948182854	1	2015-08-19	2015-08-19
107028981594327	1	2019-01-23	2021-07-24
107028981594327	3	2021-11-26	\N
288052477041170	1	2016-07-16	2016-07-16
288052477041170	1	2018-07-24	2018-07-24
288052477041170	1	2018-11-23	2018-11-23
253032370741967	1	2015-04-05	2015-04-05
149063593850027	1	2021-11-28	2021-11-28
149063593850027	1	2021-12-01	2021-12-01
218121931897884	1	2016-02-12	2016-02-12
218121931897884	1	2021-09-03	2021-09-03
115073393844074	1	2019-08-15	2019-08-15
115073393844074	1	2019-10-03	2019-10-03
115073393844074	1	2019-12-01	2019-12-01
262102954655333	6	2015-05-07	2016-04-06
262102954655333	2	2021-08-08	2021-08-28
262102954655333	1	2021-09-17	2021-10-07
262102954655333	1	2021-11-09	\N
299075025982742	6	2018-09-10	\N
216121985902635	5	2017-09-26	2017-11-02
216121985902635	5	2020-09-03	2020-09-17
216121985902635	5	2021-12-01	\N
120087250824191	1	2018-01-03	2018-01-03
120087250824191	1	2019-07-19	2019-07-19
159117903511347	1	2015-05-18	2015-05-18
159117903511347	1	2016-08-01	2016-08-01
159117903511347	1	2017-06-09	2017-06-09
151010535199329	5	2015-11-24	2016-06-21
202096545459216	6	2018-01-25	2018-01-25
202096545459216	1	2019-04-13	2019-08-12
202096545459216	5	2019-11-19	2019-12-01
202096545459216	3	2020-12-01	2021-04-12
202096545459216	6	2021-05-25	2021-09-07
220036263058474	3	2017-10-03	2017-12-01
220036263058474	5	2019-09-28	2020-01-26
220036263058474	2	2021-06-04	2021-06-13
220036263058474	4	2021-08-19	\N
164072065506044	4	2021-06-19	2021-07-22
164072065506044	2	2021-08-27	2021-12-01
225122828585441	1	2021-04-15	2021-04-15
225122828585441	1	2021-06-12	2021-06-12
225122828585441	1	2021-12-01	2021-12-01
146027101427837	1	2021-12-01	2021-12-01
157057144009934	1	2019-08-10	2019-08-10
120012655787696	6	2019-07-04	2021-06-02
272128938731412	1	2015-06-17	2015-06-17
272128938731412	1	2021-05-13	2021-05-13
123103048076517	2	2017-05-03	2020-09-09
123103048076517	5	2021-06-09	2021-09-17
123103048076517	2	2021-12-01	2021-12-01
112067612324530	1	2017-10-17	2017-10-17
212021771119539	1	2016-02-28	2016-02-28
133043200981964	1	2021-03-12	2021-03-12
222062702780531	4	2018-11-04	2021-01-08
222062702780531	2	2021-06-05	2021-06-15
116101580250637	2	2019-02-03	2020-07-08
116101580250637	6	2020-08-14	2020-09-16
116101580250637	2	2020-12-01	2020-12-01
116101580250637	6	2021-05-12	2021-12-01
223018989015713	1	2021-05-14	2021-05-14
223018989015713	1	2021-06-26	2021-06-26
223018989015713	1	2021-08-03	2021-08-03
291012132330873	3	2016-11-26	2021-07-07
291012132330873	3	2021-12-01	2021-12-01
266105404998405	1	2020-08-01	2020-08-01
243101397269448	1	2019-11-06	2019-11-06
119079086336263	1	2021-06-26	2021-06-26
159049935527582	1	2019-03-15	2019-03-15
159049935527582	1	2020-03-23	2020-03-23
290127332358372	1	2021-11-07	2021-11-07
290127332358372	1	2021-12-01	2021-12-01
233098228061700	4	2016-01-23	2018-01-27
105055073221067	1	2017-12-01	2017-12-01
284070773359105	1	2016-07-22	2016-07-22
284070773359105	1	2019-03-24	2019-03-24
128032992380904	1	2017-09-11	2020-07-07
128032992380904	2	2021-07-10	2021-09-06
128032992380904	3	2021-12-01	2021-12-01
107097295816255	1	2021-12-01	2021-12-01
151022965079221	1	2017-05-19	2017-05-19
151022965079221	1	2019-08-09	2019-08-09
151022965079221	1	2020-08-13	2020-08-13
112031596898173	1	2017-07-24	2017-07-24
112031596898173	1	2018-10-18	2018-10-18
213081650900924	1	2015-06-28	2015-06-28
213081650900924	1	2016-07-28	2016-07-28
178052502185535	4	2017-04-10	2021-02-17
178052502185535	5	2021-08-05	\N
295070626140542	1	2017-05-03	2017-05-03
295070626140542	1	2019-02-15	2019-02-15
295070626140542	1	2021-09-28	2021-09-28
226101586300159	1	2021-05-05	2021-05-05
226101586300159	1	2021-12-01	2021-12-01
120058752255719	1	2018-05-27	2018-05-27
120058752255719	1	2021-10-16	2021-10-16
120058752255719	1	2021-11-10	2021-11-10
228101775407926	5	2020-10-24	2021-04-13
228101775407926	3	2021-09-24	2021-10-23
228101775407926	5	2021-10-24	\N
251118467966521	1	2016-07-24	\N
285115820360026	1	2018-06-09	2018-06-09
283081998370622	1	2020-06-08	2020-06-08
283081998370622	1	2020-07-06	2020-07-06
283081998370622	1	2020-12-01	2020-12-01
142051862949049	1	2020-02-13	2020-02-13
142051862949049	1	2021-08-18	2021-08-18
243014454534087	4	2017-07-18	2017-08-07
243014454534087	5	2018-05-22	2021-04-23
243014454534087	1	2021-08-22	2021-08-24
243014454534087	2	2021-08-27	\N
181023381093240	1	2018-07-23	2018-07-23
181023381093240	1	2020-02-03	2020-02-03
151099301859840	1	2018-07-28	2018-07-28
151099301859840	1	2021-08-09	2021-08-09
126054747918290	1	2015-08-07	2015-08-07
126054747918290	1	2021-12-01	2021-12-01
119011754998157	1	2015-09-12	2015-09-12
253087209887583	1	2015-06-09	2015-06-09
253087209887583	1	2016-10-06	2016-10-06
294083240333014	6	2018-10-02	2020-10-23
294083240333014	1	2021-10-23	2021-11-09
139051080064928	5	2020-07-14	2020-10-23
139051080064928	1	2020-11-04	2021-04-23
139051080064928	1	2021-11-02	2021-12-01
102118325920402	1	2016-02-01	2016-02-01
102118325920402	1	2019-02-22	2019-02-22
102118325920402	1	2021-09-22	2021-09-22
162128476044686	1	2015-08-20	2015-08-20
162128476044686	1	2020-06-16	2020-06-16
162128476044686	1	2020-10-14	2020-10-14
237041083780905	1	2021-03-24	2021-04-18
237041083780905	1	2021-08-13	2021-10-20
237041083780905	5	2021-11-05	2021-11-25
237041083780905	3	2021-12-01	2021-12-01
180097454476416	6	2019-10-24	2019-10-26
180097454476416	6	2021-05-12	2021-09-25
180097454476416	3	2021-10-22	2021-11-26
180097454476416	2	2021-11-28	2021-11-28
180097454476416	2	2021-12-01	\N
198019789185927	1	2015-02-08	2015-02-08
198019789185927	1	2019-05-18	2019-05-18
289075326321716	3	2016-05-16	2017-10-22
289075326321716	2	2018-12-01	2021-09-16
289075326321716	2	2021-10-17	2021-10-18
238044454322507	1	2018-08-26	2018-08-26
238044454322507	1	2018-10-15	2018-10-15
204095944799952	1	2018-11-05	2018-11-05
204095944799952	1	2020-12-01	2020-12-01
204095944799952	1	2021-04-17	2021-04-17
160037973030119	2	2016-05-13	2016-05-14
160037973030119	5	2017-09-26	\N
228052967338855	1	2016-08-08	2016-08-08
228052967338855	1	2017-01-05	2017-01-05
228052967338855	1	2019-11-27	2019-11-27
204028909048229	1	2015-01-09	2015-01-09
204028909048229	1	2019-11-17	2019-11-17
279014234476269	1	2019-10-20	2020-04-03
279014234476269	2	2021-06-18	2021-11-13
279014234476269	4	2021-11-28	2021-11-28
279014234476269	6	2021-12-01	2021-12-01
105025228548532	1	2018-04-27	2018-04-27
105025228548532	1	2021-11-27	2021-11-27
236070319011481	1	2017-12-01	2017-12-01
174048263332316	1	2015-06-14	2021-06-21
174048263332316	3	2021-10-18	2021-11-15
199105176991230	1	2021-07-05	2021-07-05
199105176991230	1	2021-08-03	2021-08-03
161056533943893	3	2018-09-10	2020-12-01
161056533943893	3	2021-02-13	\N
286062791711375	1	2018-06-19	2018-06-19
286062791711375	1	2020-03-24	2020-03-24
286062791711375	1	2021-12-01	2021-12-01
272111238460186	1	2016-08-07	2016-08-07
272111238460186	1	2017-09-10	2017-09-10
152111965056410	1	2021-04-07	2021-04-07
165027813307360	5	2015-08-26	2016-06-07
165027813307360	1	2019-04-18	\N
104059069162387	1	2019-03-26	2019-03-26
104059069162387	1	2020-01-13	2020-01-13
121056692918082	1	2015-08-27	2015-08-27
121056692918082	1	2015-09-09	2015-09-09
188025191934459	1	2021-01-02	2021-01-02
188025191934459	1	2021-08-01	2021-08-01
188025191934459	1	2021-09-12	2021-09-12
102044945975322	1	2018-08-25	2018-08-25
102044945975322	1	2021-04-21	2021-04-21
102044945975322	1	2021-07-15	2021-07-15
292030305080256	5	2016-10-17	2018-06-04
292030305080256	2	2019-12-01	2020-01-07
292030305080256	4	2020-09-01	\N
232023864409457	3	2016-01-01	2016-02-24
232023864409457	2	2019-12-01	\N
117071617626555	1	2019-11-10	2019-11-10
117071617626555	1	2019-11-25	2019-11-25
117071617626555	1	2019-11-27	2019-11-27
196036458217210	1	2017-07-06	2017-07-06
139096044741391	1	2017-09-02	2017-09-02
139096044741391	1	2018-04-04	2018-04-04
139096044741391	1	2020-02-19	2020-02-19
284086505133848	1	2017-05-17	2017-05-17
161106377733801	1	2021-01-26	2021-01-26
266031774123621	1	2015-06-19	2015-06-19
266031774123621	1	2018-08-26	2018-08-26
176083360458256	3	2016-05-27	2020-05-27
238082768160123	1	2017-01-20	2017-01-20
238082768160123	1	2021-05-03	2021-05-03
116089104911289	1	2020-01-01	2020-01-01
116089104911289	1	2020-09-26	2020-09-26
116089104911289	1	2017-12-01	2017-12-01
184013026653488	1	2015-07-26	2015-07-26
190062769594923	1	2018-09-05	2020-12-01
190062769594923	5	2021-06-27	2021-07-28
190062769594923	4	2021-08-14	2021-09-02
129051166985007	1	2016-04-01	2016-04-01
129051166985007	1	2016-07-05	2016-07-05
171110869020530	1	2021-09-06	2021-09-06
171110869020530	1	2021-09-26	2021-09-26
170085720360240	1	2017-05-03	2021-03-04
170085720360240	3	2021-03-27	2021-04-27
170085720360240	1	2021-05-16	\N
128119566368842	1	2017-04-04	2017-04-04
250072870574866	1	2020-10-27	2020-10-27
250072870574866	1	2020-12-01	2020-12-01
250072870574866	1	2021-04-10	2021-04-10
275034106311549	1	2020-11-02	2020-11-02
275034106311549	1	2020-12-01	2020-12-01
275034106311549	1	2021-10-03	2021-10-03
293072659007230	1	2017-03-11	2017-03-11
265047126015494	1	2018-07-17	2018-07-17
265047126015494	1	2020-04-22	2020-04-22
202010382752991	1	2019-12-01	2019-12-01
202010382752991	1	2020-12-01	2020-12-01
202010382752991	1	2015-03-24	2015-03-24
119072545360121	1	2016-08-04	2016-08-04
119072545360121	1	2020-06-13	2020-06-13
119072545360121	1	2021-09-20	2021-09-20
213077721801746	1	2019-04-28	2019-04-28
213077721801746	1	2020-02-12	2020-02-12
128087936474254	2	2020-12-01	2020-12-01
128087936474254	2	2021-02-08	2021-07-23
128087936474254	2	2021-10-08	2021-12-01
294089748643596	6	2017-08-17	2021-06-21
148013229831993	1	2015-01-21	2015-01-21
148013229831993	1	2020-09-17	2020-09-17
223120960061912	1	2021-03-15	2021-03-15
223120960061912	1	2021-03-19	2021-03-19
186033137213249	1	2017-05-20	2017-05-20
186033137213249	1	2020-10-12	2020-10-12
256115115514311	1	2016-06-01	2016-06-01
256115115514311	1	2019-12-01	2019-12-01
256115115514311	1	2020-09-22	2020-09-22
244013618672814	5	2016-09-07	2018-08-21
244013618672814	5	2021-11-11	2021-11-24
196061733484675	2	2018-01-25	2021-05-14
106089885680755	1	2018-06-17	2018-09-28
106089885680755	2	2020-07-03	2020-09-19
106089885680755	5	2020-10-11	2021-12-01
208101367016896	1	2021-08-27	2021-08-27
139105087154042	1	2021-07-11	2021-07-11
139105087154042	1	2021-08-23	2021-08-23
158030363231988	1	2017-11-20	2017-11-20
158030363231988	1	2021-05-06	2021-05-06
297076719709643	1	2016-05-16	2016-05-16
297076719709643	1	2020-03-21	2020-03-21
297076719709643	1	2021-06-11	2021-06-11
222046381429882	1	2016-05-11	2016-05-11
265031930410776	1	2020-03-20	2020-03-20
265031930410776	1	2021-07-21	2021-07-21
134049072360994	3	2016-07-02	2016-10-10
134049072360994	2	2020-04-08	2020-07-28
211086595791575	6	2015-07-25	2016-01-01
211086595791575	2	2019-01-24	\N
239043603031156	1	2015-04-26	2015-04-26
239043603031156	1	2017-01-24	2017-01-24
239043603031156	1	2018-08-13	2018-08-13
150017226774891	1	2015-09-01	2015-09-01
150017226774891	1	2016-04-04	2016-04-04
290060531145979	1	2015-11-16	2015-11-16
125043167496449	1	2020-02-15	2020-02-15
259029921552493	1	2020-06-15	2020-06-15
259029921552493	1	2021-09-02	2021-09-02
165089604254636	1	2020-04-28	2020-04-28
272036042538195	1	2019-07-18	2019-07-18
272036042538195	1	2020-02-18	2020-02-18
169045466583502	1	2016-04-10	2016-04-10
169045466583502	1	2016-08-28	2016-08-28
155078862032976	1	2020-04-17	2020-04-17
155078862032976	1	2020-10-19	2020-10-19
236050817608085	6	2015-11-15	\N
228068017689713	2	2017-07-26	2017-08-03
228068017689713	4	2018-10-03	2019-07-14
139092699004560	1	2017-02-21	2017-02-21
139092699004560	1	2018-10-06	2018-10-06
139092699004560	1	2021-02-08	2021-02-08
184080527855873	4	2016-02-13	2017-04-03
184080527855873	5	2020-06-04	2020-06-06
184080527855873	1	2020-11-17	2020-12-01
184080527855873	6	2021-04-08	\N
159097071302004	1	2019-04-18	2019-04-18
159097071302004	1	2020-03-15	2020-03-15
159097071302004	1	2021-02-08	2021-02-08
171113093221638	1	2021-10-01	2021-10-01
171113093221638	1	2021-11-11	2021-11-11
107046092147076	1	2016-08-20	2016-08-20
256037369716944	1	2018-08-20	2018-08-20
141030952640812	4	2020-02-08	2021-12-01
281115596346204	1	2018-03-02	2018-03-02
264019381752416	1	2018-03-10	2018-03-10
264019381752416	1	2020-02-12	2020-02-12
206051413439664	1	2019-11-22	2020-08-20
206051413439664	5	2021-02-18	2021-03-22
206051413439664	5	2021-12-01	2021-12-01
117043894183463	5	2019-06-12	2021-01-14
117043894183463	1	2021-07-26	2021-08-19
117043894183463	5	2021-12-01	2021-12-01
282106583597519	1	2015-05-23	2015-05-23
282106583597519	1	2018-09-07	2018-09-07
282106583597519	1	2020-03-16	2020-03-16
221079212138547	1	2021-03-28	2021-03-28
126127518943951	6	2016-02-11	2020-08-19
126127518943951	1	2021-01-25	2021-02-20
126127518943951	4	2021-12-01	2021-12-01
129088384201146	1	2021-11-25	2021-11-25
129088384201146	1	2021-11-26	2021-11-26
156127291989632	1	2019-11-23	2019-11-23
156127291989632	1	2020-05-04	2020-05-04
156127291989632	1	2021-02-07	2021-02-07
117064052014050	1	2020-09-09	2020-09-09
117064052014050	1	2020-12-01	2020-12-01
117064052014050	1	2016-07-23	2016-07-23
266032587199748	5	2020-03-14	2020-08-26
266032587199748	5	2020-09-14	2020-09-24
266032587199748	2	2021-10-05	2021-10-14
266032587199748	4	2021-11-05	2021-11-24
201068456551393	3	2020-08-05	\N
280013103555645	1	2016-07-18	2018-04-02
280013103555645	6	2019-11-23	2021-05-10
280013103555645	6	2021-07-06	2021-10-01
288106819148682	3	2019-08-15	2019-10-10
220068901669705	1	2016-07-08	2016-07-08
220068901669705	1	2017-07-23	2017-07-23
218120824070079	1	2020-01-02	2020-01-02
218120824070079	1	2020-04-10	2020-04-10
153029896446820	1	2019-01-28	2019-01-28
153029896446820	1	2019-02-28	2019-02-28
153029896446820	1	2020-11-05	2020-11-05
194075342972573	6	2020-04-12	2021-06-22
194075342972573	1	2021-08-24	2021-10-23
194075342972573	3	2021-12-01	2021-12-01
296099765223309	2	2016-05-14	2017-06-18
296099765223309	1	2018-09-22	2021-09-25
296099765223309	4	2021-11-24	2021-11-25
296099765223309	3	2021-11-28	2021-12-01
185021399708089	1	2015-06-15	2015-06-15
185021399708089	1	2021-09-01	2021-09-01
278094704116338	1	2021-09-23	2021-09-23
278094704116338	1	2021-12-01	2021-12-01
139105281222043	4	2019-10-16	2021-06-26
139105281222043	5	2021-09-19	2021-12-01
227083579705919	1	2016-05-21	2016-05-21
227083579705919	1	2021-12-01	2021-12-01
284090884921702	1	2015-01-10	2015-01-10
284090884921702	1	2021-03-25	2021-03-25
284090884921702	1	2021-03-26	2021-03-26
103075757697692	1	2018-05-15	2018-05-15
103075757697692	1	2021-01-26	2021-01-26
103075757697692	1	2021-03-14	2021-03-14
195087761492606	1	2018-06-13	2018-06-13
195087761492606	1	2020-08-28	2020-08-28
195087761492606	1	2020-09-07	2020-09-07
127100875228221	1	2016-07-19	2016-07-19
127100875228221	1	2021-06-16	2021-06-16
127100875228221	1	2021-09-22	2021-09-22
215072902540441	1	2020-08-22	2020-08-22
215072902540441	1	2021-12-01	2021-12-01
169122788622827	1	2016-02-28	2016-02-28
118111411157996	1	2020-12-01	2020-12-01
118111411157996	1	2021-05-08	2021-05-08
254102671108666	1	2016-12-01	2016-12-01
254102671108666	1	2017-08-05	2017-08-05
113065641678643	1	2020-12-01	2020-12-01
221021115240958	1	2021-08-20	2021-08-20
221021115240958	1	2021-11-15	2021-11-15
287051297819393	4	2019-04-27	2020-05-13
287051297819393	6	2020-07-11	2021-11-15
287051297819393	5	2021-12-01	2021-12-01
236071547970159	1	2015-10-15	2015-10-15
236071547970159	1	2017-07-22	2017-07-22
236071547970159	1	2020-06-25	2020-06-25
152074748442071	1	2021-04-25	2021-04-25
152074748442071	1	2021-05-02	2021-05-02
131084757421667	6	2018-08-24	2018-09-18
131084757421667	4	2020-07-01	2020-10-09
131084757421667	6	2021-09-20	2021-10-20
260022594363516	1	2016-12-01	2016-12-01
108077100841690	1	2018-04-14	2018-04-14
181017147729962	1	2015-09-01	2015-09-01
181017147729962	1	2018-04-03	2018-04-03
121071265687319	1	2020-01-07	2020-01-07
121071265687319	1	2021-01-12	2021-01-12
156085302883246	1	2019-09-03	2019-09-03
156085302883246	1	2021-09-19	2021-09-19
156085302883246	1	2021-12-01	2021-12-01
115030403153781	4	2017-01-18	2021-07-05
115030403153781	2	2021-07-15	2021-11-04
115030403153781	2	2021-11-18	2021-12-01
175073159041662	4	2017-03-17	2019-04-12
175073159041662	4	2020-04-22	2021-05-10
175073159041662	4	2021-11-16	2021-11-27
175073159041662	2	2021-12-01	2021-12-01
110042098683095	1	2021-02-27	2021-02-27
110042098683095	1	2021-03-09	2021-03-09
109030537258504	1	2016-04-22	2016-04-22
109030537258504	1	2018-11-24	2018-11-24
109030537258504	1	2020-08-09	2020-08-09
223066675112456	1	2020-08-07	2020-08-07
223066675112456	1	2020-10-19	2020-10-19
223066675112456	1	2021-05-10	2021-05-10
282112984855467	5	2016-02-22	2021-08-24
282112984855467	2	2021-09-08	2021-10-01
282112984855467	6	2021-10-05	2021-11-13
206015685037422	1	2019-10-06	2019-10-06
206015685037422	1	2021-09-03	2021-09-03
206015685037422	1	2021-10-12	2021-10-12
186069087679009	3	2017-07-14	2017-10-22
186069087679009	4	2017-10-25	2021-02-08
186069087679009	5	2021-10-18	2021-12-01
216040451818667	2	2016-06-28	2018-05-22
216040451818667	2	2019-07-06	2021-10-06
216040451818667	3	2021-11-26	2021-12-01
123107251805832	6	2018-05-08	2019-07-23
123107251805832	1	2019-10-12	2019-11-09
123107251805832	5	2019-11-23	2019-12-01
123107251805832	2	2020-10-10	2020-11-11
123107251805832	3	2020-12-01	2021-03-14
252047407262592	4	2021-07-09	2021-08-24
273083395115649	1	2017-09-03	2017-09-03
273083395115649	1	2019-02-14	2019-02-14
113061066882595	1	2017-06-06	2017-06-06
113061066882595	1	2018-08-14	2018-08-14
113061066882595	1	2018-09-25	2018-09-25
112032779042732	1	2018-08-08	2019-02-11
112032779042732	1	2021-02-18	\N
256051093900976	1	2019-12-01	2021-12-01
183112049563783	6	2021-11-01	\N
162022779725514	1	2019-02-07	2019-02-07
162022779725514	1	2021-02-18	2021-02-18
162022779725514	1	2021-05-08	2021-05-08
235124605200969	1	2017-06-25	2017-06-25
235124605200969	1	2020-05-11	2020-05-11
235124605200969	1	2020-07-07	2020-07-07
187121135696356	1	2019-06-24	2019-06-24
187121135696356	1	2020-01-17	2020-01-17
187121135696356	1	2020-01-21	2020-01-21
142101413261413	2	2017-04-23	2017-12-01
142101413261413	2	2020-05-04	2020-06-11
142101413261413	6	2020-06-27	2021-10-13
142101413261413	5	2021-12-01	2021-12-01
136097591466460	1	2015-01-12	2015-01-12
145039104108865	1	2021-05-07	2021-05-07
223115310429678	2	2021-06-14	2021-10-18
223115310429678	3	2021-12-01	2021-12-01
281038699937926	1	2020-09-05	2020-09-05
281038699937926	1	2020-11-05	2020-11-05
281038699937926	1	2020-12-01	2020-12-01
285039913209682	1	2018-05-22	2018-05-22
285039913209682	1	2019-12-01	2019-12-01
285039913209682	1	2018-04-04	2018-04-04
200052554875542	1	2016-04-20	2016-04-20
200052554875542	1	2020-05-28	2020-05-28
247037596488238	2	2019-03-24	2019-05-09
247037596488238	4	2020-09-25	2020-09-26
160103642429132	1	2017-03-19	2017-03-19
107087240250732	1	2019-11-13	2019-11-13
202123105157942	1	2019-03-02	2019-03-02
204011935620841	1	2015-04-07	2015-04-07
297096978369003	1	2021-03-12	2021-03-12
186021649778788	2	2016-07-08	2018-09-07
186021649778788	5	2021-08-25	2021-09-09
186021649778788	1	2021-11-05	2021-11-24
186021649778788	2	2021-12-01	2021-12-01
103095695159235	1	2018-10-16	2018-10-16
103095695159235	1	2018-10-25	2018-10-25
103095695159235	1	2019-02-15	2019-02-15
286087656423415	4	2017-11-10	2017-12-01
286087656423415	6	2019-12-01	2020-03-26
286087656423415	6	2021-07-03	\N
175066592387802	1	2015-07-02	2015-07-02
175066592387802	1	2021-07-06	2021-07-06
113115246343642	1	2016-09-08	2016-09-08
113115246343642	1	2020-09-09	2020-09-09
113115246343642	1	2018-08-09	2018-08-09
142038048913513	1	2017-12-01	2017-12-01
176078894344648	1	2018-05-22	2018-05-22
255101453587957	3	2018-02-07	2020-09-20
255101453587957	1	2020-09-26	2020-11-18
236060592944147	1	2021-04-03	2021-04-03
236060592944147	1	2021-11-05	2021-11-05
286032428338414	1	2016-11-08	2016-11-08
213092819479712	1	2017-04-11	2017-09-03
167089520011854	1	2017-07-08	2017-07-08
167089520011854	1	2018-06-18	2018-06-18
167089520011854	1	2018-12-01	2018-12-01
287018725817056	1	2019-06-14	2019-06-14
287018725817056	1	2020-11-15	2020-11-15
287018725817056	1	2021-01-08	2021-01-08
205062269993651	1	2018-10-22	2018-10-22
138060554444491	1	2019-07-27	2019-07-27
158069665674107	1	2016-04-13	2016-04-13
158069665674107	1	2016-10-28	2016-10-28
158069665674107	1	2020-12-01	2020-12-01
106011050819427	1	2015-04-20	2015-04-20
106011050819427	1	2019-01-03	2019-01-03
106011050819427	1	2021-11-26	2021-11-26
157073274149735	1	2015-02-11	2015-02-11
157073274149735	1	2018-08-28	2018-08-28
157073274149735	1	2015-06-26	2015-06-26
212100642731642	1	2017-01-21	2017-01-21
212100642731642	1	2018-01-26	2018-01-26
212100642731642	1	2020-05-26	2020-05-26
241049099179176	1	2015-11-21	2018-07-05
241049099179176	6	2020-12-01	2021-07-05
241049099179176	5	2021-08-04	2021-08-11
226122696935272	5	2015-10-24	2020-09-05
226122696935272	1	2021-06-08	2021-09-28
226122696935272	2	2021-12-01	2021-12-01
133119158204920	1	2021-10-09	2021-10-09
133119158204920	1	2021-10-14	2021-10-14
140018008302573	1	2019-04-15	2019-04-15
140018008302573	1	2019-12-01	2019-12-01
179024378361353	1	2016-12-01	2016-12-01
179024378361353	1	2015-08-09	2015-08-09
223113006500836	5	2015-06-02	2021-09-08
100109271865326	4	2016-01-14	2016-03-22
100109271865326	6	2018-04-26	2018-08-15
100109271865326	3	2018-12-01	2020-12-01
100109271865326	2	2021-02-12	2021-06-01
100109271865326	1	2021-08-25	\N
150056887375968	1	2017-04-14	2017-04-14
150056887375968	1	2019-06-16	2019-06-16
150056887375968	1	2021-11-10	2021-11-10
233039425007949	1	2016-12-01	2016-12-01
233039425007949	1	2021-05-26	2021-05-26
264107842330942	1	2016-12-01	2016-12-01
264107842330942	1	2018-02-24	2018-02-24
134020487954794	1	2017-10-12	2017-10-12
134020487954794	1	2019-02-11	2019-02-11
150038037909168	1	2020-07-20	2020-07-20
150038037909168	1	2020-09-13	2020-09-13
150038037909168	1	2020-11-27	2020-11-27
114040705604665	1	2018-09-11	2020-12-01
114040705604665	3	2021-07-06	2021-07-06
114040705604665	1	2021-09-03	2021-12-01
281011552942390	1	2017-07-05	2017-07-05
208073703603064	1	2016-04-28	2016-04-28
208073703603064	1	2018-07-15	2018-07-15
195124129077459	1	2019-03-27	2019-03-27
195124129077459	1	2020-12-01	2020-12-01
203042945551495	6	2015-02-18	2019-11-28
203042945551495	2	2020-09-22	2020-09-24
283058967147128	1	2019-06-22	2019-06-22
118058843585359	1	2015-08-19	2021-12-01
245083736982839	1	2019-08-01	2019-08-01
113076417665792	2	2017-01-14	2021-04-20
113076417665792	2	2021-11-07	\N
116019000258412	2	2017-06-16	2017-09-14
116019000258412	1	2017-11-01	2017-12-01
131120964176884	1	2018-11-03	2018-11-03
149111387041541	1	2019-01-27	2019-01-27
149111387041541	1	2020-01-27	2020-01-27
149111387041541	1	2020-03-16	2020-03-16
153128900719727	1	2018-04-14	2018-04-14
153128900719727	1	2018-11-07	2018-11-07
153128900719727	1	2018-12-01	2018-12-01
150034197947334	3	2018-06-19	\N
245028537507582	1	2016-10-05	2016-10-05
252106588392132	1	2015-12-01	2015-12-01
252106588392132	1	2019-06-08	2019-06-08
252106588392132	1	2021-12-01	2021-12-01
159013980820603	1	2017-07-26	2017-07-26
163054889165115	1	2018-01-20	2020-03-03
163054889165115	2	2021-05-09	2021-07-28
163054889165115	5	2021-10-03	2021-10-09
163054889165115	3	2021-11-15	2021-11-28
163054889165115	1	2021-12-01	\N
114092770726295	3	2021-05-16	2021-07-27
114092770726295	3	2021-11-09	2021-11-10
114092770726295	3	2021-12-01	2021-12-01
251123729430821	4	2019-02-24	2020-11-13
251123729430821	3	2021-09-01	2021-10-09
251123729430821	2	2021-12-01	2021-12-01
193071493716975	4	2021-09-12	2021-10-13
193071493716975	1	2021-10-26	2021-11-18
106099937166117	1	2015-12-01	2015-12-01
106099937166117	1	2015-11-23	2015-11-23
106099937166117	1	2017-07-18	2017-07-18
123032531483026	1	2017-07-13	2017-07-13
131084231150591	1	2021-10-05	2021-10-05
209027164298065	4	2019-12-01	2021-07-19
209027164298065	6	2021-12-01	2021-12-01
199078543975254	1	2018-06-18	2018-06-18
199078543975254	1	2021-06-26	2021-06-26
100049631898104	1	2016-07-13	2016-07-13
234053975548370	1	2019-02-20	2019-02-20
184025786706731	5	2016-11-23	2019-06-21
274022481152500	1	2019-06-27	2019-06-27
274022481152500	1	2021-10-27	2021-10-27
274022481152500	1	2018-07-19	2018-07-19
240026048838751	1	2016-08-05	2016-08-05
178054655023440	1	2017-12-01	2017-12-01
174030300877871	1	2018-11-06	2018-11-06
174030300877871	1	2019-05-16	2019-05-16
110080140197255	1	2020-07-12	2020-07-12
110080140197255	1	2021-08-12	2021-08-12
110080140197255	1	2021-08-14	2021-08-14
161034008075245	3	2021-09-24	2021-12-01
188118883989333	1	2020-12-01	2020-12-01
188118883989333	1	2021-06-11	2021-06-11
188118883989333	1	2021-08-25	2021-08-25
107032841366591	1	2015-04-04	2015-04-04
107032841366591	1	2015-12-01	2015-12-01
107032841366591	1	2017-10-21	2017-10-21
258012906416470	1	2017-06-24	2017-06-24
258012906416470	1	2021-03-13	2021-03-13
258012906416470	1	2021-11-09	2021-11-09
230118436329405	1	2015-10-06	2015-10-06
230118436329405	1	2015-11-26	2015-11-26
230118436329405	1	2017-05-05	2017-05-05
181044191868718	1	2018-09-18	2018-09-18
181044191868718	1	2019-06-23	2019-06-23
146084909826612	1	2020-10-20	2020-10-20
146084909826612	1	2021-07-15	2021-07-15
146084909826612	1	2021-08-01	2021-08-01
192016782931511	1	2016-01-22	2016-01-22
192016782931511	1	2016-02-27	2016-02-27
259074697674603	1	2016-04-05	2016-04-05
259074697674603	1	2021-10-10	2021-10-10
259074697674603	1	2021-10-11	2021-10-11
127019244540438	2	2021-07-15	\N
148121190383571	1	2020-10-05	2021-05-26
148121190383571	5	2021-08-17	2021-10-22
264107910075035	1	2019-09-25	2019-09-25
264107910075035	1	2019-10-21	2019-10-21
210030438953147	1	2020-11-06	2020-11-06
210030438953147	1	2020-11-24	2020-11-24
210042436071478	1	2018-09-11	2018-09-11
210042436071478	1	2020-04-15	2020-04-15
210042436071478	1	2021-06-11	2021-06-11
134051402379911	5	2018-04-10	2018-08-11
134051402379911	1	2019-01-22	2020-04-19
134051402379911	4	2020-08-19	2021-05-19
134051402379911	3	2021-05-21	2021-05-21
134051402379911	6	2021-08-01	2021-08-13
196018757049140	1	2015-09-12	2018-04-15
196018757049140	2	2019-11-26	2020-09-28
196018757049140	3	2021-09-28	\N
170115855210295	1	2019-05-03	2019-05-03
170115855210295	1	2019-07-08	2019-07-08
176108949873359	3	2015-05-10	2021-04-26
176108949873359	5	2021-06-09	2021-10-01
176108949873359	6	2021-12-01	2021-12-01
292032690622575	1	2020-09-08	2020-09-08
297025448866853	1	2019-07-11	2019-07-11
297025448866853	1	2019-11-28	2019-11-28
297025448866853	1	2015-06-20	2015-06-20
239057582114519	1	2021-02-09	2021-02-09
239057582114519	1	2021-07-24	2021-07-24
189061293903962	1	2020-10-05	2020-10-05
189061293903962	1	2021-12-01	2021-12-01
107021159794718	1	2016-07-25	2016-07-25
107021159794718	1	2021-08-12	2021-08-12
235050703254130	1	2015-01-20	2015-01-20
235050703254130	1	2017-12-01	2017-12-01
225058455250413	1	2020-09-23	2020-09-23
225058455250413	1	2020-09-26	2020-09-26
150086595242939	1	2016-01-03	2016-01-03
150086595242939	1	2016-08-21	2016-08-21
150086595242939	1	2020-12-01	2020-12-01
103076152831337	1	2019-02-03	2019-02-03
103076152831337	1	2019-03-24	2019-03-24
103076152831337	1	2020-04-12	2020-04-12
198080243696000	6	2017-06-06	2017-12-01
198080243696000	1	2021-08-17	2021-11-27
198080243696000	1	2021-11-28	\N
185082755251667	5	2019-03-07	2021-02-16
185082755251667	3	2021-11-22	2021-11-23
185082755251667	2	2021-12-01	2021-12-01
152011275394961	1	2017-06-04	2017-06-04
152011275394961	1	2021-06-20	2021-06-20
152011275394961	1	2021-12-01	2021-12-01
240121987869929	1	2018-06-26	2018-06-26
240121987869929	1	2018-12-01	2018-12-01
240121987869929	1	2021-10-04	2021-10-04
121107075333327	1	2017-02-11	2017-02-11
121107075333327	1	2019-08-09	2019-08-09
121107075333327	1	2021-11-06	2021-11-06
290043665477208	1	2016-09-02	2016-09-02
224039225017336	1	2019-04-22	2019-04-22
255093111334747	1	2015-02-28	2015-02-28
255093111334747	1	2018-08-24	2018-08-24
154070228992208	1	2019-09-06	2019-09-06
154070228992208	1	2021-04-02	2021-04-02
279121641670735	1	2015-03-22	2015-03-22
279121641670735	1	2021-01-14	2021-01-14
279121641670735	1	2021-04-07	2021-04-07
266092921839948	6	2020-12-01	2020-12-01
266092921839948	3	2021-08-19	2021-11-21
266092921839948	6	2021-11-22	2021-12-01
283124185961943	1	2018-09-12	2018-09-12
283124185961943	1	2018-09-20	2018-09-20
111013917857673	1	2018-07-25	2018-07-25
111013917857673	1	2020-11-13	2020-11-13
111013917857673	1	2021-03-26	2021-03-26
221111999395911	1	2015-07-15	\N
131109142556613	3	2018-12-01	2020-04-06
131109142556613	1	2021-02-20	2021-08-09
127020452119710	4	2016-09-01	2020-09-25
127020452119710	5	2021-01-25	\N
187014852065018	1	2018-12-01	2021-05-10
187014852065018	5	2021-06-05	2021-11-28
169025278120012	1	2021-12-01	2021-12-01
143033632736665	6	2019-09-11	2021-03-22
143033632736665	6	2021-03-27	2021-10-20
113072827979823	1	2018-09-23	2018-09-23
113072827979823	1	2019-09-26	2019-09-26
113072827979823	1	2019-12-01	2019-12-01
174083131677691	1	2021-10-06	2021-10-06
240030208771657	1	2015-07-15	2015-07-15
240030208771657	1	2017-11-04	2017-11-04
240030208771657	1	2018-04-23	2018-04-23
147030287258403	1	2017-05-04	2018-07-03
147030287258403	5	2019-10-22	2021-05-19
108114213276615	1	2018-05-24	2018-05-25
108114213276615	6	2020-09-10	\N
231072312146616	1	2017-08-15	2017-08-15
135030745344836	1	2020-09-10	2020-09-10
135030745344836	1	2020-10-23	2020-10-23
260059790196310	4	2016-12-01	2021-10-04
145041267838254	3	2016-06-18	2017-11-17
145041267838254	3	2021-08-09	2021-10-15
145041267838254	1	2021-10-17	2021-10-21
145041267838254	2	2021-12-01	2021-12-01
114014067183365	1	2016-08-08	2016-08-08
114014067183365	1	2019-01-24	2019-01-24
178067934684562	1	2021-10-18	2021-10-18
174053709791679	1	2019-02-10	2019-02-10
174053709791679	1	2019-05-15	2019-05-15
141125258291919	1	2020-08-21	2020-08-21
142086019899660	1	2018-01-09	2018-01-09
142086019899660	1	2020-07-16	2020-07-16
180084675181912	3	2015-01-11	2017-02-08
131125067536259	6	2021-01-14	2021-02-25
131125067536259	4	2021-04-24	\N
149077433486489	5	2016-02-01	2017-11-19
149077433486489	1	2019-06-03	\N
292042271914783	6	2019-10-12	2020-09-20
292042271914783	2	2021-08-25	2021-12-01
116032805072076	6	2017-04-11	\N
224019865233132	1	2019-09-07	2019-11-19
224019865233132	6	2021-05-09	2021-09-08
224019865233132	3	2021-12-01	2021-12-01
283097419522568	5	2016-01-13	2020-06-24
283097419522568	3	2020-10-03	2021-10-04
283097419522568	6	2021-10-15	2021-12-01
230116145833140	5	2019-12-01	2021-07-03
230116145833140	2	2021-11-12	2021-12-01
279055788448335	1	2020-03-21	2020-03-21
279055788448335	1	2020-12-01	2020-12-01
279055788448335	1	2017-03-21	2017-03-21
139058121016456	1	2018-09-18	2018-09-18
139058121016456	1	2019-02-12	2019-02-12
194094891582637	2	2015-04-10	2019-12-01
194094891582637	5	2021-11-14	\N
139011591930760	1	2017-12-01	2017-12-01
139011591930760	1	2019-08-23	2019-08-23
139011591930760	1	2020-02-27	2020-02-27
144116934442689	6	2021-03-24	2021-08-07
144116934442689	4	2021-09-03	2021-10-09
144116934442689	6	2021-12-01	2021-12-01
252030424521689	6	2018-06-23	2020-10-27
252030424521689	2	2021-07-08	2021-11-01
252030424521689	6	2021-11-03	2021-12-01
280076300617446	4	2019-03-07	2021-11-07
280076300617446	6	2021-11-28	2021-11-28
280076300617446	5	2021-12-01	\N
221067612519950	1	2018-11-18	2018-11-18
221067612519950	1	2018-12-01	2018-12-01
221067612519950	1	2020-01-26	2020-01-26
244027770559855	1	2020-01-15	2020-01-15
244027770559855	1	2021-06-25	2021-06-25
244027770559855	1	2021-09-27	2021-09-27
134044002643870	1	2020-10-15	2020-10-15
134044002643870	1	2021-11-23	2021-11-23
170084270924505	1	2020-10-10	2020-10-10
147037410601226	4	2018-02-20	2018-07-14
147037410601226	2	2018-12-01	2020-03-15
147037410601226	1	2021-10-17	2021-10-21
147037410601226	4	2021-11-06	2021-12-01
262128322011669	1	2020-02-17	2020-02-17
187102210975946	1	2016-08-14	2018-07-28
187102210975946	4	2021-02-22	2021-10-28
104045195800843	1	2020-03-14	2020-03-14
230039788083545	1	2019-06-04	2019-06-04
230039788083545	1	2019-10-20	2019-10-20
140035393058158	1	2017-02-19	2017-02-19
140035393058158	1	2019-07-17	2019-07-17
158041701121347	1	2019-01-01	2019-01-01
270061672667130	1	2021-01-22	2021-01-22
270061672667130	1	2021-11-17	2021-11-17
270061672667130	1	2021-12-01	2021-12-01
252034453461856	1	2019-08-18	2019-08-18
278016346820968	1	2018-03-24	2018-03-24
278016346820968	1	2021-09-21	2021-09-21
133060383952590	1	2021-09-02	2021-09-02
133060383952590	1	2021-10-08	2021-10-08
193068126328431	1	2019-03-24	2019-03-24
193068126328431	1	2021-10-28	2021-10-28
228068852384413	1	2018-12-01	2018-12-01
228068852384413	1	2020-08-16	2020-08-16
228068852384413	1	2018-10-14	2018-10-14
148112887355343	1	2021-12-01	2021-12-01
175013717803592	1	2021-02-22	2021-02-22
202017836106992	1	2021-01-04	2021-01-04
202017836106992	1	2021-06-07	2021-06-07
245102229936748	6	2017-03-21	2017-03-28
245102229936748	3	2019-12-01	2019-12-01
245102229936748	1	2020-05-02	2021-04-23
245102229936748	2	2021-12-01	\N
131085813863926	4	2021-11-26	2021-11-28
131085813863926	4	2021-12-01	2021-12-01
281017548940709	1	2015-04-22	2015-04-22
131054917320660	5	2016-01-04	2019-04-11
131054917320660	4	2021-01-13	2021-01-20
131054917320660	5	2021-08-22	2021-10-15
131054917320660	2	2021-11-07	2021-12-01
165118676503239	1	2020-11-28	2021-01-15
165118676503239	1	2021-08-09	2021-11-26
165118676503239	4	2021-11-27	2021-12-01
117084718549821	1	2020-12-01	2020-12-01
124041724420932	1	2021-08-13	2021-08-13
210070413119454	1	2018-04-15	2018-04-15
210070413119454	1	2020-10-23	2020-10-23
210070413119454	1	2021-03-01	2021-03-01
142078663953463	1	2018-04-27	2018-04-27
142078663953463	1	2020-02-07	2020-02-07
142078663953463	1	2020-03-01	2020-03-01
220033098580085	1	2021-06-23	2021-06-23
220033098580085	1	2021-11-02	2021-11-02
220033098580085	1	2021-11-09	2021-11-09
288072025161887	1	2020-11-24	2020-11-24
288072025161887	1	2021-10-11	2021-10-11
285115989191758	1	2020-12-01	2020-12-01
285115989191758	1	2021-12-01	2021-12-01
193020420013248	3	2021-09-11	2021-12-01
251083723773260	1	2017-01-28	2017-01-28
251083723773260	1	2018-03-10	2018-03-10
117018876276701	1	2016-12-01	2016-12-01
117018876276701	1	2021-04-16	2021-04-16
117018876276701	1	2021-04-20	2021-04-20
211055538833854	1	2018-01-04	2018-01-04
266011804752213	1	2021-12-01	2021-12-01
228105308454888	1	2021-06-12	2021-06-12
281086421940130	1	2021-03-20	2021-03-20
281086421940130	1	2021-10-07	2021-10-07
173041596006042	1	2018-04-21	2018-04-21
173041596006042	1	2020-04-22	2020-04-22
235103315320667	1	2019-08-25	2019-08-25
235103315320667	1	2021-02-07	2021-02-07
235103315320667	1	2021-11-28	2021-11-28
196066953664866	1	2020-11-19	2020-11-19
196066953664866	1	2021-11-28	2021-11-28
196066953664866	1	2021-12-01	2021-12-01
100097374384987	1	2019-01-13	2019-01-13
100097374384987	1	2021-10-28	2021-10-28
281027685467381	1	2018-09-11	2018-09-11
288063479168564	4	2021-01-10	2021-07-24
288063479168564	1	2021-09-18	2021-11-20
288063479168564	3	2021-11-26	2021-11-28
288063479168564	6	2021-12-01	\N
244054666231017	1	2015-08-24	2015-08-24
244054666231017	1	2021-01-20	2021-01-20
244054666231017	1	2021-07-24	2021-07-24
145018037213375	1	2016-10-25	2016-10-25
145018037213375	1	2017-04-06	2017-04-06
222071821111846	1	2015-10-15	2015-10-15
222071821111846	1	2017-05-02	2017-05-02
137014618658034	3	2019-04-01	2020-09-11
137014618658034	2	2021-01-28	2021-04-02
137014618658034	3	2021-05-12	2021-08-09
137014618658034	3	2021-10-23	2021-11-15
137014618658034	4	2021-11-18	2021-12-01
117035495904467	1	2018-02-25	2018-02-25
120085453420861	1	2019-04-17	\N
107062454569949	1	2015-05-22	2015-05-22
107062454569949	1	2021-12-01	2021-12-01
174052321465035	1	2018-06-27	2018-06-27
203082364962173	1	2020-12-01	2020-12-01
251041230601930	6	2018-06-22	2020-05-16
251041230601930	4	2021-06-25	2021-10-26
251041230601930	5	2021-10-27	2021-10-28
155032782058795	2	2015-07-24	2021-10-28
155032782058795	6	2021-12-01	2021-12-01
235018357073752	1	2017-09-08	2017-09-08
235018357073752	1	2017-09-12	2017-09-12
235018357073752	1	2018-06-23	2018-06-23
219103662330782	1	2015-07-24	2015-07-24
242023117314654	1	2018-11-05	2018-11-05
242023117314654	1	2020-10-05	2020-10-05
278024853925779	6	2015-05-14	2019-07-15
278024853925779	4	2020-11-13	2020-11-17
278024853925779	4	2020-11-27	2021-06-11
278024853925779	6	2021-10-08	2021-11-16
278024853925779	4	2021-11-26	\N
166061059911408	1	2018-11-08	2018-11-08
166061059911408	1	2021-03-06	2021-03-06
166061059911408	1	2021-10-15	2021-10-15
143056272653974	1	2017-07-18	2017-07-18
143056272653974	1	2019-10-28	2019-10-28
111084417670770	1	2019-03-01	2019-03-01
111084417670770	1	2019-07-07	2019-07-07
202082616139782	1	2019-01-20	2019-01-20
202082616139782	1	2020-03-12	2020-03-12
202082616139782	1	2020-08-14	2020-08-14
121119302153015	1	2016-10-22	2016-10-22
121119302153015	1	2018-08-16	2018-08-16
121119302153015	1	2018-11-19	2018-11-19
254032393904711	1	2016-08-27	2016-08-27
259073450270161	1	2016-02-27	2016-02-27
237063613562087	3	2019-06-22	2020-06-23
237063613562087	6	2021-06-24	2021-07-03
237063613562087	5	2021-08-03	\N
210069408347984	2	2018-11-04	2019-04-18
210069408347984	2	2020-11-19	2020-11-28
210069408347984	6	2021-05-04	2021-12-01
150050950892813	1	2020-12-01	2020-12-01
150050950892813	1	2016-12-01	2016-12-01
264043641280038	1	2021-06-26	2021-06-26
264043641280038	1	2021-11-09	2021-11-09
264043641280038	1	2021-12-01	2021-12-01
137017091980101	1	2017-07-21	2017-07-21
136020837557549	1	2015-09-17	2015-09-17
136020837557549	1	2015-10-19	2015-10-19
136020837557549	1	2019-01-27	2019-01-27
138066290675800	2	2019-07-05	2021-02-02
138066290675800	2	2021-11-03	2021-11-03
138066290675800	1	2021-12-01	2021-12-01
162108651894204	1	2020-03-22	2020-03-22
171045149446952	1	2016-03-02	2016-03-02
171045149446952	1	2017-12-01	2017-12-01
171045149446952	1	2020-11-20	2020-11-20
116057590333638	1	2020-03-15	2020-03-15
116057590333638	1	2021-03-21	2021-03-21
189044619488168	1	2016-07-24	2016-07-24
189044619488168	1	2018-02-10	2018-02-10
189044619488168	1	2021-01-07	2021-01-07
292077605072543	1	2020-06-19	2020-06-19
292077605072543	1	2020-07-18	2020-07-18
252102748808594	1	2017-05-18	2017-05-18
134063838698377	1	2018-08-08	2018-08-08
271081608987354	5	2015-12-01	2019-03-23
271081608987354	2	2020-06-27	2021-06-28
271081608987354	3	2021-08-21	2021-12-01
135084429086369	6	2017-01-10	2021-05-07
135084429086369	2	2021-05-26	2021-10-26
135084429086369	1	2021-10-28	2021-12-01
213018169533032	1	2021-09-28	2021-09-28
213018169533032	1	2016-10-14	2016-10-14
213018169533032	1	2018-06-28	2018-06-28
115101172827851	1	2020-10-14	2021-03-05
115101172827851	6	2021-08-22	2021-09-06
115101172827851	3	2021-11-20	2021-11-23
115101172827851	5	2021-11-27	\N
224023519830794	1	2017-06-16	2017-06-16
224023519830794	1	2020-11-02	2020-11-02
224023519830794	1	2021-01-23	2021-01-23
113086414892889	1	2018-12-01	2018-12-01
113086414892889	1	2021-07-17	2021-07-17
113086414892889	1	2021-10-24	2021-10-24
145098366075373	1	2020-12-01	2020-12-01
145098366075373	1	2020-07-11	2020-07-11
134088596109320	5	2018-12-01	2020-03-06
134088596109320	6	2021-10-13	2021-12-01
283100127930094	1	2018-03-08	2018-03-08
283100127930094	1	2018-11-05	2018-11-05
108062368491491	1	2019-12-01	2019-12-01
295054346609627	3	2021-11-27	2021-11-27
295054346609627	5	2021-12-01	2021-12-01
175056307245608	1	2019-03-15	2019-03-15
175056307245608	1	2019-11-03	2019-11-03
245125275586869	1	2019-09-10	2019-09-10
245125275586869	1	2020-02-01	2020-02-01
245125275586869	1	2020-11-13	2020-11-13
184026584934683	1	2017-05-10	2017-05-10
184026584934683	1	2020-02-04	2020-02-04
276109369398817	1	2017-09-09	2017-09-09
276109369398817	1	2017-12-01	2017-12-01
276109369398817	1	2020-06-02	2020-06-02
258047954598738	6	2021-10-12	2021-11-15
258047954598738	2	2021-12-01	2021-12-01
159026101937367	6	2020-09-28	2020-09-28
159026101937367	1	2021-04-12	2021-08-11
159026101937367	1	2021-09-27	\N
281100914191380	1	2021-08-08	2021-08-08
281100914191380	1	2021-08-22	2021-08-22
281100914191380	1	2021-12-01	2021-12-01
265041036297803	1	2017-09-19	2020-02-08
265041036297803	2	2020-03-22	2021-03-22
265041036297803	6	2021-12-01	2021-12-01
172027357912624	1	2017-04-05	2017-04-05
172027357912624	1	2021-03-19	2021-03-19
172027357912624	1	2021-06-05	2021-06-05
113090769708903	1	2021-05-27	2021-05-27
285090329769836	1	2015-06-20	2015-06-20
285090329769836	1	2020-01-02	2020-01-02
285090329769836	1	2021-09-23	2021-09-23
235112226577695	1	2021-03-05	2021-03-05
235112226577695	1	2021-11-27	2021-11-27
146035915566546	1	2019-06-19	2019-11-28
146035915566546	5	2019-12-01	2020-10-26
146035915566546	5	2021-10-27	\N
127013049115072	1	2016-03-16	2016-03-16
127013049115072	1	2021-12-01	2021-12-01
276074955165911	1	2018-11-03	2018-11-03
276074955165911	1	2019-10-05	2019-10-05
274078327911985	1	2020-06-11	2020-06-11
274078327911985	1	2020-10-07	2020-10-07
274078327911985	1	2020-12-01	2020-12-01
297098982634129	1	2019-10-11	2019-10-11
266113030404841	5	2018-07-28	2019-07-28
266113030404841	4	2021-09-15	2021-09-27
266113030404841	6	2021-10-23	2021-12-01
291061465464580	1	2016-11-25	2016-11-25
291061465464580	1	2019-10-26	2019-10-26
297029265987716	1	2021-03-01	2021-03-01
297029265987716	1	2021-09-01	2021-09-01
297029265987716	1	2021-09-07	2021-09-07
278128075429694	1	2018-04-02	2018-04-02
278128075429694	1	2021-09-09	2021-09-09
278128075429694	1	2021-09-25	2021-09-25
184012353692245	3	2019-04-14	2019-12-01
184012353692245	1	2020-02-16	2020-11-26
184012353692245	2	2020-12-01	2021-08-20
184012353692245	1	2021-11-20	2021-11-28
165068074963681	4	2016-09-22	2019-02-18
165068074963681	3	2019-07-24	2020-07-24
165068074963681	1	2021-11-27	2021-12-01
188018753555015	1	2021-09-05	2021-09-05
188018753555015	1	2021-12-01	2021-12-01
125027234720831	3	2019-01-10	2021-03-03
125027234720831	4	2021-03-21	2021-12-01
198095494635982	1	2019-05-28	2019-05-28
151119609719317	3	2020-11-06	2021-09-12
151119609719317	2	2021-10-03	2021-12-01
178099170061457	1	2018-07-15	2018-07-15
178099170061457	1	2020-03-26	2020-03-26
178099170061457	1	2021-10-21	2021-10-21
238102455584257	1	2015-10-15	2015-10-15
174110177212641	1	2015-12-01	2015-12-01
174110177212641	1	2019-09-22	2019-09-22
238091262456688	1	2015-04-23	2015-04-23
119042090952757	1	2018-10-19	2018-10-19
247045170896320	2	2018-07-24	2021-11-03
247045170896320	2	2021-12-01	2021-12-01
182061185597144	1	2018-05-27	2018-05-27
182061185597144	1	2021-06-24	2021-06-24
182061185597144	1	2021-10-23	2021-10-23
177040756394858	1	2018-01-14	2018-01-14
216097269788636	1	2018-03-09	2018-03-09
216097269788636	1	2021-11-11	2021-11-11
240098636102457	5	2018-10-26	2020-08-20
240098636102457	4	2021-04-24	2021-07-27
240098636102457	1	2021-09-14	2021-09-27
240098636102457	5	2021-12-01	2021-12-01
223027723041314	1	2018-07-18	2018-07-18
223027723041314	1	2021-08-05	2021-08-05
223027723041314	1	2021-08-17	2021-08-17
142038029211702	1	2016-03-10	2020-08-18
142038029211702	1	2021-08-23	2021-11-21
142038029211702	3	2021-12-01	2021-12-01
119073774022947	1	2018-02-03	2018-02-03
119073774022947	1	2019-12-01	2019-12-01
203105428294586	2	2018-11-20	2021-11-27
203105428294586	6	2021-12-01	2021-12-01
127114505385305	1	2019-05-01	2019-05-01
203115204316722	5	2017-05-23	2021-06-03
203115204316722	6	2021-08-19	2021-12-01
143047530576868	2	2018-03-26	2020-03-27
252084845928826	1	2019-07-19	2019-07-19
158083284418230	1	2021-04-09	2021-04-09
158083284418230	1	2021-12-01	2021-12-01
276013421462837	1	2019-09-02	2019-09-03
276013421462837	6	2021-01-07	2021-03-05
184060750824654	1	2016-05-03	2016-05-03
184060750824654	1	2021-05-19	2021-05-19
287129112205056	1	2021-12-01	2021-12-01
108117505421653	5	2017-12-01	2018-06-06
108117505421653	2	2019-03-01	2021-09-24
108117505421653	6	2021-11-06	2021-11-27
296109313485906	1	2018-06-17	2018-06-17
296109313485906	1	2021-06-19	2021-06-19
276060158258875	1	2018-11-04	2018-11-04
119071350672351	6	2021-10-17	2021-10-17
119071350672351	4	2021-10-24	2021-11-27
119071350672351	3	2021-11-28	2021-11-28
119071350672351	4	2021-12-01	\N
287073546978367	1	2020-02-16	2020-02-16
287073546978367	1	2020-10-10	2020-10-10
216034868105920	1	2016-04-10	2016-04-10
216034868105920	1	2018-09-11	2018-09-11
216034868105920	1	2020-10-16	2020-10-16
240108256892560	1	2016-04-20	2016-04-20
240108256892560	1	2018-05-02	2018-05-02
240108256892560	1	2021-02-19	2021-02-19
144060491514938	5	2015-05-10	2021-04-06
144060491514938	5	2021-06-18	2021-06-20
144060491514938	4	2021-09-27	2021-09-28
144060491514938	1	2021-12-01	2021-12-01
263029938395133	1	2021-12-01	2021-12-01
139028225880780	3	2017-12-01	2020-06-28
139028225880780	1	2021-08-08	2021-12-01
139044509081733	5	2019-02-28	2019-10-23
139044509081733	3	2019-12-01	2019-12-01
139044509081733	4	2021-05-14	2021-07-19
139044509081733	5	2021-09-10	2021-09-24
139044509081733	6	2021-11-10	\N
286034536711317	1	2015-07-03	2015-07-03
267094158471577	6	2021-07-15	2021-12-01
275017674182759	1	2017-02-06	2018-02-19
275017674182759	4	2021-10-25	2021-10-25
192125134535252	1	2019-07-25	2019-07-25
192125134535252	1	2020-06-11	2020-06-11
153128663886446	2	2021-11-23	2021-11-23
153128663886446	2	2021-11-25	2021-12-01
181028245089128	1	2018-03-07	2018-03-07
205124133484803	1	2015-06-12	2015-06-12
205124133484803	1	2015-06-28	2015-06-28
205124133484803	1	2020-10-26	2020-10-26
141063251159329	1	2015-07-12	2015-07-12
141063251159329	1	2020-10-07	2020-10-07
295109643093570	1	2020-05-07	2020-05-07
100128404770065	1	2017-01-16	2017-01-16
100128404770065	1	2019-02-08	2019-02-08
291072587130734	5	2019-10-01	2020-07-10
291072587130734	3	2021-08-25	2021-10-12
291072587130734	3	2021-10-18	2021-10-27
291072587130734	1	2021-11-04	2021-11-21
163114987429449	1	2017-10-16	2017-10-16
296123698284802	1	2020-03-18	2020-03-18
100120657067241	1	2016-03-18	2016-03-18
100120657067241	1	2018-05-06	2018-05-06
100120657067241	1	2020-04-16	2020-04-16
220042537626746	1	2021-09-11	2021-09-11
220042537626746	1	2021-09-17	2021-09-17
117065165282646	1	2016-11-27	2016-11-27
117065165282646	1	2021-07-10	2021-07-10
209129284642422	1	2020-04-26	2021-11-23
209129284642422	1	2021-11-28	2021-11-28
209129284642422	4	2021-12-01	2021-12-01
160018543311945	1	2015-03-08	2015-03-08
160018543311945	1	2015-03-18	2015-03-18
160018543311945	1	2019-02-13	2019-02-13
131018894086716	1	2016-07-19	2016-07-19
148071204427033	1	2016-05-21	2016-05-21
148071204427033	1	2020-05-26	2020-05-26
215055219516728	1	2016-03-20	2016-03-20
215055219516728	1	2017-11-02	2017-11-02
215055219516728	1	2021-01-02	2021-01-02
288064789259254	1	2017-07-11	2017-07-11
288064789259254	1	2021-02-26	2021-02-26
288064789259254	1	2021-12-01	2021-12-01
209027484439592	1	2017-11-18	2017-11-18
209027484439592	1	2021-03-10	2021-03-10
209027484439592	1	2021-05-12	2021-05-12
112117737627127	1	2019-01-19	2019-01-19
112117737627127	1	2021-06-22	2021-06-22
212112177557168	1	2019-05-18	2019-05-18
212112177557168	1	2021-03-16	2021-03-16
212112177557168	1	2021-09-26	2021-09-26
259124262367720	1	2015-06-19	2015-06-19
243019440286294	1	2018-08-12	\N
250120320255028	1	2018-03-07	2018-03-07
250120320255028	1	2021-10-01	2021-10-01
168044544530751	3	2019-10-03	2020-04-13
168044544530751	2	2021-10-15	2021-11-23
168044544530751	2	2021-12-01	2021-12-01
197085058533851	1	2018-08-16	2018-08-16
197085058533851	1	2019-06-07	2019-06-07
189118296921538	1	2021-12-01	\N
172127121780306	1	2018-01-13	2018-01-13
172127121780306	1	2020-02-09	2020-02-09
106012829360503	3	2018-11-09	2021-02-04
106012829360503	5	2021-08-17	\N
257010508547422	1	2021-09-24	2021-09-24
288119294124480	3	2015-10-26	2015-12-01
288119294124480	5	2021-05-20	2021-08-20
288119294124480	6	2021-08-26	2021-09-03
288119294124480	6	2021-11-20	2021-11-25
288119294124480	4	2021-11-26	2021-11-27
263121043095750	1	2020-10-27	2020-10-27
263121043095750	1	2021-09-03	2021-09-03
263121043095750	1	2021-09-06	2021-09-06
169046777385625	1	2017-03-14	2017-03-14
254063151017850	1	2016-01-10	2016-01-10
254063151017850	1	2016-11-03	2016-11-03
242118914204961	1	2021-10-23	2021-10-23
290073918728392	6	2021-07-16	2021-11-12
290073918728392	3	2021-12-01	2021-12-01
191058534487268	1	2021-08-28	2021-08-28
118059785875590	1	2017-02-26	2017-02-26
255123911821943	3	2020-07-16	2020-10-06
255123911821943	3	2020-12-01	2021-03-19
255123911821943	3	2021-03-28	2021-09-27
255123911821943	6	2021-11-16	2021-11-28
255123911821943	5	2021-12-01	\N
252121548594422	1	2017-02-10	2017-02-10
252121548594422	1	2017-07-10	2017-07-10
146083034518235	1	2020-03-01	2020-03-01
146083034518235	1	2021-04-10	2021-04-10
146083034518235	1	2021-12-01	2021-12-01
215115275923744	1	2021-08-06	2021-12-01
255024434449320	3	2018-09-13	2020-04-07
255024434449320	6	2020-12-01	2020-12-01
255024434449320	6	2021-02-04	2021-06-26
255024434449320	5	2021-11-10	2021-11-24
292067301425678	4	2017-12-01	2018-06-05
292067301425678	2	2019-04-23	2019-04-25
292067301425678	4	2020-06-05	2021-12-01
238124835633617	1	2016-02-01	2016-02-01
238124835633617	1	2021-10-11	2021-10-11
238124835633617	1	2021-11-22	2021-11-22
250100390302501	4	2018-04-05	2020-11-28
250100390302501	5	2020-12-01	2020-12-01
115069780586192	4	2017-06-17	2020-12-01
115069780586192	5	2021-02-11	\N
269028582321089	1	2015-12-01	2015-12-01
269028582321089	2	2017-04-18	2021-09-03
269028582321089	1	2021-12-01	2021-12-01
228075544768360	1	2021-02-23	2021-02-23
228075544768360	1	2021-05-19	2021-05-19
228075544768360	1	2021-08-22	2021-08-22
115090459564033	1	2021-04-09	2021-04-09
136060268614388	1	2018-08-18	2018-08-18
136060268614388	1	2021-04-17	2021-04-17
239107525820988	2	2015-07-15	2020-04-28
239107525820988	5	2021-05-12	2021-11-08
277082499925687	1	2015-07-16	2015-07-16
277082499925687	1	2021-10-17	2021-10-17
277082499925687	1	2021-10-18	2021-10-18
149061089953964	1	2017-09-19	2017-09-19
149061089953964	1	2021-07-23	2021-07-23
155099604479331	3	2021-05-17	2021-06-02
249116658619254	1	2018-04-07	2018-04-07
249116658619254	1	2018-05-05	2018-05-05
249116658619254	1	2021-09-25	2021-09-25
248098356838047	1	2021-07-07	2021-07-07
248098356838047	1	2021-12-01	2021-12-01
169058905574093	1	2017-03-08	2017-03-08
169058905574093	1	2021-08-05	2021-08-05
288015091637034	1	2019-01-18	2019-01-18
288015091637034	1	2021-12-01	2021-12-01
137113043274402	1	2020-10-20	2020-10-20
137113043274402	1	2021-10-22	2021-10-22
137113043274402	1	2021-10-28	2021-10-28
257028814268392	2	2015-06-01	2017-07-24
257028814268392	2	2021-10-12	2021-11-08
257028814268392	5	2021-12-01	2021-12-01
119062273668288	1	2017-06-22	2017-06-22
119062273668288	1	2018-09-15	2018-09-15
137028151113684	1	2015-12-01	2015-12-01
183109362671564	1	2015-12-01	2015-12-01
177077015655367	1	2016-04-13	2016-04-13
177077015655367	1	2016-04-15	2016-04-15
177077015655367	1	2021-04-24	2021-04-24
113025853213883	1	2017-03-28	2017-03-28
113025853213883	1	2019-09-03	2019-09-03
279049861076510	4	2016-09-10	2021-10-22
279049861076510	6	2021-12-01	2021-12-01
105067076521029	1	2020-04-12	2020-04-12
234129579445893	1	2015-11-06	2015-11-06
234129579445893	1	2020-08-24	2020-08-24
234129579445893	1	2021-09-26	2021-09-26
262075456464328	2	2020-07-22	2020-07-28
262075456464328	5	2021-12-01	2021-12-01
103108171583767	3	2021-01-06	2021-08-23
103108171583767	4	2021-12-01	2021-12-01
289098686609121	1	2015-11-02	2015-11-02
261034304478401	1	2016-06-17	2018-05-18
261034304478401	6	2021-06-22	2021-08-22
261034304478401	2	2021-10-17	2021-11-19
261034304478401	4	2021-12-01	2021-12-01
135019316894863	1	2019-08-02	2019-08-02
143082928850324	1	2021-01-16	2021-01-16
143082928850324	1	2021-12-01	2021-12-01
150112983981791	1	2017-02-08	2017-02-08
150112983981791	1	2017-11-08	2017-11-08
194093230655172	1	2015-10-23	2015-10-23
194093230655172	1	2021-11-18	2021-11-18
172081474790883	1	2015-11-07	2016-11-15
172081474790883	2	2021-08-11	2021-08-27
172081474790883	1	2021-10-14	2021-10-19
249028848217580	1	2017-09-18	2017-09-18
249028848217580	1	2017-12-01	2017-12-01
249028848217580	1	2020-10-15	2020-10-15
110062997134954	1	2017-04-01	2017-04-01
110062997134954	1	2017-09-11	2017-09-11
110062997134954	1	2018-05-24	2018-05-24
212049852961463	1	2015-11-05	2015-11-05
279106952353170	2	2015-10-13	2019-09-01
279106952353170	4	2021-01-11	2021-06-12
279106952353170	1	2021-12-01	2021-12-01
228118075183751	1	2016-08-26	2016-08-26
185032891472891	5	2019-07-17	\N
176079215128294	5	2021-04-21	2021-11-24
227031686466265	3	2019-09-16	2021-03-01
108095665815271	1	2019-09-15	2019-09-15
108095665815271	1	2019-11-14	2019-11-14
108095665815271	1	2020-11-28	2020-11-28
293067295193883	5	2019-03-15	2021-10-24
293067295193883	1	2021-12-01	\N
146021627018427	1	2021-04-03	2021-04-03
224030202539094	1	2021-06-18	2021-06-18
224030202539094	1	2021-09-21	2021-09-21
224030202539094	1	2021-10-01	2021-10-01
177029853259907	1	2018-06-08	2018-10-20
177029853259907	6	2020-06-15	2021-09-13
170054073041927	3	2021-06-11	2021-07-16
170054073041927	5	2021-12-01	2021-12-01
187073819892261	1	2021-01-22	2021-01-22
272100390058901	1	2018-12-01	2018-12-01
199080501008050	1	2015-09-20	2015-09-20
110094961795134	1	2020-04-05	2020-04-05
110094961795134	1	2020-05-23	2020-05-23
110094961795134	1	2021-02-01	2021-02-01
217039324734896	1	2018-10-25	2018-10-25
174059385899556	2	2016-04-20	2019-08-19
169071676568835	6	2017-07-21	2021-07-28
169071676568835	3	2021-09-26	2021-11-12
225068887084592	1	2020-07-24	2020-07-24
195084616272454	5	2016-09-07	2019-04-23
195084616272454	5	2020-10-28	2020-12-01
195084616272454	3	2021-03-26	2021-09-09
195084616272454	1	2021-10-13	2021-11-15
195084616272454	4	2021-11-22	\N
285047209123387	1	2021-11-02	2021-11-02
285047209123387	1	2021-12-01	2021-12-01
172013763767596	1	2018-11-07	2018-11-07
272048448848606	6	2020-12-01	2020-12-01
272048448848606	3	2021-01-10	2021-03-25
272048448848606	5	2021-09-26	2021-09-26
272048448848606	3	2021-10-15	2021-12-01
143040375736731	6	2021-12-01	2021-12-01
149050153967537	1	2016-05-03	2016-05-03
149050153967537	1	2016-07-13	2016-07-13
149050153967537	1	2016-09-28	2016-09-28
116049935189022	1	2019-07-24	2019-07-24
116049935189022	1	2019-12-01	2019-12-01
116049935189022	1	2020-08-05	2020-08-05
188097216431952	5	2019-09-27	2021-01-16
188097216431952	2	2021-11-11	2021-11-25
188097216431952	6	2021-12-01	2021-12-01
216082764922433	1	2019-03-12	2019-03-12
216082764922433	1	2019-12-01	2019-12-01
216082764922433	1	2020-05-27	2020-05-27
224115970622441	1	2016-03-18	2016-03-18
224115970622441	1	2020-06-04	2020-06-04
285114788952558	1	2020-02-24	2020-02-24
285114788952558	1	2020-03-11	2020-03-11
285114788952558	1	2021-10-23	2021-10-23
247075491328391	1	2021-01-04	2021-01-04
247075491328391	1	2021-03-01	2021-03-01
247075491328391	1	2021-07-24	2021-07-24
271022923220246	1	2018-11-24	2018-11-24
271022923220246	1	2020-01-04	2020-01-04
111030591034594	1	2018-04-27	2018-04-27
257059520141788	3	2016-10-01	2019-12-01
257059520141788	2	2021-04-07	2021-05-06
240114567406709	6	2019-06-06	\N
167021630244142	1	2018-12-01	2018-12-01
268088051496928	1	2018-09-19	2018-09-19
268088051496928	1	2019-06-03	2019-06-03
254068184803144	1	2018-08-02	2018-08-02
254068184803144	1	2021-08-14	2021-08-14
236045389806266	1	2017-10-04	\N
145026259569030	1	2017-01-09	2017-01-09
145026259569030	1	2017-11-07	2017-11-07
255091764125894	1	2017-05-25	2017-05-25
255091764125894	1	2017-09-09	2017-09-09
246079035822823	5	2020-11-19	2020-11-28
246079035822823	3	2021-06-10	2021-12-01
242043622468996	1	2015-03-01	2015-03-01
242043622468996	1	2015-09-25	2015-09-25
242043622468996	1	2018-12-01	2018-12-01
103096383824071	1	2018-10-02	2018-10-02
103096383824071	1	2021-07-21	2021-07-21
268064292795561	1	2016-06-28	2016-06-28
268064292795561	1	2017-05-13	2017-05-13
268064292795561	1	2019-02-20	2019-02-20
299111020477610	1	2016-08-23	2020-11-06
299111020477610	2	2021-08-22	2021-10-28
299111020477610	3	2021-11-08	2021-11-27
299111020477610	6	2021-12-01	2021-12-01
135045223209774	1	2017-09-05	2017-09-05
135045223209774	1	2020-02-23	2020-02-23
135045223209774	1	2020-02-26	2020-02-26
242012498306039	1	2019-12-01	2019-12-01
242012498306039	5	2020-11-14	2021-12-01
206099679755550	1	2021-07-24	2021-07-24
206099679755550	1	2021-09-05	2021-09-05
206099679755550	1	2021-09-10	2021-09-10
153107527788126	1	2017-03-02	2017-03-02
288061199802041	1	2017-01-15	2017-01-15
288061199802041	1	2017-09-16	2017-09-16
171059332834846	1	2015-06-02	2015-06-02
171059332834846	1	2015-12-01	2015-12-01
171059332834846	1	2017-10-09	2017-10-09
106011084231378	6	2021-02-13	2021-06-04
106011084231378	6	2021-08-11	\N
192122702640673	1	2016-01-17	2016-01-17
144058651158085	5	2016-08-22	\N
297036084866434	1	2016-07-01	2016-07-01
297036084866434	1	2018-10-27	2018-10-27
104024782793871	1	2018-05-08	2018-05-08
104024782793871	1	2018-10-10	2018-10-10
104024782793871	1	2020-06-10	2020-06-10
256062556405124	1	2015-03-07	2015-03-07
188057492936580	1	2018-02-06	2018-02-06
188057492936580	1	2018-04-18	2018-04-18
188057492936580	1	2019-02-10	2019-02-10
100093386790971	2	2021-05-16	2021-10-12
100093386790971	2	2021-11-06	2021-12-01
145107728311572	3	2016-06-21	2020-12-01
145107728311572	5	2021-05-11	2021-12-01
256025976064713	6	2020-03-25	\N
118041223330245	1	2020-01-10	2020-01-10
118041223330245	1	2021-08-09	2021-08-09
118041223330245	1	2021-08-21	2021-08-21
156125231843210	1	2019-12-01	2019-12-01
108097522748111	1	2015-05-25	2015-05-25
108097522748111	1	2020-01-12	2020-01-12
108097522748111	1	2021-03-04	2021-03-04
116026335121455	3	2016-11-23	2016-12-01
116026335121455	6	2018-04-23	2020-08-12
193033556420427	1	2016-01-21	2016-01-21
193033556420427	1	2018-10-24	2018-10-24
157103185444294	1	2016-12-01	2016-12-01
158125852966745	1	2021-04-10	2021-04-10
158125852966745	1	2021-12-01	2021-12-01
238087013966826	1	2018-04-06	2018-04-06
238087013966826	1	2018-04-08	2018-04-08
245085054653774	1	2018-08-02	2021-09-03
245085054653774	3	2021-11-11	2021-11-22
245085054653774	2	2021-11-24	2021-11-25
245085054653774	6	2021-12-01	2021-12-01
129099269265203	1	2016-08-15	2016-08-15
129099269265203	1	2019-07-08	2019-07-08
137067952932213	5	2017-04-07	2018-09-08
137067952932213	2	2021-04-05	\N
181097995658562	1	2019-11-20	2019-11-20
181097995658562	1	2019-11-21	2019-11-21
129015333191150	1	2017-03-21	2017-03-21
252076491934774	4	2016-06-01	2020-02-07
252076491934774	2	2021-09-07	2021-12-01
137084945054430	1	2015-08-19	2015-08-19
123038603569252	1	2016-02-07	2016-02-07
284046374475926	1	2018-06-20	2018-06-20
284046374475926	1	2020-08-19	2020-08-19
162024692293914	1	2015-04-23	2015-04-23
162024692293914	1	2015-10-04	2015-10-04
286071597914575	3	2017-03-15	\N
139062755438909	1	2019-06-18	2019-06-18
139062755438909	1	2020-09-22	2020-09-22
139062755438909	1	2021-04-20	2021-04-20
102019659160308	1	2020-01-23	2020-01-23
102019659160308	1	2021-09-13	2021-09-13
150081201116183	1	2016-02-05	2016-02-05
150081201116183	1	2016-07-01	2016-07-01
147085285282844	1	2020-12-01	2020-12-01
295012888306237	1	2016-08-12	2016-08-12
295012888306237	1	2021-05-14	2021-05-14
295012888306237	1	2021-09-19	2021-09-19
228121380869080	1	2018-11-04	2018-11-04
228121380869080	1	2021-03-25	2021-03-25
209076917524931	1	2017-02-22	2017-02-22
209076917524931	1	2017-08-26	2017-08-26
114128201353291	1	2015-06-18	2017-10-22
114128201353291	6	2017-12-01	2018-08-13
114128201353291	4	2019-07-09	2021-04-01
140021024071878	4	2021-05-15	2021-09-24
140021024071878	1	2021-12-01	\N
122070309199973	1	2017-10-03	\N
262078078553170	1	2016-12-01	2016-12-01
262078078553170	1	2018-06-02	2018-06-02
262078078553170	1	2018-08-01	2018-08-01
214058422588031	1	2017-08-26	2017-08-26
214058422588031	1	2021-08-26	2021-08-26
214058422588031	1	2021-12-01	2021-12-01
297018588389986	4	2020-10-09	\N
270091948045432	1	2016-10-17	2016-10-17
270091948045432	1	2019-02-05	2019-02-05
270091948045432	1	2021-12-01	2021-12-01
131085984245638	1	2016-06-02	2016-06-02
217077302350914	1	2015-11-20	2015-11-20
217077302350914	1	2017-06-13	2017-06-13
247064950013140	4	2020-03-08	2020-05-02
247064950013140	4	2020-12-01	2020-12-01
247064950013140	3	2021-03-18	\N
103065213906618	1	2021-09-18	2021-09-18
103065213906618	1	2021-09-28	2021-09-28
264074023702284	3	2021-05-25	\N
104110590911744	5	2018-03-10	2020-06-10
104110590911744	1	2020-11-13	2020-12-01
104110590911744	4	2021-03-23	2021-06-12
104110590911744	2	2021-09-27	2021-12-01
272103843045703	1	2020-04-02	2020-04-02
257080110522152	4	2019-05-21	2020-10-25
257080110522152	3	2021-10-28	2021-11-10
274088813916527	1	2020-03-25	2020-03-25
274088813916527	1	2021-10-06	2021-10-06
208118561794850	1	2016-03-14	2016-03-14
208118561794850	1	2020-05-04	2020-05-04
289108977900206	1	2021-08-12	2021-08-12
138105592649180	1	2020-05-28	2020-05-28
138105592649180	1	2015-06-12	2015-06-12
138105592649180	1	2016-08-18	2016-08-18
255088965332455	1	2018-08-20	2018-08-20
243013407647544	2	2016-06-08	2018-11-09
243013407647544	5	2019-12-01	2019-12-01
243013407647544	6	2021-08-01	2021-11-26
243013407647544	2	2021-11-27	\N
208089025109136	1	2019-06-04	2019-06-04
208089025109136	1	2020-04-08	2020-04-08
208089025109136	1	2020-09-10	2020-09-10
293129298699077	1	2018-09-20	2018-09-20
293129298699077	1	2021-11-09	2021-11-09
210043607648491	1	2020-02-18	2020-02-18
210043607648491	1	2020-06-15	2020-06-15
223122030311311	1	2015-09-25	2018-09-25
223122030311311	3	2018-12-01	2019-09-19
223122030311311	5	2021-11-17	2021-11-21
223122030311311	3	2021-12-01	2021-12-01
261019617230168	1	2017-01-09	2017-01-09
243066968428847	4	2016-10-14	2016-10-23
243066968428847	2	2019-06-14	2021-05-15
243066968428847	3	2021-11-08	2021-11-14
170080268839901	1	2016-11-13	2016-11-13
170080268839901	1	2018-08-03	2018-08-03
251120945328030	1	2015-10-17	2015-10-17
251120945328030	1	2018-07-22	2018-07-22
251120945328030	1	2019-05-05	2019-05-05
219116344306402	1	2018-04-04	2018-04-04
219116344306402	1	2019-07-16	2019-07-16
179098881632515	6	2016-12-01	2019-05-26
179098881632515	5	2019-12-01	2021-03-01
144018384174747	1	2016-12-01	2016-12-01
136114138407278	1	2016-09-21	2016-09-21
136114138407278	1	2016-10-15	2016-10-15
136114138407278	1	2020-06-06	2020-06-06
281019819289565	1	2018-01-20	2018-01-20
281019819289565	1	2018-12-01	2018-12-01
248115000202929	2	2021-11-16	2021-11-16
248115000202929	2	2021-11-24	2021-11-25
248115000202929	1	2021-12-01	2021-12-01
227073625053031	1	2021-03-21	2021-03-21
227073625053031	1	2021-08-03	2021-08-03
137012739426413	1	2018-04-18	2018-04-18
137012739426413	1	2021-09-16	2021-09-16
126068767532596	1	2019-05-10	2019-05-10
126068767532596	1	2019-09-16	2019-09-16
297118813515304	1	2016-09-27	2016-09-27
297118813515304	1	2016-12-01	2016-12-01
297118813515304	1	2020-10-07	2020-10-07
102017878755115	1	2017-02-02	2017-02-02
102017878755115	1	2017-05-09	2017-05-09
102017878755115	1	2019-10-15	2019-10-15
192108415007283	1	2015-06-13	2017-05-05
192108415007283	5	2018-01-21	2019-02-19
192108415007283	6	2019-12-01	2020-02-09
192108415007283	6	2021-08-23	2021-08-25
192108415007283	5	2021-11-20	2021-11-26
266105680605414	1	2017-06-22	2017-06-22
266105680605414	1	2021-06-24	2021-06-24
131125282953657	1	2016-07-14	2016-07-14
131125282953657	1	2017-06-16	2017-06-16
255078204802254	1	2017-05-02	2017-05-02
255078204802254	1	2018-03-13	2018-03-13
255078204802254	1	2019-01-02	2019-01-02
265121844820151	1	2021-02-15	2021-02-15
125015830509845	1	2017-10-16	2017-10-16
125015830509845	1	2020-05-10	2020-05-10
125015830509845	1	2021-11-15	2021-11-15
166028647357667	6	2018-02-17	2018-04-18
166028647357667	2	2018-11-21	2021-05-15
166028647357667	3	2021-12-01	2021-12-01
118112410272245	1	2016-07-12	2016-07-12
184029967452706	6	2018-05-23	2020-12-01
184029967452706	3	2021-07-27	2021-11-09
184029967452706	6	2021-12-01	2021-12-01
102085689984553	1	2020-08-20	2020-08-20
164084503884247	6	2018-11-08	\N
135074940491607	2	2019-07-17	2021-06-27
135074940491607	2	2021-12-01	2021-12-01
199030716614074	1	2021-04-28	2021-04-28
199030716614074	1	2020-05-27	2020-05-27
185079382958660	1	2020-01-26	2020-01-26
185079382958660	1	2021-11-05	2021-11-05
185079382958660	1	2021-12-01	2021-12-01
260115670258424	6	2017-02-02	2020-04-15
260115670258424	1	2021-03-15	2021-12-01
178092232278018	1	2018-02-11	2018-02-11
169074773920796	1	2016-10-01	2016-10-01
131070172653837	1	2016-03-22	2016-03-22
252123340003556	4	2015-07-18	2020-03-25
252123340003556	1	2021-08-04	2021-10-14
252123340003556	3	2021-11-23	2021-12-01
270049403545237	6	2019-01-15	2019-12-01
270049403545237	6	2021-06-12	2021-11-03
270049403545237	6	2021-11-05	2021-12-01
122013583993734	1	2020-11-05	2020-11-05
122013583993734	1	2020-12-01	2020-12-01
247064696896690	4	2021-01-10	2021-03-15
247064696896690	2	2021-05-20	2021-07-08
247064696896690	2	2021-07-16	2021-10-10
247064696896690	1	2021-11-11	2021-12-01
211103396685063	3	2021-12-01	2021-12-01
124068718826168	1	2019-02-11	2019-02-11
124068718826168	1	2020-12-01	2020-12-01
124068718826168	1	2021-11-22	2021-11-22
296038999707691	1	2020-01-05	2020-01-05
141037987029076	1	2017-04-22	2017-04-22
141037987029076	1	2018-09-14	2018-09-14
201081626343750	1	2015-09-02	2015-09-02
190047473188512	5	2019-05-09	2021-09-15
190047473188512	3	2021-10-09	2021-11-23
190047473188512	1	2021-12-01	2021-12-01
209038216146851	1	2016-07-08	2016-12-01
209038216146851	3	2017-03-01	2018-11-06
209038216146851	6	2018-12-01	2020-11-15
209038216146851	1	2021-03-20	\N
120027610567383	1	2018-02-10	2018-02-10
120027610567383	1	2021-05-04	2021-05-04
118099632841858	1	2016-05-21	2016-05-21
153023371372412	1	2016-08-17	2016-08-17
153023371372412	1	2016-11-11	2016-11-11
153023371372412	1	2019-05-05	2019-05-05
220035719909604	3	2015-05-16	2018-07-23
220035719909604	1	2019-01-20	\N
299128835735359	1	2020-05-12	2020-05-12
299128835735359	1	2021-10-08	2021-10-08
171096323748369	1	2018-09-14	2018-09-14
249118020522088	1	2016-01-08	2016-01-08
249118020522088	1	2020-08-28	2020-08-28
279037176177857	1	2019-04-12	2019-04-12
279037176177857	1	2019-11-05	2019-11-05
279037176177857	1	2021-10-27	2021-10-27
194123870040526	1	2015-08-26	2015-08-26
216050588792452	1	2020-05-05	2020-05-05
216050588792452	1	2020-06-11	2020-06-11
216050588792452	1	2021-09-17	2021-09-17
101027766706912	1	2017-09-03	2017-09-03
101027766706912	1	2020-04-20	2020-04-20
259024064714624	5	2018-11-23	2021-08-21
270014064481086	5	2015-11-08	2020-10-02
270014064481086	2	2020-11-21	2020-12-01
270014064481086	6	2021-02-17	2021-03-28
270014064481086	3	2021-08-17	2021-08-19
270014064481086	3	2021-08-25	\N
152050826723518	1	2016-10-04	2016-10-04
231078668662003	1	2015-12-01	2015-12-01
147034386292786	6	2016-04-17	2017-11-09
147034386292786	4	2021-09-18	2021-10-18
147034386292786	2	2021-11-06	2021-12-01
182014842853195	2	2016-08-26	2016-09-25
182014842853195	1	2019-11-17	2020-10-07
292083432286212	1	2017-03-21	2017-03-21
292083432286212	1	2019-07-15	2019-07-15
246033976246105	1	2020-07-16	2020-07-16
246033976246105	1	2021-07-23	2021-07-23
246033976246105	1	2021-09-27	2021-09-27
261055944395226	1	2021-10-08	2021-12-01
128055781153403	2	2018-11-21	2020-05-14
224059146621395	1	2020-08-24	2020-08-24
224059146621395	1	2020-12-01	2020-12-01
283114678495021	1	2017-08-18	2017-08-18
283114678495021	1	2019-04-16	2019-04-16
283114678495021	1	2021-10-15	2021-10-15
178014634707159	1	2017-04-14	2019-07-13
178014634707159	4	2021-08-15	2021-12-01
213083916917722	1	2017-01-13	2017-01-13
213083916917722	1	2018-07-22	2018-07-22
107084739343784	2	2015-12-01	2016-03-20
215085796076693	1	2017-06-22	2017-06-22
215085796076693	1	2021-12-01	2021-12-01
272071958103759	2	2019-04-17	2021-05-11
272071958103759	5	2021-09-09	2021-09-23
272071958103759	3	2021-12-01	2021-12-01
202046097430545	1	2017-03-14	2017-03-14
202046097430545	1	2018-11-15	2018-11-15
255053357438060	1	2019-11-19	2019-11-19
255053357438060	1	2020-09-18	2020-09-18
255053357438060	1	2020-09-19	2020-09-19
143094758250605	1	2019-02-20	2019-02-20
298015237621938	3	2020-06-13	2021-12-01
135013147654144	1	2018-06-28	2018-06-28
135013147654144	1	2020-01-26	2020-01-26
135013147654144	1	2021-07-14	2021-07-14
149056744712258	2	2015-06-12	2019-05-21
149056744712258	1	2019-07-19	2021-05-06
149056744712258	3	2021-05-11	2021-12-01
241091337496952	4	2020-07-19	2020-07-26
237123674082614	1	2018-07-20	2018-07-20
237123674082614	1	2018-07-21	2018-07-21
237123674082614	1	2020-05-21	2020-05-21
188107331612463	1	2017-09-12	2017-09-12
146038139963472	1	2016-12-01	2016-12-01
146038139963472	1	2019-06-27	2019-06-27
275071720303360	1	2018-10-06	2018-10-06
275071720303360	1	2020-08-15	2020-08-15
275071720303360	1	2020-12-01	2020-12-01
282064682723343	3	2015-02-03	2019-05-05
282064682723343	1	2019-05-19	\N
114101952090739	6	2015-04-10	2015-06-25
207107994278129	1	2019-03-25	2019-03-25
207107994278129	1	2020-02-16	2020-02-16
207107994278129	1	2021-02-21	2021-02-21
260055549848885	1	2020-04-01	2020-04-01
214020543515529	6	2019-07-02	2021-09-07
214020543515529	3	2021-11-25	2021-12-01
135100709107338	1	2021-08-23	2021-08-23
135100709107338	1	2021-11-15	2021-11-15
278106956056295	3	2015-06-17	2021-01-02
278106956056295	6	2021-12-01	2021-12-01
196044090469523	4	2020-04-22	2020-06-26
223077011150247	1	2018-06-07	2018-06-07
223077011150247	1	2019-11-08	2019-11-08
170032191239838	2	2018-06-22	2020-03-04
170032191239838	5	2020-10-25	\N
262094703954561	5	2020-08-04	2021-06-12
262094703954561	6	2021-12-01	\N
293098735454683	1	2016-04-16	2016-04-16
293098735454683	1	2017-09-23	2017-09-23
293098735454683	1	2017-11-06	2017-11-06
114031662892732	1	2018-07-13	2018-07-13
114031662892732	1	2019-07-15	2019-07-15
233063938553717	5	2018-07-28	2018-09-11
233063938553717	4	2019-10-21	2021-08-14
142027529465492	1	2016-10-03	2016-10-03
268081386395744	1	2016-06-12	2016-06-12
268081386395744	1	2018-11-11	2018-11-11
119125003483214	1	2020-10-20	2020-10-20
119125003483214	1	2021-04-07	2021-04-07
119125003483214	1	2021-08-28	2021-08-28
260083942923902	1	2019-04-20	2019-04-20
281111914382515	1	2020-06-25	2020-06-25
281111914382515	1	2021-11-22	2021-11-22
271010916937233	1	2016-04-09	2016-04-09
271010916937233	1	2016-12-01	2016-12-01
271010916937233	1	2021-07-14	2021-07-14
131052658062338	1	2018-06-26	2018-06-26
131052658062338	1	2020-12-01	2020-12-01
131052658062338	1	2021-03-04	2021-03-04
174018102858594	1	2020-04-20	2020-04-20
150072095960502	1	2017-09-07	2017-09-07
150072095960502	1	2020-01-26	2020-01-26
156112101254314	1	2018-03-02	2018-03-02
156112101254314	1	2020-02-13	2020-02-13
156112101254314	1	2021-10-08	2021-10-08
118094258078427	1	2017-09-17	2020-06-07
118094258078427	5	2020-07-23	2020-09-15
118094258078427	5	2021-05-11	2021-06-17
118094258078427	3	2021-08-11	\N
224043336251390	6	2021-04-10	2021-11-18
224043336251390	2	2021-11-19	2021-11-23
267066331716920	1	2021-02-21	2021-02-21
267066331716920	1	2021-06-06	2021-06-06
261077305981665	4	2021-10-21	2021-10-24
261077305981665	5	2021-12-01	2021-12-01
115016947696529	1	2016-12-01	\N
245044833929736	1	2017-10-23	2017-10-23
245044833929736	1	2018-04-09	2018-04-09
245044833929736	1	2018-05-27	2018-05-27
297073818905849	1	2020-08-17	2020-08-17
297073818905849	1	2021-02-24	2021-02-24
297073818905849	1	2021-12-01	2021-12-01
218112782420475	1	2019-11-10	2019-11-10
218112782420475	1	2021-08-07	2021-08-07
218112782420475	1	2021-11-15	2021-11-15
253026744850990	5	2019-06-02	2019-10-03
253026744850990	3	2021-01-09	2021-10-14
253026744850990	6	2021-11-07	2021-12-01
203124780561391	1	2018-08-21	2018-08-21
158036596308209	1	2015-07-23	2015-07-23
158036596308209	1	2020-11-22	2020-11-22
204038320321261	1	2016-07-25	2016-07-25
204038320321261	1	2016-09-22	2016-09-22
204038320321261	1	2021-03-09	2021-03-09
269054468621668	1	2021-05-15	2021-05-15
269054468621668	1	2021-11-19	2021-11-19
269054468621668	1	2021-11-28	2021-11-28
121086804762872	1	2019-11-10	2019-11-10
121086804762872	1	2021-07-17	2021-07-17
237061640815392	1	2016-12-01	2016-12-01
201074157091853	6	2017-12-01	2017-12-01
201074157091853	3	2019-05-26	2019-06-05
201074157091853	4	2020-05-25	\N
126033690529208	6	2019-05-11	2021-04-03
126033690529208	5	2021-11-05	2021-12-01
299035859508254	1	2016-12-01	2016-12-01
299035859508254	1	2016-10-09	2016-10-09
299035859508254	1	2018-01-20	2018-01-20
210075736883420	1	2015-06-08	2015-06-08
210075736883420	1	2015-10-22	2015-10-22
216089371391561	1	2017-01-02	2017-01-02
216089371391561	1	2019-01-26	2019-01-26
216089371391561	1	2021-09-13	2021-09-13
159034821642031	1	2018-05-11	2018-06-15
159034821642031	1	2018-08-11	2021-06-20
159034821642031	1	2021-11-01	2021-12-01
197098764923639	1	2018-02-20	2018-02-20
197098764923639	1	2021-01-18	2021-01-18
264017112670014	5	2017-04-01	2018-06-01
264017112670014	6	2018-09-10	2020-04-14
264017112670014	5	2020-04-19	2020-12-01
264017112670014	5	2021-04-05	2021-06-25
264017112670014	6	2021-08-18	\N
239085554893582	1	2018-06-28	2018-06-28
239085554893582	1	2016-10-09	2016-10-09
276113638415091	1	2017-07-08	2017-07-08
276113638415091	1	2021-08-28	2021-08-28
148053879024132	1	2016-08-09	2016-08-09
160036331293193	1	2019-10-17	2019-10-17
160036331293193	1	2021-01-03	2021-01-03
274044454242295	1	2021-01-15	2021-01-15
149012807148886	4	2017-02-10	2017-04-20
149012807148886	1	2017-09-18	2020-11-09
149012807148886	4	2020-11-13	2021-10-23
149012807148886	1	2021-10-24	2021-12-01
292069883843039	1	2020-12-01	2020-12-01
102013760217462	4	2016-10-07	2017-05-24
102013760217462	1	2019-04-26	2020-01-10
102013760217462	5	2021-02-24	\N
175032006668491	1	2021-04-02	2021-04-02
296072961678303	3	2015-01-16	2018-01-17
296072961678303	1	2020-03-15	2020-12-01
296072961678303	3	2021-04-07	2021-07-16
296072961678303	1	2021-12-01	\N
186042352386031	1	2018-03-24	2018-03-24
133057183683629	3	2021-01-11	\N
239091146729071	1	2018-11-10	2018-11-10
239091146729071	1	2019-03-22	2019-03-22
239091146729071	1	2021-02-01	2021-02-01
263101694819786	1	2018-03-05	2018-03-05
161030812581007	1	2018-11-11	2018-11-11
161030812581007	1	2020-10-16	2020-10-16
161030812581007	1	2021-02-06	2021-02-06
107093235177704	1	2020-01-05	2020-01-05
107093235177704	1	2020-05-06	2020-05-06
107093235177704	1	2021-08-01	2021-08-01
212107700291388	1	2019-11-22	2019-11-22
212107700291388	1	2020-09-16	2020-09-16
212107700291388	1	2021-02-03	2021-02-03
235049460087780	1	2015-09-15	2015-09-15
235049460087780	1	2021-09-23	2021-09-23
185068654919823	1	2019-01-03	2019-01-03
185068654919823	1	2019-03-21	2019-03-21
185068654919823	1	2021-12-01	2021-12-01
186124469172237	1	2018-05-01	2018-05-01
186124469172237	1	2021-08-22	2021-08-22
186124469172237	1	2021-11-20	2021-11-20
129115117911004	1	2016-08-08	2016-08-08
129115117911004	1	2018-01-01	2018-01-01
174109372159626	3	2021-04-15	2021-07-22
174109372159626	6	2021-07-23	2021-11-22
174109372159626	2	2021-12-01	2021-12-01
166063604370140	1	2017-12-01	2017-12-01
166063604370140	1	2019-05-25	2019-05-25
166063604370140	1	2020-02-01	2020-02-01
265124877010950	1	2016-09-22	2016-09-22
265124877010950	1	2016-11-15	2016-11-15
242082419543236	5	2015-05-06	\N
231055267153739	3	2021-09-15	2021-11-01
231055267153739	3	2021-12-01	2021-12-01
183027292071405	1	2018-06-12	2018-06-12
183027292071405	1	2021-12-01	2021-12-01
119062521839354	4	2020-05-08	2021-11-21
119062521839354	3	2021-12-01	2021-12-01
192109954988377	1	2021-06-03	2021-06-03
192109954988377	1	2021-09-22	2021-09-22
202103092588087	1	2021-03-10	2021-03-10
202103092588087	1	2021-09-09	2021-09-09
134055750788867	1	2021-02-21	2021-02-21
134055750788867	1	2021-05-22	2021-05-22
175064419494236	2	2017-08-11	2019-05-05
175064419494236	3	2020-07-15	2021-02-18
175064419494236	6	2021-08-14	2021-09-10
175064419494236	3	2021-11-06	2021-12-01
270096529380286	1	2018-03-20	2021-08-19
270096529380286	1	2021-11-03	2021-12-01
201052199619458	1	2020-02-01	2020-02-01
201052199619458	1	2021-04-08	2021-04-08
259116924287307	1	2019-12-01	2020-06-12
231043870437419	1	2019-11-03	2019-11-03
231043870437419	1	2021-10-06	2021-10-06
164109917354484	1	2019-06-06	\N
185031273229975	1	2016-10-03	2016-10-03
165015991694361	1	2017-10-04	2017-10-04
165015991694361	1	2020-06-22	2020-06-22
165015991694361	1	2021-06-26	2021-06-26
181010871674560	1	2017-04-10	2017-04-10
139050580745001	1	2019-04-10	2019-04-10
139050580745001	1	2021-11-11	2021-11-11
277041387830758	1	2020-08-13	2020-08-13
277041387830758	1	2021-05-21	2021-05-21
277041387830758	1	2021-08-14	2021-08-14
115069364634634	1	2015-01-06	2015-01-06
115069364634634	1	2021-04-22	2021-04-22
115069364634634	1	2021-10-25	2021-10-25
241096000702739	1	2016-04-20	2016-04-20
241096000702739	1	2021-03-04	2021-03-04
241096000702739	1	2021-10-28	2021-10-28
216048982722935	1	2016-01-18	2016-01-18
216048982722935	1	2016-09-11	2016-09-11
216048982722935	1	2017-12-01	2017-12-01
276043885107833	1	2020-11-27	2020-11-27
257065888851792	1	2018-12-01	2018-12-01
277013639146953	1	2017-01-04	2017-01-04
277013639146953	1	2020-05-03	2020-05-03
116047632185619	3	2016-06-08	2016-12-01
116047632185619	4	2019-09-10	2020-10-28
116047632185619	1	2021-07-26	2021-11-22
116047632185619	1	2021-11-23	2021-11-23
237016326038243	1	2017-03-07	2017-03-07
280089567149014	4	2017-11-06	2017-11-12
280089567149014	3	2019-02-16	2020-08-25
280089567149014	4	2021-03-23	2021-12-01
177084821772201	6	2020-09-06	2020-10-07
177084821772201	4	2021-03-16	2021-05-07
177084821772201	6	2021-10-18	2021-12-01
132111902031658	1	2020-10-09	2020-10-09
132111902031658	1	2020-11-23	2020-11-23
212077306419001	1	2021-10-12	2021-10-12
212077306419001	1	2021-10-18	2021-10-18
265128593710036	1	2021-02-25	2021-02-25
265128593710036	1	2021-04-11	2021-04-11
265128593710036	1	2021-08-20	2021-08-20
240070875310729	5	2019-10-12	2021-05-14
240070875310729	4	2021-12-01	2021-12-01
293085789640582	5	2020-10-24	2021-10-26
293085789640582	4	2021-11-21	\N
197028693449711	1	2018-07-02	2018-07-02
248050431160701	3	2017-10-23	2018-04-14
248050431160701	1	2019-07-16	2019-11-08
248050431160701	2	2019-12-01	\N
234116778893942	1	2019-04-06	2019-04-06
291044306186509	1	2019-08-13	2019-08-13
291044306186509	1	2020-05-22	2020-05-22
291044306186509	1	2021-02-23	2021-02-23
212033837523152	5	2021-08-17	2021-10-18
212033837523152	5	2021-10-24	\N
163115995738082	1	2018-06-24	2018-06-24
163115995738082	1	2019-12-01	2019-12-01
163115995738082	1	2021-01-26	2021-01-26
108080499169703	1	2019-03-21	2019-03-21
264072212482013	1	2016-06-03	2016-06-03
264072212482013	1	2019-12-01	2019-12-01
273073748815960	1	2018-01-23	2021-01-26
273073748815960	4	2021-08-02	2021-09-20
273073748815960	4	2021-11-27	\N
281076355672170	1	2021-12-01	2021-12-01
206068251343504	1	2019-02-23	2019-02-23
270109148488384	2	2018-11-15	2021-03-13
270109148488384	4	2021-04-11	2021-06-08
270109148488384	1	2021-09-26	2021-12-01
298094244775878	1	2015-06-17	2015-06-17
166108820419376	6	2017-10-18	2018-01-09
166108820419376	1	2019-05-23	2019-05-28
294016552422681	1	2019-12-01	2019-12-01
199101967924971	1	2021-06-13	2021-06-13
199101967924971	1	2021-08-17	2021-08-17
199101967924971	1	2021-09-26	2021-09-26
124068661103286	5	2017-03-16	2019-06-07
124068661103286	4	2021-09-28	2021-09-28
124068661103286	4	2021-11-08	\N
260044683856244	1	2020-05-27	2020-05-27
260044683856244	1	2021-07-03	2021-07-03
260044683856244	1	2021-09-15	2021-09-15
276076882663621	1	2018-08-03	\N
148122725413726	1	2018-07-28	2021-01-06
148122725413726	4	2021-07-14	2021-10-10
148122725413726	4	2021-12-01	2021-12-01
289010155406208	1	2018-08-16	2019-06-03
289010155406208	2	2021-04-18	2021-09-23
289010155406208	5	2021-09-26	\N
294060407584149	1	2016-07-17	2016-07-17
294060407584149	1	2021-07-25	2021-07-25
294060407584149	1	2021-08-25	2021-08-25
139065443729140	1	2018-12-01	2018-12-01
139065443729140	1	2020-10-27	2020-10-27
139065443729140	1	2020-11-10	2020-11-10
166091666520458	4	2021-01-03	2021-06-14
166091666520458	1	2021-08-17	2021-10-14
166091666520458	4	2021-10-16	\N
226058344946712	1	2020-04-02	2020-04-02
119108066223991	1	2016-02-02	2016-02-02
119108066223991	1	2017-03-03	2017-03-03
166120368218553	1	2019-06-16	2019-06-16
166120368218553	1	2019-12-01	2019-12-01
196063036979567	4	2021-04-26	2021-04-28
196063036979567	6	2021-05-08	2021-05-08
196063036979567	2	2021-11-20	\N
287018783401310	1	2019-06-08	2019-06-08
287018783401310	1	2019-11-22	2019-11-22
169123667085745	1	2019-12-01	2019-12-01
169123667085745	1	2021-10-22	2021-10-22
169123667085745	1	2021-12-01	2021-12-01
291045917238489	1	2015-12-01	2015-12-01
291045917238489	1	2017-04-23	2017-04-23
291045917238489	1	2018-08-19	2018-08-19
203129749597569	1	2015-07-11	2015-07-11
239107910465394	1	2017-12-01	2019-09-03
239107910465394	5	2021-03-15	2021-10-18
239107910465394	1	2021-10-28	2021-12-01
107013876121908	1	2017-07-20	2017-07-20
122055679266216	1	2017-02-21	2017-02-21
118086297555680	1	2017-04-08	2017-04-08
118086297555680	1	2017-10-20	2017-10-20
118086297555680	1	2020-04-20	2020-04-20
250115721904451	1	2021-05-13	2021-05-13
250115721904451	1	2021-05-16	2021-05-16
250115721904451	1	2021-07-26	2021-07-26
280060191300313	1	2021-01-23	2021-01-23
117126688058062	1	2019-05-10	2019-05-10
117126688058062	1	2019-05-15	2019-05-15
117126688058062	1	2020-04-28	2020-04-28
127058106807061	1	2017-06-16	2017-06-16
127058106807061	1	2017-08-23	2017-08-23
127058106807061	1	2020-02-04	2020-02-04
200031594053188	1	2018-05-20	2018-05-20
179067984929908	2	2019-03-04	2019-08-04
247097436239589	1	2019-09-04	2019-09-04
193102778541743	3	2020-05-14	2020-05-26
193102778541743	6	2020-12-01	2020-12-01
193102778541743	2	2021-11-19	2021-12-01
166066770602613	1	2019-12-01	2019-12-01
166066770602613	1	2020-11-23	2020-11-23
266097183420366	6	2020-02-05	2021-04-07
106034249755113	1	2021-03-25	2021-03-25
106034249755113	1	2021-07-26	2021-07-26
288021514521235	1	2016-06-16	2016-06-16
288021514521235	1	2019-11-27	2019-11-27
288021514521235	1	2020-01-06	2020-01-06
219047723431704	1	2019-03-23	2019-03-23
219047723431704	1	2019-12-01	2019-12-01
219047723431704	1	2020-10-23	2020-10-23
105064525567135	1	2020-11-17	2020-11-17
105064525567135	1	2020-12-01	2020-12-01
143018820407138	1	2016-08-18	2016-08-18
143018820407138	1	2021-07-25	2021-07-25
154103299728937	1	2015-01-09	2015-01-09
154103299728937	1	2017-09-08	2017-09-08
206113724192459	1	2021-10-09	2021-10-09
206113724192459	1	2021-10-18	2021-10-18
247065902055612	1	2020-02-26	2020-02-26
247065902055612	1	2020-10-23	2020-10-23
247065902055612	1	2020-11-05	2020-11-05
156095915334257	1	2019-02-08	2019-02-08
197024861025985	1	2021-05-09	2021-05-09
197024861025985	1	2021-07-24	2021-07-24
137119435589253	1	2017-11-17	2017-11-17
137119435589253	1	2017-11-26	2017-11-26
210057188504519	2	2016-10-02	2020-05-12
210057188504519	5	2020-05-18	2021-01-19
168092323808223	1	2020-04-12	2020-04-12
168092323808223	1	2021-07-24	2021-07-24
168092323808223	1	2021-11-21	2021-11-21
121079326716109	1	2020-04-04	2020-04-04
208095993143744	1	2017-12-01	2017-12-01
208095993143744	1	2015-03-24	2015-03-24
208095993143744	1	2015-09-12	2015-09-12
225079785161807	1	2016-10-19	2016-10-19
225079785161807	1	2019-10-21	2019-10-21
225079785161807	1	2019-10-24	2019-10-24
217109204772961	1	2015-02-02	2015-02-02
217109204772961	1	2021-07-14	2021-07-14
217109204772961	1	2021-07-26	2021-07-26
250020760833943	1	2019-06-16	2019-06-16
297112356304318	3	2021-12-01	2021-12-01
190083588374214	1	2016-01-13	2016-01-13
179094720815996	1	2015-10-07	2015-10-07
129033616838358	1	2019-04-09	2019-04-09
138120841735658	1	2020-12-01	2020-12-01
138120841735658	1	2017-12-01	2017-12-01
259123094684548	1	2018-05-18	2018-05-18
111055160566338	1	2020-11-20	2020-11-20
113107456390850	1	2021-08-07	2021-08-07
244032415236016	4	2016-06-25	2016-07-22
244032415236016	5	2019-04-05	2019-09-04
244032415236016	4	2020-04-28	2020-09-09
184023991391628	1	2021-06-27	2021-06-27
184023991391628	1	2021-10-07	2021-10-07
184023991391628	1	2021-10-12	2021-10-12
276029793747273	1	2020-04-25	2020-04-25
134078170944188	1	2019-10-04	2020-03-25
134078170944188	4	2020-07-09	2021-04-06
134078170944188	1	2021-10-03	2021-10-12
134078170944188	2	2021-12-01	2021-12-01
246129551535565	1	2019-03-13	2019-03-13
246129551535565	1	2021-11-10	2021-11-10
221067404045732	6	2016-11-14	2020-06-17
221067404045732	4	2020-09-23	2021-02-07
221067404045732	1	2021-03-22	2021-11-07
221067404045732	4	2021-11-24	2021-12-01
172094668047237	1	2016-08-15	2016-08-15
172094668047237	1	2019-03-05	2019-03-05
172094668047237	1	2020-03-07	2020-03-07
134042462939733	4	2019-05-15	2019-12-01
134042462939733	3	2020-03-07	2021-09-24
134042462939733	6	2021-11-17	2021-12-01
180128995054010	1	2015-02-02	2015-02-02
180128995054010	1	2018-03-13	2018-03-13
180128995054010	1	2020-04-15	2020-04-15
210052462712009	1	2016-01-05	2016-01-05
210052462712009	1	2021-11-06	2021-11-06
117024346707693	1	2015-04-05	2015-04-05
117024346707693	1	2017-02-15	2017-02-15
158060792761175	6	2018-04-22	2019-02-18
158060792761175	3	2019-10-22	2019-12-01
158060792761175	3	2020-02-18	\N
115103061446648	1	2017-11-04	2017-11-04
115103061446648	1	2020-05-12	2020-05-12
292081637038605	1	2018-01-08	2018-01-08
153109335398179	5	2015-12-01	2017-01-07
153109335398179	5	2018-09-25	2019-03-21
153109335398179	2	2020-08-27	2021-04-25
153109335398179	1	2021-10-26	2021-12-01
126109239418435	1	2020-04-06	2020-04-06
250037185243654	1	2017-06-06	2017-06-06
250037185243654	1	2017-07-20	2017-07-20
201072681226547	1	2020-01-28	2020-01-28
201072681226547	1	2021-11-25	2021-11-25
201072681226547	1	2021-12-01	2021-12-01
239120237800324	1	2018-01-17	2018-01-17
239120237800324	1	2018-08-25	2018-08-25
239120237800324	1	2019-02-19	2019-02-19
248126817619060	1	2017-08-11	2017-08-11
248126817619060	1	2019-09-22	2019-09-22
261113788102102	5	2016-03-18	2021-11-27
261113788102102	2	2021-12-01	2021-12-01
182011321936788	4	2021-05-25	2021-09-28
182011321936788	3	2021-12-01	2021-12-01
270022191753200	1	2016-01-22	2016-01-22
270022191753200	1	2019-01-23	2019-01-23
270022191753200	1	2020-01-27	2020-01-27
225028099609560	1	2017-07-11	2017-07-11
225028099609560	1	2017-07-19	2017-07-19
225028099609560	1	2019-01-03	2019-01-03
244053615608657	1	2017-09-14	2017-09-14
244053615608657	1	2017-12-01	2017-12-01
244053615608657	1	2017-06-26	2017-06-26
116066809892335	5	2018-09-14	2019-01-08
116066809892335	4	2020-11-13	2021-10-03
116066809892335	2	2021-10-23	2021-10-24
116066809892335	6	2021-11-03	2021-12-01
116106724777292	5	2021-06-03	2021-08-18
116106724777292	1	2021-11-23	2021-12-01
146083500358210	5	2018-06-19	2019-01-03
146083500358210	5	2021-03-27	2021-06-06
146083500358210	6	2021-12-01	2021-12-01
157036866353328	1	2021-02-23	2021-02-23
157036866353328	1	2021-12-01	2021-12-01
268040221926572	1	2019-02-07	2019-02-07
259029201046904	1	2019-02-26	2019-02-26
259029201046904	1	2019-06-12	2019-06-12
259029201046904	1	2020-08-22	2020-08-22
282038251008033	6	2018-02-24	2021-06-12
282038251008033	6	2021-07-11	2021-10-09
282038251008033	4	2021-12-01	2021-12-01
129031456728988	6	2016-05-01	\N
136023021781523	1	2017-02-16	2017-02-16
136023021781523	1	2021-06-19	2021-06-19
147110274507518	1	2015-11-14	2015-11-14
147110274507518	1	2021-07-27	2021-07-27
147110274507518	1	2021-12-01	2021-12-01
153072150169408	1	2019-02-08	2019-02-08
153072150169408	1	2019-05-17	2019-05-17
243077956746269	1	2021-03-09	2021-03-09
291079297260025	1	2015-09-12	2015-09-12
291079297260025	1	2018-12-01	2018-12-01
291079297260025	1	2021-05-08	2021-05-08
262088041353654	1	2019-12-01	2019-12-01
227042980363902	1	2017-05-28	2017-05-28
225085330862476	1	2019-12-01	2019-12-01
225085330862476	1	2021-03-02	2021-03-02
228051958559467	1	2019-04-19	2019-04-19
228051958559467	1	2020-10-05	2020-10-05
228051958559467	1	2021-02-12	2021-02-12
217081379554035	1	2021-02-12	2021-02-12
217081379554035	1	2021-03-14	2021-03-14
298098122213462	1	2018-05-08	2018-05-08
298098122213462	1	2020-06-22	2020-06-22
276023787980654	1	2018-06-19	2018-06-19
276023787980654	1	2018-06-26	2018-06-26
276023787980654	1	2018-07-02	2018-07-02
236110135097393	1	2019-04-20	2019-04-20
236110135097393	1	2021-05-02	2021-05-02
236110135097393	1	2020-06-10	2020-06-10
214114566129124	1	2017-05-11	2017-05-11
214114566129124	1	2020-12-01	2020-12-01
220113495911050	1	2020-06-08	2020-06-08
220113495911050	1	2021-08-15	2021-08-15
209118599554171	1	2018-07-04	2018-07-04
271021954120932	1	2019-09-08	2019-09-08
237107264212189	6	2018-07-03	2018-09-24
237107264212189	5	2021-12-01	2021-12-01
251020364469865	1	2018-10-25	2018-10-25
122125838145935	1	2017-03-22	2017-03-22
122125838145935	1	2020-03-26	2020-03-26
242048258949364	1	2020-04-23	2020-04-23
242048258949364	1	2021-01-08	2021-01-08
242048258949364	1	2021-03-11	2021-03-11
256123186185406	1	2017-05-02	2017-05-02
256123186185406	1	2021-02-17	2021-02-17
179045444422744	1	2018-08-06	2018-08-06
166062449407106	1	2019-04-19	2019-04-19
233087289261865	6	2019-09-25	2020-04-14
233087289261865	5	2021-12-01	2021-12-01
197069985519854	1	2021-10-08	2021-10-08
197069985519854	1	2021-10-24	2021-10-24
197069985519854	1	2021-12-01	2021-12-01
190029314791340	1	2017-02-03	2017-02-03
190029314791340	1	2017-03-14	2017-03-14
190029314791340	1	2021-08-07	2021-08-07
227126597924105	1	2019-04-06	2019-04-06
227126597924105	1	2019-06-23	2019-06-23
227126597924105	1	2020-12-01	2020-12-01
157121022621522	1	2018-06-27	2018-06-27
143092918371476	2	2020-08-06	2021-01-16
143092918371476	1	2021-06-10	2021-12-01
222042520288908	1	2020-04-03	2020-04-03
202071437767230	3	2018-02-08	2019-08-27
202071437767230	1	2020-01-11	2020-10-10
202071437767230	6	2021-05-12	\N
189086144171587	1	2020-04-12	2020-04-12
189086144171587	1	2021-02-02	2021-02-02
189086144171587	1	2021-10-08	2021-10-08
256063692412136	1	2015-02-27	2015-02-27
170086700455011	1	2021-08-11	2021-08-11
170086700455011	1	2021-11-23	2021-11-23
170086700455011	1	2021-12-01	2021-12-01
131057674892840	1	2016-09-07	2018-10-07
131057674892840	6	2020-01-17	2021-07-19
131057674892840	6	2021-10-07	2021-12-01
240023495790364	1	2020-02-16	2020-02-16
240023495790364	1	2020-04-27	2020-04-27
255035172533923	1	2021-02-22	2021-02-22
255035172533923	1	2021-02-27	2021-02-27
268014305680881	1	2020-03-15	2020-03-15
272065307866110	5	2018-12-01	2019-02-01
272065307866110	5	2019-11-21	\N
165094296199095	1	2018-05-10	2018-05-10
165094296199095	1	2021-12-01	2021-12-01
255049439681923	1	2019-08-10	2019-08-10
255049439681923	1	2020-02-22	2020-02-22
255049439681923	1	2020-03-10	2020-03-10
121079926115784	4	2015-12-01	2021-06-08
121079926115784	2	2021-07-09	2021-09-11
121079926115784	2	2021-12-01	2021-12-01
179063322934496	2	2015-07-13	2015-07-25
179063322934496	1	2018-01-02	2018-07-01
179063322934496	1	2018-09-13	\N
138122160748934	1	2015-10-22	2015-10-22
231090596408156	3	2018-08-28	2018-11-25
231090596408156	6	2019-06-19	2019-10-21
231090596408156	4	2021-03-15	2021-08-23
231090596408156	3	2021-12-01	2021-12-01
286109172934315	1	2019-08-05	2019-08-05
286109172934315	1	2021-10-03	2021-10-03
286109172934315	1	2021-12-01	2021-12-01
271077285006735	1	2015-12-01	2015-12-01
265127996967450	1	2019-04-03	2020-03-13
265127996967450	6	2021-02-04	2021-09-17
265127996967450	1	2021-10-26	2021-12-01
190075925899731	1	2017-12-01	2017-12-01
190075925899731	1	2021-08-27	2021-08-27
120119820079715	1	2018-09-09	2018-09-09
120119820079715	1	2018-12-01	2018-12-01
120119820079715	1	2019-06-24	2019-06-24
271125052129400	1	2021-11-28	2021-11-28
271125052129400	1	2021-12-01	2021-12-01
155035914169601	1	2015-12-01	2015-12-01
287120454199264	1	2017-02-02	2017-02-02
287120454199264	1	2021-06-11	2021-06-11
287120454199264	1	2021-12-01	2021-12-01
196099311916690	6	2020-12-01	2021-07-06
196099311916690	2	2021-09-03	2021-11-19
278090644287533	1	2019-05-08	2019-05-08
109083319834772	1	2020-08-05	2020-08-05
109083319834772	1	2020-08-27	2020-08-27
109083319834772	1	2020-12-01	2020-12-01
133052277550638	1	2016-05-02	2016-05-02
226084549434468	1	2021-05-11	2021-05-11
226084549434468	1	2021-05-20	2021-05-20
292121669134423	1	2017-02-19	2017-02-19
292121669134423	1	2021-04-09	2021-04-09
253024126306890	1	2016-04-22	2016-04-22
238029027037430	1	2019-01-04	2019-01-04
238029027037430	1	2019-08-24	2019-08-24
238029027037430	1	2019-08-27	2019-08-27
228082057152542	1	2016-07-04	2016-07-04
125117547327936	5	2019-03-01	2019-04-02
125117547327936	5	2019-08-01	2020-09-27
125117547327936	4	2020-10-14	2020-12-01
125117547327936	5	2021-10-24	2021-10-25
125117547327936	5	2021-11-12	2021-12-01
290035800595956	1	2021-12-01	2021-12-01
254107648685692	5	2017-06-27	2017-12-01
254107648685692	2	2021-08-21	\N
147068405424686	1	2019-11-07	2019-11-07
147068405424686	1	2019-12-01	2019-12-01
147068405424686	1	2020-05-18	2020-05-18
201122582689823	1	2019-04-04	2019-04-04
234042399113177	1	2020-02-18	2020-02-18
166036483219145	1	2019-02-17	2019-02-17
257074140156085	1	2019-06-03	2019-06-03
257074140156085	1	2019-11-18	2019-11-18
257074140156085	1	2021-11-25	2021-11-25
241102233744196	1	2020-05-13	2020-05-13
241102233744196	1	2021-03-16	2021-03-16
235041796027551	4	2021-09-27	\N
280030696037033	6	2019-11-01	\N
258052232199718	1	2016-12-01	2016-12-01
258052232199718	2	2018-05-04	2021-09-02
258052232199718	6	2021-12-01	\N
195089048997652	1	2020-03-26	2020-03-26
195089048997652	1	2021-10-21	2021-10-21
195089048997652	1	2021-10-24	2021-10-24
224012297078722	1	2019-04-12	2019-04-12
224012297078722	1	2019-04-14	2019-04-14
133096044501013	1	2020-09-22	2020-09-22
133096044501013	1	2021-07-08	2021-07-08
105079641276488	4	2021-12-01	2021-12-01
265037138611063	1	2019-10-26	2019-10-26
265037138611063	1	2020-05-25	2020-05-25
269061340475625	1	2016-05-27	2016-05-27
289038293978883	1	2017-05-02	2017-05-02
289038293978883	1	2020-02-02	2020-02-02
289038293978883	1	2021-07-01	2021-07-01
118097743275289	1	2016-03-04	2017-10-04
118097743275289	3	2020-12-01	2020-12-01
118097743275289	2	2021-06-18	2021-10-19
118097743275289	3	2021-10-25	2021-12-01
268102515480863	1	2017-06-23	2017-06-23
262017315373034	2	2019-01-15	2021-02-20
262017315373034	4	2021-03-23	2021-05-08
262017315373034	3	2021-11-11	2021-12-01
275115595725603	1	2017-11-19	2017-11-19
275115595725603	1	2017-11-22	2017-11-22
168117966463592	4	2016-01-10	2016-01-12
168117966463592	1	2016-09-22	2021-05-23
168117966463592	5	2021-12-01	2021-12-01
294015158916742	1	2019-07-01	2019-07-01
294015158916742	1	2021-04-05	2021-04-05
229049188967727	5	2016-02-10	2019-02-15
229049188967727	3	2020-03-04	2021-02-19
229049188967727	6	2021-05-22	2021-09-16
229049188967727	1	2021-11-20	2021-12-01
248020336265548	1	2017-09-11	2017-09-11
261061517818802	1	2017-10-28	2017-10-28
261061517818802	1	2018-02-07	2018-02-07
218067839543144	1	2020-03-16	2020-03-16
137035076043920	1	2020-05-17	2020-05-17
137035076043920	1	2020-06-27	2020-06-27
277029962435780	3	2020-05-27	2021-01-07
277029962435780	5	2021-04-09	2021-04-24
277029962435780	5	2021-12-01	2021-12-01
187050790840456	1	2017-05-28	2017-05-28
258016165795720	1	2021-11-08	2021-11-08
258016165795720	1	2021-12-01	2021-12-01
284075289727096	1	2017-09-26	2017-09-26
284075289727096	1	2021-08-05	2021-08-05
238100948951460	1	2016-04-28	2016-04-28
264127794964901	4	2015-03-02	2019-11-23
264127794964901	3	2021-01-17	\N
217015419621733	1	2015-03-26	2015-03-26
150036510918192	1	2019-04-07	2019-04-07
150036510918192	1	2019-05-02	2019-05-02
147094894800840	1	2015-08-12	2015-08-12
147094894800840	1	2016-11-04	2016-11-04
147094894800840	1	2017-10-02	2017-10-02
203054662307902	3	2016-03-16	2020-01-17
203054662307902	3	2020-08-25	2021-05-11
243102394343966	1	2017-04-07	2017-04-07
235015710631442	5	2015-01-07	2020-05-26
235015710631442	5	2020-11-21	2020-12-01
139028752544809	1	2015-07-20	2015-07-20
139028752544809	1	2018-01-22	2018-01-22
139028752544809	1	2020-03-15	2020-03-15
292110340538775	4	2015-01-03	\N
172044633042546	1	2018-02-21	2018-02-21
272074630342514	1	2019-10-28	2019-10-28
272074630342514	1	2021-01-07	2021-01-07
205106177189757	1	2017-09-19	2017-09-19
205106177189757	1	2021-04-13	2021-04-13
163095683355072	1	2015-10-22	2015-10-22
163095683355072	1	2020-02-01	2020-02-01
163095683355072	1	2020-05-06	2020-05-06
118066904629610	1	2015-08-19	2015-08-19
118066904629610	1	2020-02-17	2020-02-17
118066904629610	1	2020-08-19	2020-08-19
293097683511915	1	2016-04-14	2016-04-14
293097683511915	1	2018-02-28	2018-02-28
293097683511915	1	2021-01-14	2021-01-14
288019756939738	1	2016-05-23	2016-05-23
171125291347716	2	2020-01-25	2021-02-20
171125291347716	4	2021-06-21	2021-09-02
171125291347716	3	2021-11-26	2021-12-01
118055407721077	1	2020-03-18	2020-03-18
209086618622243	1	2018-04-11	2018-04-11
211052198016337	1	2015-01-11	2015-01-11
211052198016337	1	2018-09-25	2018-09-25
269041356249776	1	2019-04-12	2019-04-12
166084097850130	2	2021-02-28	2021-09-05
166084097850130	3	2021-11-07	2021-12-01
239129600838387	1	2017-03-17	2017-03-17
239129600838387	1	2018-11-17	2018-11-17
144020579570087	1	2019-01-05	2019-01-05
144020579570087	1	2019-04-26	2019-04-26
144020579570087	1	2021-12-01	2021-12-01
157076554613448	1	2015-02-08	2015-02-08
157076554613448	1	2020-04-23	2020-04-23
157076554613448	1	2020-06-11	2020-06-11
160078524507383	6	2015-08-14	2017-08-24
160078524507383	2	2020-07-25	2020-11-12
160078524507383	2	2020-11-19	2021-02-03
157129459270583	1	2016-03-06	2016-03-06
197028070992122	1	2016-06-09	2016-06-09
225106058149347	1	2018-05-15	2018-05-15
225106058149347	1	2020-06-24	2020-06-24
225106058149347	1	2021-10-08	2021-10-08
153022679819804	1	2017-04-22	2017-04-22
153022679819804	1	2021-05-23	2021-05-23
122117120832828	1	2019-07-15	2019-07-15
122117120832828	1	2020-04-09	2020-04-09
122117120832828	1	2020-09-08	2020-09-08
108105169006820	1	2015-10-03	2015-10-03
108105169006820	1	2020-11-15	2020-11-15
133085507042722	1	2019-01-07	2019-01-07
133085507042722	1	2021-02-03	2021-02-03
133085507042722	1	2021-05-28	2021-05-28
299032100194543	1	2020-10-21	2020-10-21
299032100194543	1	2020-12-01	2020-12-01
285111122122687	1	2015-01-28	2015-01-28
105111064681116	3	2020-10-02	2021-08-14
105111064681116	5	2021-10-15	2021-12-01
106069855306956	3	2017-01-19	\N
235025043023266	1	2018-07-12	2018-07-12
235025043023266	1	2018-11-10	2018-11-10
259031305534854	1	2018-06-27	2018-06-27
259031305534854	1	2018-09-24	2018-09-24
164018247653927	1	2016-01-02	2016-01-02
164018247653927	1	2017-11-13	2017-11-13
255111462999163	1	2018-11-03	2018-11-03
149016464115574	1	2017-02-17	2017-02-17
149016464115574	1	2019-03-25	2019-03-25
218028916522993	1	2016-11-08	2016-11-08
132104189563779	1	2017-07-15	2017-07-15
132104189563779	1	2018-05-22	2018-05-22
132104189563779	1	2019-04-09	2019-04-09
103078742854508	1	2020-01-01	2020-01-01
103078742854508	1	2020-01-11	2020-01-11
103078742854508	1	2020-12-01	2020-12-01
219010336879126	3	2015-08-20	2015-10-06
219010336879126	2	2015-11-08	\N
216080798565109	1	2015-02-09	2015-02-09
176038914084519	4	2021-01-10	2021-12-01
274016315753078	1	2019-02-06	2019-02-06
206064171467425	5	2021-10-07	2021-11-05
206064171467425	1	2021-11-27	2021-11-27
206064171467425	1	2021-12-01	2021-12-01
286059858756226	1	2020-08-27	2020-08-27
144104148447610	1	2021-10-16	2021-10-16
144104148447610	1	2021-11-12	2021-11-12
144104148447610	1	2021-11-24	2021-11-24
169041874795154	1	2021-11-11	2021-11-11
169041874795154	1	2021-12-01	2021-12-01
129092551504840	4	2016-04-03	\N
170104318565314	4	2019-12-01	2019-12-01
170104318565314	5	2021-02-07	2021-07-01
170104318565314	4	2021-12-01	2021-12-01
274114292533681	1	2019-03-17	2019-03-17
237072348150692	1	2016-04-09	2018-09-10
237072348150692	1	2020-01-12	2020-11-04
283124902489728	3	2020-07-08	2021-08-21
283124902489728	1	2021-09-22	2021-09-26
283124902489728	6	2021-12-01	2021-12-01
140010920647767	1	2018-04-07	2018-04-07
174054333800157	4	2021-08-26	2021-09-17
174054333800157	4	2021-12-01	2021-12-01
236033297541443	1	2016-01-10	2016-01-10
236033297541443	1	2019-06-25	2019-06-25
236033297541443	1	2021-03-08	2021-03-08
117072352261008	1	2015-04-26	2015-04-26
117072352261008	1	2017-09-28	2017-09-28
253108676231602	1	2017-05-10	2017-05-10
253108676231602	1	2017-09-17	2017-09-17
253108676231602	1	2018-11-20	2018-11-20
214048310374407	1	2015-06-12	2015-06-12
214048310374407	1	2016-10-13	2016-10-13
283034579380856	1	2016-12-01	2016-12-01
283034579380856	1	2020-11-09	2020-11-09
283034579380856	1	2021-05-13	2021-05-13
138111930540163	1	2018-10-08	2018-10-08
239040683301450	1	2016-03-25	2016-03-25
220079068523025	4	2016-08-01	2021-06-27
220079068523025	3	2021-08-14	2021-12-01
142112061521891	1	2020-10-16	2020-10-16
228102829065978	2	2021-01-09	2021-04-08
228102829065978	6	2021-12-01	2021-12-01
108034713413292	1	2017-07-11	2017-07-11
161114713933201	1	2015-04-12	2015-04-12
161114713933201	1	2015-07-25	2015-07-25
271024262039407	1	2015-06-05	2015-06-05
271024262039407	1	2020-02-25	2020-02-25
271024262039407	1	2021-08-25	2021-08-25
116071026258730	1	2015-05-02	2015-05-02
116071026258730	1	2018-03-21	2018-03-21
116071026258730	1	2021-04-08	2021-04-08
104096864772049	1	2018-10-15	2018-10-15
104096864772049	1	2018-11-03	2018-11-03
290054393404594	1	2021-11-19	2021-11-19
290054393404594	1	2021-12-01	2021-12-01
299083781186978	1	2017-09-16	2017-09-16
299083781186978	1	2017-09-24	2017-09-24
197104772238319	1	2018-07-07	2018-07-07
197104772238319	1	2020-05-11	2020-05-11
197104772238319	1	2021-08-12	2021-08-12
221021276653204	3	2015-05-21	2019-05-25
221021276653204	4	2020-10-03	2021-05-13
221021276653204	1	2021-11-28	\N
134026849374442	1	2020-12-01	2020-12-01
133119344929516	1	2018-11-26	2018-11-26
133119344929516	1	2021-01-26	2021-01-26
133119344929516	1	2021-12-01	2021-12-01
166049821238905	1	2015-09-01	2015-09-01
102046285253211	3	2020-08-27	2020-10-11
102046285253211	5	2021-05-16	2021-11-21
102046285253211	3	2021-12-01	2021-12-01
137121652381278	1	2015-05-11	\N
155077696371044	1	2020-04-24	2020-04-24
161010244798916	1	2019-02-23	2019-02-23
161010244798916	1	2019-12-01	2019-12-01
151110869486625	1	2020-02-15	2020-02-15
277044366026913	1	2017-02-25	2017-02-25
144035676655040	1	2020-02-05	2020-02-05
144035676655040	1	2020-04-15	2020-04-15
189098056291549	1	2018-09-25	2018-09-25
278089373283395	3	2015-10-17	\N
178071952498324	1	2019-05-25	2019-05-25
156074123250805	6	2019-06-28	2020-01-02
156074123250805	5	2020-12-01	2020-12-01
156074123250805	1	2021-06-28	\N
135110615927304	1	2017-02-24	2017-02-24
135110615927304	1	2018-11-07	2018-11-07
248069614540301	1	2016-01-03	2016-01-03
248069614540301	1	2016-08-21	2016-08-21
248069614540301	1	2021-04-11	2021-04-11
148069830978569	1	2019-09-18	2019-09-18
212060310868943	5	2021-08-05	2021-10-24
212060310868943	1	2021-10-26	2021-11-17
212060310868943	3	2021-12-01	2021-12-01
162058741598167	1	2021-12-01	2021-12-01
169097507276185	5	2015-11-18	2017-10-10
169097507276185	1	2020-01-13	2020-11-02
169097507276185	2	2020-11-23	2020-11-27
169097507276185	3	2021-02-18	\N
205095024579593	5	2017-06-06	2017-06-24
205095024579593	1	2018-02-10	\N
299048039616883	1	2018-03-18	2018-03-18
299048039616883	1	2019-01-20	2019-01-20
299048039616883	1	2021-03-05	2021-03-05
224081724300171	1	2015-06-16	2015-06-16
150060303807110	1	2018-06-25	2018-06-25
126109435891127	1	2021-11-23	2021-11-23
126109435891127	1	2021-12-01	2021-12-01
275063951087350	1	2019-09-20	2019-09-20
194015343162633	1	2019-06-09	2021-10-25
251119575893548	6	2021-04-20	2021-08-12
251119575893548	4	2021-12-01	2021-12-01
154068499542428	1	2015-10-02	2015-10-02
141079769804035	1	2021-07-26	2021-07-26
141079769804035	1	2021-08-09	2021-08-09
141079769804035	1	2021-10-17	2021-10-17
101056300934406	1	2016-01-19	2016-01-19
101056300934406	1	2020-05-24	2020-05-24
101056300934406	1	2020-06-11	2020-06-11
240073988379421	3	2019-07-20	\N
260111580647383	4	2021-02-13	\N
120056823338977	1	2018-10-19	2018-10-19
120056823338977	1	2019-09-01	2019-09-01
119109623992764	1	2019-10-11	2019-10-11
119109623992764	1	2020-08-14	2020-08-14
101039612534949	3	2021-03-25	2021-06-26
101039612534949	2	2021-11-12	2021-12-01
239023073644392	4	2015-02-14	2017-05-26
239023073644392	2	2017-09-11	2021-01-21
239023073644392	2	2021-05-10	2021-06-13
239023073644392	2	2021-10-10	\N
203017476426702	1	2016-07-19	2016-07-19
203017476426702	1	2018-07-22	2018-07-22
252106418593026	1	2018-04-25	2018-04-25
252092112764860	1	2018-12-01	2018-12-01
252092112764860	1	2019-12-01	2019-12-01
252092112764860	1	2021-11-27	2021-11-27
189014693292991	1	2016-12-01	2016-12-01
157070363992818	1	2017-03-21	2020-08-06
157070363992818	2	2021-12-01	2021-12-01
195106011080181	6	2017-04-05	2021-07-11
195106011080181	4	2021-11-27	\N
182084477498741	5	2020-10-07	2020-11-04
182084477498741	3	2020-11-10	2020-11-24
182084477498741	2	2020-11-28	2021-05-18
182084477498741	5	2021-06-04	2021-10-28
253095437283501	4	2019-06-23	2019-06-23
253095437283501	6	2021-06-27	2021-10-24
253095437283501	5	2021-11-24	2021-11-28
253095437283501	6	2021-12-01	2021-12-01
229097103116120	2	2019-12-01	2019-12-01
229097103116120	2	2021-12-01	2021-12-01
203038685064147	1	2019-08-17	2019-08-17
203038685064147	1	2020-12-01	2020-12-01
244106583543744	1	2016-10-04	2016-10-04
244106583543744	1	2016-10-08	2016-10-08
137011911189687	1	2015-10-27	2015-10-27
127015812688118	1	2015-06-08	2015-06-08
127015812688118	1	2018-04-17	2018-04-17
174126989550917	1	2016-01-05	2016-01-05
174126989550917	1	2019-10-22	2019-10-22
148071526597476	1	2016-02-21	2016-02-21
148071526597476	1	2017-12-01	2017-12-01
148071526597476	1	2021-12-01	2021-12-01
206067332177665	2	2019-05-15	2021-01-05
206067332177665	6	2021-01-08	2021-03-06
206067332177665	1	2021-06-24	\N
265053211557745	1	2020-06-20	2020-06-20
265053211557745	1	2020-12-01	2020-12-01
262016873894611	1	2015-04-24	2015-04-24
262016873894611	1	2017-02-05	2017-02-05
171066719027259	1	2016-01-25	2016-01-25
267109108065202	2	2016-11-22	2020-05-07
266019956812570	4	2015-04-23	2015-06-11
266019956812570	5	2020-10-17	2020-12-01
266019956812570	3	2021-04-15	\N
252111777841915	4	2017-10-25	\N
164038608632119	1	2015-02-16	2015-02-16
131101434250337	1	2020-11-24	2020-11-24
230124336513645	1	2019-03-08	2019-03-08
230124336513645	1	2019-08-06	2019-08-06
212051079375206	1	2020-08-14	2020-08-14
207036199333762	1	2016-12-01	2016-12-01
207036199333762	1	2021-09-07	2021-09-07
195039969007673	1	2021-05-27	2021-05-27
195039969007673	1	2021-12-01	2021-12-01
221029479428090	1	2017-01-17	2017-03-10
110066257611314	1	2015-02-01	2015-02-01
110066257611314	1	2021-04-01	2021-04-01
223078053552461	1	2017-03-27	2017-03-27
223078053552461	1	2018-06-26	2018-06-26
223078053552461	1	2021-01-24	2021-01-24
114066535520356	1	2019-11-01	2019-11-01
114066535520356	1	2020-10-26	2020-10-26
114066535520356	1	2021-04-15	2021-04-15
243017583288790	1	2021-04-11	2021-04-11
243017583288790	1	2021-05-08	2021-05-08
243017583288790	1	2021-10-23	2021-10-23
202024773805862	3	2019-01-27	2019-08-06
201073789759321	2	2021-12-01	2021-12-01
266073845226430	1	2017-05-25	2017-05-25
266073845226430	1	2021-06-24	2021-06-24
266073845226430	1	2021-11-23	2021-11-23
145056354127107	1	2019-08-08	2019-08-08
145056354127107	1	2021-02-02	2021-02-02
199010342734983	1	2017-12-01	2017-12-01
199010342734983	1	2020-08-24	2020-08-24
199010342734983	1	2021-06-02	2021-06-02
204036557077489	3	2017-10-17	\N
289040697244116	1	2020-03-20	2020-03-20
289040697244116	1	2021-11-23	2021-11-23
138084307765388	6	2015-08-26	2021-03-25
138084307765388	4	2021-11-05	2021-11-13
138084307765388	3	2021-12-01	2021-12-01
245106940503490	1	2015-06-15	2015-06-15
245106940503490	1	2017-09-09	2017-09-09
245106940503490	1	2017-09-14	2017-09-14
179073352261725	6	2021-11-08	2021-12-01
298032738731346	1	2019-10-03	2019-10-03
298032738731346	1	2021-10-05	2021-10-05
243082614270684	2	2020-04-02	2020-05-05
255086087623452	1	2017-01-21	2017-01-21
255086087623452	1	2020-11-18	2020-11-18
144015615260843	1	2019-01-14	2019-01-14
144015615260843	1	2021-08-07	2021-08-07
212101169913710	3	2019-07-24	2019-08-03
212101169913710	5	2019-12-01	2020-01-22
212101169913710	5	2021-03-27	2021-03-27
212101169913710	3	2021-04-14	\N
195068695146738	1	2019-05-01	2021-02-12
195068695146738	4	2021-04-02	\N
180088976677729	1	2019-05-02	2019-05-02
109015975211104	1	2019-02-07	2019-02-07
109015975211104	1	2019-04-27	2019-04-27
110114341425639	1	2017-06-26	2017-06-26
184059224569363	5	2019-02-02	2019-12-01
184059224569363	4	2021-07-20	2021-08-19
269071637551546	2	2017-07-15	2020-03-09
269071637551546	5	2020-12-01	\N
206033830025756	1	2021-11-23	2021-11-23
258112655293107	1	2015-04-01	2015-04-01
258112655293107	1	2021-05-25	2021-05-25
157054327406685	6	2020-01-07	2020-10-06
157054327406685	4	2020-12-01	2020-12-01
258086115253449	1	2019-12-01	2019-12-01
122128399094364	1	2016-08-02	2016-08-02
122128399094364	1	2017-09-03	2017-09-03
148069955003476	1	2015-08-26	2015-08-26
148069955003476	1	2015-08-27	2015-08-27
148069955003476	1	2020-01-04	2020-01-04
180020359139629	1	2015-09-15	2015-09-15
121034314107191	6	2015-07-21	2017-02-03
121034314107191	4	2017-08-13	2018-05-13
121034314107191	2	2018-08-15	\N
227024560069053	5	2020-11-21	2021-02-23
227024560069053	2	2021-05-22	2021-05-23
227024560069053	6	2021-11-11	2021-12-01
156060915698166	4	2021-11-02	2021-11-19
156060915698166	2	2021-11-26	2021-11-27
156060915698166	1	2021-11-28	2021-11-28
156060915698166	5	2021-12-01	2021-12-01
177103352992307	1	2019-07-07	2019-07-07
177103352992307	1	2021-05-04	2021-05-04
177103352992307	1	2021-09-11	2021-09-11
255099147198042	1	2017-04-09	2017-04-09
173088238558496	1	2015-05-24	2015-05-24
173088238558496	1	2019-01-19	2019-01-19
156119474815307	1	2019-02-08	2019-02-08
166081296763649	1	2020-10-24	2020-10-24
166081296763649	1	2020-12-01	2020-12-01
166081296763649	1	2021-05-26	2021-05-26
136071847516617	4	2017-06-22	2020-09-19
136071847516617	3	2021-12-01	2021-12-01
251011333261627	1	2019-04-19	2019-04-19
251011333261627	1	2020-08-27	2020-08-27
138074248401105	1	2020-09-13	2020-09-13
138074248401105	1	2020-12-01	2020-12-01
140119959250877	1	2016-03-19	2016-03-19
140119959250877	1	2017-12-01	2017-12-01
172051108200956	1	2019-10-11	2019-10-11
172051108200956	1	2019-12-01	2019-12-01
172051108200956	1	2021-02-09	2021-02-09
134053265437083	3	2018-10-11	2019-07-28
134053265437083	6	2020-04-11	2020-11-22
134053265437083	4	2021-07-18	2021-09-21
134053265437083	3	2021-12-01	\N
198111260505320	1	2020-02-02	2020-02-02
256074987484479	2	2015-04-09	2017-03-21
256074987484479	2	2019-05-25	2020-11-22
199127252136345	1	2020-12-01	2020-12-01
262038778938203	1	2015-04-06	2015-04-06
262038778938203	1	2016-04-26	2016-04-26
262038778938203	1	2020-04-27	2020-04-27
282066379868584	1	2017-05-05	2017-05-05
233109092062205	1	2017-02-01	2017-02-01
176106513315003	1	2017-03-03	2017-03-03
180057367414637	1	2015-02-17	2015-02-17
117121559056457	1	2016-04-16	2016-04-16
240022636962670	1	2017-12-01	2017-12-01
240022636962670	1	2015-09-27	2015-09-27
240022636962670	1	2021-09-28	2021-09-28
266025004527670	1	2016-08-07	2016-08-07
266025004527670	1	2017-05-20	2017-05-20
266025004527670	1	2019-12-01	2019-12-01
277122777128078	4	2018-02-22	2020-09-04
277122777128078	2	2020-09-21	2020-09-26
277122777128078	1	2020-09-28	\N
160025901759025	5	2020-05-07	2021-09-06
160025901759025	3	2021-09-28	2021-10-02
160025901759025	6	2021-10-14	2021-10-28
160025901759025	2	2021-11-10	\N
127081156734983	1	2016-10-25	2016-10-25
127081156734983	1	2017-09-03	2017-09-03
127081156734983	1	2019-05-17	2019-05-17
288119690626128	1	2018-01-25	2021-12-01
101073163220911	1	2020-12-01	2020-12-01
101073163220911	1	2021-05-14	2021-05-14
101073163220911	1	2021-05-16	2021-05-16
286058534258713	3	2020-06-04	2021-08-18
286058534258713	2	2021-09-10	2021-12-01
149061136795769	6	2020-04-05	2020-08-08
149061136795769	3	2021-09-17	\N
245070516446550	1	2016-09-01	2016-09-01
245070516446550	1	2019-01-20	2019-01-20
245070516446550	1	2021-07-26	2021-07-26
230026753623669	1	2020-11-20	2020-11-20
230026753623669	1	2020-11-28	2020-11-28
230026753623669	1	2016-05-24	2016-05-24
102035825373803	3	2020-03-25	2021-07-12
102035825373803	4	2021-08-15	2021-08-23
102035825373803	1	2021-11-11	2021-12-01
180028509811169	1	2018-01-14	2018-01-14
180028509811169	1	2018-10-21	2018-10-21
180028509811169	1	2020-04-03	2020-04-03
216074033954453	1	2018-02-24	2020-02-27
216074033954453	6	2020-03-20	2020-04-17
216074033954453	2	2020-11-27	2021-08-17
216074033954453	4	2021-08-22	2021-10-14
216074033954453	1	2021-11-13	\N
293094751937192	1	2016-11-06	2016-11-06
293094751937192	1	2020-08-01	2020-08-01
293094751937192	1	2021-01-24	2021-01-24
147061886221913	1	2016-07-05	2016-07-05
147061886221913	1	2017-11-27	2017-11-27
223028798999363	1	2020-04-28	2020-04-28
223028798999363	1	2021-02-10	2021-02-10
232052892461325	1	2017-11-12	2017-11-12
232052892461325	1	2021-10-27	2021-10-27
232052892461325	1	2021-10-28	2021-10-28
101120424360755	2	2015-05-06	2017-04-08
101120424360755	1	2017-06-26	2020-04-05
101120424360755	1	2021-09-16	2021-12-01
221067551980230	1	2017-04-26	2019-02-05
221067551980230	5	2020-08-10	2021-08-17
221067551980230	4	2021-11-19	2021-11-28
218015653051373	1	2016-12-01	2016-12-01
218015653051373	1	2020-08-16	2020-08-16
218015653051373	1	2021-05-16	2021-05-16
240114616700691	1	2020-08-12	2020-08-12
240114616700691	1	2020-12-01	2020-12-01
193077753289249	1	2020-12-01	2020-12-01
193077753289249	1	2021-05-12	2021-05-12
265116744621785	1	2018-01-08	2018-01-08
265116744621785	1	2018-09-18	2018-09-18
242043149777286	2	2019-09-09	2020-06-11
242043149777286	2	2020-08-27	2021-12-01
133057095110202	1	2019-06-08	2019-06-08
219065678886179	1	2019-04-05	2019-04-05
219065678886179	1	2020-11-22	2020-11-22
296025362844675	1	2017-04-18	2017-04-18
119118453408165	4	2021-05-24	2021-05-28
235051633057734	1	2019-12-01	2019-12-01
235051633057734	1	2020-05-17	2020-05-17
278090615498741	1	2021-11-13	2021-11-13
147106883665481	1	2019-02-28	2019-02-28
147106883665481	1	2021-12-01	2021-12-01
167087766989559	1	2018-01-26	2018-01-26
167087766989559	1	2020-09-09	2020-09-09
167087766989559	1	2020-09-11	2020-09-11
291031559371140	1	2017-09-13	2017-09-13
247087976437659	1	2018-11-07	2018-11-07
195091425437937	2	2021-10-26	2021-12-01
194060824711882	5	2015-08-05	2016-02-19
194060824711882	3	2021-04-26	2021-12-01
292032841511432	2	2019-06-14	2021-05-10
292032841511432	1	2021-07-02	2021-12-01
185098166371591	5	2017-12-01	2018-09-28
185098166371591	2	2021-03-15	2021-08-21
185098166371591	5	2021-09-16	2021-09-19
185098166371591	3	2021-09-26	2021-09-26
246029028617827	4	2016-12-01	2016-12-01
246029028617827	6	2019-11-26	2019-11-27
246029028617827	1	2021-06-03	2021-11-14
246029028617827	6	2021-12-01	2021-12-01
221067001545141	1	2018-10-05	2018-10-05
200125523886081	1	2016-04-22	2016-04-22
200125523886081	1	2018-05-01	2018-05-01
260094752288347	1	2015-08-08	2018-03-27
260094752288347	2	2021-04-03	2021-05-10
281036969136109	1	2016-12-01	2016-12-01
272070106053457	1	2016-09-06	2016-09-21
272070106053457	3	2019-05-06	\N
199063889574962	1	2017-09-23	2017-09-23
199063889574962	1	2019-04-23	2019-04-23
145021483919530	1	2019-01-09	2019-01-09
145021483919530	1	2021-03-15	2021-03-15
145021483919530	1	2021-12-01	2021-12-01
175025581397787	1	2017-05-18	2017-05-18
195015259294765	1	2018-02-04	2018-02-04
195015259294765	1	2021-12-01	2021-12-01
157014415900863	6	2016-01-15	2019-03-24
157014415900863	1	2020-04-07	2021-06-24
157014415900863	5	2021-07-11	2021-07-27
189058437714714	1	2019-01-25	2019-01-25
205061346129578	1	2017-09-28	2017-09-28
205061346129578	1	2020-09-28	2020-09-28
205061346129578	1	2021-10-13	2021-10-13
287110819788543	1	2016-01-22	2016-01-22
287110819788543	1	2018-02-21	2018-02-21
230112913478191	1	2020-01-18	2020-01-18
230112913478191	1	2020-05-28	2020-05-28
230112913478191	1	2019-12-01	2019-12-01
194108897647962	1	2019-09-08	2019-09-08
194108897647962	1	2020-01-17	2020-01-17
194108897647962	1	2021-01-24	2021-01-24
278033263543368	3	2018-07-12	2019-11-20
278033263543368	4	2021-05-06	\N
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patients (numsecu, nomu, nom, prenom, adresse, medecint) FROM stdin;
102099406908259	DESLACS		Charles-Alan	4 Rue de la fée Paris	125884787
219099814993817	BEGUE		Paule	29 Rue Sainte Croix de la Bretonnerie Paris	125884787
160099160424193	BARBE		Séverine	30 Rue de Viarmes Paris	157845587
260070857162645	BARBE	BLANCHET	SamM	17 Rue Louis Thuillier Paris	125548762
296060410603476	RIVIERE	BOYER	Yasmina	46 Rue Montesquieu Paris	157845587
110075202910187	DOUCET	PONCET	Gilbert	40 Rue Vieille du Temple Paris	125548762
256105595097885	POTIER		Guido	40 Rue Linne Paris	264481274
214072889800551	KEITA	BAUER	Pierric	1 Rue Boutebrie Paris	125884787
193012735171474	LEFORT		Romano	18 Rue Caffarelli Paris	125884787
248042148685557	PICOT		Habib	3 Rue Cochin Paris	157845587
152027306574655	MOREAU	VARIN	Carmen	28 Rue Froissart Paris	125884787
279061486384848	TOURNIER	LERAY	Lysiane	27 Rue Laromiguiere Paris	264481274
287073840279994	MAHIEU	THIERRY	Jean-Lionel	30 Rue Vauquelin Paris	125884787
114046512153391	LE MEUR		Rémi	15 Rue Courtalon Paris	125884787
277092607082177	MERLE		Gunther	31 Rue du Ponceau Paris	125548762
299072728963532	SEGUIN	DESCHAMPS	Marianne	36 Rue des Jeuneurs Paris	264481274
206104038258974	TANGUY		Mathieu	50 Rue des Ursulines Paris	264481274
275033015197248	HARDY		Massimiliano	9 Rue Saint Augustin Paris	264481274
222124053073274	PROVOST		Marie-Julie	18 Rue Sainte Croix de la Bretonnerie Paris	125884787
199073894063622	PAYEN	PAIN	Claudie	14 Rue de l Abbe Migne Paris	125884787
261037687526684	BERTHET	LAMBERT	Josée	17 Rue Notre Dame des Victoires Paris	157845587
112017646417282	JOUAN		Eugénie	46 Rue Gabriel Vicaire Paris	157845587
174054006457994	LEMONNIER	POTIER	Jean-Maurice	14 Rue du Ponceau Paris	264481274
129096634267071	DAVID		Jenny	37 Rue Saint Medard Paris	125884787
159078258577790	GOMEZ		Jorge	46 Rue de Sevigne Paris	264481274
289117971785167	POMMIER	LEBEAU	Paule	50 Rue Saint Louis En l Ile Paris	125884787
142101422071437	BERTRAND	RIOU	Blanche	38 Rue des Barres Paris	125548762
268125207178893	BRUNEAU		Pierre-Henri	8 Rue de la Lune Paris	125884787
252083456811832	ROLAND		Juliette	2 Rue Cuvier Paris	264481274
200047009218824	GEORGE	SALMON	Anne-France	13 Rue d Argout Paris	125548762
143019800299320	LAVIGNE		Denys	35 Rue Aubriot Paris	157845587
211074534119340	VERDIER		AlexM	43 Rue Vauvilliers Paris	264481274
103125323589468	SAUVAGE	CARVALHO	ChristelM	47 Rue de Picardie Paris	125884787
106087597638186	BERARD	BERTHET	Oscar	21 Rue la Feuillade Paris	125884787
272058275424815	TOUSSAINT		Klaus	46 Rue de Poissy Paris	157845587
273129609433214	FOUCHER	BONIN	Nadine	32 Rue Castex Paris	125884787
190103324064033	CANO		Dalida	13 Rue des Filles Saint Thomas Paris	125548762
234097079083817	RAMBAUD		Antony	20 Rue des Orfevres Paris	264481274
136127094573707	LE MEUR		Medeiros	9 Rue de la Vrilliere Paris	157845587
186117248253373	COURTIN	DUVAL	Isaac	39 Rue Borda Paris	125884787
155103596746626	DELAGE		Carol	31 Rue des Ursins Paris	125884787
191039387061932	LAFONT	COULIBALY	Samira	3 Rue du Louvre Paris	264481274
205088470224121	HADDAD	GERVAIS	Desmond	38 Rue des Écoles Paris	125884787
168084074496066	LAMOTTE		Yves-Marie	24 Rue de Gramont Paris	125884787
295113751469259	BOIS	LE BRIS	Joachim	20 Rue Léon Cladel Paris	125548762
224076688820310	BAILLY		Suzanne	43 Rue Cherubini Paris	125548762
238113830884391	HAMEL		Martino	16 Rue Eugene Spuller Paris	125884787
219023373245959	ANDRIEUX		Eliane	24 Rue des 4 Fils Paris	125884787
260079595038944	PETIT		Églantine	50 Rue de la Reynie Paris	125884787
269017040525206	JACQUET		Jean-Laurent	24 Rue de la Cossonnerie Paris	264481274
236056972976895	LECLERE	PIRES	Jan	33 Rue Sainte Croix de la Bretonnerie Paris	264481274
110026458507876	LECOQ		Barbara	28 Rue de Mirbel Paris	125548762
247127106036787	HEBERT	BLANCHET	Sylvette	15 Rue de Beaujolais Paris	157845587
138114541205136	BASSET	TANGUY	SandrinoM	31 Rue Saint Sauveur Paris	125548762
222038976800500	BOUCHARD	SALAUN	Régine	34 Rue Cambon Paris	125548762
220061225495182	FRANCOIS	VIEIRA	Danielle	50 Rue des Petits Carreaux Paris	125884787
240033187603968	DUVAL	ROUSSET	Sophie	23 Rue des 2 Ponts Paris	125548762
272070825829025	LACROIX	PASQUIER	Reinhard	27 Rue Rameau Paris	264481274
157087167057385	AUVRAY	GUEGUEN	Marc-Aurèle	3 Rue Debelleyme Paris	125884787
133032823100292	PEREIRA		Vittorio	31 Rue Monsigny Paris	264481274
106119496166800	LECLERCQ		Rosane	2 Rue Eugene Spuller Paris	125884787
127115565413833	WOLFF	LUCAS	Lilian	27 Rue Sainte Apolline Paris	157845587
188029343169600	CHATELAIN	FAVIER	Danièle	41 Rue Cunin Gridaine Paris	125884787
224064678226352	BOUVIER		Clarisse	12 Rue Jean Jacques Rousseau Paris	157845587
116109407794060	ROSE		Mathias	28 Rue de l Arc En Ciel Paris	125884787
272039140869355	LANG		Joselaine	44 Rue du Val de Grace Paris	125548762
208074951895256	VIVIER	GRONDIN	Élodie	36 Rue Saint Jacques Paris	125884787
262015291294848	JULLIEN		Mario	5 Rue Paillet Paris	125548762
213106211666187	FAURE	DA SILVA	Rémi	43 Rue des Haudriettes Paris	157845587
118087215592174	YILMAZ		Hubert	23 Rue de Bearn Paris	125548762
234067373357213	MENARD	CANO	Dan	13 Rue de la Sorbonne Paris	264481274
188045887135447	MOREAU		Evelyne	11 Rue Dolomieu Paris	125884787
241080926692571	MARCHAND	LAPORTE	Lise	18 Rue Beauregard Paris	125548762
264097854809707	LANG		Eugène	4 Rue Édouard Quenu Paris	125884787
144046178449562	GOSSELIN	ROQUES	Murielle	10 Rue de Rohan Paris	125884787
178111533112086	PEPIN	BESSE	Jean-Michel	14 Rue Saint Martin Paris	157845587
189095171291580	MAYER		Abdoullah	33 Rue Saint Philippe Paris	125884787
175015762007662	SAHIN		CesareM	45 Rue Poliveau Paris	157845587
284053711527533	ROCHE	BINET	Marie-Chantal	10 Rue de la Lune Paris	157845587
105050100550524	MICHAUD	GUILBERT	Emanuelle	6 Rue des Degres Paris	264481274
227064841682823	LAVERGNE		Erick	31 Rue de Mondovi Paris	125548762
292109226948564	BOUCHE		Dan	37 Rue Feydeau Paris	264481274
155095540067981	SILVA	COUDERC	Michel-Ange	1 Rue de l Arbalete Paris	157845587
225125232448434	AFONSO	CONSTANT	Jean-Olivier	23 Rue des Feuillantines Paris	125548762
228088926039612	GALLAND	BARBOSA	Diana	33 Rue Mondetour Paris	264481274
238070277696152	PRAT	BLANDIN	André	20 Rue Quincampoix Paris	125548762
257117887417480	VIVIER		Ahmad	33 Rue de Harlay Paris	125884787
225031944898819	BAILLY	SALMON	Alberto	42 Rue du Parc Royal Paris	125884787
293079221586080	DUPRE	CAILLAUD	Benjamine	50 Rue Leopold Bellan Paris	157845587
185092827286780	DANIEL		Charles-Marie	35 Rue du Haut Pave Paris	157845587
264043437527700	VILLAIN	PELLERI	Soraya	5 Rue Duphot Paris	264481274
245015721956300	MARQUES		Karl	31 Rue du Perche Paris	157845587
231046716894840	JEAN		Marianne	19 Rue Paul Lelong Paris	125548762
140063743131455	LEBRETON	MERLIN	Dieter	27 Rue Au Maire Paris	264481274
171022452464038	MILLET		Marina	2 Rue Eugene Spuller Paris	125884787
279097002609694	PEREIRA		Mohammad	31 Rue des Bourdonnais Paris	125548762
187070500246915	WAGNER	FLEURY	Jésus	35 Rue du Tresor Paris	157845587
110122942077957	GAUDIN		Louis	41 Rue Caron Paris	157845587
212072855963112	LOMBARD	DUCLOS	Marius	12 Rue Elzevir Paris	157845587
262091838145236	ROYER	HAMON	CarmineM	35 Rue Sainte Apolline Paris	125548762
276029947381735	DUCROCQ		Marie-Josée	27 Rue Pecquay Paris	264481274
259078280957764	VARIN	FOUQUET	Bernadette	28 Rue de Mirbel Paris	125884787
279017621953618	LEBRETON	THEBAULT	François-Xavier	31 Rue des Pyramides Paris	264481274
291059430428428	YILDIZ	LAVAL	Manfred	26 Rue des Fontaines du Temple Paris	264481274
225088516583057	JOLLY	BERTRAND	Kamel	3 Rue Gabriel Vicaire Paris	264481274
254036634248290	TISSOT	LACROIX	Cathy	2 Rue Vauquelin Paris	125548762
199055493956493	MACHADO		Vivian	31 Rue de la Ville Neuve Paris	125548762
251044262482430	BLAISE	BELIN	Benoît-Paul	24 Rue Cujas Paris	125884787
230107599623686	SOARES		Sybille	50 Rue Vaucanson Paris	157845587
157028597172844	BROSSARD		Linda	26 Rue du Nil Paris	157845587
214072768854685	DELAGE		Serge	17 Rue Beaubourg Paris	125884787
280026155058522	PASCAL		Bernadette	28 Rue Reaumur Paris	264481274
135091467058684	LELIEVRE		Marie-Odile	25 Rue Lagarde Paris	264481274
299096402146261	LEFRANCOIS	NICOLLE	Marie-Pascale	36 Rue des Patriarches Paris	157845587
123079019442742	VIEIRA	LECOCQ	Paula	27 Rue Gaillon Paris	125884787
285073076628400	LAFLEUR	LEON	Sami	38 Rue du Ponceau Paris	157845587
122076067789172	BLONDEAU		Grégoire	45 Rue Catinat Paris	157845587
164104498311563	JOSEPH	BRUNO	Odile	5 Rue des Francs Bourgeois Paris	125884787
223079798264179	NORMAND	GIBERT	Frederick	48 Rue Mornay Paris	125548762
287128641152343	WEISS		Manuel	3 Rue Saint Joseph Paris	125884787
124064655533453	MAILLET	PRIGENT	Malika	21 Rue Brantome Paris	264481274
177087933217555	MARIE	KONATE	Lucile	15 Rue Paul Dubois Paris	157845587
178083543213634	SILVA		Renaud	26 Rue Censier Paris	125548762
193052131885364	JARRY		Max	16 Rue Cochin Paris	264481274
230034748673362	FLAMENT	TERRIER	Emily	11 Rue Bailly Paris	125884787
234081951792054	PRIEUR	LE BORGNE	Jean-Roger	50 Rue du 4 Septembre Paris	125548762
138021076527659	KEITA		Christiane	24 Rue Tournefort Paris	157845587
112011349625910	CISSE		Yolande	2 Rue Geoffroy l Asnier Paris	264481274
130110933481910	DIDIER		Pierre-Yves	4 Rue Monge Paris	157845587
200036971177056	PONCET	HOARAU	Dimitri	36 Rue Courtalon Paris	264481274
248026335038972	OLIVEIRA		Pascaline	35 Rue des Rosiers Paris	125548762
108014463737146	JOURDAIN	LEJEUNE	Jean-Marie	9 Rue Louis le Grand Paris	125884787
113087786480165	PUJOL	LE GUEN	Jean-Loup	5 Rue des Bourdonnais Paris	125548762
279045756456236	DUHAMEL	BRAULT	Aristide	21 Rue Basse Paris	264481274
158031664828007	POULET	LEFEUVRE	Vincent	14 Rue Castex Paris	125884787
253107320548282	JIMENEZ		Wilfried	23 Rue Montgolfier Paris	125548762
159112943567608	HOFFMANN	BRUN	Katia	6 Rue Saint Julien le Pauvre Paris	125884787
249024680955619	HERAULT	MOREL	Arlette	5 Rue Menars Paris	264481274
192057011550036	SISSOKO	MULLER	Jean-Loïc	31 Rue Herold Paris	264481274
256083287261288	GUIGNARD	BRUNET	Blandine	36 Rue du Mail Paris	125548762
248098049506176	LABORDE	SYLLA	Sébastien	4 Rue du Bouloi Paris	125548762
130029464135944	DARRAS		Thibaud	34 Rue Coquilliere Paris	157845587
232123044977541	ALLARD	BUISSON	Peguy	14 Rue du Sommerard Paris	264481274
148074826149072	CASTEL	JOLLY	Raoul	5 Rue Chapon Paris	125548762
199051568162490	GRANIER	ALBERT	Claudius	37 Rue de Quatrefages Paris	125884787
192091009413573	MAURY		Floriane	35 Rue des Feuillantines Paris	125884787
167024655249766	GIBERT	BLIN	Jean-Sébastien	39 Rue du Pont Aux Choux Paris	125548762
292071211633603	TARDY	RIOU	Bertrand	31 Rue de Birague Paris	264481274
279082331012316	LOPEZ	BOCQUET	Yann	39 Rue Montorgueil Paris	125548762
174110385863580	RENAUD		Jeannine	37 Rue Jacques Henri Lartigue Paris	157845587
160017115802452	LEBLOND		Jean-Frédéric	29 Rue Leopold Bellan Paris	264481274
100043305622465	RENOU		André-Luc	40 Rue Pernelle Paris	125884787
194128800296508	AUBRY	LAMOTTE	Romuald	23 Rue Berthollet Paris	157845587
153016273510071	LAURET	LEGENDRE	Irma	9 Rue Eginhard Paris	125548762
144047443721909	QUERE	POMMIER	Gabriella	40 Rue Beranger Paris	157845587
230073061835012	GUIGNARD		Augustin	34 Rue du Louvre Paris	125884787
242060173510692	SAIDI		Mercedes	23 Rue des Filles du Calvaire Paris	157845587
118017450826990	GUILBERT		Rudolph	3 Rue Blondel Paris	264481274
289048180276376	GODET	LENOIR	Sophie	40 Rue de la Reynie Paris	264481274
245116596868850	GOUJON		Luca	46 Rue de Lanneau Paris	264481274
168076338524481	TEXIER	BARREAU	Gaston	32 Rue Nicolas Houel Paris	125548762
112059565719842	COLLET		Armelle	3 Rue des Tournelles Paris	264481274
136076785900286	DUPRE		Salma	31 Rue du Pas de la Mule Paris	157845587
103024280047064	LANG		Anne-Lise	8 Rue des Capucines Paris	125548762
268075069028143	GARNIER		Marta	49 Rue de Venise Paris	157845587
249111185011005	BUREAU		Jeanine	45 Rue de l Abbe de l Epee Paris	157845587
185059544397412	VIEIRA	LAGARDE	Frantz	36 Rue Jean Lantier Paris	125884787
101115361637735	ALI		Ulrika	36 Rue Sainte Anne Paris	157845587
223064299968133	LEON		Sandrine	21 Rue Cochin Paris	264481274
290030296252649	BOULET	LUCAS	Baudoin	7 Rue Notre Dame de Nazareth Paris	264481274
183096237207201	DORE	PRAT	Armel	6 Rue Boucher Paris	125548762
257102630986082	BOULAY	SCHWARTZ	Lawrence	45 Rue Saint Joseph Paris	125548762
139058252403158	LAVIGNE	MICHELET	Claudia	28 Rue Saint Merri Paris	264481274
197092256134117	JANVIER	DELAPORTE	Adrianus	2 Rue du Petit Musc Paris	264481274
167073348121233	MOREL	ROYER	Mariana	38 Rue du Forez Paris	264481274
257084916573371	BOURGEOIS	LEBAS	Françoise	40 Rue de l Orient Express Paris	125884787
269064890143438	MOUNIER		Patrizia	19 Rue des Petits Peres Paris	125884787
107063793494291	JIMENEZ	NICOLLE	Janine	1 Rue de la Perle Paris	125548762
172057342339830	GRAND	VARIN	Brian	21 Rue des Halles Paris	157845587
179076282691743	JACQUET	GODIN	Chiara	24 Rue Ferdinand Duval Paris	125884787
125053714364144	NGUYEN	LOISEAU	Herman	33 Rue Pernelle Paris	157845587
107116261245646	BLONDEAU	DUMAS	Maria	10 Rue Saint Bon Paris	264481274
222095362060135	FOUCHER	BAILLY	Rudy	16 Rue Saint Spire Paris	264481274
164087084249753	DIABY	AUBERT	Dieudonné	26 Rue du Gril Paris	157845587
117126263944457	TOURE		Lauriane	45 Rue Cunin Gridaine Paris	125884787
286095607481988	CHARBONNIER		Nadège	26 Rue Tournefort Paris	125548762
154100549674560	LASSERRE	PAYEN	Oswald	8 Rue Lacepede Paris	264481274
243124767698205	LANGLOIS	GROS	Alessandro	43 Rue Cambon Paris	125548762
240055800882855	JACQUEMIN		Antonio	26 Rue des Ursulines Paris	157845587
213114441086169	LEMARCHAND		Jean-Yves	47 Rue le Regrattier Paris	125884787
250022187467305	VANNIER		Stefano	5 Rue de Bretonvilliers Paris	125548762
109039206294408	PERON		Marie-Angèle	45 Rue Poulletier Paris	157845587
160026095111549	MASSE	ROMERO	Mercedes	9 Rue Claude Bernard Paris	125884787
237012302577364	TOUSSAINT	RAYMOND	Judith	17 Rue Beaubourg Paris	125548762
140088069682239	CHAUVEAU		Carla	22 Rue Perrault Paris	125884787
102050748294646	COMTE	RODRIGUES	Didier	39 Rue du Fouarre Paris	125884787
173016545039252	BARRET		Philip	15 Rue du Cygne Paris	125548762
236010256267941	BARBOSA	MEUNIER	Jean-Olivier	31 Rue Royer Collard Paris	125884787
165011896866744	DELMAS	RENAUD	Klaus-Werner	41 Rue Jean Jacques Rousseau Paris	264481274
150070518841138	LEJEUNE	VERDIER	Max	6 Rue de Turbigo Paris	125548762
171115439111771	DANIEL	DA COSTA	Jean-Daniel	24 Rue Beautreillis Paris	157845587
177037001185459	MAILLET	LEPRETRE	Arthur	32 Rue de Choiseul Paris	157845587
299080308159168	NAVARRO	PHILIPPE	Jean-Bernard	3 Rue Paul Dubois Paris	125884787
111069747504039	MARC	DIARRA	Mohamed	48 Rue Aubriot Paris	157845587
127103535268416	MANGIN	BONNET	Jean-Clément	50 Rue Pascal Paris	125884787
297028710752743	DAVID	BONIN	Charlie	39 Rue des Arquebusiers Paris	125548762
111094658103947	DA SILVA		Dieudonné	10 Rue Villehardouin Paris	125884787
216063297975659	LESUEUR	GUITTON	Lila	7 Rue Aubry le Boucher Paris	157845587
197114552893819	TEIXEIRA	LE	France	41 Rue Boutarel Paris	125884787
261095472962933	LELEU	CHATELAIN	Gérard	34 Rue du Mont Thabor Paris	264481274
102011564442610	GUEGAN		Lucy	8 Rue Pernelle Paris	125548762
126086148657250	COSTA		Léon	33 Rue de Castiglione Paris	125548762
122100732156095	LEROY	MULLER	Donald	31 Rue de la Verrerie Paris	264481274
193091370484103	HOARAU	LEGRAND	Jean-Bernard	11 Rue Bailleul Paris	157845587
278086882390588	BON	LOPES	Marie-Chantal	12 Rue Massillon Paris	125548762
136084997092352	DUPUIS		Victoire	39 Rue Sainte Croix de la Bretonnerie Paris	125884787
135101302110067	GROSJEAN		Élie	26 Rue du Chevalier de Saint George Paris	264481274
133057388336451	CORNU		Ahmed	41 Rue de Latran Paris	125548762
108038498976924	LESUEUR	TISON	Messaoud	18 Rue Domat Paris	157845587
266012535044395	HOARAU		Adriana	31 Rue Saint Denis Paris	125884787
235081064179459	JOLY	CLAUDE	Isabelle	25 Rue Malher Paris	264481274
189071551347808	LECOCQ		Jonas	33 Rue du Pont Louis Philippe Paris	157845587
294103109740262	SISSOKO	DUPIN	Youssef	28 Rue Saint Germain l Auxerrois Paris	157845587
147110710661853	BOUCHER	CHOPIN	Pierre-Marc	13 Rue du Pas de la Mule Paris	157845587
145077876002511	BLAISE	SALMON	Giorgio	50 Rue du Mail Paris	125884787
221014625770907	ANDRIEUX		Ahmed	49 Rue Poliveau Paris	264481274
289077275942294	LASSERRE	BOUVIER	Virginie	47 Rue du Forez Paris	264481274
230044759876745	MARTY		Lucienne	20 Rue Saint Denis Paris	125884787
296119994996166	BARRE	THUILLIER	Medeiros	39 Rue de Braque Paris	125548762
289045790842034	BROSSARD		Marie-Jeanne	12 Rue Saint Julien le Pauvre Paris	264481274
257084245336102	BIGOT	VILLAIN	Allan-David	19 Rue de Montpensier Paris	264481274
154034482837144	LAVERGNE	SANTOS	Marie-Ange	47 Rue d Arras Paris	157845587
212069761197108	CHEVALIER	REMY	Cathy	21 Rue Lagrange Paris	264481274
119034662639308	RAYNAUD	TOURE	Salma	38 Rue Favart Paris	157845587
117097307536183	BINET		Paco	4 Rue Sainte Anastase Paris	125884787
260124860732275	CHRETIEN	COURTOIS	Jean-Gilles	1 Rue de l Amiral Coligny Paris	125548762
172089291557913	BLONDEAU		Jean-Francis	4 Rue Sainte Croix de la Bretonnerie Paris	125548762
224129352103655	AUGER		Amandine	46 Rue Duphot Paris	264481274
186035821684512	LUCAS		Noémie	35 Rue Perrault Paris	125548762
282116367172719	PAPIN		Mario	14 Rue d Aboukir Paris	157845587
207076163837556	MAHE		Magali	20 Rue Pastourelle Paris	125884787
298063513226885	DIARRA	LAVERGNE	Loriane	6 Rue Tiquetonne Paris	157845587
213056577719720	DUPUY	GUYOT	Magaly	27 Rue d Alger Paris	125884787
257126563480430	PERRIN	THIBAULT	Jorg	3 Rue Borda Paris	157845587
161066859251464	POTTIER		Tanguy	35 Rue de Bretagne Paris	264481274
227101652934764	RIBEIRO	DUPONT	Jean-Roger	2 Rue de Cluny Paris	125548762
255066466547116	LY	MEUNIER	Jean-Manuel	48 Rue Cloche Perce Paris	125884787
117031740249272	CHRETIEN	LAMOTTE	Adolf	45 Rue Jean du Bellay Paris	125884787
281027462517127	SCHMIDT	LEONARD	Léo	33 Rue Geoffroy l Asnier Paris	157845587
195098864552439	LAROCHE		Evelyne	1 Rue du Pont Aux Choux Paris	125884787
139077210843596	CASTEL		Bahia	47 Rue Charlemagne Paris	125884787
248015103890538	SAHIN	GERARD	Élodie	31 Rue le Goff Paris	157845587
238051213766800	BRUN		Jean-Laurent	31 Rue des Minimes Paris	125884787
180014450742418	MOHAMED		Claudius	36 Rue de Pontoise Paris	157845587
282103173173307	PERRIER		Brian-John	3 Rue des Anglais Paris	264481274
130032128540230	ANDRE	LECLERE	Abdelaziz	4 Rue Claude Bernard Paris	125884787
160081840144512	BAYLE		Jean-Daniel	49 Rue Sainte Foy Paris	125884787
282093945534106	GRANGER	MILLET	Jeannette	16 Rue Cloche Perce Paris	125548762
185086534132201	REMY	LY	Charles-Emile	45 Rue des Precheurs Paris	157845587
294041736505100	MILLE		Loriane	16 Rue de l Arbalete Paris	125548762
160113579531989	MERLIN	LAINE	Emma	22 Rue de Mulhouse Paris	157845587
204025670523878	AUBERT		Edouard	24 Rue de Ventadour Paris	157845587
269032951239687	CHATELAIN	LEBLANC	Valentine	19 Rue de Mulhouse Paris	125884787
107087128682443	HUBERT		Théodore	20 Rue Froissart Paris	264481274
289106989656446	RIO		Lucette	12 Rue Jules Cousin Paris	157845587
116100226032930	COMBE		Wolfgang	23 Rue des Petits Champs Paris	157845587
126029294716045	BRUN		Esther	25 Rue du Bourg Tibourg Paris	125548762
259056721582059	PETITJEAN	WALTER	Claire	35 Rue Vivienne Paris	125884787
296078344435443	LAROCHE	TEXIER	Fatima	4 Rue Saint Claude Paris	264481274
275101635834500	SERRA	MICHELET	Tobias	38 Rue Domat Paris	125548762
253097588009331	LABORDE		Douglas	38 Rue Descartes Paris	264481274
173115356247302	CHRISTOPHE	FOFANA	Eddy	30 Rue du Foin Paris	264481274
196104695126094	JEANNE	VERGER	Constant	50 Rue des Orfevres Paris	264481274
104084767796763	GUILLET	GUIBERT	Dolorès	14 Rue Sainte Elisabeth Paris	125884787
173069866743140	DIAZ		Augustin	41 Rue du Perche Paris	125884787
104038552688549	PASCAL	MATHIEU	Rénata	41 Rue de Sevigne Paris	125548762
176026748099490	PETITJEAN		Anna	32 Rue des Haudriettes Paris	264481274
103117548023800	LE ROUX		Blandine	14 Rue de Beaujolais Paris	157845587
148109232252267	COHEN		Hervé-Joseph	15 Rue Erasme Paris	125884787
194069349220315	ROUX	MAILLET	Jean-Loup	44 Rue de Thorigny Paris	157845587
126095603806820	LE CORRE		Mauricette	41 Rue des Feuillantines Paris	125884787
268125032408842	JULIEN		SandyM	14 Rue de l Essai Paris	125884787
140123122489282	BOUCHE	CARLIER	Suzan	4 Rue Édouard Quenu Paris	157845587
255125446859673	THIEBAUT		Ali	23 Rue de la Bourse Paris	125884787
230081205171029	BERARD	MARIN	Henry	17 Rue du Marc des Blancs Manteaux Paris	125548762
196072465567305	LEBRETON		Kurt	5 Rue des Boulangers Paris	157845587
271094924607285	GILLET		Marie-José	23 Rue Ferdinand Berthoud Paris	125548762
132084756535784	CHATELAIN	LOUIS	Brahim	29 Rue des 3 Portes Paris	264481274
196100412822638	JOURDAIN		Octave	3 Rue du Pere Teilhard de Chardin Paris	264481274
297013402217591	BONNET	AUGER	Anna	31 Rue Maitre Albert Paris	125548762
206088289892884	PROVOST		Emmanuelle	30 Rue Pierre Brossolette Paris	125884787
220122235099677	MOUNIER		Louise	36 Rue du Pont Aux Choux Paris	125884787
173096580101586	THERY	COURTOIS	ClaudeM	31 Rue Dante Paris	157845587
282046629787403	KAYA		Jean-Yves	21 Rue de l Hôtel Saint Paul Paris	125548762
231060729971548	DIAS	MILLE	Elena	39 Rue Charlot Paris	264481274
261043349444673	MICHELET		Damien	39 Rue Catinat Paris	125884787
115012156909773	PETITJEAN	JEAN	Nourdine	42 Rue Victor Cousi Paris	157845587
261038771759746	COMBES	DUVAL	Tanguy	1 Rue Bernard de Clairvaux Paris	264481274
131107626638488	MERLIN		Anne-Claire	8 Rue Charles V Paris	125884787
251127256365773	DUPIN	BAUER	Jean-Nicolas	2 Rue Geoffroy Saint Hilaire Paris	125884787
267125703711841	MORIN	PICHON	Johannes	7 Rue de Rohan Paris	264481274
263084417717835	LOUVET		Léopold	28 Rue d Argout Paris	264481274
244078512056467	CHARLES	CLAIN	Timothy	9 Rue de l Oculus Paris	157845587
218120988164777	HUSSON		Reynald	45 Rue de Bievre Paris	125548762
257095588726569	DUPUIS	BARRE	Jean-Hervé	13 Rue de Marivaux Paris	157845587
166065352240321	AVRIL	LEBRUN	SandyM	33 Rue de Mulhouse Paris	125884787
194012458189138	JOSSE		Eudes	29 Rue du Nil Paris	264481274
247031441605135	RAMOS	JUNG	Anaïs	10 Rue la Feuillade Paris	125548762
270125888665229	SALOMON	PAUL	Jean-Claude	32 Rue de Franche Comte Paris	264481274
158059952001652	FERRARI	LOISEAU	Graham	37 Rue Mandar Paris	157845587
259026635921108	CARDON		Gaëlle	19 Rue Louis le Grand Paris	125884787
222066223450293	BLONDEAU	BOUQUET	Armando	22 Rue des Forges Paris	157845587
294035173348892	FABRE	CAMARA	Louis-Marie	21 Rue Tiron Paris	125548762
185012960779831	LOPEZ		Suzanna	6 Rue du Ponceau Paris	125884787
272017325071928	LEFRANCOIS	DESCHAMPS	Peguy	47 Rue de Valence Paris	264481274
226039430004407	DAVID		Muguette	42 Rue de Birague Paris	157845587
200070224267018	POLLET		Marylène	28 Rue du Forez Paris	264481274
290078809746561	HUE	GUY	Cathy	33 Rue de Montpensier Paris	125548762
184054997914403	BONHOMME	DUPRE	Allan	49 Rue Pierre Nicole Paris	125548762
231095254215790	COULON	JAMET	Jérémie	41 Rue des Haudriettes Paris	157845587
224036658465337	TISON		Arnaud	1 Rue du Pas de la Mule Paris	264481274
204063744707638	TARDY	TANGUY	Fatiha	38 Rue de Turbigo Paris	125548762
133077951509022	MERLIN		Abderrahim	33 Rue Ferdinand Duval Paris	125548762
279068550131477	PAIN	LETELLIER	Félix	50 Rue de Birague Paris	125884787
140021429173584	ROYER	PRIGENT	Alida	22 Rue Perrault Paris	264481274
116087933558285	MARIE	WAGNER	Samia	12 Rue de Palestro Paris	157845587
184042816040471	SAIDI	BEAUFILS	Mathieu	9 Rue Gay Lussac Paris	125548762
262065796255647	POTIER	PROST	Marcel	22 Rue Elzevir Paris	125548762
289116874121144	REMY		Nicholas	11 Rue du Colonel Driant Paris	264481274
242112406964207	PASQUET	PONS	Jean-Hugues	43 Rue des Bons Enfants Paris	125548762
254043611144658	BILLARD		Norbert	4 Rue de la Paix Paris	264481274
268031648794265	BENOIST		Dennis	15 Rue du Chevalier de Saint George Paris	125548762
173100893513653	BLAISE		Domingos	30 Rue Frédéric Sauton Paris	264481274
287059122651264	BOUSQUET		Jean-Hugues	16 Rue du Puits de l Ermite Paris	157845587
298073164942612	BINET		Judith	2 Rue Pastourelle Paris	157845587
131121957283294	CARDON		DominiqueM	18 Rue du Bouloi Paris	264481274
188110658741765	LAINE		Giorgio	11 Rue des 2 Boules Paris	125884787
112048414030269	BEAUFILS		Pietro	50 Rue de la Sourdiere Paris	125548762
172057142211349	LUCAS	PHILIPPE	Diogo	43 Rue des Prouvaires Paris	264481274
247081496882220	DEVAUX		Anne-Sophie	21 Rue des Carmes Paris	125548762
295057117847588	BON		Magali	44 Rue Lagrange Paris	125548762
106029864328731	LEGROS		Séverine	27 Rue de Louvois Paris	157845587
297077289777229	CARTIER		AlexM	48 Rue Caron Paris	125548762
157092099718462	TOUSSAINT	SAUNIER	Pierre-Jean	20 Rue Clemence Royer Paris	125884787
117017034544064	HONORE	VALLET	Pascaline	49 Rue la Feuillade Paris	125548762
134040655044942	THEBAULT	CAMUS	Gaspard	13 Rue Saint Gilles Paris	125884787
166012754054480	POTTIER		Rosanna	27 Rue Toullier Paris	264481274
159099939848446	COSTE	CARVALHO	Élise	46 Rue le Goff Paris	125884787
111129599402824	GREGOIRE		Jean-Guy	39 Rue Neuve Saint Pierre Paris	125548762
180080247750688	JOLLY	FAURE	Gladys	33 Rue du Foin Paris	125548762
115120226939995	MARY	SABATIER	Denyse	35 Rue d Aboukir Paris	264481274
178108944503402	SAUVAGE		Nathan	5 Rue de Franche Comte Paris	264481274
159059689722694	DIAS		Nora	2 Rue de la Boucle Paris	125548762
179036643060955	DUJARDIN	GAUTIER	Jean-Guy	29 Rue Perrault Paris	264481274
261023956555783	PREVOT	AVRIL	Jean-Raphaël	46 Rue du 29 Juillet Paris	264481274
235061978907881	COLAS		Muguette	28 Rue de la Corderie Paris	157845587
160076989558266	PETIT	DUPONT	Paulo	7 Rue de l Essai Paris	125548762
237044696201755	LE	DUPONT	Maryse	22 Rue des 2 Ponts Paris	157845587
147087143819012	FLAMENT	PERRIN	Cyprien	14 Rue de Birague Paris	264481274
177040491302245	MAITRE	MAUGER	Anne-Gaëlle	24 Rue des Lombards Paris	264481274
181026482885579	CHABOT		Alain	37 Rue Eginhard Paris	264481274
129073106456222	SILVA	GUICHARD	Bertrand	35 Rue Caffarelli Paris	157845587
241090757336013	RENOU		Jean-Léon	11 Rue de l Abbe de l Epee Paris	125884787
171110762807449	LACOMBE		Etiennette	16 Rue Thorel Paris	125884787
132105298375429	HAMELIN		Eve	39 Rue Dupetit Thouars Paris	264481274
277093701187718	CHRETIEN	BINET	Armelle	38 Rue le Goff Paris	157845587
233024779652808	ZIMMERMANN		Agathe	28 Rue Rambuteau Paris	125548762
299090800746875	LE GALL		Steve	31 Rue de Beaujolais Paris	125884787
158129815961864	LAFLEUR	BOUCHARD	Stewart	6 Rue Etienne Marcel Paris	264481274
186033471783730	DROUET		Sylvine	22 Rue des Pyramides Paris	125884787
124065145979904	SOULIER	CLAUDE	Abdoullah	26 Rue de Pontoise Paris	125548762
249013256140217	LEGRAND		Fernand	45 Rue du Petit Pont Paris	157845587
193118595042552	LAROCHE		Josephus	16 Rue Henri Robert Paris	264481274
159081311543565	GROS		Nina	2 Rue Chapon Paris	157845587
173038729083641	ALLARD		Judith	31 Rue de Bievre Paris	125548762
125025454240765	NICOLAS	BRETON	Carol	35 Rue de Cluny Paris	125884787
221074080373957	RIOU		Pierrette	8 Rue Berger Paris	264481274
158060447338923	SANCHEZ	RENARD	Erika	8 Rue de Sevigne Paris	264481274
191129347920866	LE CORRE	DUHAMEL	Friedrich	47 Rue Saint Claude Paris	125884787
146033753292561	CHARTIER		Yvonne	25 Rue du Caire Paris	264481274
235048088880828	DUARTE	BERNIER	Éva	42 Rue de Tracy Paris	157845587
232076673853214	GUILLOU		Abderrahim	8 Rue Charlemagne Paris	157845587
286090186822302	VOISIN		Erwann	19 Rue du Marche Saint Honore Paris	125884787
118091053967656	PIERRON		Alain	36 Rue la Feuillade Paris	264481274
178068445869714	MICHEL	MAYER	Pierre-Guy	43 Rue Jean Jacques Rousseau Paris	264481274
158102532502789	JOUAN		Jean-Pascal	1 Rue de la Cite Paris	157845587
234042453907063	DUBREUIL	HUE	Jean-Dominique	40 Rue du Petit Musc Paris	125884787
174108510634221	LANG	GROSJEAN	Nelly	28 Rue des Guillemites Paris	125548762
106024732204736	JOUAN		Dolorès	18 Rue Paul Lelong Paris	125884787
210082757893566	GUILLOU	MEUNIER	Marie-Joseph	17 Rue Saint Bon Paris	264481274
274074214651338	GUILLET		Claudie	27 Rue Coquilliere Paris	125884787
213049451577031	HERVE		Benaïcha	48 Rue de la Montagne Sainte Genevieve Paris	157845587
110117968136108	SOW	JOUBERT	Oscar	19 Rue Guerin Boisseau Paris	125548762
165121074783476	GUIGNARD	LEGER	Farid	26 Rue de Venise Paris	125884787
285020199679212	GUITTON	DUCLOS	Jean-Lou	41 Rue Paul Lelong Paris	125884787
153094524936207	DELATTRE		Dimitri	14 Rue Adolphe Adam Paris	125548762
132049184273634	LAMY	TESSIER	Alexander	37 Rue des Écoles Paris	157845587
276037987247044	MORICE	LEMARCHAND	Bruno	19 Rue le Goff Paris	157845587
228106833603672	ROGER		Anne-Marie	34 Rue Lagarde Paris	157845587
242105257964173	RAYNAUD	BLANCHET	Amandine	39 Rue Notre Dame de Recouvrance Paris	125884787
138014247515067	CAMARA		Esther	40 Rue du Bourg Tibourg Paris	125548762
173064457870768	MARC		Denyse	44 Rue de Gramont Paris	264481274
208025327926752	FISCHER		Jason	22 Rue des Bourdonnais Paris	264481274
200121336505714	COMTE	CAILLAUD	ChristelM	35 Rue de la Montagne Sainte Genevieve Paris	264481274
150066519299853	CHARTIER	FRANCOIS	Dieter	14 Rue Payenne Paris	125884787
230101267074777	MOREL	HEBERT	Marie-Thérèse	38 Rue Ortolan Paris	157845587
249032164220679	JOURDAIN		Mounia	2 Rue du Grenier Saint Lazare Paris	125548762
128032363278916	KELLER	ALI	Alexandra	27 Rue Lhomond Paris	125548762
220097402246683	LENOIR	CLERC	Charlie	29 Rue de Bazeilles Paris	264481274
124080612389525	SIDIBE	KAYA	Mathieu	6 Rue du Cardinal Lemoine Paris	157845587
210054779062612	BOUCHE	SERRANO	Marius	10 Rue de la Coutellerie Paris	157845587
231077978618248	GUILLET		Christina	46 Rue Mornay Paris	125884787
111087875486253	LAMBERT	CANO	Nathaniel	48 Rue Favart Paris	264481274
145093359860917	BERNARD		Jean-Joël	30 Rue de Bearn Paris	125548762
264057206314352	CARDON		Christopher	9 Rue Maitre Albert Paris	264481274
288115135986478	BOUSQUET		Bernhard	38 Rue Volta Paris	125548762
231076141443908	KLEIN		Georges-Michel	34 Rue des Oiseaux Paris	125884787
108039523482436	BUREL	LEDUC	Roland	13 Rue Jean Beausire Paris	125884787
139037968769029	CARDON	SANTOS	Gérard	42 Rue Sainte Opportune Paris	157845587
111020282740019	BAUDIN		Guido	6 Rue de Palestro Paris	157845587
188049194998024	BONNET	GUITTON	Joselaine	28 Rue du Louvre Paris	125548762
258065169240672	MAYER		Élisa	18 Rue Necker Paris	157845587
232129815038482	PEPIN		Albert	36 Rue Descartes Paris	157845587
145093900289545	MARECHAL		CamilleM	5 Rue du Renard Paris	125884787
267121440433418	PRIGENT		Vanina	1 Rue de Rivoli Paris	125884787
227015778432519	MARQUET	TURPIN	Éva	34 Rue des Irlandais Paris	264481274
192048701289850	FAVRE	THIBAULT	René	48 Rue Bassompierre Paris	125548762
142077321716367	ANDRE	RENAUD	Manuela	36 Rue Guerin Boisseau Paris	125548762
286055345126560	DUFOUR	DELAHAYE	Charline	26 Rue de Quatrefages Paris	125884787
200021889427908	JOLLY		Paco	44 Rue d Uzes Paris	157845587
199129081130353	LEON		Marie-Aude	38 Rue du Nil Paris	157845587
243121776162227	BOUCHARD		Daniel-Henri	13 Rue de Brosse Paris	264481274
259114157338055	RICHARD		Nathaniel	3 Rue des Colonnes Paris	157845587
262105941528540	BIGOT	POIRIER	Margaux	43 Rue de la Cite Paris	125548762
109028760703504	BLOT	COUTURIER	Erik	45 Rue de la Boucle Paris	125884787
111061695359540	GUILBERT	BARBE	Olivia	32 Rue de l Abbe de l Epee Paris	157845587
104113276019870	VIGNERON		Sofia	17 Rue de Bretagne Paris	125884787
283023385915710	BASSET	DOUCET	Stanislas	18 Rue de la Harpe Paris	157845587
245093190848672	LEBRUN	LAGRANGE	Simone	13 Rue François Miron Paris	264481274
204069532268616	MILLOT	CARPENTIER	Marie-Juliette	21 Rue de la Vrilliere Paris	157845587
266125761809637	LE GOFF	GUILLARD	Oriane	37 Rue Saint Victor Paris	125548762
179043377875534	MARTINEZ	JANVIER	Viviane	38 Rue Jussieu Paris	157845587
112012210565675	GUILLEMIN	DA COSTA	Charles-Henry	12 Rue des Patriarches Paris	157845587
235043385743272	SOLER		Mario	11 Rue Sainte Foy Paris	264481274
279090179414274	GIMENEZ	HAMELIN	Valéry	47 Rue Sainte Apolline Paris	125884787
160121447322029	CORNU	DUMAS	Farid	41 Rue de Tracy Paris	125884787
113013415022913	MOREIRA		Darren	6 Rue Montmartre Paris	125548762
265027129877746	LANG	VAILLANT	Léo	32 Rue des Bons Enfants Paris	125884787
297052200312957	FLEURY		Damien	45 Rue de Mulhouse Paris	125548762
122014663436309	LECUYER		Denise	40 Rue Blainville Paris	125884787
129038681181682	FOFANA	LEPAGE	Augusta	23 Rue d Argenteuil Paris	125884787
134020806670324	GILLET	BARRE	Roseline	24 Rue de Pontoise Paris	125548762
187012554792695	JOURDAN	JACQUEMIN	Constant	22 Rue Tournefort Paris	264481274
180059188878011	BERTIN		Marie-Gabrielle	32 Rue du Roi de Sicile Paris	157845587
297125523160096	CHEVRIER	TOURNIER	Roland	21 Rue Mehul Paris	157845587
265029036567340	ROCHE	BAUDRY	Natanael	7 Rue Saint Medard Paris	125884787
261121983306746	PREVOT		Bernhard	47 Rue des Petits Peres Paris	125548762
250104194589654	DELAHAYE		Sybille	21 Rue Blainville Paris	264481274
106061220442334	BLANC	OLIVEIRA	Marie-Françoise	23 Rue d Antin Paris	157845587
235045565580018	THOMAS		Mohammed	48 Rue Thenard Paris	157845587
126078707125125	VASSEUR	LESAGE	Marjorie	12 Rue Leopold Bellan Paris	125884787
138016532409883	GUY	BONNARD	Fabre	26 Rue Baillet Paris	125548762
202065667224500	HUBERT		Jean	28 Rue de Braque Paris	264481274
279028648982730	GUERIN		Joao	12 Rue de l École Polytechnique Paris	264481274
167079831709246	LECLERC		Charles-Marie	2 Rue des Jeuneurs Paris	125548762
119040594612771	BOUSQUET	GUILLOT	Fleur	14 Rue de Harlay Paris	125548762
119123584674924	CROS	GOUJON	Jean-Nicolas	15 Rue Herold Paris	157845587
111093957436571	LECLERCQ		Nissim	5 Rue Pastourelle Paris	264481274
138117414994632	FRANCOIS		Amélie	3 Rue Pastourelle Paris	125548762
108095378165916	RICHARD		Maya	2 Rue du Pont Neuf Paris	125548762
168127697496623	OLIVIER	JACQUEMIN	Margaret	38 Rue Adolphe Adam Paris	264481274
106013559184560	PETITJEAN	MAURICE	Yves	32 Rue Scipion Paris	125548762
184058380356337	KELLER	LEGENDRE	Océane	6 Rue Rameau Paris	264481274
198076664451368	MESSAOUDI		Benjamine	11 Rue de la Grande Truanderie Paris	125548762
258048082897406	GUILLAUME		Nadège	33 Rue des Lombards Paris	157845587
231126440314564	CHAMPION		Nadège	43 Rue Payenne Paris	264481274
138012682483624	PARIS	JUNG	Jean-François	19 Rue Monsigny Paris	125548762
204086878297454	NIAKATE	LEMARCHAND	Léa	50 Rue des Halles Paris	125884787
283093646958657	GOMEZ		Madiha	27 Rue du Chevalier de Saint George Paris	264481274
271061263635761	CARDOSO		Abel	9 Rue Pascal Paris	125548762
105118896795057	MILLE		Achille	48 Rue des Lombards Paris	125548762
102105813093180	BINET	BOULET	Yasmina	20 Rue Champollion Paris	264481274
237017905332326	PARISOT	BONHOMME	Noémie	36 Rue des Fosses Saint Jacques Paris	125548762
118077056581811	GAUDIN	BONNEFOY	Miguel	11 Rue de Lutece Paris	125548762
263034571304887	BAPTISTE		CyrilleM	31 Rue des Fosses Saint Jacques Paris	157845587
208044768997360	BELIN	GUILLEMOT	Katy	27 Rue Saint Honore Paris	125548762
122079075675007	HAMON	BARBE	Marie-Édith	6 Rue du Cygne Paris	264481274
282129387212331	THIERRY	BONNEFOY	Judith	6 Rue Tiquetonne Paris	125884787
115026863697543	BARTHELEMY		Lorianne	50 Rue Pierre Au Lard Paris	264481274
220026006410436	CASTEL		Macha	44 Rue Bailleul Paris	125548762
167044562347780	DUPIN		Salma	21 Rue des Ursulines Paris	264481274
299037133754616	GILLES		Franz	14 Rue de l Oculus Paris	125548762
103031465371271	LASSERRE	BAZIN	Lauriane	30 Rue Leopold Bellan Paris	125548762
104058028163037	PAPIN	LACOSTE	Séverine	2 Rue Pernelle Paris	157845587
240055854166975	GRAND	BLONDEAU	Jean-Guy	36 Rue Froissart Paris	157845587
117037132207874	CARPENTIER	CROS	Brahim	37 Rue Censier Paris	125548762
201045792556159	MONTAGNE		Anne-Joséphine	31 Rue Erasme Paris	157845587
247076680160492	THUILLIER	BLIN	Gérard	17 Rue Perrault Paris	264481274
182106998943886	SCHMITT	HAMON	Jeannette	25 Rue des Jeuneurs Paris	264481274
228021921390634	VARIN		Roberta	19 Rue du Gril Paris	264481274
287096364247345	JACQUOT		Peguy	9 Rue de Beauce Paris	125884787
205021808810249	RAMBAUD		Sarah	31 Rue du Pere Teilhard de Chardin Paris	264481274
266118269787392	SCHWARTZ	LOUIS	André-Clément	27 Rue de l Ave Maria Paris	157845587
184122205851230	MICHEL	VERDIER	Macha	18 Rue d Arras Paris	264481274
122079030744910	RENAUD	RICARD	Lana	33 Rue Saint Medard Paris	125884787
224110767613876	HERVE		Jean-André	33 Rue Berger Paris	157845587
241037377974214	MILLET		Marie-Reine	46 Rue Soufflot Paris	157845587
108092681347765	ARNOULD	BAUER	Rodolphe	36 Rue d Uzes Paris	125884787
280018349144984	LE GAL	LEBEAU	Olivier	8 Rue de l Hôtel Saint Paul Paris	125884787
196057096921758	BAZIN	GAUTIER	Carol	38 Rue de Turenne Paris	264481274
194011513570806	LEMARCHAND		Nick	20 Rue de Pontoise Paris	125548762
259035687657778	BROSSARD		Romain	18 Rue de Saintonge Paris	125548762
126057880251485	BENOIST	TEIXEIRA	Anthony	11 Rue Jean de Beauvais Paris	157845587
199093654141463	CONSTANT	BOIS	Camille-Pierre	8 Rue de l Arsenal Paris	264481274
103069351144655	COLIN	GEORGE	Gary	33 Rue de Candolle Paris	125548762
124112836245324	COULON	GARREAU	Alexandra	37 Rue de l Arbre Sec Paris	157845587
196053106233543	CADET		Jozef	18 Rue Vauvilliers Paris	157845587
262111043702672	PARMENTIER	LEMOINE	Jean-Manuel	23 Rue Pierre Brossolette Paris	125884787
197072095070400	GUILLAUME		Mireille	50 Rue Charles V Paris	157845587
257093009218404	LAVIGNE		Erwann	35 Rue de Jarente Paris	125884787
203066369133626	VASSEUR	BERTHIER	CyrilleM	11 Rue de l Epee de Bois Paris	125884787
111035950431815	VERON	SELLIER	Agathe	9 Rue de la Cerisaie Paris	125548762
263125259436378	BARBIER		Lila	12 Rue de Turbigo Paris	264481274
134017162187334	LE MEUR		Ramon	24 Rue Geoffroy l Asnier Paris	125884787
168030986226722	LEBON	OLIVIER	Sara	17 Rue Descartes Paris	264481274
168021202642226	FERRARI	CAILLAUD	Melinda	41 Rue des Petits Carreaux Paris	264481274
201079687531493	COSTA	GRANDJEAN	Françoise	15 Rue des Petits Champs Paris	157845587
172083246489015	CASTEL		Adolf	5 Rue de Bievre Paris	125548762
238058887249971	MAILLOT	FERREIRA	Laura	30 Rue des Coutures Saint Gervais Paris	157845587
182121313633004	CORRE		Matthieu	4 Rue Scipion Paris	125884787
158024695395585	SENECHAL		Aurore	17 Rue de Turbigo Paris	264481274
143019130446016	DELMAS		Giselle	44 Rue de la Sourdiere Paris	125548762
232091464781612	PASCAL	VOISIN	Regina	25 Rue d Ormesson Paris	157845587
119054090697465	POTIER		Inès	8 Rue Mondetour Paris	125548762
286096550018864	CONSTANT	FLAMENT	Salvador	8 Rue des Pretres Saint G l Auxerrois Paris	125884787
224103773518604	MAURICE		Hervé-Joseph	38 Rue Jean Calvin Paris	264481274
187076588240535	RIO	POIRIER	Katy	42 Rue du Petit Moine Paris	125548762
111117128024918	PICHON	GOUJON	Reynald	12 Rue Conte Paris	125884787
195039141611720	COLLET	FERRER	Rudolf	22 Rue Cloche Perce Paris	125548762
110079463566681	LECLERCQ		Reine	30 Rue Papin Paris	157845587
146038235197769	BOURDIN		Antoni	3 Rue Debelleyme Paris	264481274
277056664098252	BERTHELOT		Leslie	41 Rue Georges Desplas Paris	157845587
289037829621190	HOARAU		Marylise	33 Rue du Marche des Patriarches Paris	264481274
103114111526792	BERTHE	CORREIA	Ahmad	26 Rue Saint Etienne du Mont Paris	157845587
256072702237635	GODIN		Franck	46 Rue du Parc Royal Paris	157845587
215109609078559	MARTINET		Capucine	34 Rue de Montmorency Paris	125884787
287106613897037	LY		Angie	40 Rue des Fosses Saint Jacques Paris	157845587
246037149657382	PIERRE	LEJEUNE	Raphaëlle	22 Rue Vesale Paris	125884787
260121787044371	MOULIN		GwenM	35 Rue de l Oratoire Paris	157845587
270012241493705	SALMON	BOUCHET	SandrinoM	8 Rue de Montmorency Paris	125884787
261060456525634	DIAKITE	JOSSE	Stéphanie	39 Rue de Lobau Paris	125548762
196041514401521	LAURET		Armin	16 Rue d Amboise Paris	264481274
131021682878445	DESHAYES		Albino	29 Rue de Turenne Paris	264481274
280096672979293	DA CUNHA	MENDY	Houria	5 Rue Scipion Paris	264481274
161110895952876	DROUET	OLLIVIER	Line	4 Rue Rambuteau Paris	125548762
111028862692739	VERON		Otto	37 Rue Barbette Paris	125548762
281033961629584	SALMON		Stuart	7 Rue du Petit Pont Paris	157845587
283119762283310	TERRIER	BRUNEL	Daniela	50 Rue du Caire Paris	125884787
171037193876663	BAUER		Jean-Baptiste	9 Rue Pavee Paris	157845587
291052955637911	GRAND	SISSOKO	Ambroise	27 Rue Papin Paris	125548762
186108833612501	BOURDON		Wilfried	36 Rue du Grand Veneur Paris	157845587
191087419601552	CHAPUIS	GIRAULT	Jean-Frédéric	11 Rue Saint Severin Paris	125884787
208108168434507	BODIN		Kadyja	41 Rue du Cygne Paris	157845587
144032955003677	BARBE	GRANGE	Erick	34 Rue Barbette Paris	125884787
245031024735106	LOISEAU	DUMOULIN	Pierric	11 Rue Vauquelin Paris	125884787
244051103911471	CANO	DOS SANTOS	Habib	37 Rue Montesquieu Paris	264481274
143024158070291	BERNIER		Ludovic	50 Rue de la Parcheminerie Paris	157845587
296078260808814	BLONDEAU		Fabrice	43 Rue de l Equerre d Argent Paris	264481274
129036638333996	PARMENTIER	BOYER	Gervais	11 Rue de la Monnaie Paris	157845587
175084237674269	THOMAS		Gino	48 Rue des Ursulines Paris	264481274
127109489453869	MARTEL	BAUDIN	Alicia	10 Rue des Nonnains d Hyeres Paris	125884787
207121168949178	BODIN	ALEXANDRE	Annabel	31 Rue des Dechargeurs Paris	125884787
162123090223760	LENFANT	THIEBAUT	Franco	46 Rue du Pelican Paris	125884787
196014599832638	COLLET		Claude-Henri	14 Rue Cambon Paris	264481274
249123962387030	JACQUIN	CLAUDE	Nick	42 Rue des Forges Paris	264481274
191098072780944	LEBRETON	JARRY	AlexM	6 Rue Valette Paris	125884787
180030334988128	HAMON	GODIN	Hans	2 Rue de l Hôtel Colbert Paris	125548762
233095184464913	OGER		Josette	31 Rue des Colonnes Paris	157845587
160129415851720	VOISIN	BONNEFOY	Jean-Baptiste	26 Rue des Lombards Paris	125548762
290064596215313	MIGNOT	VIDAL	Éva	12 Rue de Brosse Paris	125884787
162024029695095	AUBERT		Bénédicte	8 Rue de l Abbe de l Epee Paris	125548762
256035745805285	LE BERRE		Thérèse	50 Rue des Bons Enfants Paris	157845587
299095883325694	REGNIER		Armin	23 Rue de Cluny Paris	125884787
255010508757484	BOIS		Lysiane	4 Rue des Rosiers Paris	157845587
284025054958080	SCHMITT	JOLLY	Lilliane	35 Rue Therese Paris	157845587
198115876820091	ROMAIN	BOUCHET	Astrid	41 Rue Scipion Paris	264481274
292127286360670	KEITA		Isidore	26 Rue Saint Louis En l Ile Paris	157845587
238106074150665	VIGNERON		Germaine	50 Rue Boutarel Paris	157845587
124125087042200	PICARD	SOULIER	Karl	23 Rue du Renard Paris	125548762
104107459950188	GICQUEL	BONNEAU	Norman	47 Rue des Lombards Paris	157845587
266021326138534	SCHMITT	DEVAUX	Farid	29 Rue de Ventadour Paris	125884787
177099561621308	DELAGE		Aglaé	37 Rue des Piliers Paris	125548762
220057917231572	CANO	LEPAGE	Chrystel	23 Rue de la Clef Paris	125548762
127109276206342	BONNET	BERGER	Michel	31 Rue Vivienne Paris	157845587
285041428779415	BARRET	DUCROCQ	Jack	47 Rue Charlemagne Paris	264481274
115102762371703	HUSSON	GODET	Alban	39 Rue du Perche Paris	125548762
131109289872634	ARNOULD	LEVY	Abdallah	16 Rue de Navarre Paris	125548762
199069886261876	MAIRE		Armel	31 Rue du 4 Septembre Paris	125884787
233068001860172	GOMEZ	KAYA	Paulo	36 Rue des Bourdonnais Paris	264481274
189083343412684	MARQUES		Peter	43 Rue du Roi Dore Paris	125884787
274017748986076	MAUREL		Marie-Thérèse	25 Rue Française Paris	125548762
203071505075882	NAVARRO		Alice	21 Rue Erasme Paris	264481274
225046338616560	RAMOS	SALAUN	Anne-Cécile	27 Rue d Alexandrie Paris	125548762
282125089606113	MASSE		Jean-Sébastien	19 Rue d Arcole Paris	264481274
268067070083090	CARLIER		Luca	7 Rue Meslay Paris	264481274
219021809637382	GRANDJEAN		Abdelaziz	13 Rue de Turenne Paris	264481274
148128918443996	GIMENEZ	GUY	Jean-Charles	33 Rue Marsollier Paris	125884787
134060133645153	GROS		Marcelle	44 Rue des Lyonnais Paris	125548762
167073716399416	JOSEPH	VIDAL	GianniM	18 Rue Eugene Spuller Paris	157845587
170026816597756	DIAKITE	AUBERT	Célia	43 Rue Lhomond Paris	125548762
239112027995661	BARREAU	NICOLAS	Anne-Catherine	21 Rue Caron Paris	125884787
155041690002972	REY		Line	8 Rue de Turbigo Paris	125884787
248092200396476	SAUNIER		Elvire	4 Rue Linne Paris	264481274
240035852414745	LEPRETRE	GILLES	Sandie	46 Rue Brantome Paris	157845587
146016758089885	TEXIER		Yvon	33 Rue des Fosses Saint Bernard Paris	125548762
161067172287541	HEBERT		Bruce	33 Rue Marsollier Paris	264481274
111039511573819	SALOMON	GUILLET	Yvon	47 Rue Jean du Bellay Paris	125548762
225032278266803	ALI	SOARES	Marie-Laure	10 Rue Notre Dame de Nazareth Paris	264481274
217074086831428	GERVAIS		Ghislaine	13 Rue Menars Paris	125548762
293067026576534	PAGES	BARBIER	Yann	46 Rue des Arquebusiers Paris	264481274
229104969463987	SENECHAL		Jean-Claude	20 Rue d Argout Paris	125884787
211126925899180	GUIGNARD	GICQUEL	Salvator	19 Rue Cherubini Paris	125884787
253097276162617	MILLET	BARRE	Houria	34 Rue Lagarde Paris	125884787
236036316584601	PASQUIER		Salomon	10 Rue d Ormesson Paris	125548762
279104322668824	GUEGAN	PICOT	Grâce	46 Rue Menars Paris	157845587
129054448109734	ANDRE		Edouard	46 Rue Sainte Foy Paris	264481274
209049564105921	MIGNOT		Arielle	5 Rue des Lombards Paris	264481274
271110105237227	DENIS		Yves-Marie	24 Rue du Cinema Paris	125884787
130071148664148	LACROIX	MORICE	Eudes	42 Rue Sainte Foy Paris	125548762
193046098419989	LE BORGNE		Edwige	29 Rue Édouard Quenu Paris	125884787
171113093221638	BLONDEL		Lauretta	50 Rue Tiquetonne Paris	125548762
108059912447754	PELTIER	MACHADO	Louis-Marie	27 Rue de Richelieu Paris	264481274
221084521836196	LAMBERT	MARCHAND	Fabrizio	41 Rue Barbette Paris	157845587
275010892493538	JOLY		Sunny	43 Rue Saint Joseph Paris	125884787
201104145535465	GUILLEMOT	POULET	Ann	46 Rue Jean Calvin Paris	264481274
238037295713009	GALLET	ROUX	Louis	45 Rue de l Epee de Bois Paris	125548762
145028128718210	LACOMBE		Elizabeth	33 Rue du Temple Paris	264481274
294085279933523	CHATELAIN	MAILLET	Jean-François	1 Rue Saint Philippe Paris	264481274
292060159246061	DELANNOY		Charlène	47 Rue des Nonnains d Hyeres Paris	264481274
218012483586376	TRAN		Jacques-Olivier	32 Rue du 4 Septembre Paris	157845587
254082106848079	LEFORT		Jean-Sébastien	37 Rue Therese Paris	125548762
289038194355035	BOUCHER	LE BRIS	Yannick	38 Rue des Halles Paris	264481274
187070799370259	GODEFROY		Riccardo	27 Rue de la Boucle Paris	264481274
108020934941188	PICOT		Sylvestre	13 Rue Domat Paris	125548762
259046387441327	CHARBONNIER		Daphné	24 Rue Édouard Colonne Paris	125548762
233066555514390	PREVOT		Magdeleine	50 Rue du Roi Dore Paris	125884787
137021233550200	MONTEIRO	MAILLARD	Roselyne	13 Rue Clotaire Paris	157845587
167088138223313	LOPES	LECOQ	Samir	45 Rue du Jour Paris	157845587
243080616823446	LECLERE		Ghuilem	28 Rue du Pas de la Mule Paris	125884787
210117948182854	DIOP		Esther	45 Rue Scipion Paris	264481274
107028981594327	FAVIER		Marie-Joëlle	43 Rue de Poitou Paris	125548762
288052477041170	JOLIVET		Sylvette	37 Rue Lacepede Paris	264481274
253032370741967	MAILLARD	BRAULT	Raphaelo	37 Rue Saint Gilles Paris	125884787
149063593850027	TRAN	CLERC	Danielle	27 Rue de Jouy Paris	264481274
218121931897884	MARION	NEVEU	AndreaM	5 Rue François Miron Paris	125548762
115073393844074	SENECHAL	CASTEL	Maya	27 Rue du Figuier Paris	125548762
262102954655333	CARRE		Abdallah	47 Rue de l Oratoire Paris	125548762
299075025982742	MACHADO	FAVIER	Lionel	2 Rue Tiquetonne Paris	157845587
216121985902635	MAURICE		DannyM	9 Rue Henri Robert Paris	157845587
120087250824191	REY	MICHEL	Amina	49 Rue Ortolan Paris	264481274
159117903511347	BAPTISTE		Josephus	22 Rue de la Sourdiere Paris	125548762
151010535199329	THIBAULT		Arnold	45 Rue Reaumur Paris	125884787
202096545459216	RIOU		Thibaut	29 Rue Marsollier Paris	264481274
220036263058474	LERAY	DIAKITE	Noëlle	6 Rue de Bievre Paris	125548762
164072065506044	DIABY	ALLAIN	Gabriella	33 Rue du Prevot Paris	125884787
225122828585441	CORNET	MORIN	Sebastian	17 Rue des Halles Paris	125548762
146027101427837	LE CORRE	CHARTIER	Wolfgang	19 Rue Champollion Paris	264481274
157057144009934	LEONARD	DESCHAMPS	Laurence	15 Rue Molière Paris	264481274
120012655787696	PASQUET		Hans	35 Rue des Forges Paris	264481274
272128938731412	AUBIN		Albéric	19 Rue Colbert Paris	125884787
123103048076517	TORRES	FRANCOIS	Colette	47 Rue de Mirbel Paris	125548762
112067612324530	NUNES		Joëlle	17 Rue Malus Paris	264481274
212021771119539	BAILLEUL		Noël	6 Rue Poquelin Paris	125548762
133043200981964	AMAR	MARTEL	Suzie	13 Rue du Petit Pont Paris	264481274
222062702780531	SCHWARTZ		Carmen	23 Rue de Jarente Paris	157845587
116101580250637	BABIN	KAYA	Tiffany	6 Rue du Puits de l Ermite Paris	125548762
223018989015713	ROGER	PASQUET	Flavio	18 Rue de la Coutellerie Paris	157845587
291012132330873	BROSSARD	FOUQUET	Otto	47 Rue de la Collegiale Paris	125884787
266105404998405	PREVOST	FERRY	Mourad	4 Rue des Patriarches Paris	264481274
243101397269448	AFONSO	WAGNER	Jenny	15 Rue Édouard Colonne Paris	125548762
119079086336263	LE CORRE	BOUTET	Jean-Louis	46 Rue Blainville Paris	125884787
159049935527582	SENECHAL		Ingrid	17 Rue Breve Paris	157845587
290127332358372	GIRARD		Johnny	27 Rue de l École Polytechnique Paris	125884787
233098228061700	LERAY		Katerine	40 Rue du Nil Paris	125884787
105055073221067	THIBAULT		Wolfgang	30 Rue Bailly Paris	264481274
284070773359105	MAUGER	BECK	Daisy	18 Rue des Fontaines du Temple Paris	264481274
128032992380904	PEPIN		Reynald	17 Rue de Bretonvilliers Paris	157845587
107097295816255	COMBES	THIERRY	Laura	7 Rue Vivienne Paris	125548762
151022965079221	GUILLARD		Rosane	31 Rue des Ursins Paris	125884787
112031596898173	BESSE		Darren	19 Rue des 3 Portes Paris	125884787
213081650900924	MARTIN		Jean-Mary	14 Rue Lagrange Paris	125884787
178052502185535	MARTINEAU		Jules	14 Rue des Irlandais Paris	157845587
295070626140542	FAUCHER	JOUBERT	Virginie	22 Rue Lacepede Paris	125548762
226101586300159	LELONG		Silvano	11 Rue Bachaumont Paris	125884787
120058752255719	DAVID	PAUL	Bernard-Eric	13 Rue du Pere Teilhard de Chardin Paris	157845587
228101775407926	JACQUIN	ETIENNE	Albertine	16 Rue des Petits Peres Paris	157845587
251118467966521	CHEVALLIER		Edouard	16 Rue Beaubourg Paris	264481274
285115820360026	LESAGE	LEFRANCOIS	Josette	36 Rue du Marche des Patriarches Paris	125884787
283081998370622	PREVOT		Klaus	23 Rue des Capucines Paris	125548762
142051862949049	VERON		Léon	46 Rue des Fosses Saint Bernard Paris	157845587
243014454534087	VILLARD	LEBAS	Anne-Lyse	15 Rue des Forges Paris	125548762
181023381093240	LEFRANCOIS		David	10 Rue Jean du Bellay Paris	125884787
151099301859840	GODET	JEAN	Cyril	21 Rue de l Amiral Coligny Paris	157845587
126054747918290	GOMES	SALAUN	Odette	49 Rue des Coutures Saint Gervais Paris	157845587
119011754998157	GIRAUD	WOLFF	Pierre-Henri	14 Rue Portefoin Paris	157845587
253087209887583	JUNG	BOIVIN	Marie-Madeleine	22 Rue du Fouarre Paris	157845587
294083240333014	DELANNOY	BOUCHET	Léone	33 Rue de Franche Comte Paris	125548762
139051080064928	DRAME		Franck	18 Rue du Roule Paris	157845587
102118325920402	CISSE		StefanM	30 Rue des 2 Boules Paris	264481274
162128476044686	DUFOUR		Marie-Lou	2 Rue Léon Cladel Paris	125884787
237041083780905	GRANGE	FAUCHER	Steve	16 Rue de Normandie Paris	264481274
180097454476416	MARTIN		Simon	23 Rue Ferdinand Berthoud Paris	125884787
198019789185927	MEUNIER	LECLERCQ	Karl	30 Rue Vivienne Paris	157845587
289075326321716	CHAUVEAU	RENAULT	Frederica	13 Rue du Tresor Paris	264481274
238044454322507	MAIRE	HUMBERT	Ludivine	40 Rue des Pretres Saint G l Auxerrois Paris	264481274
204095944799952	BAUDET		Wilfrid	46 Rue des Capucines Paris	264481274
160037973030119	NGUYEN		Marie-Angèle	31 Rue de l Abbe Migne Paris	125548762
228052967338855	POLLET	COMBES	Malcolm	10 Rue de Damiette Paris	264481274
204028909048229	HARDY	ARNAUD	CameronM	9 Rue Mornay Paris	264481274
279014234476269	FOFANA	THUILLIER	Christian	47 Rue du 4 Septembre Paris	125884787
105025228548532	BESSON		Lydia	26 Rue Pastourelle Paris	264481274
236070319011481	TERRIER		Laurence	46 Rue Frédéric Sauton Paris	125884787
174048263332316	LE ROUX	DUPRE	Kristel	28 Rue du Cygne Paris	157845587
199105176991230	SOULIER	SAIDI	Joseph	22 Rue Barbette Paris	264481274
161056533943893	FELIX		Cécile	10 Rue des Colonnes Paris	264481274
286062791711375	MAIRE		Diana	20 Rue de la Tacherie Paris	157845587
272111238460186	CAMARA	TEIXEIRA	Sandra	27 Rue Jean Calvin Paris	125884787
152111965056410	BRUNEL		Jean-Manuel	39 Rue Caffarelli Paris	157845587
165027813307360	CARDON		Gérald	23 Rue des Pretres Saint Severin Paris	125884787
104059069162387	PASQUET		Odile	39 Rue des Piliers Paris	125548762
121056692918082	CREPIN		Georgio	36 Rue de la Collegiale Paris	125548762
188025191934459	FELIX		Anne-Cécile	32 Rue de l Hôtel Colbert Paris	125884787
102044945975322	DIOP	DELANNOY	Daniel-Henri	17 Rue Cochin Paris	125548762
292030305080256	LEGENDRE		Arlette	40 Rue de l Hôtel de Ville Paris	125548762
232023864409457	GAUDIN		Lucette	10 Rue Danielle Casanova Paris	264481274
117071617626555	LE FLOCH		Sabine	48 Rue de Sevigne Paris	125884787
196036458217210	MORICE	LEONARD	Diane	18 Rue de Lobau Paris	125884787
139096044741391	PAUL		Eugénie	14 Rue Bailleul Paris	125548762
284086505133848	NICOLAS		Lilliane	21 Rue Pierre Lescot Paris	125884787
161106377733801	LEROUX	ZIMMERMANN	Oscar	20 Rue de la Parcheminerie Paris	125548762
266031774123621	RENAUD		Jacobus	24 Rue des Barres Paris	157845587
176083360458256	BENARD		Maéva	46 Rue Beranger Paris	125884787
238082768160123	DOS SANTOS	LAMBERT	Raoul	32 Rue Larrey Paris	125548762
116089104911289	HERVE		Jean-Christophe	45 Rue Vieille du Temple Paris	125548762
184013026653488	MONTAGNE		Lucia	8 Rue Brisemiche Paris	125884787
190062769594923	PRUVOST		Lylia	38 Rue du Petit Musc Paris	264481274
129051166985007	MARTY		Markus	48 Rue de Montmorency Paris	125548762
171110869020530	VALETTE	MARIE	Bastien	4 Rue Bachaumont Paris	264481274
170085720360240	LAFON	ROY	Jean	1 Rue de la Cite Paris	125548762
128119566368842	PICHON	VILLARD	Marie-Madeleine	32 Rue de l Estrapade Paris	125884787
250072870574866	MICHON		Bianca	33 Rue Roger Verlomme Paris	264481274
275034106311549	GILLET		Theodor	19 Rue de Fourcy Paris	157845587
293072659007230	RENARD		Valérie	3 Rue des Petits Peres Paris	264481274
265047126015494	LASSERRE		André-Louis	20 Rue de Normandie Paris	125548762
202010382752991	JIMENEZ		Jeannette	38 Rue Paul Lelong Paris	264481274
119072545360121	DIAZ	KEITA	Henri	25 Rue Saint Sauveur Paris	264481274
213077721801746	JOSSE	MOREIRA	Jean-Charles	34 Rue des Bourdonnais Paris	125884787
128087936474254	BERGER	SAMSON	Yann	41 Rue Danielle Casanova Paris	157845587
294089748643596	SARRAZIN		Pedro	27 Rue de l Hôtel Saint Paul Paris	157845587
148013229831993	JIMENEZ	THIBAULT	Aude	44 Rue des Arquebusiers Paris	264481274
223120960061912	LEDUC	IMBERT	Solène	31 Rue Au Maire Paris	264481274
186033137213249	RENOU		Madiha	48 Rue Debelleyme Paris	264481274
256115115514311	PIRES	DUCROCQ	Jean-Pierre	1 Rue du Temple Paris	125884787
244013618672814	SIMON		Pascaline	35 Rue des Halles Paris	157845587
196061733484675	GARREAU	LAMBERT	Jean-Philippe	28 Rue Bailly Paris	125548762
106089885680755	PARMENTIER		Gwenaëlle	45 Rue du Parc Royal Paris	125884787
208101367016896	PARENT		Saïd	48 Rue de Thorigny Paris	264481274
139105087154042	GUITTON		GabyM	47 Rue Barbette Paris	157845587
158030363231988	SAUVAGE	SALMON	Nelly	11 Rue des Carmes Paris	157845587
297076719709643	KAYA	OGER	Carlo	29 Rue de la Ferronnerie Paris	157845587
222046381429882	PERRET		Jean-Patrice	24 Rue du Haut Pave Paris	125548762
265031930410776	SCHNEIDER		Gerardo	1 Rue des Haudriettes Paris	125884787
134049072360994	BLONDEL		Vivian	7 Rue Sainte Apolline Paris	125884787
211086595791575	POULET		Pierre-Louis	22 Rue Saint Merri Paris	157845587
239043603031156	PAYET		Stefanie	8 Rue Jean de Beauvais Paris	125548762
150017226774891	MORENO	LEBLANC	Oscar	32 Rue de l Hôtel Saint Paul Paris	125548762
290060531145979	MIGNOT	CHARBONNIER	Jean-Thomas	1 Rue Poissonniere Paris	125884787
125043167496449	CARRE	LEDOUX	Rolande	21 Rue Rataud Paris	157845587
259029921552493	ROSSI		Lorianne	47 Rue Mehul Paris	125884787
165089604254636	PEPIN		Rosanna	4 Rue des Francs Bourgeois Paris	125884787
272036042538195	BLOT		Andrée	37 Rue du Roi de Sicile Paris	125548762
169045466583502	MAILLOT		Jean-Antoine	30 Rue de Jouy Paris	125548762
155078862032976	DEVAUX		Marie-Paule	16 Rue Pierre Brossolette Paris	157845587
236050817608085	VOISIN		Angie	19 Rue Marsollier Paris	157845587
228068017689713	TISSIER	BRUNEL	Gilbert	6 Rue du Pere Teilhard de Chardin Paris	264481274
139092699004560	SENECHAL		Dorothy	3 Rue de l Epee de Bois Paris	157845587
184080527855873	BAPTISTE	FERNANDES	Mary	24 Rue Caffarelli Paris	264481274
159097071302004	CHEVALLIER	MANGIN	Camille-Pierre	15 Rue Gay Lussac Paris	157845587
107046092147076	MAILLOT		Martin	17 Rue Debelleyme Paris	125548762
256037369716944	AUBRY	GUILLARD	Gianfranco	32 Rue du Pont Louis Philippe Paris	125548762
141030952640812	VAILLANT	GROSJEAN	Pierre-Marie	20 Rue Eginhard Paris	125548762
281115596346204	DELATTRE		Morgan	8 Rue Cuvier Paris	264481274
264019381752416	MILLET	BOULANGER	Sandra	48 Rue Maitre Albert Paris	157845587
206051413439664	PEPIN		Noël	35 Rue Poliveau Paris	125548762
117043894183463	MARIE		Pierre-Fabre	40 Rue des Degres Paris	157845587
282106583597519	GUITTON		Yolande	34 Rue Michel le Comte Paris	157845587
221079212138547	GALLAND		OlaM	17 Rue de Clery Paris	125548762
126127518943951	POIRIER		Carl	11 Rue du Pere Teilhard de Chardin Paris	264481274
129088384201146	CAMUS	MANGIN	Karen	25 Rue Reaumur Paris	125884787
156127291989632	PONS		Jean-Joël	20 Rue Catinat Paris	264481274
117064052014050	BERTRAND	HUET	Cécile	17 Rue Sainte Anne Paris	264481274
266032587199748	POIRIER		Jean-Dominique	5 Rue du Renard Paris	264481274
201068456551393	MEUNIER		Dieudonné	29 Rue Chanoinesse Paris	125548762
280013103555645	LUCAS		France	19 Rue de la Cerisaie Paris	157845587
288106819148682	LECONTE		Zoubida	29 Rue du Forez Paris	125884787
220068901669705	BLANCHET	DE OLIVEIRA	Pauline	22 Rue Etienne Marcel Paris	264481274
218120824070079	BERTRAND	GUILLOT	Roseline	36 Rue de l Abbe de l Epee Paris	125548762
153029896446820	GROS	SEGUIN	Philip	16 Rue de Brissac Paris	125884787
194075342972573	LE MEUR		Jan	18 Rue Courtalon Paris	125884787
296099765223309	MAILLET		Marc	44 Rue Froissart Paris	157845587
185021399708089	GARCIA		Petrus	19 Rue des Jardins Saint Paul Paris	264481274
278094704116338	ROUX	DUMONT	Shirley	10 Rue Etienne Marcel Paris	264481274
139105281222043	DELATTRE		Karima	41 Rue Montorgueil Paris	264481274
227083579705919	BAUDOUIN	LEGER	Marie-Christine	38 Rue de Mirbel Paris	125884787
284090884921702	HOAREAU	POMMIER	Adolf	20 Rue de Mirbel Paris	125884787
103075757697692	PREVOST	VIGNERON	Marylène	31 Rue Beaubourg Paris	264481274
195087761492606	RENARD	PINEAU	Cécile	11 Rue des Lions Saint Paul Paris	157845587
127100875228221	BRETON		StefanM	24 Rue Feydeau Paris	125548762
215072902540441	JULIEN		Friedrich	36 Rue Gay Lussac Paris	125548762
169122788622827	ROUXEL		Victoire	17 Rue des Panoramas Paris	264481274
118111411157996	SAID		GilM	35 Rue Saint Honore Paris	125884787
254102671108666	SERRANO		Nadia	38 Rue des Minimes Paris	264481274
113065641678643	REYNAUD	BERNIER	Arnold	21 Rue des Prouvaires Paris	125884787
221021115240958	DUCLOS	HERNANDEZ	Djamel	9 Rue Jules Cousin Paris	125548762
287051297819393	BRUNEL		Farid	38 Rue de la Banque Paris	125548762
236071547970159	BAPTISTE		Grâce	2 Rue Radziwill Paris	264481274
152074748442071	LECONTE		Sophia	21 Rue des Nonnains d Hyeres Paris	125884787
131084757421667	MASSON	DELORME	Paolo	45 Rue de l Equerre d Argent Paris	157845587
260022594363516	LEDUC		Vincente	8 Rue Poissonniere Paris	125884787
108077100841690	MACHADO	SENECHAL	Myriam	19 Rue Mauconseil Paris	157845587
181017147729962	MARTINEZ		Josiane	50 Rue Lacepede Paris	125548762
121071265687319	EVRARD		Gérald	47 Rue Gretry Paris	125884787
156085302883246	BEAUFILS		Norman	2 Rue Lacepede Paris	125884787
115030403153781	HERVE	ANTUNES	Miguel	49 Rue du Fauconnier Paris	157845587
175073159041662	LEFEUVRE	BATAILLE	Marie-José	21 Rue Clotaire Paris	157845587
110042098683095	LE GUEN		Gislain	4 Rue Jussieu Paris	125884787
109030537258504	FOFANA	DUCROCQ	Vivian	41 Rue du Platre Paris	125884787
223066675112456	JANVIER	SYLLA	Marie-Angèle	27 Rue d Amboise Paris	157845587
282112984855467	LEFRANC		Manon	43 Rue de la Collegiale Paris	125548762
206015685037422	LEROY	MANGIN	Claudette	10 Rue Caffarelli Paris	125884787
186069087679009	LEGROS		Sylvestre	22 Rue Montorgueil Paris	125548762
216040451818667	BARRE		Soria	25 Rue de la Vrilliere Paris	125884787
123107251805832	SENECHAL		Sebastian	14 Rue de l Abbe Migne Paris	157845587
252047407262592	CHRISTOPHE		Fatiha	9 Rue du Petit Moine Paris	125884787
273083395115649	BENARD	JOURDAN	Sylvie	46 Rue Villehardouin Paris	125548762
113061066882595	HERNANDEZ		Erwin	37 Rue des Guillemites Paris	125548762
112032779042732	CLERC		Ulrike	22 Rue des Pretres Saint Severin Paris	157845587
256051093900976	SELLIER		Grégoire	14 Rue de la Perle Paris	157845587
183112049563783	TRAN	STEPHAN	Thierry	14 Rue de Brissac Paris	125884787
162022779725514	PARENT		Macha	46 Rue des Lombards Paris	125884787
235124605200969	MONTEIRO	RIGAUD	Audrey	7 Rue de Turenne Paris	264481274
187121135696356	GRONDIN		Rodolphe	49 Rue Montmartre Paris	125884787
142101413261413	GRANGER	GODEFROY	Rachid	28 Rue de Rivoli Paris	157845587
136097591466460	AUGER		Mounir	46 Rue des Carmes Paris	157845587
145039104108865	LECONTE		Diogo	40 Rue Daubenton Paris	125884787
223115310429678	BOUSQUET	MARIN	Sandrine	13 Rue de la Harpe Paris	125884787
281038699937926	PONS		Fabienne	48 Rue Favart Paris	157845587
285039913209682	RAGOT	MONNIER	Élodie	29 Rue de Palestro Paris	157845587
200052554875542	MOUNIER	LUCAS	Nathalie	31 Rue des Forges Paris	157845587
247037596488238	GAUDIN		Mathias	28 Rue du Marche Saint Honore Paris	157845587
160103642429132	LASSALLE	GIMENEZ	Marguerite	3 Rue Tournefort Paris	157845587
107087240250732	MESSAOUDI	CORRE	Marylène	14 Rue d Arras Paris	264481274
202123105157942	CORTES	LE GALL	Magaly	48 Rue Gretry Paris	125548762
204011935620841	DIALLO	LEJEUNE	Yannick	25 Rue Nicolas Flamel Paris	264481274
297096978369003	HUE	FERNANDEZ	Christian	11 Rue d Uzes Paris	125548762
186021649778788	DELORME	CHAMPION	Éva	10 Rue Charlot Paris	157845587
103095695159235	BASTIEN		Emmanuelle	22 Rue du 4 Septembre Paris	125884787
286087656423415	JOSSE		GianniM	44 Rue de Sevigne Paris	125548762
175066592387802	CHATELAIN		Noël	21 Rue de la Lingerie Paris	125548762
113115246343642	PROVOST	PARISOT	Dounia	14 Rue du Roi Dore Paris	157845587
142038048913513	SCHWARTZ	LAVIGNE	Benoît-David	42 Rue du Roi de Sicile Paris	264481274
176078894344648	COHEN		Emanuel	7 Rue de l Orient Express Paris	157845587
255101453587957	HUET		Jean-Raphaël	35 Rue Tiquetonne Paris	157845587
236060592944147	BABIN	CHEVALIER	Bénédicte	20 Rue du Cloitre Saint Merri Paris	264481274
286032428338414	DIDIER		Mylène	46 Rue Marsollier Paris	264481274
213092819479712	SAMSON		Tanguy	26 Rue des Panoramas Paris	125884787
167089520011854	THERY	BOYER	Macha	16 Rue du Fouarre Paris	125884787
287018725817056	ROYER		Marie-Anne	44 Rue de Choiseul Paris	264481274
205062269993651	SANCHEZ	DA SILVA	Olympia	1 Rue de l Hôtel de Ville Paris	125884787
138060554444491	GABRIEL	MENARD	Rocco	36 Rue Domat Paris	125548762
158069665674107	LELONG	THIERRY	Djamila	4 Rue des Ecouffes Paris	264481274
106011050819427	LANDAIS	PICHON	Slimane	33 Rue de Clery Paris	125548762
157073274149735	DUCHEMIN		Corinne	42 Rue du Puits de l Ermite Paris	125548762
212100642731642	CHARLET		Joanna	14 Rue de la Parcheminerie Paris	264481274
241049099179176	BESSE		Frederick	3 Rue Au Maire Paris	125884787
226122696935272	BLONDEL	BLANCHARD	Tony	33 Rue Thouin Paris	264481274
133119158204920	DRAME		Lucio	21 Rue d Alger Paris	125548762
140018008302573	CORTES		Virginie	27 Rue Pecquay Paris	264481274
179024378361353	PREVOT		Lilian	4 Rue Notre Dame de Nazareth Paris	157845587
223113006500836	GUILBAUD		Cédric	42 Rue des Dechargeurs Paris	125884787
100109271865326	SABATIER	LAUNAY	Pierrick	50 Rue de Rivoli Paris	125548762
150056887375968	GUILBERT		Bianca	50 Rue Boucher Paris	125884787
233039425007949	MICHEL	BOUCHE	Jeannette	12 Rue des Bons Enfants Paris	264481274
264107842330942	GAUTIER		Jacky	25 Rue de Louvois Paris	125884787
134020487954794	MICHELET	CORDIER	Louise	16 Rue de l Arbre Sec Paris	125548762
150038037909168	DELATTRE		Malcolm	24 Rue Blondel Paris	264481274
114040705604665	GAUTIER		Vittorio	9 Rue Greneta Paris	125884787
281011552942390	LELEU		Amel	39 Rue Henri Barbusse Paris	157845587
208073703603064	MILLET		Jérôme	7 Rue d Ormesson Paris	125548762
195124129077459	HOAREAU		CamilleM	1 Rue Sauval Paris	125548762
203042945551495	LEMOINE	FABRE	Amina	10 Rue Maitre Albert Paris	125548762
283058967147128	LEDOUX		Nelly	22 Rue Saint Denis Paris	157845587
118058843585359	BENOIST	LEBLANC	Jimmy	29 Rue Marie Stuart Paris	264481274
245083736982839	COCHET		Willem	15 Rue de la Sorbonne Paris	157845587
113076417665792	ROUSSET		Denyse	41 Rue Quincampoix Paris	125884787
116019000258412	RAGOT	TRAORE	Marie-Florence	12 Rue du Petit Pont Paris	157845587
131120964176884	RODRIGUES		Henriette	24 Rue de la Huchette Paris	125548762
149111387041541	BATAILLE	BOULAY	Charline	44 Rue Lulli Paris	157845587
153128900719727	BOUVIER	SABATIER	Nick	39 Rue Notre Dame de Bonne Nouvelle Paris	157845587
150034197947334	BATAILLE	DA SILVA	Raimondo	43 Rue du Petit Moine Paris	125548762
245028537507582	LEPRETRE	GIRAUD	Fatima	24 Rue du Temple Paris	125884787
252106588392132	LEONARD		Gildas	41 Rue Sainte Apolline Paris	157845587
159013980820603	MOUNIER		Andreas	22 Rue Sainte Apolline Paris	264481274
163054889165115	NIAKATE		Anne-Lyse	45 Rue Tournefort Paris	125884787
114092770726295	LECLERC		Alain	9 Rue Dalayrac Paris	264481274
251123729430821	JOURDAN	MEUNIER	Esther	12 Rue Greneta Paris	157845587
193071493716975	REYNAUD	VIEIRA	Constant	6 Rue des 4 Fils Paris	125548762
106099937166117	LABORDE		Marie-Gabrielle	35 Rue Courtalon Paris	125884787
123032531483026	ROMAIN		Augustin	41 Rue Marsollier Paris	264481274
131084231150591	SANTIAGO	REMY	Yohann	7 Rue Blainville Paris	125548762
209027164298065	LANG		Émeline	35 Rue Borda Paris	157845587
199078543975254	HAMON		Bérangère	45 Rue de la Bastille Paris	125884787
100049631898104	KELLER	OLIVIER	Frederico	7 Rue Saint Spire Paris	125548762
234053975548370	BARBIER	AFONSO	Cerise	23 Rue Papin Paris	157845587
184025786706731	LEBEAU	IMBERT	César	48 Rue de la Lingerie Paris	125884787
274022481152500	NICOLAS		Coralie	6 Rue Conte Paris	264481274
240026048838751	FISCHER	LEBAS	Florent	17 Rue Lagrange Paris	157845587
178054655023440	MASSON	LEON	Josette	21 Rue du Marche des Patriarches Paris	264481274
174030300877871	HERNANDEZ	CHARBONNIER	Marjorie	34 Rue des Prouvaires Paris	125884787
110080140197255	JACQUET	AMAR	José-Maria	5 Rue de Sevigne Paris	157845587
161034008075245	CASTEL	ALLAIN	Régine	39 Rue Etienne Marcel Paris	125884787
188118883989333	CLERC	SARRAZIN	Émile	7 Rue des Tournelles Paris	157845587
107032841366591	JOLLY		Lucie	16 Rue du Croissant Paris	125548762
258012906416470	GAUTHIER	TECHER	Laure	45 Rue des Petits Peres Paris	157845587
230118436329405	POULET	MICHON	Marthe	11 Rue Jacques Coeur Paris	264481274
181044191868718	LEMONNIER	VILLAIN	Lamia	21 Rue Broca Paris	264481274
146084909826612	VIGNERON	BARBE	Claudia	10 Rue Saint Victor Paris	157845587
192016782931511	BLONDEAU		Leslie	25 Rue de Ventadour Paris	125884787
259074697674603	DIJOUX		Youssef	37 Rue de Beauce Paris	125548762
127019244540438	LAURET		Théophile	20 Rue de la Montagne Sainte Genevieve Paris	125548762
148121190383571	ROBIN		Fatma	16 Rue Cujas Paris	157845587
264107910075035	DAMOUR		Audebert	25 Rue des Chantres Paris	264481274
210030438953147	ROBIN	BOUTIN	Jean-Louis	8 Rue Saint Roch Paris	157845587
210042436071478	DUHAMEL		Olivia	3 Rue du Sommerard Paris	125548762
134051402379911	BONNEFOY		Kurt	44 Rue des Lions Saint Paul Paris	125548762
196018757049140	THIERRY		Khaled	47 Rue Danielle Casanova Paris	125548762
170115855210295	LEMONNIER	GICQUEL	Oscar	1 Rue Saint Honore Paris	264481274
176108949873359	SANCHEZ		Marjolaine	23 Rue de Jarente Paris	125548762
292032690622575	BELIN	BEAUMONT	Norman	27 Rue d Arcole Paris	125548762
297025448866853	BESSON	LE ROUX	Slimane	6 Rue de Turbigo Paris	157845587
239057582114519	PAPIN		Edoardo	33 Rue Montmartre Paris	157845587
189061293903962	RICHARD		Vivian	19 Rue Saint Merri Paris	157845587
107021159794718	CASTEL	LANG	Laetitia	30 Rue Rambuteau Paris	125884787
235050703254130	DELAPORTE		StéphaneM	14 Rue Coq Heron Paris	157845587
225058455250413	CAMARA	SANTIAGO	François	41 Rue du Petit Musc Paris	157845587
150086595242939	AUGER	DIAZ	Aglaé	22 Rue de la Lune Paris	125548762
103076152831337	ROYER		Karl	34 Rue de Thorigny Paris	125548762
198080243696000	DELORME		Ali	22 Rue Lhomond Paris	125548762
185082755251667	ALI		Henri-Pierre	2 Rue du Pont Neuf Paris	125884787
152011275394961	LENFANT	BAILLY	Eddie	38 Rue Montgolfier Paris	157845587
240121987869929	GONTHIER	COLIN	Mary	36 Rue Sainte Foy Paris	264481274
121107075333327	TEIXEIRA		SamM	39 Rue de Clery Paris	125548762
290043665477208	VIEIRA		Ferdinand	16 Rue Daunou Paris	125884787
224039225017336	MARTINS	LEFEUVRE	Rolande	4 Rue d Ecosse Paris	125884787
255093111334747	RICARD	MESSAOUDI	Anne-France	23 Rue Caron Paris	157845587
154070228992208	COHEN	JANVIER	Alban	12 Rue Geoffroy Saint Hilaire Paris	264481274
279121641670735	FAVIER	LOUIS	Léa	25 Rue de Bievre Paris	125884787
266092921839948	GILLES	GEORGE	Klaus	7 Rue d Arcole Paris	264481274
283124185961943	DUCHESNE	GUY	Ulla	32 Rue du Fauconnier Paris	264481274
111013917857673	RICHARD		Félix	30 Rue de la Petite Truanderie Paris	157845587
221111999395911	CARDOSO	MARION	Raymond	22 Rue Duphot Paris	157845587
131109142556613	FAIVRE		Marie-Andrée	38 Rue Lacepede Paris	125884787
127020452119710	LAURENT		Charlène	32 Rue de la Collegiale Paris	125884787
187014852065018	BAUDRY		Aimée	29 Rue de la Cite Paris	157845587
169025278120012	VIEIRA		Angèle	31 Rue Payenne Paris	125884787
143033632736665	SARRAZIN	PRAT	Gwendoline	1 Rue du Pere Teilhard de Chardin Paris	125884787
113072827979823	LELIEVRE		Francis	43 Rue Gabriel Vicaire Paris	157845587
174083131677691	FERRER	BAUER	Reine	25 Rue du Grand Veneur Paris	125884787
240030208771657	LAPORTE		Antoinette	14 Rue Neuve Saint Pierre Paris	157845587
147030287258403	BLANDIN	ESNAULT	CesareM	35 Rue Guerin Boisseau Paris	125884787
108114213276615	BARBE		Claudio	29 Rue d Alexandrie Paris	157845587
231072312146616	GIMENEZ		Marylaine	17 Rue des Moulins Paris	264481274
135030745344836	COURTOIS		Anissa	11 Rue Flatters Paris	125884787
260059790196310	SCHNEIDER		Gottfried	17 Rue Larrey Paris	125884787
145041267838254	MORAND		Joëlle	24 Rue Aubry le Boucher Paris	125548762
114014067183365	MARTINEAU	CISSE	Augustin	26 Rue Jean Lantier Paris	157845587
178067934684562	LEFEBVRE		John	11 Rue des Archives Paris	157845587
174053709791679	OLIVEIRA	BRUN	Guylaine	5 Rue du Fauconnier Paris	125548762
141125258291919	GOUJON	ALEXANDRE	Olympia	4 Rue Léon Cladel Paris	264481274
142086019899660	PHILIPPE		Marie-Émilie	29 Rue Baltard Paris	125884787
180084675181912	KELLER		Juliana	8 Rue Victor Cousi Paris	125548762
131125067536259	HUMBERT		Albéric	29 Rue Jean Calvin Paris	125548762
149077433486489	BLANC		Charle	29 Rue Tournefort Paris	264481274
292042271914783	FONTAINE	EVRARD	Anne-Laure	7 Rue des Francs Bourgeois Paris	157845587
116032805072076	LELONG	BUISSON	Michel-Ange	4 Rue Coquilliere Paris	125884787
224019865233132	FERRARI		Francesca	18 Rue de la Michodiere Paris	157845587
283097419522568	BOULAY		Mélanie	28 Rue de Turenne Paris	125884787
230116145833140	BOURDON	BERNARD	Charlène	38 Rue de la Lingerie Paris	125884787
279055788448335	SIDIBE		Aglaé	24 Rue des Barres Paris	264481274
139058121016456	MARIN		Jean-Antoine	25 Rue Sainte Opportune Paris	157845587
194094891582637	PIERRE	MAILLOT	Gwenaëlle	1 Rue Berthollet Paris	264481274
139011591930760	HERAULT	COMTE	Claire	22 Rue de l Estrapade Paris	157845587
144116934442689	GEOFFROY		Yvonne	42 Rue de Bretonvilliers Paris	264481274
252030424521689	LAMBERT		Margaux	39 Rue des Guillemites Paris	157845587
280076300617446	GARCIA		Gary	44 Rue de Franche Comte Paris	125548762
221067612519950	LAGRANGE		Zoubida	43 Rue de Louvois Paris	157845587
244027770559855	RODRIGUES		Pierre	26 Rue Malher Paris	125884787
134044002643870	MAIRE		Oriane	17 Rue Buffon Paris	264481274
170084270924505	GARNIER	GEOFFROY	Anne-Gaëlle	20 Rue des Boulangers Paris	157845587
147037410601226	POULET	GICQUEL	Pauline	33 Rue de Rohan Paris	157845587
262128322011669	GUILLAUME	HAMON	Anna	6 Rue Saint Antoine Paris	157845587
187102210975946	DERRIEN	RAGOT	Axelle	5 Rue du Marc des Blancs Manteaux Paris	264481274
104045195800843	PASQUIER	TURPIN	Raoul	50 Rue Caron Paris	264481274
230039788083545	PROVOST		Mary	47 Rue de Viarmes Paris	264481274
140035393058158	PARIS		Xavier	27 Rue des Forges Paris	264481274
158041701121347	CORREIA		Adeline	26 Rue Boucher Paris	125884787
270061672667130	TRAORE	GRAS	Marina	27 Rue de Sevigne Paris	157845587
252034453461856	PETITJEAN		Marie-Dominique	11 Rue des Pretres Saint Severin Paris	157845587
278016346820968	HUET		Yolande	9 Rue Montmartre Paris	264481274
133060383952590	GUILLAUME	SCHMITT	Lorenzo	10 Rue Valette Paris	125884787
193068126328431	GAILLARD	GROS	Clotilde	33 Rue Fustel de Coulanges Paris	125548762
228068852384413	BECK	NGUYEN	Elisabeth	7 Rue Montesquieu Paris	125548762
148112887355343	GUILLEMOT	MAILLOT	Sarah	37 Rue Clotilde Paris	157845587
175013717803592	JANVIER	BINET	Nicholas	34 Rue de la Huchette Paris	157845587
202017836106992	ALONSO		Sunny	34 Rue Saint Fiacre Paris	125884787
245102229936748	CHARLES		Pierrette	21 Rue de l Arc En Ciel Paris	125884787
131085813863926	BOUVET		Caroline	12 Rue du Cygne Paris	264481274
281017548940709	FRANCOIS		Anne-Françoise	33 Rue du Bourg Tibourg Paris	125884787
131054917320660	MORIN	BOIVIN	Frédéric	27 Rue Etienne Marcel Paris	125884787
165118676503239	CHAUVET		Ulysse	49 Rue Blainville Paris	157845587
117084718549821	VERON	BRUN	Jimmy	48 Rue Baltard Paris	264481274
124041724420932	ROMERO	MICHELET	Blandine	21 Rue Saint Martin Paris	157845587
210070413119454	SAID		Philip	19 Rue Vide Gousset Paris	125548762
142078663953463	BEAUMONT	DESCHAMPS	Henri-Charles	25 Rue Georges Desplas Paris	264481274
220033098580085	DA COSTA	GUILLEMIN	Paulo	30 Rue Flatters Paris	125884787
288072025161887	GUEGUEN		Jacky	21 Rue Ortolan Paris	157845587
285115989191758	COSTA	REY	Pierre-Henri	49 Rue Saint Antoine Paris	125548762
193020420013248	SAID	PHILIPPE	Chloé	7 Rue Charlot Paris	157845587
251083723773260	BOUCHARD	MARECHAL	Jeanne	18 Rue de la Sourdiere Paris	264481274
117018876276701	TEXIER	CORDIER	Shirley	40 Rue Galande Paris	264481274
211055538833854	SCHNEIDER		Blaise	33 Rue Sainte Anne Paris	125548762
266011804752213	LECOCQ	ARNAUD	Dominoco	31 Rue Coq Heron Paris	125548762
228105308454888	OGER	AUBIN	Ian	46 Rue Charles V Paris	264481274
281086421940130	JACOB		Germain	21 Rue de Rivoli Paris	125884787
173041596006042	BAUDRY	MORVAN	Louisette	50 Rue des Degres Paris	125548762
235103315320667	GIBERT		Sigrid	25 Rue Saint Honore Paris	264481274
196066953664866	MACHADO	POTIER	Barbara	35 Rue Brisemiche Paris	264481274
100097374384987	SAUNIER	NICOLAS	Lauriane	24 Rue des Irlandais Paris	125884787
281027685467381	LESUEUR	MATHIEU	Hans	46 Rue Perree Paris	264481274
288063479168564	BARON		Justine	5 Rue Crillon Paris	125884787
244054666231017	LABORDE		ClaudeM	4 Rue du Pont Aux Choux Paris	264481274
145018037213375	LEBON		Béatrice	29 Rue Greneta Paris	125548762
222071821111846	MAHIEU		Donald	18 Rue de Lanneau Paris	125548762
137014618658034	RAYNAUD	LAUNAY	Delphine	22 Rue de la Banque Paris	125884787
117035495904467	LEDUC	SELLIER	Laurent	8 Rue des Patriarches Paris	125884787
120085453420861	FAVRE	GUILLOU	Georges-Henri	17 Rue des Haudriettes Paris	157845587
107062454569949	DUHAMEL		Rose-Marie	24 Rue Simon le Franc Paris	157845587
174052321465035	HUGUET	SARRAZIN	Éloïse	48 Rue Sainte Anastase Paris	125884787
203082364962173	PAUL	MERLE	Jean-Luc	48 Rue de la Sourdiere Paris	125884787
251041230601930	BRAULT	TEXIER	Matthieu	38 Rue des Juges Consuls Paris	125548762
155032782058795	GRAS	MARQUET	Augusta	20 Rue Berthollet Paris	125884787
235018357073752	LEMONNIER	PROST	Serge	19 Rue Saint Merri Paris	125884787
219103662330782	LERAY	STEPHAN	Elizabeth	3 Rue de Bievre Paris	125548762
242023117314654	LAFLEUR		Loriane	6 Rue de Mondovi Paris	125548762
278024853925779	HAMON	SILVA	Micheline	2 Rue Pirouette Paris	264481274
166061059911408	TRAN		Edgar	12 Rue de l Arc En Ciel Paris	125884787
143056272653974	DROUET		Eve	40 Rue de Damiette Paris	264481274
111084417670770	ALEXANDRE		Patrice	27 Rue de Hesse Paris	264481274
202082616139782	ROSSI	JACQUET	Pamela	37 Rue Aubry le Boucher Paris	264481274
121119302153015	JOLLY		Mohammad	33 Rue des Guillemites Paris	125884787
254032393904711	BOUCHER	GUERIN	Marie-Émilie	25 Rue du Marche des Patriarches Paris	125548762
259073450270161	DELATTRE	PAGES	Silvano	47 Rue de la Cerisaie Paris	125548762
237063613562087	LAGRANGE	GILLET	Damien	43 Rue de Louvois Paris	157845587
210069408347984	DESCAMPS		Fabrice	22 Rue d Ormesson Paris	157845587
150050950892813	LABBE		Viviane	46 Rue des Mauvais Garcons Paris	125884787
264043641280038	BARON	SIMON	Georges	26 Rue des Tournelles Paris	157845587
137017091980101	BOUSQUET		Charly	9 Rue Roger Verlomme Paris	125884787
136020837557549	PINEAU		Raphaëlle	16 Rue des Arquebusiers Paris	264481274
138066290675800	MILLET	LE CORRE	Rachid	1 Rue du Colonel Driant Paris	125884787
162108651894204	BOIVIN	FAUCHER	Harold	33 Rue Cunin Gridaine Paris	157845587
171045149446952	BEAUMONT		Kevin	47 Rue Blondel Paris	264481274
116057590333638	TORRES	MAYER	Willem	10 Rue Barbette Paris	264481274
189044619488168	FOFANA	GUYOT	Esther	44 Rue Amyot Paris	264481274
292077605072543	HOARAU		Hughes	2 Rue de Brissac Paris	125884787
252102748808594	ZIMMERMANN		Aïcha	34 Rue Saint Fiacre Paris	157845587
134063838698377	SIDIBE		Jean-Pascal	1 Rue de Candolle Paris	264481274
271081608987354	BOURGUIGNON	GUILLEMOT	Umberto	42 Rue de l Arbalete Paris	264481274
135084429086369	NIAKATE	BARBOSA	Heinrich	22 Rue Blainville Paris	264481274
213018169533032	MILLE		Anthony	15 Rue Coq Heron Paris	125884787
115101172827851	GILLES	BAZIN	Kevin	46 Rue Mehul Paris	125548762
224023519830794	COCHET	SAID	Adélaïde	22 Rue du Val de Grace Paris	264481274
113086414892889	LABORDE		Auréliane	24 Rue du Bouloi Paris	157845587
145098366075373	MAILLET		Nathalie	19 Rue Saint Louis En l Ile Paris	125884787
134088596109320	TRAORE		Tonia	16 Rue des Pretres Saint G l Auxerrois Paris	157845587
283100127930094	MARTY	MAHIEU	Farid	17 Rue des Ecouffes Paris	125548762
108062368491491	BRETON		Kristel	44 Rue Saint Bon Paris	125548762
295054346609627	COUSIN		Myrna	3 Rue de l École Polytechnique Paris	125548762
175056307245608	CARON		Oussama	37 Rue du Pot de Fer Paris	125548762
245125275586869	THIERY		Marie-Rose	11 Rue de Bretagne Paris	157845587
184026584934683	GABRIEL	WEBER	Geoffrey	5 Rue du Pas de la Mule Paris	125548762
276109369398817	DIDIER	LEGENDRE	Georg	29 Rue de la Perle Paris	264481274
258047954598738	BONHOMME		Oliver	23 Rue du Croissant Paris	125884787
159026101937367	GRAND		Anita	26 Rue Eugene Spuller Paris	264481274
281100914191380	LEBEAU	DURET	Clotilde	12 Rue Bailleul Paris	125548762
265041036297803	JOSEPH		Pietro	47 Rue du Pont Louis Philippe Paris	264481274
172027357912624	FLORES	MAITRE	Sonia	10 Rue Baillet Paris	157845587
113090769708903	CLAUDE	DORE	Albéric	18 Rue Saint Roch Paris	264481274
285090329769836	CHAUVEAU	MAGNIER	Giovanni	13 Rue de Marivaux Paris	264481274
235112226577695	LEBRETON		Joseph	48 Rue des Francs Bourgeois Paris	125548762
146035915566546	BAUDOUIN	PICOT	Charlène	8 Rue Sainte Foy Paris	125548762
127013049115072	PUJOL	BENARD	Benoît	5 Rue Édouard Colonne Paris	264481274
276074955165911	LACOSTE		Marc-Aurèle	5 Rue de la Bourse Paris	125884787
274078327911985	DA CUNHA	NIAKATE	Peggy	14 Rue des Carmes Paris	157845587
297098982634129	LEBLOND		Jean-Max	28 Rue Villehardouin Paris	125884787
266113030404841	POTIER	DUPIN	Christelle	14 Rue des Bourdonnais Paris	125548762
291061465464580	CHARLET		Aurélien	32 Rue du Pont Neuf Paris	125884787
297029265987716	VAILLANT		Ferdinand	44 Rue du Bourg l Abbe Paris	125548762
278128075429694	BOUVIER	LAVIGNE	Lia	40 Rue Pierre Nicole Paris	125548762
184012353692245	MARTIN	CHABOT	Lila	25 Rue Leopold Bellan Paris	157845587
165068074963681	GUIBERT		Mohammad	23 Rue Quincampoix Paris	157845587
188018753555015	DUCLOS		Cyprien	3 Rue du Prevot Paris	157845587
125027234720831	GRANDJEAN	MARTEL	Jean-Marc	10 Rue du Louvre Paris	125548762
198095494635982	ROSSIGNOL		Florian	36 Rue Notre Dame des Victoires Paris	157845587
151119609719317	ROLAND		Hughes	46 Rue le Goff Paris	125548762
178099170061457	JAMET	PELLERI	Sylviane	24 Rue des Bons Enfants Paris	125884787
238102455584257	CISSE		Klaus-Werner	35 Rue Notre Dame de Recouvrance Paris	125548762
174110177212641	DELAPORTE		Jean-Gilles	27 Rue du Prevot Paris	157845587
238091262456688	WEBER		Myrna	18 Rue Poquelin Paris	157845587
119042090952757	LEBAS		Daisy	36 Rue Saint Hyacinthe Paris	125548762
247045170896320	BOUQUET		Lucas	2 Rue de Hesse Paris	157845587
182061185597144	DIABY	GEOFFROY	Nadia	46 Rue Erasme Paris	157845587
177040756394858	BONHOMME		Rosanna	42 Rue des Haudriettes Paris	264481274
216097269788636	BRAULT	BECK	Martine	10 Rue Charles V Paris	125884787
240098636102457	PROVOST		Karin	7 Rue Gaillon Paris	264481274
223027723041314	PELLERI		Perrine	23 Rue de Fourcy Paris	264481274
142038029211702	CORREIA		Léonie	32 Rue Duphot Paris	264481274
119073774022947	VERDIER	FOULON	Isaac	7 Rue Greneta Paris	125548762
203105428294586	COSTA	BERNARD	Bénédicte	43 Rue Mehul Paris	157845587
127114505385305	TORRES		Jean-François	5 Rue Herold Paris	125884787
203115204316722	GALLAND		Helen	38 Rue Mondetour Paris	157845587
143047530576868	FOURNIER		Brian	12 Rue Saint Bon Paris	125548762
252084845928826	GAUDIN		Adrianus	35 Rue de la Clef Paris	264481274
158083284418230	KEITA		Charles-Louis	17 Rue des Lombards Paris	125884787
276013421462837	SAIDI	BELIN	Jean-Louis	10 Rue du Pont Louis Philippe Paris	264481274
184060750824654	ALVES		Tania	27 Rue Ferdinand Berthoud Paris	125548762
287129112205056	PIERRON		Peguy	36 Rue Roger Verlomme Paris	125884787
108117505421653	CARDON		Charles	32 Rue Pierre Nicole Paris	125548762
296109313485906	ROUXEL		Océane	44 Rue Rouget de Lisle Paris	125548762
276060158258875	LEROY		Fanny	36 Rue des Coutures Saint Gervais Paris	157845587
119071350672351	GIBERT		Margueritte	27 Rue de Normandie Paris	125548762
287073546978367	SABATIER	BIGOT	Alban	5 Rue Nicolas Flamel Paris	125884787
216034868105920	LAFON	ETIENNE	Jannick	43 Rue Saint Sauveur Paris	157845587
240108256892560	DUMONT		Gottfried	24 Rue d Uzes Paris	125884787
144060491514938	BARBIER		Raphaëlle	47 Rue des Pretres Saint Severin Paris	125548762
263029938395133	BESSE		Amel	42 Rue Saint Medard Paris	264481274
139028225880780	LEGROS	LOPEZ	Marie-Cécile	15 Rue Paillet Paris	125548762
139044509081733	WOLFF	BATAILLE	Marilyn	18 Rue de la Harpe Paris	125884787
286034536711317	JOSSE		Josette	6 Rue François Miron Paris	125884787
267094158471577	BAUDET		Danièle	10 Rue des Mauvais Garcons Paris	264481274
275017674182759	MICHON	DUPUIS	Laetitia	16 Rue Lagarde Paris	157845587
192125134535252	MAURIN		Marinette	21 Rue Paul Dubois Paris	264481274
153128663886446	SOULIER	MACHADO	Gislain	21 Rue Notre Dame de Nazareth Paris	125548762
181028245089128	PROST	THIERRY	Ernst	18 Rue Soufflot Paris	125548762
205124133484803	JOLLY		Eddie	48 Rue de Castiglione Paris	264481274
141063251159329	EVRARD		Nancy	1 Rue Bude Paris	264481274
295109643093570	THUILLIER	LAGRANGE	Raymonde	6 Rue Monge Paris	264481274
100128404770065	NIAKATE	COULIBALY	Eveline	39 Rue des Filles Saint Thomas Paris	125884787
291072587130734	LEROY		Jean-Eudes	41 Rue Royer Collard Paris	125884787
163114987429449	LEBRETON		Steve	34 Rue Ortolan Paris	264481274
296123698284802	GAUDIN		Abdelah	22 Rue Rambuteau Paris	125548762
100120657067241	FORT	GICQUEL	Anne-Cécile	18 Rue des Bernardins Paris	125884787
220042537626746	OLIVIER	PERROT	Karl-Otto	13 Rue Nicolas Houel Paris	125548762
117065165282646	LAFLEUR		Delphine	24 Rue Pierre Nicole Paris	157845587
209129284642422	BOUQUET		Louisette	31 Rue Cunin Gridaine Paris	264481274
160018543311945	BERTHE	HOARAU	Monique	11 Rue Castex Paris	125884787
131018894086716	GUILLARD	LAUNAY	Allen	44 Rue Castex Paris	125548762
148071204427033	GAUTIER	PETIT	Fabien	34 Rue de la Tacherie Paris	157845587
215055219516728	FORT		Michèle	18 Rue de Saintonge Paris	125884787
288064789259254	BOUTET	LELONG	Arturo	4 Rue Villehardouin Paris	125884787
209027484439592	LEVASSEUR	PAYET	Edgard	16 Rue Lhomond Paris	125548762
112117737627127	FOUQUET		Salomon	40 Rue Larrey Paris	125884787
212112177557168	PIERRE		Pierre-Loïc	39 Rue Beaubourg Paris	125884787
259124262367720	VIAL		Peter	46 Rue de Turenne Paris	157845587
243019440286294	SELLIER	COMTE	Pierre-Emmanuel	26 Rue Montmartre Paris	125884787
250120320255028	RODRIGUES		Julia	21 Rue Rambuteau Paris	125884787
168044544530751	IMBERT	FISCHER	Charlène	32 Rue du Marche des Patriarches Paris	157845587
197085058533851	SEGUIN	FORESTIER	Alexandrine	25 Rue Ferdinand Berthoud Paris	264481274
189118296921538	MACE		Laetitia	27 Rue Roger Verlomme Paris	264481274
172127121780306	JOSEPH		Odile	30 Rue Thorel Paris	125548762
106012829360503	AUBERT	BOUVIER	Honoré	19 Rue Mehul Paris	264481274
257010508547422	RIBEIRO	AUBERT	Stanislas	39 Rue de Mirbel Paris	264481274
288119294124480	LACOUR	HAMON	Colin	18 Rue de la Cite Paris	264481274
263121043095750	POULET		Jacques	13 Rue Mehul Paris	264481274
169046777385625	DEVAUX		Rolf	25 Rue Coquilliere Paris	125884787
254063151017850	CLEMENT		Sunny	1 Rue Berthollet Paris	157845587
242118914204961	CANO		Karine	45 Rue Beauregard Paris	125548762
290073918728392	LASSERRE		Line	17 Rue Chapon Paris	157845587
191058534487268	DERRIEN		Vincent	19 Rue Beranger Paris	157845587
118059785875590	CHARLES		Allan-David	41 Rue de la Michodiere Paris	125884787
255123911821943	MAURICE		DannyM	20 Rue Au Maire Paris	157845587
252121548594422	LETELLIER	ROSSI	Lawrence	6 Rue de Lanneau Paris	157845587
146083034518235	CARRE		Marie-Noëlle	35 Rue Menars Paris	157845587
215115275923744	GUYON		Claire	28 Rue Notre Dame de Nazareth Paris	125548762
255024434449320	DUFOUR		Kenneth	33 Rue Pierre Au Lard Paris	264481274
292067301425678	CHEVALIER	ETIENNE	Dounia	49 Rue Broca Paris	125548762
238124835633617	CARDOSO		Chrystel	10 Rue des Forges Paris	125884787
250100390302501	PRIGENT		Aymeric	1 Rue de l Orient Express Paris	125884787
115069780586192	ANTUNES	MARQUES	Yohann	16 Rue de la Lune Paris	264481274
269028582321089	GODET	FERRAND	Djamila	44 Rue Croix des Petits Champs Paris	125548762
228075544768360	NUNES	ALEXANDRE	Vittorio	18 Rue des Minimes Paris	157845587
115090459564033	COLLIN		Anouk	43 Rue Bailleul Paris	125548762
136060268614388	DRAME	BOYER	Marie-Laure	43 Rue des Tournelles Paris	125884787
239107525820988	BOUVIER		Amandine	22 Rue Claude Bernard Paris	125884787
277082499925687	RAMBAUD	VOISIN	Christine	12 Rue Boutebrie Paris	264481274
149061089953964	CARLIER		Frederica	44 Rue des Precheurs Paris	125884787
155099604479331	VALETTE	LEROY	Émile	31 Rue Eginhard Paris	264481274
249116658619254	TOURE	VARIN	Maéva	8 Rue des Pyramides Paris	157845587
248098356838047	GUILLOU	BRETON	Louise	42 Rue Vivienne Paris	157845587
169058905574093	GODEFROY	LEFEUVRE	Lucienne	25 Rue de la Sourdiere Paris	125884787
288015091637034	TURPIN		Jacqueline	1 Rue Marsollier Paris	125548762
137113043274402	TEXIER		Mark	42 Rue Saint Victor Paris	125548762
257028814268392	LECLERE		Jean-Eudes	11 Rue des Patriarches Paris	157845587
119062273668288	LANGLOIS	LAMOTTE	Nora	6 Rue de Brissac Paris	157845587
137028151113684	PIERRE		Honoré	21 Rue des Orfevres Paris	157845587
183109362671564	BAPTISTE	JULLIEN	Bertrand	35 Rue Pierre Au Lard Paris	125548762
177077015655367	LEMAITRE		Ulysse	25 Rue de Sevigne Paris	157845587
113025853213883	BEAUFILS		Betty	2 Rue de Hesse Paris	157845587
279049861076510	GUYON	TARDY	Warren	25 Rue des Coutures Saint Gervais Paris	125548762
105067076521029	CORNU	MAS	Fernande	41 Rue Michel le Comte Paris	157845587
234129579445893	LECLERCQ		Rodrigues	35 Rue Saint Claude Paris	125884787
262075456464328	GRANGER		Marthe	41 Rue des Fosses Saint Bernard Paris	125884787
103108171583767	PAYEN		Jacques-Olivier	33 Rue de la Huchette Paris	157845587
289098686609121	JOLLY		Louis-Gérard	25 Rue Meslay Paris	125884787
261034304478401	ROQUES		Line	21 Rue des Juges Consuls Paris	264481274
135019316894863	ROUSSET		Lysiane	18 Rue Cambon Paris	157845587
143082928850324	AUGER	PASQUET	José-Maria	22 Rue Fustel de Coulanges Paris	157845587
150112983981791	VAILLANT		Jannick	28 Rue Agrippa d Aubigne Paris	125548762
194093230655172	YILDIZ		Mary	11 Rue Scipion Paris	125884787
172081474790883	ROBERT		Douglas	36 Rue Pascal Paris	125548762
249028848217580	MARTIN		Alexia	28 Rue du Cimetière Saint Benoist Paris	125548762
110062997134954	MONNIER		Marie-Josèphe	32 Rue Fustel de Coulanges Paris	264481274
212049852961463	LEGRAND	LACOSTE	Madiha	4 Rue de Jouy Paris	125884787
279106952353170	LOMBARD	THEBAULT	Anne-Claire	7 Rue du Croissant Paris	157845587
228118075183751	RENAULT		Esther	29 Rue de la Corderie Paris	125548762
185032891472891	SOLER	THERY	Arnault	37 Rue de la Corderie Paris	125548762
176079215128294	PELLERI	BENARD	Oriane	1 Rue Charles François Dupuis Paris	157845587
227031686466265	BOUTET		Francis	5 Rue du Petit Pont Paris	264481274
108095665815271	BRUNET		Pedro	33 Rue Volta Paris	157845587
293067295193883	LAGARDE	GAUDIN	Gustave	49 Rue des Bons Enfants Paris	157845587
146021627018427	VACHER	LEFORT	Miguel	3 Rue Poulletier Paris	264481274
224030202539094	LEBRETON	GABRIEL	Philomène	28 Rue Daubenton Paris	125548762
177029853259907	BRIERE		Élisa	24 Rue Saint Philippe Paris	157845587
170054073041927	LAVERGNE	MACHADO	Violaine	5 Rue Ortolan Paris	157845587
187073819892261	GRANGER		Gabriella	14 Rue Montorgueil Paris	157845587
272100390058901	SOLER		Michel-Ange	32 Rue Poliveau Paris	125548762
199080501008050	GIRAUD		Hélène	33 Rue des Bourdonnais Paris	125884787
110094961795134	LEBEAU		GilM	28 Rue de Turenne Paris	157845587
217039324734896	JOLLY		Matthieu	42 Rue Frédéric Sauton Paris	264481274
174059385899556	TELLIER		AndreaM	19 Rue Saint Antoine Paris	125548762
169071676568835	ANDRIEUX	RAMBAUD	Albéric	19 Rue Bailly Paris	264481274
225068887084592	CHARBONNIER		Ludovic	18 Rue Maitre Albert Paris	125548762
195084616272454	AUVRAY		Monique	30 Rue des Colonnes Paris	125548762
285047209123387	MAILLET	LAVAL	Stéphan	40 Rue de Navarre Paris	125548762
172013763767596	DEVAUX		Lylia	18 Rue Paillet Paris	157845587
272048448848606	ROLLAND		Adrianus	18 Rue des Arenes Paris	157845587
143040375736731	PARENT		Mohammad	2 Rue Agrippa d Aubigne Paris	157845587
149050153967537	ROY	BOUTIN	Susan	49 Rue du Puits de l Ermite Paris	264481274
116049935189022	DUMOULIN		Isaac	49 Rue des Lombards Paris	157845587
188097216431952	CARRE		Marie-Louise	6 Rue Poissonniere Paris	125548762
216082764922433	PAYEN		Willem	39 Rue Bachaumont Paris	125884787
224115970622441	MARY		Sarah	5 Rue de la Verrerie Paris	157845587
285114788952558	GODARD		Léo	48 Rue du 4 Septembre Paris	157845587
247075491328391	CORDIER	OLIVIER	Anne	24 Rue du Perche Paris	125884787
271022923220246	FERRER	ALVES	Audrey	34 Rue Beaubourg Paris	157845587
111030591034594	HADDAD	AUBIN	Agnès	8 Rue la Feuillade Paris	264481274
257059520141788	NICOLAS		Ernest	4 Rue Favart Paris	125884787
240114567406709	FOUCAULT		Eddie	35 Rue des 2 Ponts Paris	264481274
167021630244142	JOUBERT		Eric	33 Rue du Cinema Paris	157845587
268088051496928	BOURDIN	SIDIBE	Denys	47 Rue Bude Paris	125884787
254068184803144	DUMAS	DELMAS	Ferouz	41 Rue de l Echelle Paris	125884787
236045389806266	CHAMBON		Miloud	37 Rue du Roi de Sicile Paris	264481274
145026259569030	FAUCHER	DUVAL	Ghislain	14 Rue Brongniart Paris	125884787
255091764125894	TRAN	TRAORE	Benaïcha	30 Rue Malus Paris	125548762
246079035822823	LELIEVRE	MARTY	Reine	36 Rue de l Oratoire Paris	157845587
242043622468996	TANGUY		Yann	6 Rue de Thorigny Paris	125548762
103096383824071	MARTINEAU		Joël	8 Rue Henri Barbusse Paris	125548762
268064292795561	LEBLANC		Ghuilem	32 Rue Saint Severin Paris	264481274
299111020477610	IMBERT		Paul-Antoine	19 Rue de la Cossonnerie Paris	264481274
135045223209774	LEJEUNE		Albino	38 Rue Pirouette Paris	157845587
242012498306039	JOLIVET		Gabriella	32 Rue de la Sourdiere Paris	125884787
206099679755550	CARON		Marie-Reine	44 Rue du Sentier Paris	264481274
153107527788126	FERREIRA		Rosette	27 Rue Poulletier Paris	125548762
288061199802041	BONHOMME		Pierric	8 Rue de Bievre Paris	157845587
171059332834846	MARTINET		Sonya	25 Rue Reaumur Paris	125884787
106011084231378	TISSIER		Jean-Pierre	2 Rue Malus Paris	125884787
192122702640673	SARRAZIN	PARMENTIER	Olivia	46 Rue de Choiseul Paris	264481274
144058651158085	BONIN	TELLIER	Yasmina	26 Rue d Alexandrie Paris	264481274
297036084866434	GONTHIER		Patrice	10 Rue Lagarde Paris	157845587
104024782793871	DAMOUR		Abderrahim	23 Rue des Bourdonnais Paris	125548762
256062556405124	DURET	HADDAD	Yves-Marie	4 Rue du Grand Veneur Paris	125884787
188057492936580	GUILLON		Ronan	40 Rue Payenne Paris	125548762
100093386790971	VINCENT	ROCHER	Jean-Guy	17 Rue Maitre Albert Paris	125884787
145107728311572	BERARD		Gwendoline	4 Rue Aubry le Boucher Paris	264481274
256025976064713	BONNET	MARTIN	Raphaël	12 Rue Cochin Paris	264481274
118041223330245	LOMBARD	ARNOULD	Aimée	29 Rue Saint Denis Paris	157845587
156125231843210	MEYER		GabrieleM	19 Rue des Gravilliers Paris	264481274
108097522748111	GUILLARD	DIABY	Louis	44 Rue Cloche Perce Paris	157845587
116026335121455	GERARD		Janine	42 Rue Censier Paris	125884787
193033556420427	KEITA		Denys	3 Rue Sainte Apolline Paris	125884787
157103185444294	CORREIA		Éva	35 Rue des Mauvais Garcons Paris	125884787
158125852966745	GOMEZ	MAHE	Perrine	1 Rue Blondel Paris	125548762
238087013966826	POULET	MICHELET	Sylvine	9 Rue Vauvilliers Paris	157845587
245085054653774	GARNIER	QUERE	Brahim	39 Rue des 2 Boules Paris	264481274
129099269265203	FERRAND		Oswald	17 Rue des Fosses Saint Jacques Paris	157845587
137067952932213	SAHIN	LELIEVRE	Madeleine	25 Rue Bailleul Paris	157845587
181097995658562	GRANIER		Francine	17 Rue Jean Jacques Rousseau Paris	264481274
129015333191150	ALLAIN		Pedro	11 Rue Charles François Dupuis Paris	264481274
252076491934774	LERAY		Bastien	41 Rue du Prevot Paris	125548762
137084945054430	KIEFFER		Marie-Pascale	9 Rue Saint Merri Paris	125548762
123038603569252	HUGUET		Rita	49 Rue Saint Gilles Paris	264481274
284046374475926	BONIN	BONNEFOY	Vincenzo	24 Rue Vieille du Temple Paris	264481274
162024692293914	ROBERT		Marinette	3 Rue Jean Calvin Paris	125884787
286071597914575	BAUDOUIN	POULAIN	Friedrich	3 Rue de l Orient Express Paris	125548762
139062755438909	DANIEL	FERREIRA	Norbert	25 Rue Jean Calvin Paris	264481274
102019659160308	FONTAINE		Deborah	17 Rue du Cloitre Saint Merri Paris	125884787
150081201116183	DANIEL	GREGOIRE	Adam	18 Rue des Degres Paris	125548762
147085285282844	CASTEL	CHAUVEAU	Didier	48 Rue des Jeuneurs Paris	264481274
295012888306237	LEFORT		GilM	2 Rue de la Cossonnerie Paris	264481274
228121380869080	MONTEIRO	CARTIER	Helmut	26 Rue Maitre Albert Paris	264481274
209076917524931	SELLIER		Esther	19 Rue Saint Gilles Paris	264481274
114128201353291	HUSSON		Armelle	41 Rue des Colonnes Paris	125548762
140021024071878	MARION		Raphaëlle	17 Rue Saint Roch Paris	125884787
122070309199973	MOREIRA		Amanda	46 Rue Elzevir Paris	125884787
262078078553170	PASQUIER	GUILLON	Edwige	44 Rue de Rivoli Paris	125884787
214058422588031	TANGUY	TESSIER	Louisa	24 Rue du Croissant Paris	264481274
297018588389986	LEMOINE		Rose	27 Rue de Poitou Paris	125884787
270091948045432	LECUYER		Abdelhalim	29 Rue des Barres Paris	125548762
131085984245638	BRIERE		Rodolphe	44 Rue Castex Paris	125548762
217077302350914	COLLIN	JACQUET	Sandrine	39 Rue Sainte Elisabeth Paris	125884787
247064950013140	NUNES		Maria-Lisa	3 Rue Sainte Opportune Paris	125884787
103065213906618	THERY		Léon	21 Rue du Ponceau Paris	264481274
264074023702284	BERNARD		Eveline	5 Rue Henri Robert Paris	157845587
104110590911744	MASSON		Loriane	48 Rue du Temple Paris	157845587
272103843045703	BARRE		Éva	47 Rue de Navarre Paris	157845587
257080110522152	YILDIZ	JOLY	Gisèle	44 Rue de l Abbe Migne Paris	264481274
274088813916527	PETITJEAN		Raymonde	28 Rue des Rosiers Paris	125548762
208118561794850	THIERY	ROLLAND	Johanna	27 Rue du Petit Moine Paris	157845587
289108977900206	BAUDET	LEFEVRE	Jean-Marcel	48 Rue Ortolan Paris	125884787
138105592649180	HONORE	BRIERE	Agathe	26 Rue Geoffroy l Angevin Paris	157845587
255088965332455	PRUVOST		Isabel	11 Rue des Arenes Paris	125548762
243013407647544	PROST		Fatima	27 Rue Paillet Paris	157845587
208089025109136	YILMAZ	CARPENTIER	Aline	9 Rue de Beauce Paris	264481274
293129298699077	CARLIER	CHARPENTIER	Laurent-Benoît	31 Rue Marie Stuart Paris	125548762
210043607648491	KIEFFER	LAPORTE	Nicolle	42 Rue Saint Spire Paris	125548762
223122030311311	LETELLIER		Jean-Hugues	14 Rue de la Monnaie Paris	264481274
261019617230168	LECLERE	SLIMANI	Bahia	45 Rue des Pyramides Paris	157845587
243066968428847	SALAUN		Pierre-Louis	23 Rue Basse Paris	125548762
170080268839901	FONTAINE		Jean-Georges	48 Rue de la Corderie Paris	125884787
251120945328030	PAPIN	SABATIER	Richard	33 Rue la Feuillade Paris	264481274
219116344306402	DA CUNHA	TISSOT	Fatma	41 Rue des Francs Bourgeois Paris	125548762
179098881632515	SELLIER	LERAY	Monica	31 Rue des Haudriettes Paris	157845587
144018384174747	BERTIN	LEFEUVRE	Dorothy	5 Rue Perrault Paris	264481274
136114138407278	HUSSON	BOYER	Sandra	49 Rue Linne Paris	264481274
281019819289565	DUMONT		Ulrike	7 Rue Valette Paris	157845587
248115000202929	LE GOFF		Johann	26 Rue des Panoramas Paris	125548762
227073625053031	OLIVIER		Geneviève	16 Rue Saint Julien le Pauvre Paris	125884787
137012739426413	MAILLOT	LOISEAU	Christopher	28 Rue des Lions Saint Paul Paris	125548762
126068767532596	DELAUNAY	ROYER	DanyM	12 Rue Saint Medard Paris	125548762
297118813515304	MARECHAL	LERAY	Leonardo	50 Rue du Bourg l Abbe Paris	264481274
102017878755115	ROUSSEL		Dieudonné	46 Rue Jean du Bellay Paris	125548762
192108415007283	ARNOULD		Oriane	14 Rue Fustel de Coulanges Paris	125548762
266105680605414	LELEU	GRAS	Jean-Patrick	34 Rue du Cygne Paris	125884787
131125282953657	CHAUVIN		Aymeric	26 Rue des Chantres Paris	157845587
255078204802254	LELIEVRE	SENECHAL	André-Clément	41 Rue Perree Paris	125548762
265121844820151	LY	BASSET	Célia	40 Rue des Pretres Saint Severin Paris	125884787
125015830509845	GEORGE	LECOMTE	Bernard	22 Rue Saint Florentin Paris	157845587
166028647357667	SERRANO	GOMEZ	Jessie	31 Rue de Quatrefages Paris	264481274
118112410272245	PERROT	TESSIER	CesareM	4 Rue Thenard Paris	157845587
184029967452706	JACOB	PIRES	ChristelM	12 Rue Notre Dame de Nazareth Paris	264481274
102085689984553	LEMAITRE		Willy	26 Rue Saint Severin Paris	125884787
164084503884247	LESUEUR		Anna-Lisa	13 Rue Agrippa d Aubigne Paris	157845587
135074940491607	TISON	BLONDEAU	Adam	49 Rue de la Tacherie Paris	264481274
199030716614074	DERRIEN		Edwige	17 Rue de Cluny Paris	125884787
185079382958660	BARBE		Dorothy	26 Rue Georges Desplas Paris	264481274
260115670258424	DE SOUSA		Petrus	42 Rue Sainte Anne Paris	264481274
178092232278018	DE ALMEIDA		Valérie	6 Rue Sainte Anne Paris	157845587
169074773920796	LEPAGE		Anthony	19 Rue de Choiseul Paris	125548762
131070172653837	GODEFROY		Messaouda	21 Rue de Richelieu Paris	157845587
252123340003556	PELLETIER	RAMOS	Alain	11 Rue Sainte Apolline Paris	264481274
270049403545237	ROBIN	HERVE	Georges-Michel	15 Rue d Ormesson Paris	125548762
122013583993734	FAVRE	IMBERT	Mario	2 Rue Marie Stuart Paris	264481274
247064696896690	LEBRETON	LOUIS	Muguette	27 Rue Caffarelli Paris	125884787
211103396685063	MAITRE		Marie-Juliette	9 Rue du Bouloi Paris	125884787
124068718826168	POTIER		CesareM	44 Rue du Sommerard Paris	264481274
296038999707691	LECUYER		Arnault	48 Rue des Petits Peres Paris	157845587
141037987029076	JACQUEMIN		Julie	48 Rue de Sully Paris	125884787
201081626343750	DUPONT	LECUYER	Clémence	24 Rue du Louvre Paris	157845587
190047473188512	BELIN		Stéphanie	44 Rue Claude Bernard Paris	125548762
209038216146851	MAITRE		Etiennette	14 Rue Beautreillis Paris	264481274
120027610567383	DIAS	SANCHEZ	Ahmed	2 Rue des Grands Degres Paris	125884787
118099632841858	RIO	FLEURY	Marie-Juliette	47 Rue Neuve Saint Pierre Paris	125884787
153023371372412	BARON	SALAUN	Lucy	1 Rue des Rosiers Paris	157845587
220035719909604	DUMOULIN		Pierre-Martin	12 Rue de Turenne Paris	157845587
299128835735359	ANDRE	PASQUIER	Pierre-Henri	16 Rue Larrey Paris	157845587
171096323748369	REY		Pierre-Nicolas	23 Rue Lacepede Paris	125548762
249118020522088	SCHNEIDER		Eddy	49 Rue du Croissant Paris	125884787
279037176177857	GIBERT	MOUTON	Lamia	23 Rue Bachaumont Paris	125884787
194123870040526	BERARD		Léopold	4 Rue Gomboust Paris	125884787
216050588792452	MORENO		Arlette	8 Rue Sainte Foy Paris	157845587
101027766706912	FERRARI	BECK	Maria	6 Rue Dussoubs Paris	157845587
259024064714624	BLIN	DROUET	Alexis	45 Rue des Capucines Paris	264481274
270014064481086	LAMOTTE		Laurent	28 Rue Bertin Poiree Paris	264481274
152050826723518	DEVAUX		Armelle	48 Rue Lavandières Sainte Opportune Paris	125548762
231078668662003	VACHER		Jimmy	39 Rue du Chat Qui Peche Paris	264481274
147034386292786	JOUBERT	VACHER	Jean-Daniel	4 Rue Meslay Paris	264481274
182014842853195	LY	GUILLET	Benjamine	4 Rue Pavee Paris	264481274
292083432286212	BLANCHET		Daphné	45 Rue des Oiseaux Paris	264481274
246033976246105	CHARRIER	JANVIER	Ghislain	28 Rue des Guillemites Paris	125548762
261055944395226	STEPHAN		Eric	29 Rue Soufflot Paris	157845587
128055781153403	PRAT	DELORME	Filippo	1 Rue de Turbigo Paris	157845587
224059146621395	MARTINEZ		Clara	39 Rue de Mulhouse Paris	125548762
283114678495021	SAMSON		Audebert	31 Rue Notre Dame des Victoires Paris	125548762
178014634707159	GUILLEMOT		FredM	17 Rue du Pont Neuf Paris	157845587
213083916917722	JEAN	BLANCHET	Vivianne	35 Rue des Ursulines Paris	125884787
107084739343784	MORIN	DESCHAMPS	Jean-Raphaël	45 Rue des Oiseaux Paris	157845587
215085796076693	MUNOZ		Arnold	36 Rue Saint Martin Paris	125884787
272071958103759	GIRARD	JEAN	Marianne	39 Rue de l Orient Express Paris	264481274
202046097430545	MORVAN		Fatima	27 Rue du Pelican Paris	264481274
255053357438060	LAPORTE		Alistair	26 Rue Jean de Beauvais Paris	157845587
143094758250605	TOUSSAINT	JOLY	Peggy	29 Rue de Turbigo Paris	157845587
298015237621938	BLANCHARD		StefanM	14 Rue de Turbigo Paris	157845587
135013147654144	DAMOUR	RICHARD	Reza	9 Rue du Croissant Paris	264481274
149056744712258	CAMARA	DELAGE	Cédric	24 Rue de l Ave Maria Paris	125548762
241091337496952	ZIMMERMANN	COUSIN	Samira	35 Rue Gay Lussac Paris	125548762
237123674082614	BONNIN	GUERIN	Amanda	4 Rue des Francs Bourgeois Paris	157845587
188107331612463	TEIXEIRA		Alexia	34 Rue Tournefort Paris	264481274
146038139963472	CHARLET		Marie-Édith	21 Rue de Rohan Paris	125548762
275071720303360	GARCIA	GONTHIER	Clotilde	47 Rue des Minimes Paris	264481274
282064682723343	JULLIEN	MONTAGNE	Jason	22 Rue Henri Barbusse Paris	125884787
114101952090739	CARTIER		Jean-Hervé	5 Rue du Foin Paris	125548762
207107994278129	SABATIER	ROLAND	Augustin	22 Rue Henri Robert Paris	264481274
260055549848885	DUVAL	AVRIL	Jean-Henri	2 Rue Quincampoix Paris	125884787
214020543515529	LEBON		Candice	10 Rue Debelleyme Paris	264481274
135100709107338	MILLE	LEBON	Suzan	16 Rue du Cloitre Saint Merri Paris	125884787
278106956056295	GUILLON	TOURE	Gaël	3 Rue Malus Paris	264481274
196044090469523	CHOLLET		Salma	33 Rue de Lobau Paris	125548762
223077011150247	MAURIN	BAUDOUIN	Lyna	23 Rue Croix des Petits Champs Paris	264481274
170032191239838	GARCIA		Yves	16 Rue des Chantiers Paris	264481274
262094703954561	LASSALLE	ROUX	Steve	15 Rue Beautreillis Paris	125548762
293098735454683	NICOLAS		Henri-Charles	11 Rue Eugene Spuller Paris	125884787
114031662892732	JEANNE		Franz	24 Rue des Halles Paris	157845587
233063938553717	DENIS		Frédérique	30 Rue des Panoramas Paris	125548762
142027529465492	DESCHAMPS		Jean-François	43 Rue Debelleyme Paris	157845587
268081386395744	TOUSSAINT	GILBERT	Angie	43 Rue de Bazeilles Paris	125884787
119125003483214	YILDIZ		Jozef	26 Rue Blondel Paris	157845587
260083942923902	BRAULT	DUCHEMIN	Myrna	3 Rue du Ponceau Paris	125548762
281111914382515	OLLIVIER	JACQUIN	Auguste	26 Rue Basse des Carmes Paris	264481274
271010916937233	NIAKATE		Yasmine	6 Rue des Innocents Paris	125548762
131052658062338	BRUN	GIL	Jean-François	13 Rue Erasme Paris	157845587
174018102858594	JOUBERT		Carolyn	27 Rue Saint Etienne du Mont Paris	264481274
150072095960502	COUDERC		Stewart	25 Rue Saint Julien le Pauvre Paris	264481274
156112101254314	LEPAGE		Madiha	2 Rue de l Arc En Ciel Paris	125884787
118094258078427	REGNIER		Patricia	33 Rue des Petits Carreaux Paris	125884787
224043336251390	BLANCHET		Vincente	48 Rue de Brosse Paris	264481274
267066331716920	SAHIN	DIAS	Laura	28 Rue Saint Florentin Paris	125884787
261077305981665	CARPENTIER	RENARD	CyrilleM	5 Rue des Chantres Paris	125548762
115016947696529	VIDAL		Romano	17 Rue de Lesdiguieres Paris	157845587
245044833929736	CARVALHO	DIAZ	Mylène	35 Rue Berthollet Paris	157845587
297073818905849	CHARLES		Fabian	8 Rue du Nil Paris	125884787
218112782420475	LEGER	PONS	StefanM	40 Rue du Bourg Tibourg Paris	264481274
253026744850990	VILLAIN		Luciano	27 Rue des Vertus Paris	157845587
203124780561391	COHEN		Manon	14 Rue Baillet Paris	125884787
158036596308209	ROUXEL	GUILLARD	Benjamin	47 Rue de la Boucle Paris	125884787
204038320321261	BRUNO		Cendrine	12 Rue Adolphe Adam Paris	125884787
269054468621668	CONSTANT		Odile	18 Rue des Bons Vivants Paris	157845587
121086804762872	GUYOT	DUCHENE	Jean-René	34 Rue de la Petite Truanderie Paris	125884787
237061640815392	FELIX	LAURET	Josephus	22 Rue Sauval Paris	264481274
201074157091853	COLAS	DIAZ	Jérôme	38 Rue Caffarelli Paris	125884787
126033690529208	CHAMPION		Monica	5 Rue des Tournelles Paris	125884787
299035859508254	LEVASSEUR		Jacky	42 Rue de la Collegiale Paris	157845587
210075736883420	CORNET	DIAKITE	Sarah	29 Rue Sainte Opportune Paris	264481274
216089371391561	BOUQUET	BAZIN	Roderick	27 Rue Quincampoix Paris	125548762
159034821642031	MAURIN		Tristan	21 Rue Brantome Paris	264481274
197098764923639	DUARTE	IMBERT	Laurencia	11 Rue de la Sourdiere Paris	125884787
264017112670014	GUY		Harold	15 Rue Ferdinand Duval Paris	125548762
239085554893582	LAVAL		Jean-Manuel	4 Rue des Arquebusiers Paris	157845587
276113638415091	COUTURIER		Anne-Marie	6 Rue Larrey Paris	125884787
148053879024132	BELLANGER	IMBERT	Ghislaine	6 Rue d Aboukir Paris	157845587
160036331293193	NAVARRO	MICHON	Nina	18 Rue Brantome Paris	157845587
274044454242295	SANTIAGO	PRIGENT	Benoît	31 Rue des Fosses Saint Bernard Paris	264481274
149012807148886	PUJOL	SENECHAL	Pedro	28 Rue du Gril Paris	125884787
292069883843039	SANCHEZ		Jean-François	47 Rue des Juges Consuls Paris	125884787
102013760217462	VILLARD	LECOMTE	Robin	24 Rue de Brosse Paris	125548762
175032006668491	FORESTIER		Charlotte	47 Rue Clotaire Paris	264481274
296072961678303	BARRET		Solène	34 Rue de Clery Paris	157845587
186042352386031	ANDRIEU	CORRE	Théophile	10 Rue Jacques Coeur Paris	125884787
133057183683629	PAIN		Héléna	3 Rue Boutarel Paris	125548762
239091146729071	DRAME	VIDAL	Nadia	30 Rue Herold Paris	125548762
263101694819786	BON	PEREIRA	FredM	22 Rue Beranger Paris	125884787
161030812581007	SILVA	JOSEPH	Kurt	31 Rue de Turbigo Paris	157845587
107093235177704	GUILLAUME	WOLFF	Tomy	22 Rue Sainte Anastase Paris	125548762
212107700291388	MAILLET	GAUDIN	Karina	17 Rue des Nonnains d Hyeres Paris	157845587
235049460087780	DURAND		Maggaly	5 Rue Charlemagne Paris	157845587
185068654919823	PERROT		Jenny	41 Rue de la Clef Paris	125884787
186124469172237	GERARD	DUHAMEL	Marylène	3 Rue du Marc des Blancs Manteaux Paris	264481274
129115117911004	COUDERC	CROS	Églantine	2 Rue Colbert Paris	157845587
174109372159626	MARTINEZ	WEISS	Françoise	39 Rue Clotilde Paris	125884787
166063604370140	GRAS		Laurie	13 Rue Beaubourg Paris	125548762
265124877010950	TEXIER		Soazig	18 Rue des Lombards Paris	264481274
242082419543236	BLANDIN	CAILLAUD	Madeline	27 Rue Pernelle Paris	157845587
231055267153739	COMTE		Cynthia	8 Rue Danielle Casanova Paris	157845587
183027292071405	EVRARD	TOUSSAINT	Wolfgang	32 Rue du Pelican Paris	125884787
119062521839354	DA SILVA	LEMAIRE	Jean-Pierre	24 Rue Colbert Paris	125884787
192109954988377	MARQUET		Christiane	33 Rue Danielle Casanova Paris	125548762
202103092588087	BAPTISTE	CISSE	Giovanni	22 Rue Française Paris	157845587
134055750788867	TISON	LACOSTE	Jeannette	37 Rue Sainte Elisabeth Paris	125884787
175064419494236	VALENTIN	TESSIER	Marthe	32 Rue de Thorigny Paris	125548762
270096529380286	SAIDI	CARLIER	Paule	46 Rue Beaubourg Paris	125548762
201052199619458	SIDIBE	VIDAL	Franz-Georg	44 Rue Gabriel Vicaire Paris	157845587
259116924287307	LEGENDRE	BAILLEUL	Marie-Pierre	38 Rue de la Sorbonne Paris	125884787
231043870437419	LAFONT		Ronan	8 Rue de Sully Paris	125884787
164109917354484	GARCIA		Paule	32 Rue Pascal Paris	264481274
185031273229975	RENARD		Valérie	40 Rue Reaumur Paris	157845587
165015991694361	GEORGE		Elisabeth	30 Rue Massillon Paris	125548762
181010871674560	DESCAMPS	SALMON	Marie-Amélie	2 Rue de la Collegiale Paris	157845587
139050580745001	CHOLLET		Silvana	22 Rue des Pretres Saint Severin Paris	157845587
277041387830758	SARRAZIN	DIAS	Margueritte	22 Rue Malebranche Paris	125548762
115069364634634	LAPORTE	FOUCAULT	Habib	6 Rue Villehardouin Paris	125884787
241096000702739	RAULT	COUSIN	Ivan	16 Rue d Argout Paris	125548762
216048982722935	SAUNIER		Dieudonné	28 Rue Paillet Paris	157845587
276043885107833	GIRAUD	GEORGE	Danielle	49 Rue de la Lingerie Paris	125548762
257065888851792	GONTHIER	GROSJEAN	Stanislas	14 Rue du Mont Thabor Paris	125548762
277013639146953	BRUN	HOARAU	Tobias	19 Rue Louis Thuillier Paris	125884787
116047632185619	LAGARDE		Reynald	33 Rue Baltard Paris	157845587
237016326038243	GABRIEL		Marie-Pascale	40 Rue de Mirbel Paris	125884787
280089567149014	SAUNIER	BOULANGER	Estelle	45 Rue de l Amiral Coligny Paris	125884787
177084821772201	LAUNAY		Djamel	35 Rue de l Equerre d Argent Paris	264481274
132111902031658	NUNES	MILLOT	Mylène	48 Rue Brisemiche Paris	125884787
212077306419001	TESSIER	FAVIER	Manuel	10 Rue Debelleyme Paris	157845587
265128593710036	WINTERSTEIN	BERTRAND	Jean-Nicolas	17 Rue Malher Paris	157845587
240070875310729	LEROUX	MARTIN	Anne-Clotilde	12 Rue du Foin Paris	125884787
293085789640582	QUERE	CHRISTOPHE	Grégor	14 Rue de l Equerre d Argent Paris	125884787
197028693449711	BLONDEAU	DUHAMEL	Carole	37 Rue du Haut Pave Paris	125884787
248050431160701	PONS	MARTINEAU	Wolfgang	22 Rue Favart Paris	125548762
234116778893942	THIBAULT		Benoît-Paul	40 Rue de la Clef Paris	125884787
291044306186509	BOURDON		Michel	31 Rue Roger Verlomme Paris	157845587
212033837523152	VASSEUR		Olga	23 Rue Monsigny Paris	157845587
163115995738082	VIGNERON	OLIVEIRA	Mark	46 Rue Menars Paris	125884787
108080499169703	DIDIER		Jocelyne	38 Rue Agrippa d Aubigne Paris	125884787
264072212482013	FONTAINE		Salvatore	25 Rue Therese Paris	157845587
273073748815960	TORRES		Pauline	47 Rue de Braque Paris	157845587
281076355672170	DUBOIS	IMBERT	Angie	10 Rue Perrault Paris	264481274
206068251343504	CHEVALLIER	SIMON	Michel-Philippe	8 Rue Française Paris	125548762
270109148488384	AUBERT		Anne-Joséphine	9 Rue Amyot Paris	125548762
298094244775878	ARNAUD		Anouk	42 Rue de la Petite Truanderie Paris	264481274
166108820419376	GAUTIER		Dieudonné	28 Rue de Moussy Paris	157845587
294016552422681	GUILLEMIN		Josette	1 Rue Sauval Paris	125548762
199101967924971	WINTERSTEIN		Soazig	29 Rue de Marivaux Paris	157845587
124068661103286	BOURGEOIS		Jean-Louis	45 Rue Borda Paris	157845587
260044683856244	CADET	BARRE	Dounia	46 Rue du Bouloi Paris	125884787
276076882663621	LAFLEUR		Kristel	49 Rue Gaillon Paris	157845587
148122725413726	GAILLARD		Frederik	10 Rue de l Epee de Bois Paris	157845587
289010155406208	SIMON		Gaston	30 Rue Monge Paris	264481274
294060407584149	CORTES		Denyse	22 Rue Henri Barbusse Paris	125884787
139065443729140	LAMY	LASSERRE	Giselle	8 Rue des Anglais Paris	157845587
166091666520458	GUERIN	JACOB	Janine	33 Rue de Beauce Paris	264481274
226058344946712	BARRET		Colin	16 Rue Soufflot Paris	264481274
119108066223991	VERNET	HUET	Lucille	13 Rue des Haudriettes Paris	125548762
166120368218553	FOFANA		Armand	46 Rue Montorgueil Paris	125548762
196063036979567	JACQUIN		Elizabeth	18 Rue des Forges Paris	264481274
287018783401310	NEVEU		Marie-Pierre	34 Rue Monge Paris	264481274
169123667085745	MOHAMED	SAVARY	Reynald	20 Rue des Capucines Paris	264481274
291045917238489	CLAIN	LEBEAU	Maxence	28 Rue de Montmorency Paris	157845587
203129749597569	HUMBERT		Luca	13 Rue Saint Martin Paris	125548762
239107910465394	LERAY		Floriane	38 Rue Cherubini Paris	125884787
107013876121908	PROST		Jean-Raphaël	10 Rue des Anglais Paris	125548762
122055679266216	COMBE		Soazig	39 Rue du Parc Royal Paris	157845587
118086297555680	VALLEE		Inès	21 Rue Cujas Paris	125884787
250115721904451	COLIN	ARNAUD	Janine	24 Rue Poquelin Paris	157845587
280060191300313	NEVEU		Germaine	1 Rue Cherubini Paris	125884787
117126688058062	THOMAS	DELMAS	Djamel	10 Rue Sainte Elisabeth Paris	125884787
127058106807061	BATAILLE		Hervé-Joseph	13 Rue des Fontaines du Temple Paris	125884787
200031594053188	CHABOT	MERCIER	Marcelino	19 Rue Pastourelle Paris	125884787
179067984929908	BARREAU	POLLET	Mercedes	45 Rue Roger Verlomme Paris	264481274
247097436239589	FOFANA		Carole	34 Rue Mouffetard Paris	157845587
193102778541743	LAMOTTE		Lorenzo	14 Rue Castex Paris	264481274
166066770602613	GUY		Charles-Henry	24 Rue de la Tacherie Paris	157845587
266097183420366	DUBOIS	LE ROY	Tiffany	48 Rue de la Perle Paris	125884787
106034249755113	TRAN		Françoise	2 Rue de Turenne Paris	125548762
288021514521235	DIARRA		Marie-Florence	2 Rue Saint Philippe Paris	157845587
219047723431704	DUMOULIN	PINEAU	Jean-Yves	43 Rue du Louvre Paris	125548762
105064525567135	MASSON		Théodore	9 Rue des Minimes Paris	264481274
143018820407138	LELIEVRE		Charles-Eric	10 Rue de Lobau Paris	264481274
154103299728937	PETITJEAN	ADAM	Vladimir	13 Rue Favart Paris	125884787
206113724192459	RIVIERE	COURTOIS	Alec	3 Rue de la Bucherie Paris	264481274
247065902055612	LABORDE	WEISS	Dietrich	7 Rue Pastourelle Paris	125548762
156095915334257	BONNEAU	CHEVALIER	Solène	31 Rue Caron Paris	264481274
197024861025985	VINCENT	ANTUNES	Rénata	6 Rue Malus Paris	125548762
137119435589253	MILLOT	RAMOS	Miguel	24 Rue Menars Paris	125548762
210057188504519	PERROT		Guy	29 Rue de Gramont Paris	264481274
168092323808223	DEVAUX		Mohamed	28 Rue du Puits de l Ermite Paris	157845587
121079326716109	COUSIN		Violetta	32 Rue Feydeau Paris	125884787
208095993143744	BOURGEOIS	BON	Caroline	17 Rue Vivienne Paris	125884787
225079785161807	TEXIER	BROSSARD	Eudes	22 Rue du Croissant Paris	157845587
217109204772961	GAILLARD		Omar	30 Rue Marsollier Paris	125548762
250020760833943	DELATTRE		Michel	36 Rue de la Banque Paris	125548762
297112356304318	BROSSARD	JACQUEMIN	Oscar	27 Rue Clotaire Paris	125884787
190083588374214	COLIN	VERDIER	Constant	41 Rue de la Michodiere Paris	264481274
179094720815996	LAVERGNE		StefanM	45 Rue des Archives Paris	157845587
129033616838358	BLANCHET		Eddie	47 Rue des Chantres Paris	157845587
138120841735658	GEOFFROY		Alexandrine	16 Rue Amyot Paris	125884787
259123094684548	MAHE	BASTIEN	Annabelle	9 Rue Notre Dame des Victoires Paris	125548762
111055160566338	ROUSSEAU	OLIVIER	Étienne	14 Rue Commines Paris	264481274
113107456390850	DUPIN	VERDIER	Germain	26 Rue de Choiseul Paris	125884787
244032415236016	LEBON		Sandra	5 Rue du Bourg Tibourg Paris	264481274
184023991391628	MERLIN		Charles-Eric	50 Rue Guerin Boisseau Paris	125548762
276029793747273	MUNOZ	THIBAULT	Suzanna	22 Rue du Bourg l Abbe Paris	157845587
134078170944188	SCHMITT	BOULANGER	Jean-Brice	42 Rue du Cloitre Saint Merri Paris	125548762
246129551535565	MORENO		Noémie	16 Rue Saint Denis Paris	125548762
221067404045732	ROBIN	FERRARI	Isidore	8 Rue Portefoin Paris	264481274
172094668047237	GUY	LECOCQ	Ulrike	49 Rue du Cloitre Saint Merri Paris	264481274
134042462939733	CARLIER		Marie-Joëlle	30 Rue du Chat Qui Peche Paris	157845587
180128995054010	LEJEUNE		Jonathan	44 Rue de Braque Paris	264481274
210052462712009	BOUCHET	GRIMAUD	Régis	40 Rue des Vertus Paris	125548762
117024346707693	CLEMENT	PINEAU	Ulrike	43 Rue du Val de Grace Paris	157845587
158060792761175	COLLIN		Steve	8 Rue Lagrange Paris	264481274
115103061446648	BERTHIER		Geneviève	38 Rue Dupetit Thouars Paris	125884787
292081637038605	LEMAITRE	DUCHESNE	Ralph	27 Rue Mornay Paris	125548762
153109335398179	AUBERT		Joël	33 Rue Saint Joseph Paris	125548762
126109239418435	DUPRE	LAMBERT	Josette	39 Rue des Ecouffes Paris	264481274
250037185243654	GABRIEL	LANG	Emannuelle	3 Rue Rambuteau Paris	264481274
201072681226547	LE BERRE	HARDY	Francesco	12 Rue du Pot de Fer Paris	264481274
239120237800324	LE GALL	BROSSARD	Maria-Lisa	31 Rue Dalayrac Paris	157845587
248126817619060	DE OLIVEIRA	SAUNIER	Gaëlle	32 Rue Boucher Paris	125548762
261113788102102	BRUNO		Kadyja	1 Rue Leopold Bellan Paris	264481274
182011321936788	GARCIA	LE GALL	Marianna	36 Rue du Temple Paris	125884787
270022191753200	GUY		Katy	35 Rue de Fourcy Paris	157845587
225028099609560	DIALLO		Fabre	22 Rue Mouffetard Paris	264481274
244053615608657	BOIVIN		Joël	48 Rue du Jour Paris	125548762
116066809892335	LENOIR		Mélodie	34 Rue des Fosses Saint Marcel Paris	157845587
116106724777292	CISSE		André-Marie	27 Rue de l Abbe Migne Paris	157845587
146083500358210	BRUNET	SALOMON	France	22 Rue du Jour Paris	157845587
157036866353328	ANDRIEU	AFONSO	Angelina	23 Rue Rouget de Lisle Paris	125548762
268040221926572	ZIMMERMANN	OLIVEIRA	Myriam	50 Rue Guerin Boisseau Paris	125548762
259029201046904	TEXIER	LE GALL	Ernest	33 Rue Elzevir Paris	125884787
282038251008033	GUIGNARD		Géraud	41 Rue de Mirbel Paris	157845587
129031456728988	GUILLOT	SAVARY	Petrus	17 Rue Saint Joseph Paris	264481274
136023021781523	FERRAND	BROSSARD	Emanuel	35 Rue du Pas de la Mule Paris	157845587
147110274507518	COMBES	ALI	Annie-Claude	14 Rue Chenier Paris	264481274
153072150169408	PARENT	DUMOULIN	Houria	46 Rue de Port Mahon Paris	264481274
243077956746269	DIABY		Salima	35 Rue des Tournelles Paris	264481274
291079297260025	THOMAS	OLIVEIRA	Lucy	35 Rue des Bons Vivants Paris	125884787
262088041353654	MARTINEZ	COUTURIER	René	28 Rue du Pas de la Mule Paris	125548762
227042980363902	LENOIR		Carlos	17 Rue Coq Heron Paris	157845587
225085330862476	BECKER		Samia	8 Rue Poulletier Paris	264481274
228051958559467	FAUCHER		Bahia	27 Rue de Poitou Paris	125884787
217081379554035	TISSIER		Malcom	22 Rue des Colonnes Paris	157845587
298098122213462	FLORES	COURTOIS	Gaetanino	19 Rue Victor Cousi Paris	125884787
276023787980654	CAMARA	JOLIVET	Marielle	37 Rue Louis le Grand Paris	157845587
236110135097393	OLLIVIER	DUPUY	Jean-Raphaël	34 Rue Papin Paris	264481274
214114566129124	DUCHEMIN	LEGENDRE	Yveline	11 Rue Pecquay Paris	125548762
220113495911050	TEIXEIRA	LE FLOCH	Rosine	49 Rue Descartes Paris	125548762
209118599554171	DESHAYES	LEDOUX	Charlène	47 Rue de la Petite Truanderie Paris	264481274
271021954120932	LEGENDRE	GONCALVES	Adolphe	3 Rue de Cluny Paris	264481274
237107264212189	FOFANA	CAMARA	Vanina	33 Rue de Jouy Paris	125548762
251020364469865	SAUNIER	FERNANDEZ	Kenny	32 Rue la Feuillade Paris	125548762
122125838145935	BONIN	BARTHELEMY	Jean-Louis	9 Rue de la Colombe Paris	157845587
242048258949364	BARBOSA	CHAUVET	Fleur	44 Rue de l Amiral Coligny Paris	125548762
256123186185406	HENRY		AlexM	17 Rue Dupetit Thouars Paris	125884787
179045444422744	RUIZ		Estelle	8 Rue des Coutures Saint Gervais Paris	125884787
166062449407106	BECKER	LUCAS	Rodolphe	47 Rue Adolphe Jullien Paris	125548762
233087289261865	JANVIER	LACOSTE	Murielle	2 Rue de Sevigne Paris	157845587
197069985519854	LEROUX	BAUDOUIN	Solange	49 Rue Courtalon Paris	264481274
190029314791340	MILLET		José-Maria	22 Rue de Montpensier Paris	125548762
227126597924105	LEJEUNE		Stuart	6 Rue des Forges Paris	157845587
157121022621522	RIBEIRO		Johnny	35 Rue des Halles Paris	125884787
143092918371476	ROBERT	MANCEAU	Leonardo	38 Rue de Choiseul Paris	125884787
222042520288908	CANO	MARTEL	Karen	6 Rue des Capucines Paris	125884787
202071437767230	SERGENT		Guido	9 Rue d Argout Paris	157845587
189086144171587	MARAIS		Brian	39 Rue Bernard de Clairvaux Paris	125884787
256063692412136	BESSON		Thomas	37 Rue Danielle Casanova Paris	125548762
170086700455011	DEVAUX		Jean-Eudes	18 Rue des Panoramas Paris	264481274
131057674892840	LY	MICHON	Jean-Claude	23 Rue de la Bucherie Paris	264481274
240023495790364	DAMOUR		Diana	13 Rue Édouard Colonne Paris	125548762
255035172533923	LECUYER		Marylou	39 Rue Censier Paris	125884787
268014305680881	BASSET	SERRE	Théophile	10 Rue de la Vrilliere Paris	264481274
272065307866110	ROUSSET	LAROCHE	Lucile	3 Rue Malus Paris	125884787
165094296199095	DIAZ	PARMENTIER	Heinrich	36 Rue Ortolan Paris	125884787
255049439681923	CHAMPION	BAUDOUIN	Jean-Louis	45 Rue Portefoin Paris	264481274
121079926115784	LOPEZ	RIGAUD	Clémence	35 Rue Perrault Paris	264481274
179063322934496	LAMOTTE	BRIAND	Mercedes	11 Rue de la Vrilliere Paris	264481274
138122160748934	LEGRAND	DIALLO	Isaac	17 Rue Dussoubs Paris	264481274
231090596408156	MAHIEU	DESCAMPS	Allen	39 Rue de la Tacherie Paris	125548762
286109172934315	VILLARD		Eduardo	15 Rue Basse Paris	125884787
271077285006735	PELLERI	GODIN	Lila	43 Rue Charles V Paris	157845587
265127996967450	RIOU	GAUTIER	Damien	28 Rue de l Oculus Paris	125548762
190075925899731	LAINE	JOSEPH	Ernest	13 Rue du Sommerard Paris	125548762
120119820079715	LEMAIRE		Anne-Gaëlle	28 Rue Thouin Paris	125548762
271125052129400	MOULIN	RICARD	Laetitia	50 Rue Clemence Royer Paris	264481274
155035914169601	SYLLA	TORRES	Marie-Laure	47 Rue Greneta Paris	264481274
287120454199264	TRAORE		Andrée	43 Rue Eginhard Paris	264481274
196099311916690	CORNET		Daniela	33 Rue de l Epee de Bois Paris	157845587
278090644287533	GEOFFROY	THIBAULT	Flavien	9 Rue du Petit Moine Paris	125884787
109083319834772	LANG	ETIENNE	Christine	49 Rue des Gravilliers Paris	157845587
133052277550638	HUE	SANTIAGO	Marie-France	3 Rue Saint Medard Paris	125884787
226084549434468	MANGIN		Jean-Eudes	49 Rue d Aboukir Paris	264481274
292121669134423	POISSON		Reza	29 Rue Saint Medard Paris	264481274
253024126306890	DUFOUR	PIERRE	Geneviève	43 Rue Saint Jacques Paris	157845587
238029027037430	DE ALMEIDA		Jérémie	38 Rue Lhomond Paris	125548762
228082057152542	FAURE		Emannuele	21 Rue des Pretres Saint Severin Paris	125884787
125117547327936	AUBIN		Erika	12 Rue Quincampoix Paris	264481274
290035800595956	BOUCHE	BINET	Peter	3 Rue de l Amiral Coligny Paris	125884787
254107648685692	ADAM	YILDIZ	Marjolaine	34 Rue Boucher Paris	125548762
147068405424686	LOISEAU	GUIBERT	Leonardo	49 Rue de l Oculus Paris	125548762
201122582689823	FABRE	VACHER	Laurence	31 Rue de Marengo Paris	125884787
234042399113177	TISSOT		Anna-Lisa	7 Rue des Forges Paris	125548762
166036483219145	BARBE		Georgette	27 Rue de Marivaux Paris	157845587
257074140156085	GEORGES		Lucas	35 Rue du Petit Moine Paris	125884787
241102233744196	BONNET		Charles-Marie	45 Rue Pernelle Paris	125884787
235041796027551	BOIS	BEGUE	Marc	3 Rue de Braque Paris	125884787
280030696037033	GONZALEZ	ALVES	Loriane	11 Rue de l Ave Maria Paris	125884787
258052232199718	WEBER	ALEXANDRE	Christine	43 Rue du Pere Teilhard de Chardin Paris	125884787
195089048997652	GRANGE		Rudi	49 Rue Paul Dubois Paris	125548762
224012297078722	LECOMTE		Virginia	17 Rue Sainte Anne Paris	125548762
133096044501013	BESSON		Eliane	34 Rue de l Epee de Bois Paris	264481274
105079641276488	GALLET		Florence	5 Rue Massillon Paris	125884787
265037138611063	PERRIN		Gerhard	5 Rue Champollion Paris	264481274
269061340475625	BOUVET	TRAN	Malika	7 Rue d Argout Paris	264481274
289038293978883	BERTHET		Jacky	44 Rue Bachaumont Paris	125548762
118097743275289	BELLANGER	CASTEL	Marcel	33 Rue Mauconseil Paris	157845587
268102515480863	THIBAULT		Grâce	23 Rue Paillet Paris	125548762
262017315373034	DIOP		Samantha	49 Rue Rataud Paris	264481274
275115595725603	GUYON		Évelyn	24 Rue Bernard de Clairvaux Paris	264481274
168117966463592	PINTO		GabyM	7 Rue Villehardouin Paris	157845587
294015158916742	MESSAOUDI	PAPIN	Claudie	29 Rue du Val de Grace Paris	157845587
229049188967727	BAILLY	DUMOULIN	Margareth	4 Rue Jean Lantier Paris	125548762
248020336265548	PONCET	LELEU	Émilia	33 Rue Villehardouin Paris	125548762
261061517818802	LEBEAU		Sonya	29 Rue Jussieu Paris	125884787
218067839543144	DE SOUSA	DUVAL	Kadyja	28 Rue Vauquelin Paris	125548762
137035076043920	LACOSTE		Martino	8 Rue des Bourdonnais Paris	157845587
277029962435780	BOURGUIGNON		Elvire	33 Rue des Dechargeurs Paris	125884787
187050790840456	GIL		Annie-Claude	12 Rue des Francs Bourgeois Paris	125884787
258016165795720	MAYER	BONNET	Jean-Dominique	23 Rue du Figuier Paris	125548762
284075289727096	GUILBERT	ROCHER	Raffaël	1 Rue de Bazeilles Paris	157845587
238100948951460	BERTHET		Marie-Michelle	37 Rue des Irlandais Paris	157845587
264127794964901	GARNIER	RENAULT	Susan	47 Rue de Beaujolais Paris	125548762
217015419621733	LAURENT		Adolf	23 Rue des Lombards Paris	125884787
150036510918192	TORRES		Pierre-Marc	39 Rue de Bievre Paris	264481274
147094894800840	PERRIN	FOURNIER	Rosalie	14 Rue de Poitou Paris	125548762
203054662307902	LAUNAY	ARNOUX	Aline	22 Rue des Capucines Paris	125884787
243102394343966	LOMBARD		Thomas	5 Rue Toullier Paris	264481274
235015710631442	GUEGUEN		Émilia	44 Rue Beauregard Paris	125884787
139028752544809	MARTY		Chiara	8 Rue des Arquebusiers Paris	125548762
292110340538775	MUNOZ		Anna-Lisa	33 Rue Fustel de Coulanges Paris	264481274
172044633042546	BARBIER		Laurencia	32 Rue de Port Mahon Paris	264481274
272074630342514	DUARTE		Éliza	9 Rue Papin Paris	157845587
205106177189757	ARMAND		Lucio	36 Rue Chanoinesse Paris	157845587
163095683355072	MAUGER	FOFANA	Lucile	50 Rue Maitre Albert Paris	125884787
118066904629610	GODARD	ESNAULT	Paule	21 Rue du Haut Pave Paris	125548762
293097683511915	CHOLLET	GRANDJEAN	Maxime	35 Rue Ferdinand Duval Paris	125548762
288019756939738	ZIMMERMANN	EVRARD	Arnault	23 Rue Mehul Paris	125884787
171125291347716	RODRIGUEZ		Abderrahim	27 Rue Sainte Anne Paris	125884787
118055407721077	GONCALVES		Georges-Michel	31 Rue des Tournelles Paris	264481274
209086618622243	DELAGE	TECHER	Aïcha	31 Rue Leopold Bellan Paris	125548762
211052198016337	BECK		Hervé	6 Rue Portefoin Paris	157845587
269041356249776	LEFEVRE		Gilles-Marie	31 Rue Sainte Opportune Paris	157845587
166084097850130	CARDOSO		Fabiola	24 Rue des Colonnes Paris	157845587
239129600838387	DA COSTA		Andrew	48 Rue du Temple Paris	157845587
144020579570087	CORTES		Aimée	10 Rue des 4 Fils Paris	264481274
157076554613448	AUBIN	VERGER	Pierrick	5 Rue Berthollet Paris	125548762
160078524507383	BOULET	GRIMAUD	Jean-René	2 Rue du 29 Juillet Paris	264481274
157129459270583	SALAUN	LESAGE	Isabelle	39 Rue Soufflot Paris	125548762
197028070992122	BODIN		Sylvain	48 Rue d Argenteuil Paris	125548762
225106058149347	WINTERSTEIN	AUVRAY	Florent	2 Rue de la Montagne Sainte Genevieve Paris	157845587
153022679819804	MAILLARD	MAITRE	Aimée	38 Rue d Argenteuil Paris	157845587
122117120832828	AFONSO	GUERIN	ClaudeM	27 Rue Gomboust Paris	264481274
108105169006820	GUY		Wladimir	41 Rue de l Oratoire Paris	264481274
133085507042722	BATAILLE	DIOP	Djamila	34 Rue des Pyramides Paris	125884787
299032100194543	PONS		Marie-Sophie	35 Rue du Grand Veneur Paris	157845587
285111122122687	VIEIRA		Anaïs	37 Rue Lacepede Paris	264481274
105111064681116	KLEIN		Jean-Patrick	41 Rue Massillon Paris	125548762
106069855306956	CORTES	LERAY	Olympia	2 Rue du Vertbois Paris	125884787
235025043023266	VAILLANT	JARRY	Jean-Antoine	23 Rue Beranger Paris	125884787
259031305534854	LAFON	LEGER	Klaus-Werner	19 Rue de la Lingerie Paris	264481274
164018247653927	LE ROUX		Ludiwine	35 Rue de la Paix Paris	157845587
255111462999163	COURTIN	MARCHAL	Kathleen	8 Rue de l Abbe Migne Paris	264481274
149016464115574	CHARRIER	GIRAUD	Roxane	48 Rue de Louvois Paris	125884787
218028916522993	HAMELIN		Marcel	29 Rue de la Ferronnerie Paris	125548762
132104189563779	BOIVIN		Jenny	6 Rue Dante Paris	125884787
103078742854508	FELIX		José-Maria	19 Rue du Roule Paris	264481274
219010336879126	RAULT		Clara	17 Rue des Precheurs Paris	125548762
216080798565109	FELIX		Peggy	5 Rue de Cluny Paris	125548762
176038914084519	MARTY	LACOMBE	Diego	15 Rue Gabriel Vicaire Paris	125884787
274016315753078	COULON	GIRAUD	Jean-Pierre	12 Rue Lacepede Paris	125548762
206064171467425	GAUDIN		Odile	10 Rue Saint Denis Paris	157845587
286059858756226	THIERY	LEBLANC	Otto	7 Rue la Feuillade Paris	264481274
144104148447610	LAINE	SIDIBE	Virginia	1 Rue des Archives Paris	125548762
169041874795154	AUGER		Salvator	39 Rue des Francs Bourgeois Paris	125548762
129092551504840	DUPUIS		Roberto	3 Rue de la Huchette Paris	125884787
170104318565314	GEOFFROY		Sébastien	19 Rue de la Ville Neuve Paris	157845587
274114292533681	NOEL	TISON	Jean-Henri	17 Rue de Bievre Paris	264481274
237072348150692	LABBE	DUMOULIN	José-Maria	28 Rue Borda Paris	157845587
283124902489728	BERARD	PAPIN	Eléonore	29 Rue des Minimes Paris	125548762
140010920647767	BRIERE		Fabio	39 Rue Massillon Paris	157845587
174054333800157	VERDIER	TOUSSAINT	Marylou	11 Rue Sainte Croix de la Bretonnerie Paris	157845587
236033297541443	MERCIER		Salvador	36 Rue des Degres Paris	125884787
117072352261008	CHATELAIN	CAMUS	Tommy	25 Rue Agrippa d Aubigne Paris	264481274
253108676231602	RAGOT		Jeannette	28 Rue du Foin Paris	125548762
214048310374407	JOLLY	GERARD	Abdelah	22 Rue de la Reynie Paris	157845587
283034579380856	KLEIN		Philomène	40 Rue de Lutece Paris	125884787
138111930540163	GUYON		Tiffany	9 Rue Vauvilliers Paris	125884787
239040683301450	BOUVET		Guido	22 Rue des Juges Consuls Paris	157845587
220079068523025	BOUCHE		Marjorie	9 Rue Saint Martin Paris	264481274
142112061521891	LEMOINE		Aymeric	27 Rue du Pont Neuf Paris	125884787
228102829065978	CHAUVEAU		Eloïse	27 Rue du Cygne Paris	264481274
108034713413292	SERGENT	DUCHENE	Benoît	49 Rue de la Cerisaie Paris	125548762
161114713933201	FERREIRA	SLIMANI	Jean-Eric	25 Rue Geoffroy l Asnier Paris	125548762
271024262039407	PINTO		Agathe	12 Rue du Petit Musc Paris	264481274
116071026258730	DUMAS		Tania	41 Rue de Richelieu Paris	125884787
104096864772049	COLAS	LECLERE	Sara	11 Rue des Piliers Paris	125548762
290054393404594	HUBERT		Diane	26 Rue Cloche Perce Paris	264481274
299083781186978	LECOCQ		Marie-Josée	6 Rue des Colonnes Paris	125548762
197104772238319	BESNARD	BRUNO	Willy	13 Rue du Prevot Paris	157845587
221021276653204	CHEVALIER		Morgan	16 Rue Vauvilliers Paris	125884787
134026849374442	LAPORTE		Roderick	3 Rue Etienne Marcel Paris	157845587
133119344929516	BRAULT	FERNANDEZ	Leslie	15 Rue Saint Germain l Auxerrois Paris	125884787
166049821238905	BLAISE		Kelly	14 Rue Cambon Paris	125548762
102046285253211	FAVRE	MASSE	Rudolph	39 Rue de la Banque Paris	157845587
137121652381278	LECUYER		Francis	17 Rue du Renard Paris	125548762
155077696371044	JACQUIN		Fiona	22 Rue de Damiette Paris	264481274
161010244798916	GEOFFROY	WINTERSTEIN	Jean-Didier	9 Rue d Uzes Paris	125548762
151110869486625	FOFANA	PONCET	Malcolm	24 Rue Toullier Paris	125548762
277044366026913	CORRE		Jean-Clément	7 Rue Gretry Paris	125548762
144035676655040	BERNARD		Charlie	33 Rue Poulletier Paris	157845587
189098056291549	BON	VAILLANT	Pierre-Louis	15 Rue Saint Victor Paris	264481274
278089373283395	LAMOTTE	VINCENT	Grégoire	35 Rue du Vertbois Paris	157845587
178071952498324	PETIT		Walterqqqqq	18 Rue Vaucanson Paris	157845587
156074123250805	LUCAS	DERRIEN	Jean	17 Rue Cochin Paris	157845587
135110615927304	BOULANGER		Joachim	2 Rue des Precheurs Paris	264481274
248069614540301	MAGNIER		Maryline	1 Rue des Tournelles Paris	157845587
148069830978569	PONS		Helen	12 Rue Perrault Paris	125548762
212060310868943	BARTHELEMY		Jean-Lucien	23 Rue Sainte Anne Paris	264481274
162058741598167	ESNAULT		Gildas	29 Rue de la Petite Truanderie Paris	125548762
169097507276185	FONTAINE	LEROY	Marie-Angèle	16 Rue de Mondovi Paris	125884787
205095024579593	FERRY	BONNIN	Line	19 Rue Saint Joseph Paris	264481274
299048039616883	MOUTON		Léopold	33 Rue de Marivaux Paris	125884787
224081724300171	MONTEIRO	RODRIGUEZ	Aurélie	21 Rue de la Bastille Paris	125548762
150060303807110	GERMAIN	CISSE	Coralie	13 Rue Bailleul Paris	125548762
126109435891127	VERDIER	DUMONT	Anny	30 Rue de la Paix Paris	264481274
275063951087350	DANIEL		Marcel	25 Rue de Rohan Paris	264481274
194015343162633	FERRAND		Renée	41 Rue de Turenne Paris	125884787
251119575893548	PARISOT		Cécile	2 Rue de l École Polytechnique Paris	157845587
154068499542428	DURET		Raymonde	6 Rue des Fosses Saint Marcel Paris	157845587
141079769804035	JOLLY	MAITRE	Ange	25 Rue Crillon Paris	125548762
101056300934406	GUYOT	MAILLOT	Dieter	1 Rue Frédéric Sauton Paris	125884787
240073988379421	GONCALVES		Constantin	36 Rue des Arenes Paris	125884787
260111580647383	LEFEUVRE		Jimmy	16 Rue des Petits Champs Paris	157845587
120056823338977	LAMY	FERRY	Muriel	5 Rue Sainte Anastase Paris	264481274
119109623992764	LAROCHE	LEGRAND	Antoinette	21 Rue Paillet Paris	125548762
101039612534949	DUBOIS		Bérengère	4 Rue des Blancs Manteaux Paris	264481274
239023073644392	ALLARD		StefanM	12 Rue d Alexandrie Paris	157845587
203017476426702	HUET		Tanguy	1 Rue Dussoubs Paris	125884787
252106418593026	LEONARD		Ian	33 Rue de la Coutellerie Paris	157845587
252092112764860	BARON		Jacky	19 Rue de Tracy Paris	125884787
189014693292991	BARBIER		Josephus	23 Rue Sainte Foy Paris	125884787
157070363992818	BOUCHE		GianniM	35 Rue de la Vrilliere Paris	157845587
195106011080181	BOUTET		Daniela	29 Rue Adolphe Adam Paris	125548762
182084477498741	ROBIN	FOUQUET	Kevin	50 Rue des Patriarches Paris	264481274
253095437283501	CORNU	SAHIN	Michel-Philippe	10 Rue de Franche Comte Paris	125548762
229097103116120	HONORE		Line	24 Rue Berger Paris	125548762
203038685064147	LEMONNIER		Monique	39 Rue Bude Paris	125884787
244106583543744	BONHOMME		Anne-Claire	45 Rue Monsigny Paris	264481274
137011911189687	BLANC	LACOUR	Abdelaziz	47 Rue de Louvois Paris	125548762
127015812688118	DELMAS		Jeanne	1 Rue du Chevalier de Saint George Paris	264481274
174126989550917	ESNAULT	MARION	Marco	22 Rue Saint Germain l Auxerrois Paris	125884787
148071526597476	REYNAUD	FRANCOIS	Sergio	33 Rue Barbette Paris	157845587
206067332177665	MOREL		Rosanna	42 Rue de Marivaux Paris	157845587
265053211557745	BAUDOUIN		Magdeleine	31 Rue Laplace Paris	125548762
262016873894611	ROUSSEL		Jean-Olivier	3 Rue des Moulins Paris	264481274
171066719027259	GUY	BERTHELOT	Jonas	25 Rue Reaumur Paris	125548762
267109108065202	BRAULT		Jessica	40 Rue de Moussy Paris	125548762
266019956812570	BECK	BOUVIER	Carlo	34 Rue de Louvois Paris	125548762
252111777841915	MILLOT		Jean-André	2 Rue du Marc des Blancs Manteaux Paris	157845587
164038608632119	MARTEL		Jean-Baptiste	9 Rue de Richelieu Paris	157845587
131101434250337	MESSAOUDI		Jeannine	6 Rue de la Sourdiere Paris	157845587
230124336513645	DORE		Marie-Agnès	9 Rue de la Paix Paris	125884787
212051079375206	MEUNIER		ClaudeM	10 Rue Paul Dubois Paris	157845587
207036199333762	GILBERT	LEPAGE	Fabio	4 Rue Soufflot Paris	157845587
195039969007673	SANTIAGO		Karin	4 Rue Claude Bernard Paris	264481274
221029479428090	SCHMIDT	ROGER	Nina	2 Rue de l Hôtel Colbert Paris	125548762
110066257611314	TISON	COLIN	Anne-Catherine	11 Rue Baltard Paris	264481274
223078053552461	RAYNAUD	LEVASSEUR	DanyM	13 Rue Pierre Au Lard Paris	157845587
114066535520356	SENECHAL		Joselaine	35 Rue Champollion Paris	264481274
243017583288790	JIMENEZ	RICHARD	Warren	13 Rue Feydeau Paris	157845587
202024773805862	MOUTON		Freddy	4 Rue de Rohan Paris	264481274
201073789759321	BONNIN		Sofia	49 Rue des Filles du Calvaire Paris	125884787
266073845226430	WINTERSTEIN	MARTINET	Eudes	34 Rue Molière Paris	125884787
145056354127107	CHARRIER	CHEVALLIER	Catherine	22 Rue Rambuteau Paris	125548762
199010342734983	LESUEUR	FOUCAULT	Aurélie	26 Rue des Vertus Paris	264481274
204036557077489	DRAME		Kenneth	12 Rue Sauval Paris	264481274
289040697244116	BECKER		Anne-Gaëlle	17 Rue du Cinema Paris	264481274
138084307765388	FLEURY	MAURIN	Juliana	27 Rue Montmartre Paris	125884787
245106940503490	COURTIN	MARION	Robin	37 Rue de la Cite Paris	264481274
179073352261725	ROCHE	CHEVALLIER	Amel	10 Rue Conte Paris	264481274
298032738731346	JOSEPH		Gaston	28 Rue des Fosses Saint Bernard Paris	125884787
243082614270684	FOUQUET		Anna	48 Rue des 4 Fils Paris	125884787
255086087623452	CHRISTOPHE		Nathanaël	31 Rue Bailly Paris	157845587
144015615260843	BUREL	NICOLAS	Emma	20 Rue Pierre Brossolette Paris	157845587
212101169913710	STEPHAN		Marylou	29 Rue de la Ferronnerie Paris	125548762
195068695146738	GOMIS	MICHELET	Honoré	8 Rue Clovis Paris	125548762
180088976677729	TECHER		Madiha	3 Rue Notre Dame de Recouvrance Paris	125548762
109015975211104	NAVARRO		Eugène	11 Rue Massillon Paris	125884787
110114341425639	BECK		Daphné	12 Rue Jean de Beauvais Paris	264481274
184059224569363	LAURET	DELMAS	Marthe	49 Rue Saint Augustin Paris	264481274
269071637551546	HAMEL	DUCLOS	Pierre-Eric	7 Rue Neuve Saint Pierre Paris	157845587
206033830025756	BAZIN		Alberto	14 Rue Malebranche Paris	157845587
258112655293107	LE BIHAN		Nora	50 Rue de Franche Comte Paris	264481274
157054327406685	MARCHAND		Claire	14 Rue des Prouvaires Paris	125884787
258086115253449	PONCET		Raymond	11 Rue Reaumur Paris	264481274
122128399094364	SILVA		Richard	27 Rue Bassompierre Paris	125548762
148069955003476	GAUTIER		Moïse	22 Rue de la Michodiere Paris	125548762
180020359139629	SERRA	GODET	Fabio	43 Rue Coq Heron Paris	125548762
121034314107191	MACHADO	CHEVALIER	Salma	4 Rue Gracieuse Paris	264481274
227024560069053	MOHAMED	BLAISE	Jonas	14 Rue Neuve Saint Pierre Paris	264481274
156060915698166	GILBERT		Yasmina	8 Rue Baillet Paris	125884787
177103352992307	VERNET		Madeline	8 Rue du Marche Saint Honore Paris	125884787
255099147198042	BARRET		SandyM	9 Rue Tiquetonne Paris	125548762
173088238558496	JACQUET	ROMERO	Reza	45 Rue Frédéric Sauton Paris	157845587
156119474815307	BASTIEN		Éliza	5 Rue Beautreillis Paris	264481274
166081296763649	MACHADO	LAVERGNE	Lise	3 Rue Descartes Paris	125884787
136071847516617	DOS SANTOS		Didier	7 Rue d Aboukir Paris	264481274
251011333261627	BERTIN	HUE	Sunny	35 Rue du Parc Royal Paris	157845587
138074248401105	MARTY		Allan-David	13 Rue de Braque Paris	157845587
140119959250877	VERNET		Théophile	31 Rue Saint Merri Paris	125884787
172051108200956	NICOLAS	DAMOUR	Fabrizio	32 Rue du Marche des Patriarches Paris	125884787
134053265437083	MORENO		Ahmed	24 Rue Monge Paris	125884787
198111260505320	COUTURIER		Henriette	26 Rue Georges Desplas Paris	264481274
256074987484479	FISCHER	ROYER	Francis	12 Rue des Piliers Paris	125548762
199127252136345	MAUREL		Manfred	13 Rue de Venise Paris	125884787
262038778938203	LOMBARD		Anne	26 Rue Clovis Paris	157845587
282066379868584	DUMOULIN		Lucille	8 Rue de Bretagne Paris	125884787
233109092062205	FAVIER		Lucie	8 Rue Chanoinesse Paris	157845587
176106513315003	GAUDIN		Sandra	24 Rue Etienne Marcel Paris	157845587
180057367414637	HOFFMANN	GODET	Ernest	10 Rue Feydeau Paris	264481274
117121559056457	CHAMPION	GODARD	Jean-Eudes	7 Rue de la Perle Paris	157845587
240022636962670	CHOLLET	DUVAL	Pierre-Arnaud	35 Rue des Fosses Saint Jacques Paris	125548762
266025004527670	GIBERT		Anne-Gaëlle	22 Rue de Rivoli Paris	157845587
277122777128078	LEMAIRE		Josée	22 Rue Monge Paris	125884787
160025901759025	AUBRY	VACHER	Peguy	40 Rue Linne Paris	264481274
127081156734983	SELLIER	VALLEE	Colin	50 Rue des Orfevres Paris	125548762
288119690626128	FORT		Éloïse	16 Rue Malebranche Paris	264481274
101073163220911	CORDIER	PONCET	Jacky	26 Rue des Archives Paris	125884787
286058534258713	BOURGUIGNON		Laurent	31 Rue de la Sorbonne Paris	125548762
149061136795769	LECLERC		Slimane	26 Rue de Jarente Paris	264481274
245070516446550	HUE		Gianfranco	9 Rue des Piliers Paris	125884787
230026753623669	MAHIEU	BOCQUET	Francine	48 Rue Roger Verlomme Paris	264481274
102035825373803	AUBERT	GODET	Clara	34 Rue de la Michodiere Paris	157845587
180028509811169	MEUNIER	SOLER	Marcellin	43 Rue Saint Philippe Paris	125548762
216074033954453	LASSERRE		Yvonne	17 Rue des Filles Saint Thomas Paris	157845587
293094751937192	MAILLOT	WAGNER	Jean-Joël	28 Rue Pecquay Paris	125884787
147061886221913	VALLEE	SOW	Émeline	2 Rue Aubriot Paris	264481274
223028798999363	COUSIN	LE GALL	Malcolm	30 Rue Charlot Paris	125548762
232052892461325	ROGER	CHARBONNIER	Yvon	47 Rue de Turenne Paris	125548762
101120424360755	SABATIER	LECOMTE	Emmanuelle	45 Rue Ferdinand Duval Paris	125884787
221067551980230	ESNAULT		Christian	31 Rue Aux Ours Paris	125884787
218015653051373	RIBEIRO		Anny	27 Rue de l Estrapade Paris	125548762
240114616700691	NAVARRO		Amina	24 Rue du Marche Saint Honore Paris	125548762
193077753289249	PASQUET	GRANGE	Raphaëlle	27 Rue Adolphe Jullien Paris	125548762
265116744621785	PERRIN		Francine	45 Rue Reaumur Paris	125548762
242043149777286	ETIENNE		Gilles	45 Rue Pierre Brossolette Paris	125884787
133057095110202	WEBER		Jean-François	17 Rue Vivienne Paris	264481274
219065678886179	DESHAYES		Yves-François	47 Rue Saint Paul Paris	125884787
296025362844675	LENOIR		Marie-Reine	5 Rue Poulletier Paris	125548762
119118453408165	ROUXEL		Ronald	14 Rue des Fosses Saint Jacques Paris	264481274
235051633057734	GUILLOU		Roland	39 Rue Adolphe Adam Paris	157845587
278090615498741	RODRIGUES		Isaac	49 Rue de Richelieu Paris	125548762
147106883665481	COLAS		Raffaël	21 Rue Scipion Paris	125884787
167087766989559	LUCAS	DUVAL	Patrizia	42 Rue de la Perle Paris	125884787
291031559371140	GONZALEZ		Rudolf-Jan	28 Rue Saint Martin Paris	264481274
247087976437659	FRANCOIS	JULIEN	Rudolf-Jan	9 Rue de Navarre Paris	125884787
195091425437937	VALETTE		Leonardo	16 Rue de la Banque Paris	125548762
194060824711882	CHABOT	GUILLAUME	Joachim	49 Rue de Marivaux Paris	264481274
292032841511432	GAUDIN		José	10 Rue Cloche Perce Paris	125884787
185098166371591	GABRIEL		Axelle	12 Rue Rataud Paris	264481274
246029028617827	MAILLOT		Benaïcha	13 Rue Coq Heron Paris	157845587
221067001545141	BERTIN	LEFRANCOIS	Lucien	18 Rue du Cinema Paris	264481274
200125523886081	DUCHESNE		Sami	19 Rue François Miron Paris	264481274
260094752288347	WAGNER	BLAISE	Gildas	43 Rue des Moulins Paris	157845587
281036969136109	LEMAITRE		Norman	36 Rue Lulli Paris	157845587
272070106053457	PASQUIER		Marjolaine	8 Rue Necker Paris	264481274
199063889574962	GABRIEL		Petrus	19 Rue Saint Marc Paris	125548762
145021483919530	JEANNE	LAURET	Michael	41 Rue des 4 Fils Paris	264481274
175025581397787	LAFLEUR		Lucile	39 Rue Cherubini Paris	264481274
195015259294765	RICARD		Jean-Baptiste	25 Rue des Haudriettes Paris	125548762
157014415900863	BRUNEAU	VIVIER	Carole	1 Rue Perrault Paris	264481274
189058437714714	LEGRAND	COSTE	Marie-Madeleine	14 Rue de la Coutellerie Paris	157845587
205061346129578	BERTHE		Luigi	16 Rue du Caire Paris	125548762
287110819788543	LEMOINE	MAUREL	Diogo	32 Rue de Castiglione Paris	125548762
230112913478191	NICOLAS		Michelle	42 Rue Linne Paris	157845587
194108897647962	HAMELIN		Otto	39 Rue Clovis Paris	125548762
278033263543368	VIEIRA		Ugo	46 Rue Colbert Paris	125548762
\.


--
-- Data for Name: possede; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.possede (patient, allergie, dated, datef) FROM stdin;
102099406908259	PENIC	2019-07-18	\N
160099160424193	POILE	2015-02-01	\N
160099160424193	GLUTN	2018-07-24	\N
160099160424193	ASPIR	2021-11-18	2021-11-18
160099160424193	MOISI	2020-08-08	\N
260070857162645	POILE	2018-05-07	\N
260070857162645	BEE	2019-12-10	2019-12-23
296060410603476	LAV	2018-02-22	\N
110075202910187	MOISI	2018-08-03	\N
110075202910187	GLUTN	2019-07-03	2019-12-19
110075202910187	LAV	2019-08-13	2019-10-02
110075202910187	POILE	2015-03-11	2021-05-01
110075202910187	GUEPE	2018-11-05	\N
256105595097885	ARA	2020-12-02	\N
256105595097885	LAV	2020-03-23	\N
256105595097885	ASPIR	2019-10-27	\N
256105595097885	BEE	2016-01-08	\N
256105595097885	POILE	2016-07-22	2016-12-25
214072889800551	lATEX	2018-12-12	\N
214072889800551	GLUTN	2015-03-19	2016-10-25
193012735171474	BEE	2016-11-07	2021-11-08
152027306574655	POILE	2020-10-19	2020-10-25
152027306574655	GUEPE	2020-10-03	2020-12-23
152027306574655	LAV	2017-06-16	\N
152027306574655	lATEX	2019-05-16	\N
279061486384848	ASPIR	2017-09-02	\N
279061486384848	BEE	2016-03-18	2018-09-14
279061486384848	GUEPE	2017-05-07	2020-06-12
279061486384848	POILE	2021-08-22	\N
114046512153391	BEE	2015-07-16	2017-08-22
114046512153391	MOISI	2019-04-07	\N
277092607082177	POLN	2016-03-14	\N
277092607082177	POILE	2015-03-11	2021-02-22
277092607082177	lATEX	2021-08-11	2021-10-18
277092607082177	LAV	2015-06-28	\N
299072728963532	POILE	2017-09-24	\N
299072728963532	GLUTN	2018-01-22	2020-09-11
299072728963532	BLATE	2021-02-23	2021-02-26
275033015197248	ARA	2017-03-16	2021-10-25
199073894063622	LAV	2017-03-13	\N
199073894063622	ARA	2017-02-13	\N
199073894063622	ASPIR	2015-04-03	2021-09-05
199073894063622	GLUTN	2021-07-08	2021-09-20
261037687526684	PENIC	2018-11-03	2020-06-15
174054006457994	POILE	2017-01-08	2019-06-26
174054006457994	ASPIR	2019-02-04	2021-05-21
174054006457994	GLUTN	2016-08-16	2018-09-18
174054006457994	MOISI	2017-02-26	\N
129096634267071	ASPIR	2017-05-21	\N
129096634267071	PENIC	2016-02-08	2021-01-26
129096634267071	LAV	2020-04-06	\N
129096634267071	POLN	2017-01-03	2017-06-06
129096634267071	BLATE	2021-08-23	2021-10-11
289117971785167	LAV	2021-02-22	\N
289117971785167	MOISI	2020-10-04	2020-10-28
289117971785167	lATEX	2016-08-18	2021-10-08
289117971785167	POILE	2021-01-13	2021-06-26
142101422071437	ARA	2019-04-08	\N
268125207178893	MOISI	2018-10-28	2019-10-28
268125207178893	ASPIR	2016-02-25	2016-12-22
268125207178893	ARA	2020-10-17	2020-10-26
268125207178893	PENIC	2019-05-25	\N
200047009218824	LAV	2020-12-21	2020-12-25
200047009218824	BLATE	2020-06-28	2020-09-11
143019800299320	PENIC	2017-11-04	\N
143019800299320	LAV	2020-08-03	\N
143019800299320	GLUTN	2016-10-12	2019-08-04
143019800299320	ARA	2018-09-25	\N
211074534119340	GUEPE	2018-08-02	\N
211074534119340	PENIC	2017-05-11	\N
211074534119340	POLN	2017-05-14	\N
272058275424815	lATEX	2017-01-26	\N
272058275424815	ASPIR	2016-04-08	2018-09-24
272058275424815	LAV	2015-05-13	2020-04-12
272058275424815	POLN	2017-10-25	2020-08-13
272058275424815	GLUTN	2019-05-05	\N
273129609433214	ARA	2020-06-22	2021-07-09
273129609433214	GUEPE	2019-07-05	2020-01-03
273129609433214	PENIC	2019-04-20	\N
273129609433214	LAV	2018-09-14	\N
273129609433214	lATEX	2017-09-02	\N
190103324064033	GUEPE	2018-02-07	2018-10-16
234097079083817	GUEPE	2021-04-24	2021-04-27
234097079083817	MOISI	2016-10-04	\N
234097079083817	GLUTN	2016-08-26	2021-05-28
136127094573707	MOISI	2018-03-23	\N
136127094573707	GLUTN	2018-12-20	\N
136127094573707	BLATE	2017-09-10	\N
136127094573707	BEE	2016-01-02	2018-09-11
155103596746626	POILE	2020-11-03	\N
191039387061932	BLATE	2021-04-16	2021-08-24
191039387061932	ASPIR	2017-02-14	\N
191039387061932	GLUTN	2019-01-21	2019-04-03
191039387061932	POILE	2015-01-22	2016-02-12
205088470224121	LAV	2016-11-03	\N
205088470224121	GLUTN	2019-02-24	2021-05-02
205088470224121	PENIC	2016-01-05	\N
168084074496066	ARA	2019-11-08	2021-05-15
168084074496066	MOISI	2018-11-07	\N
168084074496066	ASPIR	2017-08-04	2021-11-16
168084074496066	PENIC	2017-04-23	\N
295113751469259	BEE	2018-08-09	\N
295113751469259	ASPIR	2016-07-23	\N
295113751469259	BLATE	2018-08-16	\N
295113751469259	ARA	2019-12-27	\N
238113830884391	ARA	2021-11-15	2021-11-18
238113830884391	LAV	2018-08-21	2019-08-25
238113830884391	POILE	2021-11-13	\N
219023373245959	POLN	2021-04-25	\N
219023373245959	LAV	2018-12-15	2021-02-07
219023373245959	MOISI	2020-09-02	2020-09-09
219023373245959	lATEX	2021-11-16	2021-11-18
260079595038944	LAV	2016-06-12	2019-09-21
260079595038944	PENIC	2015-07-08	2015-08-12
260079595038944	BEE	2015-02-13	2015-04-01
260079595038944	GLUTN	2018-09-08	2018-10-04
269017040525206	ASPIR	2016-01-23	2021-02-12
269017040525206	LAV	2016-09-12	\N
269017040525206	MOISI	2019-09-19	\N
269017040525206	PENIC	2016-02-17	2021-01-26
269017040525206	BLATE	2016-05-06	\N
236056972976895	lATEX	2020-08-01	2021-09-10
236056972976895	BLATE	2018-07-06	\N
236056972976895	PENIC	2015-03-21	\N
236056972976895	BEE	2017-03-19	\N
236056972976895	ASPIR	2015-06-21	\N
110026458507876	POLN	2021-04-03	2021-07-02
138114541205136	lATEX	2017-09-10	2021-03-17
138114541205136	MOISI	2016-01-22	\N
138114541205136	ARA	2019-11-12	\N
138114541205136	ASPIR	2021-10-05	\N
222038976800500	POLN	2017-09-04	\N
222038976800500	POILE	2021-06-21	\N
222038976800500	GUEPE	2018-08-10	2020-08-16
222038976800500	BLATE	2016-01-08	2016-10-07
272070825829025	PENIC	2019-08-09	2020-04-13
272070825829025	GLUTN	2021-02-25	2021-11-06
272070825829025	POLN	2021-05-24	2021-05-28
272070825829025	BLATE	2020-10-12	2021-03-21
157087167057385	ARA	2021-02-15	\N
157087167057385	lATEX	2017-12-11	\N
133032823100292	GUEPE	2016-12-02	\N
106119496166800	PENIC	2017-03-02	2020-09-22
106119496166800	GUEPE	2015-05-11	\N
106119496166800	BLATE	2018-07-03	2018-10-15
106119496166800	ARA	2015-05-25	\N
127115565413833	POILE	2018-08-26	\N
127115565413833	GUEPE	2016-10-28	2016-11-11
127115565413833	BLATE	2015-03-16	\N
127115565413833	LAV	2015-10-04	2016-10-16
188029343169600	GLUTN	2018-02-24	\N
188029343169600	LAV	2021-01-20	\N
188029343169600	ASPIR	2018-04-10	\N
116109407794060	POLN	2017-06-09	2020-12-16
116109407794060	POILE	2017-06-05	\N
116109407794060	GLUTN	2021-02-15	\N
116109407794060	BEE	2021-07-27	2021-11-17
208074951895256	BEE	2020-11-01	2020-11-15
208074951895256	GUEPE	2016-02-26	\N
208074951895256	GLUTN	2019-08-25	2021-02-27
208074951895256	ASPIR	2020-02-22	2021-08-14
262015291294848	POLN	2021-09-24	2021-10-03
262015291294848	GLUTN	2018-09-27	2021-07-19
262015291294848	lATEX	2018-01-22	\N
262015291294848	LAV	2018-04-23	\N
262015291294848	GUEPE	2020-05-17	\N
118087215592174	PENIC	2016-09-14	2016-09-28
234067373357213	LAV	2020-11-17	2020-12-07
234067373357213	GUEPE	2020-02-27	2021-04-04
188045887135447	MOISI	2016-06-04	2021-06-18
188045887135447	BLATE	2017-12-13	2019-05-02
188045887135447	POILE	2017-09-16	\N
188045887135447	ASPIR	2017-06-07	2020-01-12
188045887135447	lATEX	2019-03-26	\N
241080926692571	POLN	2015-03-25	\N
241080926692571	GUEPE	2021-05-04	2021-07-28
241080926692571	BEE	2017-12-25	\N
241080926692571	MOISI	2020-05-07	2021-05-19
264097854809707	POILE	2020-08-01	2020-12-06
264097854809707	LAV	2018-04-16	\N
264097854809707	ASPIR	2015-05-10	\N
264097854809707	MOISI	2017-11-13	\N
178111533112086	GUEPE	2016-09-15	\N
178111533112086	POLN	2017-11-02	\N
178111533112086	BEE	2019-01-22	2020-05-08
178111533112086	GLUTN	2020-07-09	\N
178111533112086	ARA	2015-04-06	2016-05-25
175015762007662	ASPIR	2015-12-18	2016-12-23
175015762007662	GUEPE	2015-06-15	2017-05-17
175015762007662	LAV	2020-04-10	2021-02-25
284053711527533	BLATE	2015-06-12	\N
284053711527533	PENIC	2016-01-21	\N
284053711527533	GUEPE	2019-08-07	\N
284053711527533	BEE	2015-12-09	2018-05-05
105050100550524	LAV	2018-06-22	2020-02-28
227064841682823	LAV	2017-01-08	\N
227064841682823	GLUTN	2020-05-28	\N
227064841682823	POILE	2017-12-12	2021-02-27
227064841682823	POLN	2021-04-03	2021-06-08
292109226948564	ASPIR	2020-06-09	\N
155095540067981	BLATE	2019-10-15	\N
155095540067981	PENIC	2018-10-16	2021-08-28
225125232448434	PENIC	2019-10-13	2020-03-12
257117887417480	ASPIR	2020-05-08	\N
257117887417480	MOISI	2020-12-26	2021-03-21
257117887417480	LAV	2017-03-25	\N
257117887417480	PENIC	2017-01-17	2019-06-04
257117887417480	GLUTN	2021-03-01	2021-07-22
225031944898819	BEE	2016-04-21	2019-11-04
225031944898819	POILE	2017-04-23	\N
225031944898819	PENIC	2016-01-27	\N
225031944898819	POLN	2021-01-09	\N
293079221586080	LAV	2021-01-14	2021-04-11
293079221586080	ASPIR	2015-04-28	\N
293079221586080	GUEPE	2016-08-11	2016-08-15
185092827286780	POILE	2021-06-28	\N
185092827286780	BEE	2019-02-20	2020-09-01
185092827286780	ARA	2017-02-14	\N
264043437527700	LAV	2020-08-28	\N
264043437527700	MOISI	2015-11-05	\N
264043437527700	BLATE	2018-12-05	2019-03-27
264043437527700	GLUTN	2021-11-08	2021-11-10
264043437527700	POLN	2018-08-05	\N
231046716894840	POLN	2016-08-05	\N
231046716894840	PENIC	2018-01-10	\N
231046716894840	ARA	2021-04-13	\N
231046716894840	GLUTN	2017-07-25	2021-02-20
140063743131455	PENIC	2018-02-14	2018-03-17
140063743131455	MOISI	2020-12-07	\N
140063743131455	POILE	2019-11-14	\N
140063743131455	lATEX	2015-06-24	\N
171022452464038	PENIC	2016-03-16	2019-06-25
171022452464038	GUEPE	2019-11-03	2019-11-08
171022452464038	GLUTN	2019-11-10	2019-11-10
171022452464038	lATEX	2015-11-18	2017-06-20
279097002609694	lATEX	2018-04-23	\N
279097002609694	ARA	2020-01-05	2020-01-08
279097002609694	GLUTN	2015-01-02	2020-09-05
279097002609694	LAV	2017-02-01	\N
279097002609694	PENIC	2021-05-23	2021-09-13
187070500246915	LAV	2015-07-22	2017-09-08
187070500246915	PENIC	2015-02-28	2021-11-17
187070500246915	MOISI	2016-05-04	2020-04-20
187070500246915	BLATE	2018-06-25	2021-09-20
187070500246915	POILE	2021-06-08	2021-11-04
110122942077957	lATEX	2019-05-28	\N
110122942077957	POILE	2017-03-28	2021-06-03
110122942077957	BEE	2017-08-18	\N
212072855963112	BLATE	2017-03-28	2019-07-22
262091838145236	ASPIR	2021-04-08	2021-11-16
262091838145236	PENIC	2016-04-26	2017-05-25
262091838145236	POLN	2017-08-24	\N
276029947381735	BEE	2016-08-23	\N
259078280957764	GLUTN	2015-05-21	2019-05-21
259078280957764	PENIC	2018-07-23	\N
291059430428428	ARA	2021-09-14	2021-10-15
254036634248290	LAV	2018-05-10	\N
254036634248290	POILE	2018-01-09	2018-01-14
199055493956493	lATEX	2019-01-07	\N
199055493956493	ARA	2020-06-21	2020-07-07
251044262482430	ASPIR	2016-10-21	2017-11-11
251044262482430	BLATE	2021-07-25	\N
251044262482430	GUEPE	2016-04-03	\N
251044262482430	lATEX	2020-02-22	\N
230107599623686	PENIC	2015-04-21	2017-02-02
230107599623686	POILE	2018-10-18	\N
230107599623686	LAV	2017-03-03	2018-03-07
230107599623686	POLN	2015-03-21	2021-03-22
157028597172844	GLUTN	2020-02-06	2021-11-16
214072768854685	BLATE	2016-11-04	\N
214072768854685	PENIC	2020-03-11	2021-10-16
214072768854685	LAV	2018-12-04	\N
280026155058522	BEE	2018-08-07	2018-08-08
280026155058522	lATEX	2015-10-03	\N
135091467058684	LAV	2017-01-25	2018-02-14
299096402146261	ARA	2018-01-20	\N
299096402146261	lATEX	2016-03-15	2018-02-10
123079019442742	ASPIR	2021-08-20	2021-10-18
285073076628400	lATEX	2016-05-11	\N
122076067789172	POILE	2017-01-16	2019-06-14
122076067789172	BEE	2018-01-27	2019-04-19
122076067789172	ARA	2017-01-26	2018-01-26
223079798264179	BEE	2015-09-15	2021-06-25
223079798264179	GLUTN	2016-10-16	\N
287128641152343	BEE	2019-11-03	2021-10-28
287128641152343	POLN	2018-01-06	\N
287128641152343	lATEX	2016-04-05	2020-03-22
287128641152343	PENIC	2019-12-16	\N
124064655533453	POILE	2020-06-13	\N
124064655533453	GLUTN	2019-06-28	\N
124064655533453	PENIC	2020-01-18	2021-02-28
124064655533453	BLATE	2018-03-18	\N
124064655533453	ARA	2020-04-14	\N
177087933217555	BEE	2020-10-03	\N
177087933217555	MOISI	2017-10-28	2019-06-17
177087933217555	BLATE	2015-01-25	\N
177087933217555	GUEPE	2016-10-15	\N
177087933217555	GLUTN	2016-12-22	\N
178083543213634	ARA	2015-08-04	2018-01-14
193052131885364	POLN	2021-11-16	\N
193052131885364	lATEX	2017-12-14	\N
193052131885364	MOISI	2015-04-01	\N
193052131885364	POILE	2015-08-14	2020-08-18
230034748673362	GUEPE	2021-07-15	\N
234081951792054	POLN	2017-12-10	2018-02-11
234081951792054	LAV	2019-01-06	2019-01-28
234081951792054	PENIC	2017-11-07	2020-03-28
234081951792054	GLUTN	2017-12-05	2020-11-17
112011349625910	ASPIR	2018-01-21	2019-06-09
112011349625910	MOISI	2018-08-07	\N
112011349625910	GLUTN	2016-02-15	\N
112011349625910	lATEX	2020-08-12	2020-08-16
130110933481910	GUEPE	2015-10-21	\N
130110933481910	MOISI	2018-05-10	2021-08-20
130110933481910	GLUTN	2020-12-17	2021-03-15
200036971177056	GLUTN	2018-06-07	\N
200036971177056	ARA	2017-09-03	\N
248026335038972	MOISI	2015-02-02	2015-04-23
248026335038972	BLATE	2018-02-28	2019-04-23
108014463737146	LAV	2020-09-28	\N
108014463737146	GUEPE	2017-12-15	\N
108014463737146	ASPIR	2015-10-14	2018-06-10
108014463737146	GLUTN	2018-09-13	\N
113087786480165	GUEPE	2020-08-15	2020-08-18
279045756456236	ARA	2018-04-25	\N
279045756456236	GUEPE	2021-03-13	\N
279045756456236	ASPIR	2016-06-04	\N
279045756456236	PENIC	2020-08-16	\N
279045756456236	BLATE	2016-11-14	2020-12-14
158031664828007	PENIC	2017-11-14	\N
253107320548282	ASPIR	2017-10-23	2020-05-15
253107320548282	BEE	2021-02-13	\N
253107320548282	lATEX	2019-04-10	\N
253107320548282	MOISI	2020-06-15	\N
253107320548282	BLATE	2015-02-24	\N
159112943567608	BEE	2016-01-03	2019-04-12
159112943567608	POLN	2017-07-19	2020-02-10
159112943567608	POILE	2019-10-23	2020-10-26
159112943567608	MOISI	2021-05-18	2021-09-12
192057011550036	POLN	2015-01-22	2015-03-24
192057011550036	BEE	2015-12-01	2020-04-24
192057011550036	lATEX	2018-07-06	2019-04-13
192057011550036	ARA	2019-11-03	2020-08-10
256083287261288	LAV	2021-04-03	2021-08-14
256083287261288	GLUTN	2016-05-07	2019-12-02
248098049506176	BEE	2016-09-03	2016-09-09
248098049506176	MOISI	2018-05-08	\N
248098049506176	lATEX	2019-10-13	2021-07-19
248098049506176	ARA	2016-04-09	2019-03-07
248098049506176	POILE	2015-02-24	2019-02-25
130029464135944	PENIC	2019-12-12	\N
130029464135944	lATEX	2015-01-25	2019-10-03
130029464135944	LAV	2020-11-16	\N
148074826149072	PENIC	2020-01-03	\N
148074826149072	ARA	2021-09-03	\N
148074826149072	GLUTN	2017-07-28	2017-12-20
148074826149072	ASPIR	2018-04-09	2019-08-13
199051568162490	ASPIR	2015-05-20	\N
199051568162490	GUEPE	2015-02-12	\N
192091009413573	GUEPE	2021-10-17	\N
192091009413573	POILE	2017-11-01	2019-02-05
192091009413573	POLN	2019-10-15	\N
192091009413573	MOISI	2019-04-04	\N
192091009413573	ARA	2021-06-08	\N
292071211633603	BEE	2016-01-26	\N
292071211633603	MOISI	2021-06-16	\N
292071211633603	POILE	2018-09-08	\N
292071211633603	BLATE	2019-08-21	\N
174110385863580	PENIC	2021-10-20	\N
174110385863580	ARA	2019-06-16	\N
160017115802452	BEE	2017-05-06	\N
160017115802452	ASPIR	2020-09-09	\N
160017115802452	GUEPE	2017-07-20	2017-10-28
100043305622465	POILE	2019-09-05	\N
100043305622465	BEE	2016-12-13	2018-11-14
100043305622465	GUEPE	2021-07-25	\N
100043305622465	lATEX	2020-02-03	\N
100043305622465	PENIC	2015-12-22	2017-08-01
194128800296508	ARA	2019-04-19	2019-04-19
153016273510071	ARA	2018-07-20	\N
153016273510071	LAV	2021-01-12	\N
230073061835012	lATEX	2018-03-08	2020-04-19
242060173510692	GUEPE	2019-03-12	\N
242060173510692	POILE	2019-01-21	2021-02-26
242060173510692	BLATE	2018-04-17	2018-12-18
118017450826990	BEE	2018-03-08	\N
118017450826990	GUEPE	2017-09-13	\N
118017450826990	ASPIR	2018-01-21	2021-01-26
118017450826990	POILE	2015-02-17	2017-04-01
118017450826990	BLATE	2019-03-18	2019-03-23
289048180276376	LAV	2017-06-15	\N
289048180276376	PENIC	2018-09-15	2021-11-07
289048180276376	MOISI	2016-11-14	\N
289048180276376	ASPIR	2017-01-26	\N
289048180276376	lATEX	2021-07-09	2021-09-22
245116596868850	BLATE	2019-07-23	2019-07-24
245116596868850	ARA	2015-08-15	2017-02-07
245116596868850	POILE	2021-01-06	\N
168076338524481	POILE	2020-09-16	\N
168076338524481	BLATE	2016-04-09	\N
168076338524481	ASPIR	2018-07-25	2018-10-15
168076338524481	GLUTN	2015-11-09	\N
112059565719842	MOISI	2021-06-16	2021-07-13
112059565719842	ARA	2018-09-15	\N
112059565719842	POLN	2019-07-13	\N
136076785900286	GUEPE	2016-10-05	\N
136076785900286	lATEX	2017-03-01	2021-09-15
103024280047064	ASPIR	2018-12-24	2018-12-25
103024280047064	GUEPE	2015-03-26	\N
103024280047064	BLATE	2020-10-25	\N
103024280047064	MOISI	2016-11-01	2018-08-18
103024280047064	POLN	2019-05-16	\N
268075069028143	BLATE	2018-02-12	2018-11-03
268075069028143	ASPIR	2016-03-26	\N
268075069028143	BEE	2020-11-03	2021-02-07
249111185011005	ASPIR	2018-02-05	2020-02-17
249111185011005	lATEX	2020-08-24	2021-06-16
249111185011005	POLN	2019-02-11	\N
185059544397412	MOISI	2021-06-27	\N
185059544397412	BEE	2016-11-01	\N
185059544397412	LAV	2018-05-13	\N
185059544397412	lATEX	2017-10-10	\N
101115361637735	ASPIR	2015-04-22	\N
101115361637735	LAV	2021-05-28	\N
101115361637735	GUEPE	2021-11-15	2021-11-17
101115361637735	PENIC	2021-08-03	2021-08-16
101115361637735	lATEX	2020-02-08	\N
223064299968133	MOISI	2018-12-13	2019-07-18
223064299968133	ASPIR	2017-05-13	\N
223064299968133	POLN	2018-10-19	\N
290030296252649	GUEPE	2020-01-14	\N
290030296252649	LAV	2018-11-09	2018-11-13
183096237207201	PENIC	2021-08-19	\N
183096237207201	BEE	2020-01-09	\N
183096237207201	POILE	2017-06-24	\N
183096237207201	POLN	2020-03-12	\N
183096237207201	GLUTN	2020-07-06	2021-11-01
257102630986082	ARA	2015-04-23	\N
139058252403158	GUEPE	2015-01-13	2020-05-27
139058252403158	ARA	2015-12-12	\N
139058252403158	MOISI	2019-02-07	2020-04-15
139058252403158	LAV	2019-10-22	2019-12-02
139058252403158	POLN	2020-10-13	2020-12-12
197092256134117	BLATE	2016-11-11	2021-01-19
197092256134117	BEE	2021-11-02	2021-11-10
197092256134117	ASPIR	2020-10-27	2021-07-28
167073348121233	PENIC	2015-10-14	2017-02-28
167073348121233	BEE	2018-03-05	2020-12-06
167073348121233	ASPIR	2017-11-02	\N
167073348121233	lATEX	2017-02-16	2017-07-28
257084916573371	MOISI	2016-01-09	\N
269064890143438	LAV	2017-08-21	2021-02-06
269064890143438	BEE	2018-12-23	2021-02-06
107063793494291	GLUTN	2018-12-01	2020-11-02
107063793494291	ASPIR	2020-09-09	2020-10-05
107063793494291	POILE	2020-06-19	2021-10-09
107063793494291	GUEPE	2017-11-03	\N
172057342339830	GLUTN	2018-02-15	\N
172057342339830	BEE	2020-12-14	2021-09-05
172057342339830	POILE	2017-05-06	2018-08-20
172057342339830	ARA	2021-02-20	2021-06-27
172057342339830	LAV	2018-01-10	\N
179076282691743	LAV	2021-01-09	\N
179076282691743	POILE	2018-09-23	\N
125053714364144	MOISI	2016-03-07	2017-07-03
107116261245646	BLATE	2017-01-25	\N
107116261245646	GUEPE	2020-07-27	2020-12-26
107116261245646	MOISI	2016-04-08	2016-10-09
107116261245646	ASPIR	2017-12-26	\N
107116261245646	POILE	2018-01-10	2020-09-23
222095362060135	PENIC	2020-11-12	2021-06-28
222095362060135	BLATE	2021-04-17	2021-06-09
222095362060135	ARA	2016-04-08	2018-12-09
164087084249753	MOISI	2015-06-07	2018-10-09
164087084249753	ASPIR	2021-09-20	2021-10-12
164087084249753	PENIC	2018-02-21	2020-04-23
164087084249753	POLN	2021-10-02	\N
164087084249753	POILE	2020-08-23	2021-03-10
117126263944457	BLATE	2017-05-26	\N
286095607481988	ARA	2018-08-04	\N
286095607481988	GUEPE	2020-04-18	\N
286095607481988	lATEX	2018-02-09	\N
154100549674560	lATEX	2017-10-26	2019-12-20
154100549674560	POILE	2018-05-09	2018-05-10
154100549674560	LAV	2018-06-01	\N
154100549674560	ARA	2018-03-18	2020-08-10
243124767698205	BEE	2020-02-25	\N
243124767698205	LAV	2021-07-10	2021-09-21
240055800882855	GLUTN	2019-09-17	\N
213114441086169	MOISI	2020-10-18	2020-12-21
213114441086169	ASPIR	2016-05-26	2018-06-04
213114441086169	ARA	2019-03-13	\N
250022187467305	GLUTN	2015-01-22	\N
109039206294408	POILE	2016-02-01	2020-01-12
160026095111549	lATEX	2021-05-04	\N
160026095111549	BEE	2021-08-27	\N
160026095111549	ASPIR	2021-02-10	\N
237012302577364	GUEPE	2020-07-17	\N
237012302577364	PENIC	2021-09-11	\N
237012302577364	ASPIR	2016-11-06	2016-12-12
237012302577364	MOISI	2017-09-19	2017-11-10
140088069682239	ARA	2015-01-10	2016-12-14
140088069682239	BEE	2016-02-19	2018-07-01
102050748294646	POILE	2017-07-23	2017-07-27
173016545039252	PENIC	2019-11-05	\N
173016545039252	lATEX	2016-11-14	\N
236010256267941	BEE	2021-04-22	\N
236010256267941	ASPIR	2021-04-09	2021-05-05
236010256267941	POILE	2016-02-24	\N
150070518841138	POLN	2019-08-13	\N
150070518841138	ARA	2018-02-26	2021-06-06
177037001185459	POILE	2015-05-19	2016-08-12
299080308159168	ARA	2018-12-07	2019-07-18
299080308159168	PENIC	2017-10-15	\N
299080308159168	lATEX	2015-03-16	\N
297028710752743	lATEX	2021-01-10	2021-03-27
297028710752743	PENIC	2019-09-01	2019-12-05
297028710752743	POILE	2018-07-20	2019-01-05
297028710752743	BLATE	2017-06-27	\N
297028710752743	POLN	2015-01-20	2018-11-04
216063297975659	lATEX	2021-03-08	\N
197114552893819	ARA	2017-04-28	2020-02-20
197114552893819	POLN	2019-09-12	\N
197114552893819	PENIC	2020-07-08	2021-09-10
261095472962933	BLATE	2019-05-11	2021-01-16
261095472962933	PENIC	2018-06-13	2020-12-17
261095472962933	MOISI	2015-07-15	2017-09-02
261095472962933	POLN	2018-08-08	2019-03-01
261095472962933	POILE	2016-04-14	2017-07-03
126086148657250	lATEX	2020-02-10	\N
122100732156095	lATEX	2018-10-03	\N
193091370484103	GLUTN	2016-08-11	2020-10-05
193091370484103	LAV	2020-05-01	\N
193091370484103	POILE	2016-03-23	\N
193091370484103	POLN	2015-10-25	\N
278086882390588	POILE	2019-08-05	2021-02-12
136084997092352	lATEX	2020-12-22	2020-12-22
136084997092352	BLATE	2017-02-22	\N
136084997092352	MOISI	2016-01-09	2017-11-11
136084997092352	ARA	2015-06-03	\N
136084997092352	LAV	2015-03-28	\N
135101302110067	lATEX	2021-10-03	\N
135101302110067	ASPIR	2015-12-07	\N
135101302110067	BEE	2020-12-20	2020-12-25
135101302110067	MOISI	2016-10-23	\N
108038498976924	POILE	2016-03-25	\N
108038498976924	lATEX	2021-05-27	2021-05-28
108038498976924	POLN	2016-08-20	2019-12-10
108038498976924	ASPIR	2021-06-25	2021-11-18
108038498976924	PENIC	2018-08-18	2020-02-03
266012535044395	BLATE	2020-10-01	2020-10-12
266012535044395	MOISI	2020-01-05	\N
266012535044395	PENIC	2019-04-21	\N
235081064179459	BEE	2019-12-01	2021-11-09
235081064179459	BLATE	2016-07-19	\N
235081064179459	POILE	2016-04-25	\N
235081064179459	POLN	2017-12-24	2020-08-03
235081064179459	LAV	2015-06-27	2021-03-26
189071551347808	GUEPE	2016-07-04	2018-02-23
189071551347808	BEE	2020-02-17	\N
189071551347808	GLUTN	2018-10-14	\N
189071551347808	LAV	2016-02-27	2020-08-14
189071551347808	PENIC	2020-02-09	\N
294103109740262	PENIC	2019-07-14	\N
147110710661853	BLATE	2015-04-15	\N
147110710661853	LAV	2018-12-13	2019-11-17
145077876002511	MOISI	2016-04-10	\N
145077876002511	lATEX	2021-06-10	2021-07-03
145077876002511	GLUTN	2016-09-04	2018-12-02
145077876002511	ARA	2018-05-05	\N
145077876002511	ASPIR	2020-09-13	\N
289077275942294	ASPIR	2016-01-25	2020-06-26
289077275942294	PENIC	2017-08-08	2017-08-14
289077275942294	GLUTN	2018-06-21	\N
230044759876745	lATEX	2019-05-20	\N
230044759876745	LAV	2018-05-08	2018-05-20
230044759876745	GUEPE	2019-10-26	2021-03-20
230044759876745	ASPIR	2015-06-16	2018-12-11
257084245336102	POILE	2020-08-13	2021-04-23
212069761197108	lATEX	2017-08-26	2021-08-28
212069761197108	POLN	2016-11-15	\N
212069761197108	GLUTN	2019-04-22	2021-05-08
212069761197108	LAV	2018-02-14	2021-06-09
212069761197108	POILE	2015-08-28	\N
119034662639308	POLN	2018-04-17	\N
119034662639308	PENIC	2018-03-07	\N
119034662639308	POILE	2020-05-18	2021-10-06
119034662639308	GUEPE	2017-03-10	\N
117097307536183	BEE	2016-09-15	\N
260124860732275	BLATE	2018-01-12	2021-03-25
260124860732275	GLUTN	2021-04-12	\N
260124860732275	ARA	2018-07-02	2021-07-17
260124860732275	POLN	2017-04-17	\N
172089291557913	lATEX	2018-06-06	\N
172089291557913	PENIC	2016-06-07	\N
172089291557913	GLUTN	2019-08-14	2020-02-03
224129352103655	LAV	2016-07-05	\N
282116367172719	POILE	2018-03-26	2019-11-12
282116367172719	GUEPE	2021-05-19	2021-05-28
282116367172719	BEE	2020-10-24	\N
207076163837556	GUEPE	2015-09-08	2020-05-08
207076163837556	MOISI	2019-12-28	2019-12-28
207076163837556	ASPIR	2021-08-12	\N
207076163837556	lATEX	2017-07-05	\N
207076163837556	ARA	2020-10-16	\N
298063513226885	POILE	2019-06-15	2021-11-01
298063513226885	ASPIR	2019-02-14	\N
298063513226885	BEE	2021-06-17	\N
298063513226885	BLATE	2020-05-19	\N
213056577719720	GUEPE	2016-02-11	\N
213056577719720	LAV	2020-01-02	2021-04-02
213056577719720	PENIC	2019-01-28	\N
213056577719720	POLN	2015-12-17	\N
213056577719720	ARA	2020-03-14	2021-10-18
257126563480430	LAV	2016-01-20	2016-04-04
257126563480430	POILE	2015-11-15	2017-06-16
257126563480430	GLUTN	2019-11-02	2019-11-18
257126563480430	PENIC	2017-02-05	\N
161066859251464	POLN	2019-03-08	\N
161066859251464	PENIC	2019-12-15	2020-02-02
161066859251464	BLATE	2015-05-15	\N
161066859251464	lATEX	2015-11-03	2017-11-11
161066859251464	ARA	2020-01-24	\N
227101652934764	PENIC	2017-08-17	\N
227101652934764	ARA	2020-04-09	\N
255066466547116	GLUTN	2021-04-11	\N
255066466547116	POILE	2017-04-12	2020-02-12
117031740249272	PENIC	2015-01-19	\N
117031740249272	ARA	2021-04-04	2021-10-05
117031740249272	POLN	2020-12-06	\N
195098864552439	GUEPE	2017-12-09	2018-05-22
139077210843596	PENIC	2021-01-16	\N
248015103890538	lATEX	2018-04-23	2019-12-18
248015103890538	MOISI	2021-11-06	2021-11-08
248015103890538	LAV	2016-12-16	2017-08-25
248015103890538	GUEPE	2016-09-03	2017-06-06
248015103890538	ARA	2015-09-17	\N
238051213766800	BLATE	2020-07-25	\N
238051213766800	LAV	2021-05-08	\N
282103173173307	PENIC	2021-07-08	2021-11-14
282103173173307	GLUTN	2021-03-04	2021-06-07
160081840144512	GUEPE	2019-10-16	2020-01-10
160081840144512	lATEX	2017-01-21	2017-04-02
160081840144512	PENIC	2020-04-11	2020-05-17
282093945534106	ARA	2017-02-25	\N
282093945534106	POLN	2015-07-04	2019-04-10
282093945534106	BLATE	2021-10-23	\N
282093945534106	BEE	2015-05-21	2017-11-11
282093945534106	PENIC	2015-03-15	2015-09-27
185086534132201	POLN	2015-06-16	\N
185086534132201	GUEPE	2015-03-22	2017-02-28
294041736505100	GLUTN	2017-09-21	2020-04-13
294041736505100	MOISI	2018-04-18	\N
294041736505100	PENIC	2015-10-04	\N
294041736505100	LAV	2016-06-09	\N
294041736505100	ARA	2021-11-04	2021-11-15
160113579531989	GUEPE	2018-06-22	\N
160113579531989	PENIC	2016-05-13	\N
160113579531989	POILE	2019-11-12	2021-08-01
160113579531989	BEE	2019-10-13	\N
160113579531989	ASPIR	2021-02-22	2021-05-16
204025670523878	PENIC	2020-01-01	\N
204025670523878	GLUTN	2018-08-03	2019-12-14
204025670523878	LAV	2019-09-19	\N
204025670523878	ASPIR	2016-04-09	\N
204025670523878	BEE	2015-03-06	\N
269032951239687	PENIC	2017-07-11	\N
107087128682443	BLATE	2020-07-21	\N
107087128682443	ASPIR	2019-04-16	2020-12-11
289106989656446	ASPIR	2020-10-21	\N
116100226032930	BEE	2015-02-24	\N
116100226032930	GLUTN	2016-10-24	\N
116100226032930	GUEPE	2021-05-04	\N
259056721582059	GUEPE	2017-07-24	2018-08-20
259056721582059	GLUTN	2017-03-04	\N
296078344435443	ASPIR	2015-10-26	\N
296078344435443	MOISI	2016-10-25	2017-04-15
275101635834500	GLUTN	2016-04-14	\N
275101635834500	POLN	2021-07-27	2021-11-16
275101635834500	MOISI	2019-07-15	\N
275101635834500	lATEX	2019-12-05	\N
275101635834500	PENIC	2016-11-02	\N
173115356247302	PENIC	2016-10-22	\N
196104695126094	LAV	2017-10-21	2020-08-03
196104695126094	GUEPE	2016-11-01	2018-12-23
196104695126094	ASPIR	2016-03-24	2016-10-02
104084767796763	BEE	2016-11-09	\N
104084767796763	GUEPE	2015-08-24	\N
104084767796763	LAV	2019-06-23	2019-06-24
104084767796763	ARA	2020-03-17	\N
104084767796763	MOISI	2017-12-24	\N
173069866743140	PENIC	2017-02-16	2020-11-05
173069866743140	BLATE	2018-10-21	2018-10-27
173069866743140	GLUTN	2015-04-19	\N
173069866743140	POLN	2016-06-25	\N
104038552688549	ASPIR	2015-01-17	\N
104038552688549	BLATE	2018-09-26	\N
176026748099490	ASPIR	2020-06-09	2020-11-05
103117548023800	POILE	2016-02-05	\N
103117548023800	GLUTN	2016-01-18	\N
103117548023800	BLATE	2019-07-12	\N
103117548023800	PENIC	2016-11-03	\N
148109232252267	POILE	2015-12-13	2017-01-20
194069349220315	ARA	2019-04-17	2019-07-19
194069349220315	BEE	2017-11-11	2018-09-22
194069349220315	LAV	2018-09-02	2021-01-18
126095603806820	BLATE	2018-11-07	2020-06-09
126095603806820	POLN	2017-03-16	\N
126095603806820	GUEPE	2017-01-16	\N
126095603806820	lATEX	2018-12-20	\N
268125032408842	POLN	2015-09-04	2020-11-03
140123122489282	POILE	2019-06-19	2020-09-05
271094924607285	GUEPE	2021-04-28	2021-04-28
271094924607285	BLATE	2021-03-06	\N
271094924607285	lATEX	2016-05-15	2016-08-28
271094924607285	PENIC	2018-04-24	\N
271094924607285	MOISI	2016-08-14	\N
196100412822638	MOISI	2016-06-28	\N
196100412822638	BEE	2019-02-01	2020-01-10
196100412822638	GUEPE	2016-08-27	2020-06-26
196100412822638	BLATE	2021-06-10	\N
196100412822638	lATEX	2017-10-23	2021-02-21
297013402217591	POLN	2020-06-11	2021-08-11
297013402217591	PENIC	2017-07-28	2020-03-14
297013402217591	lATEX	2016-02-26	2021-07-11
297013402217591	GLUTN	2018-07-27	\N
297013402217591	BLATE	2019-06-27	2021-05-04
206088289892884	ARA	2021-10-14	2021-10-14
206088289892884	ASPIR	2017-04-24	2019-06-20
173096580101586	LAV	2016-04-04	2021-07-05
173096580101586	POLN	2015-11-05	2015-12-23
173096580101586	GUEPE	2019-04-05	\N
173096580101586	MOISI	2021-09-17	\N
282046629787403	GLUTN	2021-05-10	2021-10-01
231060729971548	POLN	2016-08-19	\N
231060729971548	ASPIR	2021-09-15	2021-11-05
231060729971548	PENIC	2016-10-03	\N
231060729971548	BLATE	2017-07-17	2018-04-20
231060729971548	GUEPE	2018-02-24	\N
261043349444673	MOISI	2020-08-25	2020-11-02
261038771759746	ASPIR	2017-09-25	2017-09-26
261038771759746	BLATE	2018-05-21	\N
131107626638488	MOISI	2017-05-07	2017-05-08
131107626638488	GUEPE	2021-07-28	2021-10-19
131107626638488	ARA	2016-04-24	\N
131107626638488	GLUTN	2020-04-19	\N
251127256365773	ASPIR	2020-04-21	\N
267125703711841	ARA	2020-04-18	2020-11-13
267125703711841	PENIC	2015-11-15	\N
263084417717835	POILE	2015-07-21	\N
263084417717835	BEE	2017-12-10	2017-12-10
218120988164777	lATEX	2016-12-08	2017-10-11
218120988164777	MOISI	2021-04-09	\N
218120988164777	BLATE	2019-09-01	2021-09-10
166065352240321	GUEPE	2020-01-02	\N
166065352240321	GLUTN	2019-02-08	2021-11-17
166065352240321	PENIC	2018-02-18	\N
194012458189138	lATEX	2020-04-19	2020-07-12
194012458189138	LAV	2015-06-25	2019-11-15
247031441605135	LAV	2019-07-01	2019-10-11
247031441605135	lATEX	2021-01-03	2021-11-14
247031441605135	GUEPE	2016-10-22	\N
247031441605135	BEE	2015-04-12	\N
158059952001652	BEE	2017-03-06	2017-07-02
158059952001652	BLATE	2018-07-05	\N
158059952001652	GLUTN	2018-05-15	\N
259026635921108	PENIC	2019-05-08	\N
222066223450293	lATEX	2020-07-20	\N
222066223450293	POILE	2020-07-04	2021-06-23
294035173348892	lATEX	2017-10-20	\N
294035173348892	GUEPE	2015-04-04	\N
185012960779831	lATEX	2021-11-03	2021-11-10
185012960779831	MOISI	2018-11-17	\N
185012960779831	GLUTN	2016-11-16	\N
272017325071928	ARA	2019-03-14	2019-07-17
272017325071928	BLATE	2018-05-21	2021-06-11
272017325071928	ASPIR	2018-08-19	\N
272017325071928	BEE	2015-03-09	2016-06-11
226039430004407	PENIC	2020-03-11	2021-03-28
226039430004407	BLATE	2019-07-15	\N
200070224267018	POLN	2020-10-10	\N
200070224267018	lATEX	2019-05-21	\N
200070224267018	ARA	2021-02-20	\N
290078809746561	ASPIR	2017-03-14	2017-04-05
231095254215790	BLATE	2016-04-23	\N
224036658465337	GLUTN	2017-01-01	\N
204063744707638	lATEX	2021-06-05	2021-09-15
204063744707638	BEE	2019-02-14	\N
204063744707638	LAV	2020-05-23	\N
204063744707638	GLUTN	2015-03-11	\N
133077951509022	BEE	2017-12-18	2018-02-21
133077951509022	PENIC	2021-05-24	\N
133077951509022	ARA	2021-03-14	2021-07-27
279068550131477	GUEPE	2017-03-17	2019-09-17
140021429173584	ARA	2015-08-21	\N
140021429173584	POLN	2018-03-07	2021-01-13
140021429173584	PENIC	2018-10-12	2019-12-21
140021429173584	GLUTN	2018-06-28	2020-12-01
116087933558285	MOISI	2020-01-17	\N
184042816040471	POLN	2020-03-23	2021-07-16
184042816040471	ASPIR	2020-12-02	\N
184042816040471	PENIC	2017-10-03	\N
262065796255647	ASPIR	2019-03-15	\N
262065796255647	POILE	2016-03-23	2016-05-24
289116874121144	ASPIR	2021-07-11	2021-09-03
289116874121144	MOISI	2019-02-28	\N
242112406964207	ARA	2016-01-26	2021-06-10
242112406964207	GUEPE	2017-11-03	2018-06-28
254043611144658	BLATE	2019-02-02	2019-07-10
254043611144658	BEE	2016-12-10	\N
254043611144658	GUEPE	2018-01-20	2019-11-13
268031648794265	LAV	2021-05-11	2021-06-19
268031648794265	ASPIR	2016-12-21	\N
268031648794265	BLATE	2016-02-16	\N
173100893513653	BLATE	2021-07-26	\N
173100893513653	LAV	2020-01-13	\N
287059122651264	BEE	2015-08-01	\N
287059122651264	lATEX	2021-04-19	\N
131121957283294	BLATE	2018-09-04	\N
131121957283294	POILE	2017-12-13	\N
131121957283294	ASPIR	2019-09-22	\N
131121957283294	BEE	2017-07-01	\N
188110658741765	POLN	2020-02-24	2021-07-13
188110658741765	POILE	2020-08-15	2021-08-26
188110658741765	GUEPE	2021-07-19	\N
188110658741765	GLUTN	2015-01-19	\N
188110658741765	BEE	2018-02-04	2020-08-26
112048414030269	BEE	2017-02-06	2019-01-18
112048414030269	GUEPE	2019-10-14	2020-07-20
112048414030269	ARA	2016-04-07	\N
112048414030269	ASPIR	2017-09-19	2017-12-02
112048414030269	POILE	2021-02-24	2021-06-11
172057142211349	PENIC	2015-04-12	2020-02-12
172057142211349	BEE	2021-02-10	2021-11-09
172057142211349	POLN	2021-01-20	\N
247081496882220	BLATE	2020-10-16	\N
247081496882220	GUEPE	2015-05-26	2016-05-26
247081496882220	MOISI	2018-08-15	\N
247081496882220	LAV	2016-12-12	2021-04-05
297077289777229	ARA	2016-09-12	2021-01-12
297077289777229	BLATE	2021-11-12	\N
297077289777229	POLN	2021-11-03	\N
297077289777229	GUEPE	2020-09-26	\N
157092099718462	PENIC	2017-03-16	2019-09-04
157092099718462	POILE	2020-12-07	2021-10-18
157092099718462	lATEX	2016-09-12	\N
157092099718462	LAV	2019-09-16	\N
157092099718462	BEE	2021-06-21	2021-10-03
117017034544064	BLATE	2017-12-02	\N
117017034544064	GLUTN	2019-09-22	\N
117017034544064	POLN	2018-11-03	2020-10-14
134040655044942	BEE	2016-04-20	\N
134040655044942	lATEX	2017-06-14	2018-06-23
134040655044942	ASPIR	2017-04-08	2019-05-13
134040655044942	GLUTN	2019-04-08	\N
166012754054480	ARA	2018-09-01	\N
166012754054480	BLATE	2017-01-09	\N
166012754054480	MOISI	2015-01-02	\N
166012754054480	lATEX	2021-02-10	2021-07-22
159099939848446	POLN	2019-09-17	\N
159099939848446	lATEX	2017-12-20	2018-10-24
159099939848446	GLUTN	2021-03-28	\N
159099939848446	PENIC	2021-07-13	2021-07-23
159099939848446	POILE	2016-01-09	2016-09-02
180080247750688	PENIC	2018-05-15	2020-03-06
178108944503402	GLUTN	2015-03-16	\N
159059689722694	LAV	2017-02-04	\N
179036643060955	GUEPE	2015-03-24	2016-03-24
179036643060955	BEE	2018-07-02	2018-10-10
261023956555783	GLUTN	2018-07-16	\N
235061978907881	ARA	2018-07-09	2019-02-19
235061978907881	GUEPE	2016-03-11	2021-05-19
235061978907881	POILE	2018-03-17	2018-09-10
235061978907881	PENIC	2017-10-27	2021-02-09
160076989558266	MOISI	2016-05-19	\N
160076989558266	GUEPE	2017-01-08	2019-06-01
237044696201755	POILE	2021-08-03	\N
237044696201755	ARA	2020-05-20	2020-06-15
237044696201755	GLUTN	2016-03-05	2016-10-09
237044696201755	lATEX	2018-12-10	2018-12-21
237044696201755	BEE	2021-11-03	2021-11-16
147087143819012	BLATE	2017-03-15	\N
147087143819012	POLN	2020-06-19	\N
147087143819012	GUEPE	2020-09-06	\N
147087143819012	MOISI	2015-08-19	\N
177040491302245	POLN	2020-09-04	\N
181026482885579	PENIC	2017-01-09	\N
181026482885579	GLUTN	2015-12-08	2018-12-19
181026482885579	POLN	2018-03-18	2021-05-26
181026482885579	BLATE	2017-06-14	\N
129073106456222	lATEX	2018-10-08	\N
129073106456222	ASPIR	2021-02-03	\N
171110762807449	POILE	2016-08-14	2018-03-13
171110762807449	lATEX	2017-09-17	\N
171110762807449	GLUTN	2021-07-11	\N
171110762807449	BLATE	2020-07-18	\N
277093701187718	ASPIR	2017-06-14	\N
277093701187718	lATEX	2015-06-27	2018-05-14
233024779652808	ARA	2018-05-08	\N
299090800746875	ASPIR	2019-10-13	\N
299090800746875	BLATE	2017-03-11	\N
299090800746875	GUEPE	2020-10-07	2020-10-15
299090800746875	lATEX	2018-07-20	2018-12-23
299090800746875	GLUTN	2020-12-14	\N
158129815961864	BEE	2021-11-05	2021-11-05
158129815961864	lATEX	2016-08-18	2019-11-14
158129815961864	POILE	2021-11-11	\N
186033471783730	POILE	2017-08-26	2018-09-09
186033471783730	LAV	2019-07-12	2020-06-23
186033471783730	BEE	2017-11-11	2018-04-24
124065145979904	POLN	2015-07-26	2021-02-04
124065145979904	ARA	2017-06-07	2018-01-27
124065145979904	GUEPE	2017-08-06	\N
249013256140217	ARA	2017-10-01	\N
159081311543565	ASPIR	2020-01-07	\N
159081311543565	LAV	2019-01-21	2021-05-25
159081311543565	lATEX	2019-04-03	\N
159081311543565	PENIC	2016-09-02	\N
173038729083641	BEE	2020-03-14	2020-12-28
125025454240765	BLATE	2019-12-14	\N
125025454240765	LAV	2016-02-06	2019-04-01
125025454240765	POILE	2018-04-25	\N
125025454240765	BEE	2019-01-25	\N
221074080373957	BEE	2018-11-15	2020-01-11
221074080373957	GUEPE	2021-11-04	2021-11-06
191129347920866	MOISI	2021-02-04	\N
191129347920866	lATEX	2018-09-04	2020-05-28
191129347920866	BLATE	2021-09-19	\N
191129347920866	GLUTN	2015-12-17	2017-02-07
146033753292561	GUEPE	2016-02-20	2017-10-05
146033753292561	BLATE	2017-08-24	2021-09-01
146033753292561	MOISI	2020-10-20	2020-11-05
146033753292561	ARA	2020-04-26	\N
235048088880828	ASPIR	2016-11-17	2017-11-17
235048088880828	LAV	2017-04-26	2018-01-07
235048088880828	PENIC	2020-04-04	\N
235048088880828	POILE	2017-06-12	\N
286090186822302	PENIC	2021-09-09	\N
286090186822302	POILE	2017-03-17	2017-10-11
286090186822302	lATEX	2021-10-10	2021-11-11
286090186822302	LAV	2019-11-01	\N
286090186822302	MOISI	2021-08-06	2021-09-06
118091053967656	BLATE	2020-12-17	2021-02-21
118091053967656	POLN	2015-06-11	\N
118091053967656	BEE	2021-06-12	2021-09-21
118091053967656	PENIC	2021-11-15	\N
118091053967656	MOISI	2015-08-20	\N
178068445869714	GUEPE	2019-10-09	\N
178068445869714	POILE	2018-05-28	2020-05-28
178068445869714	lATEX	2020-02-13	\N
178068445869714	BEE	2018-07-07	\N
178068445869714	ASPIR	2019-05-25	\N
158102532502789	ARA	2020-10-02	2021-07-13
158102532502789	ASPIR	2017-12-22	\N
158102532502789	POLN	2018-06-21	2020-03-14
158102532502789	PENIC	2018-06-22	\N
234042453907063	ARA	2017-09-03	\N
234042453907063	ASPIR	2017-11-18	2020-10-27
234042453907063	MOISI	2019-12-12	2021-01-13
234042453907063	PENIC	2019-08-09	2021-07-18
174108510634221	LAV	2015-03-14	2015-06-28
174108510634221	BEE	2019-11-13	2021-03-04
174108510634221	GUEPE	2021-06-15	\N
174108510634221	BLATE	2020-05-06	2021-06-25
174108510634221	lATEX	2021-03-02	2021-05-14
106024732204736	ASPIR	2015-04-16	2017-06-03
106024732204736	BEE	2015-05-04	2018-09-24
106024732204736	LAV	2020-11-03	\N
210082757893566	POILE	2021-09-22	\N
210082757893566	GUEPE	2019-01-11	2019-03-23
210082757893566	POLN	2016-11-05	\N
210082757893566	PENIC	2019-12-27	2019-12-28
210082757893566	ARA	2015-10-27	2021-03-23
274074214651338	POILE	2017-01-15	2021-10-15
274074214651338	BEE	2021-04-17	\N
110117968136108	GLUTN	2015-07-13	\N
110117968136108	lATEX	2018-02-07	2020-07-02
110117968136108	ASPIR	2021-04-09	\N
110117968136108	GUEPE	2015-01-10	2018-04-26
110117968136108	BEE	2016-03-07	2019-07-05
165121074783476	PENIC	2015-09-10	\N
165121074783476	LAV	2018-11-08	2021-04-02
165121074783476	MOISI	2018-10-05	\N
165121074783476	BEE	2019-07-03	\N
153094524936207	PENIC	2019-06-17	\N
153094524936207	BEE	2017-08-21	\N
153094524936207	POLN	2020-07-18	\N
153094524936207	ARA	2018-02-08	\N
132049184273634	lATEX	2020-11-13	2021-05-10
228106833603672	ASPIR	2021-01-11	2021-03-05
228106833603672	POLN	2019-05-11	\N
228106833603672	POILE	2015-09-06	2020-02-03
228106833603672	BEE	2020-09-28	\N
242105257964173	BLATE	2017-06-08	2020-05-27
242105257964173	GUEPE	2021-03-07	\N
242105257964173	POILE	2018-12-06	\N
138014247515067	PENIC	2019-11-02	2021-11-12
138014247515067	ARA	2016-11-13	\N
138014247515067	POLN	2019-06-22	\N
138014247515067	GUEPE	2018-11-18	\N
173064457870768	lATEX	2020-12-02	2020-12-14
173064457870768	MOISI	2018-06-28	2020-11-07
173064457870768	LAV	2015-06-14	2020-08-02
173064457870768	GLUTN	2020-05-09	\N
200121336505714	BEE	2020-07-03	\N
249032164220679	POILE	2018-02-26	2018-06-12
249032164220679	LAV	2018-03-12	2021-07-17
249032164220679	BEE	2019-03-26	\N
249032164220679	MOISI	2021-02-11	2021-02-16
249032164220679	GUEPE	2019-12-11	2019-12-26
220097402246683	lATEX	2021-09-19	2021-09-27
124080612389525	ARA	2017-09-11	2019-03-06
210054779062612	GUEPE	2017-01-26	2021-10-09
210054779062612	PENIC	2018-02-20	\N
231077978618248	BLATE	2018-06-16	\N
231077978618248	POILE	2020-06-03	2021-11-09
231077978618248	BEE	2018-04-15	2020-04-17
231077978618248	GUEPE	2015-12-28	2020-08-24
111087875486253	MOISI	2017-02-16	2018-02-23
145093359860917	POILE	2016-07-03	\N
264057206314352	ARA	2019-07-10	2021-05-11
288115135986478	GUEPE	2016-05-15	2019-09-20
139037968769029	PENIC	2018-01-04	2018-12-18
139037968769029	GLUTN	2021-01-21	2021-10-21
139037968769029	POILE	2015-12-20	\N
111020282740019	LAV	2021-03-05	\N
111020282740019	BLATE	2019-06-05	2019-12-14
111020282740019	MOISI	2018-06-21	2021-06-28
188049194998024	GUEPE	2015-12-11	\N
188049194998024	POILE	2020-05-12	\N
188049194998024	BLATE	2021-01-28	2021-01-28
188049194998024	PENIC	2016-08-17	2021-07-15
188049194998024	ASPIR	2018-07-16	2018-09-07
258065169240672	GLUTN	2016-11-16	\N
258065169240672	PENIC	2019-08-02	2020-03-19
232129815038482	ASPIR	2017-06-19	2018-01-05
232129815038482	LAV	2015-05-11	2018-11-17
232129815038482	POILE	2017-11-10	\N
145093900289545	lATEX	2019-03-22	\N
145093900289545	GLUTN	2018-01-14	\N
267121440433418	LAV	2015-10-23	2015-10-27
267121440433418	MOISI	2015-02-18	2017-05-28
267121440433418	ASPIR	2016-03-06	\N
267121440433418	PENIC	2015-02-16	\N
267121440433418	lATEX	2021-02-23	2021-02-25
142077321716367	POLN	2018-08-24	\N
142077321716367	POILE	2019-10-08	\N
142077321716367	GLUTN	2019-04-25	\N
142077321716367	GUEPE	2020-09-02	2020-09-17
286055345126560	LAV	2017-05-11	\N
286055345126560	ASPIR	2015-12-20	\N
286055345126560	BLATE	2021-11-18	2021-11-18
286055345126560	MOISI	2017-04-04	\N
200021889427908	lATEX	2021-10-17	2021-10-19
200021889427908	PENIC	2015-06-16	\N
243121776162227	lATEX	2019-04-03	2019-04-05
259114157338055	POILE	2016-08-05	2021-04-28
259114157338055	PENIC	2017-04-11	2020-10-13
259114157338055	ARA	2016-07-19	2021-09-10
259114157338055	MOISI	2020-01-25	2021-02-28
262105941528540	BLATE	2016-06-20	2019-09-15
262105941528540	LAV	2015-09-11	\N
262105941528540	ARA	2018-07-07	2020-01-10
262105941528540	ASPIR	2015-07-22	2019-04-10
109028760703504	ASPIR	2020-06-16	2021-07-20
111061695359540	PENIC	2019-04-06	2019-04-06
111061695359540	GLUTN	2020-10-14	\N
111061695359540	GUEPE	2016-02-15	2017-12-05
104113276019870	lATEX	2016-02-14	2017-06-28
104113276019870	LAV	2018-09-12	2019-05-18
104113276019870	GUEPE	2016-10-26	\N
104113276019870	MOISI	2020-10-11	\N
283023385915710	PENIC	2016-06-03	2016-12-09
283023385915710	BLATE	2021-10-17	\N
283023385915710	ASPIR	2019-05-12	2019-10-15
283023385915710	GUEPE	2016-02-14	\N
245093190848672	BLATE	2021-08-06	\N
245093190848672	POLN	2021-08-20	\N
204069532268616	LAV	2016-02-27	2021-10-24
204069532268616	BEE	2021-06-25	2021-11-07
204069532268616	ARA	2017-04-04	\N
204069532268616	BLATE	2015-04-24	2015-06-13
204069532268616	MOISI	2021-03-11	2021-03-22
112012210565675	POILE	2019-05-02	\N
112012210565675	MOISI	2015-01-21	\N
112012210565675	GUEPE	2019-10-23	\N
112012210565675	BLATE	2017-09-27	\N
112012210565675	LAV	2018-06-06	\N
235043385743272	ASPIR	2021-07-18	2021-11-11
279090179414274	BLATE	2018-08-23	\N
160121447322029	GUEPE	2020-09-28	\N
265027129877746	GLUTN	2016-07-17	\N
265027129877746	BLATE	2017-12-13	2020-06-24
265027129877746	POILE	2015-03-25	\N
122014663436309	GLUTN	2020-07-06	2020-11-17
122014663436309	POLN	2018-08-11	\N
129038681181682	ASPIR	2018-08-07	2019-08-28
129038681181682	GLUTN	2015-01-01	\N
134020806670324	GLUTN	2019-05-12	\N
134020806670324	BEE	2020-03-11	\N
134020806670324	ARA	2020-08-27	\N
187012554792695	ARA	2016-04-22	\N
187012554792695	MOISI	2019-09-18	\N
187012554792695	BEE	2018-03-04	\N
180059188878011	ASPIR	2019-01-10	\N
180059188878011	ARA	2015-10-03	2018-05-16
180059188878011	BLATE	2016-08-28	2020-10-06
180059188878011	PENIC	2021-08-11	\N
180059188878011	POILE	2020-02-09	\N
297125523160096	GLUTN	2017-04-01	2020-06-15
297125523160096	lATEX	2020-02-10	\N
265029036567340	BLATE	2015-03-04	2016-04-23
265029036567340	GLUTN	2020-03-16	2020-09-22
265029036567340	POLN	2016-02-05	\N
265029036567340	MOISI	2016-09-01	\N
265029036567340	POILE	2021-06-24	\N
106061220442334	LAV	2015-08-20	2019-02-18
106061220442334	lATEX	2016-05-12	\N
106061220442334	BLATE	2017-03-21	\N
235045565580018	PENIC	2018-12-27	2020-03-23
235045565580018	MOISI	2018-02-05	\N
126078707125125	BEE	2016-05-10	2018-04-23
138016532409883	GUEPE	2019-02-19	2019-11-05
138016532409883	GLUTN	2017-05-14	2018-02-22
138016532409883	ASPIR	2021-04-10	2021-09-23
202065667224500	BEE	2018-12-10	2020-04-03
202065667224500	ASPIR	2021-05-02	2021-08-22
202065667224500	LAV	2021-05-20	\N
202065667224500	MOISI	2018-11-06	\N
202065667224500	lATEX	2019-11-08	\N
279028648982730	ASPIR	2018-02-24	\N
279028648982730	GUEPE	2018-09-11	\N
279028648982730	PENIC	2017-08-26	2019-04-23
167079831709246	MOISI	2019-08-03	2021-04-02
167079831709246	PENIC	2015-01-18	\N
167079831709246	LAV	2020-12-05	\N
167079831709246	BEE	2017-11-10	\N
119040594612771	GUEPE	2021-07-02	2021-11-12
119123584674924	POLN	2017-05-18	\N
119123584674924	GUEPE	2018-05-27	2018-07-08
119123584674924	GLUTN	2018-01-03	\N
119123584674924	POILE	2015-06-05	\N
111093957436571	PENIC	2018-09-08	\N
111093957436571	GUEPE	2016-12-09	\N
138117414994632	BEE	2020-10-03	\N
138117414994632	BLATE	2015-08-05	\N
138117414994632	ARA	2015-07-03	\N
138117414994632	POILE	2015-05-19	2018-10-28
138117414994632	ASPIR	2021-11-01	2021-11-13
108095378165916	lATEX	2015-09-26	\N
108095378165916	POLN	2015-04-18	2021-07-16
108095378165916	ARA	2021-04-15	\N
108095378165916	BEE	2021-08-09	2021-10-14
108095378165916	ASPIR	2017-01-19	\N
168127697496623	POLN	2016-09-17	\N
168127697496623	ASPIR	2020-01-11	\N
168127697496623	lATEX	2018-02-11	2018-04-28
106013559184560	BEE	2016-02-15	\N
184058380356337	lATEX	2020-01-10	2020-04-26
184058380356337	POLN	2017-07-03	\N
198076664451368	POILE	2018-07-03	2018-09-24
198076664451368	MOISI	2015-10-21	\N
198076664451368	GUEPE	2019-02-23	\N
198076664451368	GLUTN	2018-08-20	\N
198076664451368	ARA	2017-09-03	2018-06-12
258048082897406	BLATE	2017-08-17	\N
258048082897406	POLN	2021-09-18	2021-09-27
231126440314564	BLATE	2021-08-01	2021-08-20
231126440314564	lATEX	2018-06-19	2020-02-08
138012682483624	POLN	2021-11-08	2021-11-08
204086878297454	MOISI	2017-09-13	\N
204086878297454	ASPIR	2017-11-17	\N
204086878297454	PENIC	2020-05-20	\N
283093646958657	LAV	2016-01-26	\N
271061263635761	GLUTN	2015-10-28	2018-08-12
271061263635761	BEE	2018-05-06	\N
271061263635761	POLN	2021-01-13	\N
105118896795057	PENIC	2015-09-16	2019-02-21
105118896795057	POLN	2020-02-07	2021-05-05
105118896795057	ASPIR	2015-06-13	\N
105118896795057	lATEX	2016-04-28	\N
105118896795057	GLUTN	2017-06-25	2019-07-28
102105813093180	MOISI	2015-07-03	\N
102105813093180	POILE	2020-03-15	\N
237017905332326	PENIC	2019-05-01	\N
263034571304887	ASPIR	2016-06-23	\N
263034571304887	GLUTN	2020-10-27	\N
122079075675007	GUEPE	2017-08-25	\N
122079075675007	LAV	2017-10-10	\N
282129387212331	MOISI	2017-12-02	\N
282129387212331	ARA	2015-02-03	\N
282129387212331	POLN	2020-11-10	\N
282129387212331	BEE	2016-11-13	\N
115026863697543	BLATE	2021-03-21	2021-03-25
115026863697543	POLN	2016-04-03	\N
167044562347780	ASPIR	2015-06-06	2021-07-13
299037133754616	GLUTN	2021-10-02	\N
299037133754616	MOISI	2018-06-07	\N
103031465371271	BEE	2020-12-06	2021-05-16
103031465371271	lATEX	2021-01-18	2021-11-13
103031465371271	POLN	2016-12-13	2018-06-28
104058028163037	BEE	2018-10-27	\N
104058028163037	POLN	2015-11-08	\N
104058028163037	LAV	2016-01-21	2017-05-14
240055854166975	POILE	2017-12-20	2018-10-10
117037132207874	ARA	2020-02-24	\N
117037132207874	GUEPE	2021-07-03	2021-11-11
117037132207874	GLUTN	2017-01-27	\N
117037132207874	POLN	2020-12-10	\N
117037132207874	LAV	2015-04-11	\N
182106998943886	POLN	2019-09-27	\N
182106998943886	POILE	2015-11-17	2021-06-17
182106998943886	PENIC	2019-03-13	2021-02-24
182106998943886	BEE	2015-05-17	\N
182106998943886	MOISI	2020-10-17	\N
287096364247345	lATEX	2020-06-05	\N
287096364247345	PENIC	2017-10-12	2019-04-16
287096364247345	ASPIR	2019-06-09	2021-02-02
287096364247345	MOISI	2015-11-07	\N
205021808810249	GLUTN	2016-03-24	2021-09-28
205021808810249	GUEPE	2016-01-07	2018-03-19
205021808810249	ASPIR	2021-10-26	2021-10-26
205021808810249	POLN	2020-09-22	2021-04-18
266118269787392	GUEPE	2015-12-19	\N
266118269787392	lATEX	2016-02-06	\N
266118269787392	POLN	2021-07-25	\N
184122205851230	GUEPE	2019-12-24	\N
122079030744910	POILE	2017-09-27	2017-09-28
122079030744910	ARA	2019-09-24	\N
224110767613876	GLUTN	2015-06-07	2019-01-13
224110767613876	GUEPE	2021-05-27	\N
224110767613876	POILE	2018-04-23	\N
224110767613876	BLATE	2021-09-19	\N
241037377974214	lATEX	2020-07-21	2021-05-01
108092681347765	GLUTN	2018-07-22	2021-03-11
280018349144984	ASPIR	2018-04-23	2018-09-16
280018349144984	BLATE	2017-09-20	2019-03-23
280018349144984	PENIC	2020-03-11	\N
280018349144984	GUEPE	2017-03-10	\N
280018349144984	MOISI	2018-01-02	\N
196057096921758	ARA	2019-07-11	2019-10-07
196057096921758	ASPIR	2015-07-01	\N
126057880251485	BLATE	2017-07-06	2020-12-06
126057880251485	MOISI	2018-06-28	2021-02-15
126057880251485	POLN	2019-07-04	2021-02-13
126057880251485	ASPIR	2021-05-16	2021-11-02
126057880251485	LAV	2017-09-25	2020-09-28
103069351144655	GUEPE	2017-12-26	\N
196053106233543	GUEPE	2020-12-23	\N
196053106233543	PENIC	2020-03-17	2020-06-05
196053106233543	POLN	2018-07-19	2021-10-28
197072095070400	GLUTN	2015-12-16	2021-07-27
197072095070400	POLN	2017-03-18	2021-08-20
197072095070400	PENIC	2020-02-25	2020-02-28
197072095070400	GUEPE	2018-02-11	\N
257093009218404	ASPIR	2021-11-10	2021-11-14
257093009218404	MOISI	2016-10-09	\N
257093009218404	LAV	2016-06-08	\N
111035950431815	MOISI	2019-08-21	\N
134017162187334	LAV	2018-02-23	2018-05-13
134017162187334	MOISI	2016-09-22	\N
134017162187334	GLUTN	2021-09-26	\N
168030986226722	BEE	2018-03-28	\N
168030986226722	ARA	2017-07-02	2018-01-18
168030986226722	POLN	2017-02-13	2019-06-03
168021202642226	POILE	2015-03-25	\N
201079687531493	BLATE	2016-12-02	\N
201079687531493	GUEPE	2019-12-25	2019-12-27
201079687531493	BEE	2016-05-07	2016-09-24
172083246489015	PENIC	2017-03-09	2019-02-09
172083246489015	GLUTN	2018-05-02	2021-11-11
172083246489015	MOISI	2016-08-12	2020-05-26
238058887249971	LAV	2020-02-24	2020-07-02
182121313633004	LAV	2016-08-14	\N
182121313633004	POLN	2021-02-14	\N
143019130446016	GUEPE	2018-10-20	2021-04-23
143019130446016	BEE	2017-10-03	\N
143019130446016	ARA	2019-12-07	2019-12-13
143019130446016	POILE	2017-04-01	\N
232091464781612	POLN	2018-06-08	\N
232091464781612	PENIC	2017-09-02	\N
232091464781612	POILE	2016-04-20	2016-12-11
232091464781612	MOISI	2018-01-13	\N
224103773518604	GUEPE	2015-10-11	2019-10-16
224103773518604	POLN	2015-10-21	2019-06-23
111117128024918	BLATE	2020-02-22	\N
111117128024918	PENIC	2016-07-28	2018-11-17
195039141611720	BEE	2017-08-08	2021-10-12
195039141611720	ASPIR	2019-10-24	\N
195039141611720	POLN	2018-10-22	2021-03-10
195039141611720	GUEPE	2018-07-16	2021-06-11
110079463566681	POILE	2020-02-04	\N
146038235197769	ARA	2017-04-07	2017-07-07
146038235197769	MOISI	2020-02-08	2020-06-21
146038235197769	BEE	2017-08-10	2019-11-17
277056664098252	lATEX	2016-08-23	2016-08-27
277056664098252	POLN	2017-03-20	\N
277056664098252	BLATE	2016-04-22	2017-01-26
277056664098252	BEE	2020-10-04	\N
289037829621190	ASPIR	2020-11-08	\N
289037829621190	MOISI	2016-05-12	2019-01-13
289037829621190	lATEX	2015-11-03	2018-12-09
289037829621190	PENIC	2020-02-08	2021-04-16
103114111526792	LAV	2019-02-10	\N
215109609078559	LAV	2021-08-15	\N
215109609078559	ASPIR	2015-08-16	\N
215109609078559	PENIC	2016-10-09	2017-11-04
287106613897037	ASPIR	2021-02-13	\N
287106613897037	POLN	2017-05-23	\N
287106613897037	LAV	2019-07-22	2021-05-03
246037149657382	PENIC	2017-02-26	\N
246037149657382	GUEPE	2018-12-16	\N
246037149657382	POILE	2018-06-13	\N
260121787044371	ARA	2016-01-26	\N
260121787044371	PENIC	2016-10-16	\N
260121787044371	BLATE	2019-04-20	2019-11-18
260121787044371	LAV	2021-08-20	\N
260121787044371	GLUTN	2018-12-28	\N
270012241493705	MOISI	2017-08-27	2020-03-07
270012241493705	BEE	2020-08-02	2021-03-13
270012241493705	GLUTN	2015-07-23	2017-08-21
270012241493705	GUEPE	2016-07-14	\N
261060456525634	lATEX	2019-07-22	\N
261060456525634	GUEPE	2015-01-22	\N
261060456525634	ARA	2021-02-12	\N
131021682878445	BLATE	2015-11-14	2021-07-10
131021682878445	GLUTN	2021-06-01	\N
131021682878445	POILE	2021-10-06	2021-10-15
131021682878445	BEE	2018-02-23	2018-12-12
131021682878445	MOISI	2017-03-07	\N
280096672979293	POLN	2020-02-11	\N
280096672979293	ASPIR	2018-09-19	2020-11-13
161110895952876	ASPIR	2015-03-26	2016-02-02
111028862692739	GLUTN	2021-06-20	\N
111028862692739	LAV	2021-03-26	2021-06-19
281033961629584	lATEX	2018-11-01	2020-09-02
283119762283310	POILE	2018-12-11	2021-08-02
283119762283310	BEE	2020-10-01	2021-10-13
283119762283310	ASPIR	2015-07-17	2018-05-03
283119762283310	ARA	2020-03-04	2021-05-25
283119762283310	POLN	2016-10-01	2020-11-13
186108833612501	ASPIR	2016-10-03	\N
186108833612501	lATEX	2019-02-13	\N
186108833612501	POILE	2020-02-16	2020-06-25
186108833612501	POLN	2017-02-19	2019-02-27
144032955003677	GLUTN	2021-01-21	2021-10-03
144032955003677	lATEX	2019-08-01	2019-09-16
144032955003677	ASPIR	2017-12-19	2021-03-20
245031024735106	lATEX	2019-01-23	2019-01-27
245031024735106	BLATE	2018-10-11	\N
244051103911471	POLN	2017-07-25	\N
244051103911471	GUEPE	2020-06-23	\N
143024158070291	POLN	2021-10-14	2021-11-15
143024158070291	BLATE	2021-02-10	2021-09-09
143024158070291	POILE	2017-01-22	\N
296078260808814	BLATE	2019-05-21	2021-03-06
296078260808814	LAV	2017-01-08	2018-09-04
296078260808814	GLUTN	2017-05-05	2018-02-23
296078260808814	ARA	2016-07-12	2018-05-02
129036638333996	GUEPE	2018-08-12	2018-11-07
129036638333996	PENIC	2019-05-23	\N
129036638333996	LAV	2015-11-14	2021-11-14
129036638333996	POILE	2016-07-28	\N
129036638333996	POLN	2021-02-18	2021-04-21
175084237674269	ASPIR	2017-12-27	\N
175084237674269	LAV	2017-10-15	\N
175084237674269	BEE	2017-08-25	2020-03-24
175084237674269	GUEPE	2017-12-22	\N
127109489453869	LAV	2020-11-09	2020-11-16
127109489453869	lATEX	2015-03-25	2016-08-08
127109489453869	BLATE	2020-07-27	\N
127109489453869	MOISI	2020-12-12	\N
127109489453869	PENIC	2015-12-04	2018-01-07
207121168949178	POILE	2019-04-19	2020-03-06
207121168949178	GLUTN	2017-05-01	\N
207121168949178	ARA	2017-03-17	\N
162123090223760	PENIC	2016-05-03	\N
162123090223760	GUEPE	2015-07-23	\N
162123090223760	POILE	2018-09-19	2018-12-05
249123962387030	PENIC	2015-08-19	\N
249123962387030	GLUTN	2021-04-15	2021-08-04
191098072780944	GLUTN	2018-04-17	\N
191098072780944	POLN	2016-11-15	\N
191098072780944	BLATE	2020-10-25	\N
191098072780944	PENIC	2017-10-07	\N
191098072780944	BEE	2021-09-14	2021-11-12
180030334988128	lATEX	2019-02-16	2020-07-04
233095184464913	BEE	2019-07-13	2019-08-11
233095184464913	GLUTN	2015-01-05	2021-04-05
233095184464913	MOISI	2015-07-05	\N
233095184464913	BLATE	2018-07-19	2019-07-27
233095184464913	ASPIR	2019-06-19	\N
290064596215313	GUEPE	2016-03-24	2019-12-05
290064596215313	BEE	2020-01-17	2020-10-25
290064596215313	BLATE	2016-08-20	2021-06-16
162024029695095	GUEPE	2016-12-26	2016-12-27
256035745805285	GUEPE	2015-09-22	\N
256035745805285	ARA	2016-12-07	2018-05-27
256035745805285	MOISI	2018-11-09	\N
256035745805285	POILE	2018-09-06	\N
284025054958080	lATEX	2017-04-15	2018-11-08
198115876820091	PENIC	2019-06-26	2020-06-28
198115876820091	GUEPE	2015-06-19	2015-09-08
198115876820091	GLUTN	2017-08-06	\N
198115876820091	ASPIR	2019-05-18	2020-05-21
292127286360670	ARA	2016-02-26	2019-01-04
292127286360670	BEE	2018-12-02	2020-01-26
292127286360670	PENIC	2017-01-01	2020-06-11
292127286360670	GUEPE	2015-05-25	2019-06-10
238106074150665	lATEX	2019-08-04	\N
124125087042200	ARA	2016-12-18	\N
124125087042200	lATEX	2021-05-02	2021-10-18
124125087042200	POLN	2017-03-19	\N
104107459950188	POILE	2021-07-06	\N
104107459950188	ARA	2021-06-09	2021-10-07
266021326138534	PENIC	2021-06-20	2021-09-18
266021326138534	MOISI	2017-11-07	\N
266021326138534	BEE	2020-08-24	\N
266021326138534	ARA	2017-10-02	\N
177099561621308	lATEX	2018-04-22	\N
177099561621308	GUEPE	2016-12-23	2018-08-19
177099561621308	LAV	2020-04-08	\N
285041428779415	LAV	2021-03-14	2021-11-01
285041428779415	ARA	2016-10-11	\N
285041428779415	POILE	2019-04-07	2019-10-06
285041428779415	MOISI	2016-09-28	\N
285041428779415	BLATE	2015-01-17	2020-07-11
115102762371703	ARA	2020-08-07	2021-11-14
115102762371703	PENIC	2020-01-26	\N
115102762371703	ASPIR	2017-04-17	2019-10-23
115102762371703	BLATE	2015-04-09	2021-11-05
131109289872634	PENIC	2017-01-17	\N
131109289872634	lATEX	2016-02-02	\N
131109289872634	BLATE	2018-01-14	\N
131109289872634	POILE	2016-10-12	\N
131109289872634	LAV	2015-03-17	\N
199069886261876	POILE	2020-03-18	\N
199069886261876	POLN	2015-08-22	\N
199069886261876	GLUTN	2015-07-09	\N
199069886261876	MOISI	2020-12-10	\N
199069886261876	ASPIR	2019-09-19	2020-04-25
189083343412684	PENIC	2016-12-19	2016-12-20
189083343412684	ARA	2020-03-07	\N
225046338616560	POLN	2015-01-11	2016-03-07
225046338616560	PENIC	2020-10-12	\N
225046338616560	MOISI	2017-10-28	\N
225046338616560	ARA	2019-07-13	\N
225046338616560	LAV	2017-01-09	2018-08-21
282125089606113	ARA	2018-09-11	2021-11-09
282125089606113	POLN	2016-06-21	2017-12-13
282125089606113	ASPIR	2016-08-23	\N
282125089606113	lATEX	2019-09-15	2020-09-23
282125089606113	POILE	2015-02-19	\N
268067070083090	ARA	2021-01-24	2021-03-01
268067070083090	MOISI	2018-11-08	2020-01-02
268067070083090	POILE	2021-09-22	\N
268067070083090	BEE	2016-01-24	2020-07-17
148128918443996	GUEPE	2015-10-13	\N
148128918443996	BEE	2019-01-24	\N
148128918443996	LAV	2020-06-19	\N
148128918443996	PENIC	2019-06-14	\N
148128918443996	MOISI	2015-08-04	2017-07-14
134060133645153	LAV	2017-04-20	2020-03-18
134060133645153	GUEPE	2017-06-14	2019-06-28
134060133645153	POILE	2017-12-11	2017-12-23
134060133645153	POLN	2020-07-13	2020-07-16
134060133645153	lATEX	2021-02-21	\N
167073716399416	BEE	2015-10-06	\N
239112027995661	LAV	2019-10-23	\N
239112027995661	ASPIR	2016-03-16	2018-08-05
239112027995661	POILE	2021-10-27	\N
239112027995661	BEE	2017-03-20	\N
239112027995661	POLN	2021-06-09	2021-09-28
155041690002972	ASPIR	2021-01-05	\N
155041690002972	MOISI	2017-11-03	2021-08-02
155041690002972	POILE	2019-08-07	2020-09-25
248092200396476	BLATE	2015-07-23	2019-06-10
248092200396476	POLN	2016-07-27	\N
240035852414745	LAV	2019-10-18	\N
240035852414745	ASPIR	2017-05-27	2020-09-22
240035852414745	PENIC	2021-03-15	\N
146016758089885	POILE	2019-03-14	\N
146016758089885	LAV	2018-01-26	2018-05-23
146016758089885	PENIC	2018-07-08	\N
146016758089885	ASPIR	2017-12-27	2021-06-22
146016758089885	BLATE	2016-05-11	2021-10-25
161067172287541	BLATE	2020-11-10	2020-12-25
161067172287541	POILE	2016-01-06	2020-03-19
161067172287541	GUEPE	2018-03-22	\N
111039511573819	POILE	2021-04-22	2021-08-18
111039511573819	PENIC	2015-10-23	2015-11-03
111039511573819	lATEX	2018-12-04	2020-05-04
111039511573819	BLATE	2019-05-09	\N
217074086831428	PENIC	2016-09-08	\N
293067026576534	GLUTN	2019-03-21	2020-10-06
229104969463987	BLATE	2016-11-11	\N
229104969463987	lATEX	2017-02-23	2019-10-08
229104969463987	POILE	2021-09-26	\N
211126925899180	GUEPE	2019-09-11	2021-07-06
253097276162617	BLATE	2016-09-22	2016-10-07
253097276162617	GUEPE	2020-02-09	\N
236036316584601	POILE	2018-12-17	2020-03-08
236036316584601	BLATE	2019-02-27	2021-04-21
279104322668824	POILE	2017-11-05	2017-11-08
279104322668824	ARA	2015-09-13	\N
129054448109734	POLN	2015-11-03	\N
129054448109734	GLUTN	2021-03-10	2021-09-08
129054448109734	GUEPE	2019-07-25	\N
209049564105921	GUEPE	2017-07-26	2021-10-21
209049564105921	PENIC	2020-01-18	2020-05-11
209049564105921	ARA	2016-10-16	2019-11-13
209049564105921	POLN	2020-11-08	\N
209049564105921	LAV	2017-06-24	2017-09-23
130071148664148	lATEX	2015-11-12	2017-08-01
130071148664148	POLN	2020-02-12	2020-07-11
130071148664148	ARA	2020-07-04	2020-12-11
130071148664148	PENIC	2015-03-20	2020-01-09
130071148664148	BLATE	2021-05-17	2021-06-19
193046098419989	lATEX	2018-07-06	2019-02-07
193046098419989	POILE	2020-08-27	2020-11-03
193046098419989	GLUTN	2017-10-11	\N
108059912447754	POILE	2018-09-20	2019-01-06
108059912447754	MOISI	2015-09-28	\N
108059912447754	LAV	2016-09-23	\N
108059912447754	ARA	2021-03-15	\N
108059912447754	PENIC	2019-08-26	2021-01-24
221084521836196	ASPIR	2017-03-13	2019-12-17
221084521836196	POLN	2021-05-02	2021-08-11
221084521836196	LAV	2019-02-04	2020-09-19
275010892493538	PENIC	2021-11-16	2021-11-17
275010892493538	BEE	2015-12-19	2017-09-22
201104145535465	ASPIR	2021-01-18	2021-11-14
201104145535465	POLN	2021-09-10	\N
201104145535465	LAV	2015-10-24	\N
201104145535465	BEE	2017-01-11	\N
238037295713009	LAV	2016-09-22	\N
238037295713009	POLN	2016-02-16	\N
238037295713009	ASPIR	2018-06-07	\N
145028128718210	POLN	2017-04-03	\N
145028128718210	GUEPE	2015-10-27	2019-04-10
145028128718210	MOISI	2017-09-12	\N
145028128718210	BEE	2018-04-28	2020-05-01
145028128718210	lATEX	2019-07-21	\N
292060159246061	LAV	2015-10-10	\N
292060159246061	BLATE	2019-05-17	2021-06-19
218012483586376	BEE	2021-10-14	2021-10-24
218012483586376	POLN	2017-08-18	2021-05-20
218012483586376	PENIC	2021-04-18	2021-04-25
218012483586376	MOISI	2018-10-11	2018-10-19
218012483586376	POILE	2020-01-05	2021-01-10
289038194355035	LAV	2019-06-01	\N
289038194355035	BLATE	2017-07-26	\N
289038194355035	GUEPE	2016-10-11	\N
289038194355035	ARA	2018-04-06	\N
187070799370259	MOISI	2017-07-15	2018-04-20
108020934941188	lATEX	2021-01-10	2021-11-04
108020934941188	POILE	2015-11-11	\N
108020934941188	BLATE	2016-11-09	2020-07-20
108020934941188	GUEPE	2016-04-19	2016-05-17
259046387441327	BEE	2017-11-01	2018-07-27
259046387441327	GLUTN	2017-12-03	\N
167088138223313	ASPIR	2021-06-03	\N
210117948182854	BEE	2021-02-16	\N
210117948182854	MOISI	2017-11-18	\N
210117948182854	POILE	2019-01-08	\N
210117948182854	BLATE	2021-08-26	\N
107028981594327	PENIC	2019-12-03	\N
288052477041170	BEE	2019-03-01	2019-07-02
288052477041170	POLN	2016-01-10	\N
288052477041170	ASPIR	2017-07-22	2021-05-17
253032370741967	ASPIR	2015-09-03	\N
253032370741967	BLATE	2019-11-11	\N
253032370741967	GUEPE	2021-09-19	2021-10-05
253032370741967	POILE	2019-03-10	\N
149063593850027	MOISI	2021-01-22	\N
149063593850027	lATEX	2017-11-07	\N
149063593850027	POLN	2020-10-01	\N
149063593850027	LAV	2017-11-13	2017-12-01
149063593850027	BEE	2016-03-15	2020-06-07
218121931897884	ARA	2016-07-10	\N
218121931897884	GLUTN	2018-04-11	\N
218121931897884	PENIC	2021-08-17	2021-10-10
218121931897884	BEE	2015-09-03	2018-10-14
262102954655333	lATEX	2021-01-24	2021-07-21
262102954655333	LAV	2017-04-27	\N
262102954655333	GUEPE	2019-12-22	\N
262102954655333	POILE	2021-05-13	2021-07-20
299075025982742	lATEX	2021-05-23	\N
299075025982742	GUEPE	2017-02-27	\N
299075025982742	LAV	2017-01-15	2017-10-28
216121985902635	ASPIR	2018-02-17	2021-04-19
216121985902635	LAV	2020-12-12	2021-04-11
216121985902635	ARA	2016-07-08	2017-12-13
120087250824191	POLN	2019-08-25	2021-03-03
151010535199329	BLATE	2017-02-04	\N
151010535199329	ARA	2017-05-23	\N
202096545459216	GUEPE	2016-05-20	2018-04-17
202096545459216	ASPIR	2021-11-12	2021-11-17
202096545459216	MOISI	2017-04-11	\N
202096545459216	BLATE	2015-05-15	2017-11-16
220036263058474	ASPIR	2015-09-06	2018-11-02
220036263058474	POILE	2017-11-01	\N
220036263058474	BLATE	2019-05-06	2021-07-22
164072065506044	PENIC	2018-12-28	\N
164072065506044	ASPIR	2017-07-07	\N
164072065506044	GUEPE	2019-01-04	2021-05-20
164072065506044	POILE	2015-02-26	\N
164072065506044	lATEX	2016-07-27	2021-01-19
225122828585441	GLUTN	2015-12-01	\N
225122828585441	lATEX	2019-12-17	\N
146027101427837	POLN	2021-09-26	\N
146027101427837	BLATE	2021-05-04	\N
146027101427837	BEE	2018-06-22	\N
157057144009934	GLUTN	2016-06-03	\N
272128938731412	ASPIR	2018-05-23	2019-05-27
272128938731412	BEE	2017-09-21	2017-11-01
123103048076517	LAV	2020-04-27	2020-10-11
123103048076517	ASPIR	2016-05-12	2020-07-18
112067612324530	POLN	2015-09-24	\N
212021771119539	lATEX	2016-01-01	2017-01-18
212021771119539	ARA	2020-05-17	2020-07-16
212021771119539	MOISI	2016-01-05	\N
212021771119539	BLATE	2019-07-26	2021-11-17
133043200981964	BLATE	2016-08-09	2021-09-05
133043200981964	POILE	2015-01-10	\N
133043200981964	ARA	2015-07-01	2016-10-23
133043200981964	GLUTN	2016-09-10	\N
222062702780531	PENIC	2019-03-21	\N
222062702780531	MOISI	2018-09-21	2019-04-11
222062702780531	POLN	2016-11-04	\N
222062702780531	BEE	2016-07-05	2017-02-07
223018989015713	BLATE	2017-08-28	\N
223018989015713	ARA	2019-07-12	\N
223018989015713	GLUTN	2016-01-02	\N
291012132330873	BLATE	2018-08-05	\N
266105404998405	ASPIR	2018-07-11	\N
243101397269448	POLN	2019-07-20	\N
243101397269448	ARA	2019-02-04	2020-07-02
243101397269448	ASPIR	2019-12-03	2019-12-18
243101397269448	PENIC	2017-06-21	2018-02-27
119079086336263	PENIC	2021-10-26	2021-11-05
119079086336263	POLN	2017-02-09	2017-03-11
119079086336263	ARA	2019-06-08	2021-01-08
119079086336263	LAV	2018-06-03	\N
119079086336263	MOISI	2017-03-23	\N
290127332358372	BLATE	2017-07-23	2019-02-02
290127332358372	ARA	2017-09-17	\N
105055073221067	BLATE	2019-03-02	2019-08-08
284070773359105	GLUTN	2016-02-23	\N
284070773359105	lATEX	2017-01-27	\N
128032992380904	ARA	2016-01-10	\N
128032992380904	GUEPE	2016-07-26	\N
128032992380904	GLUTN	2019-10-17	\N
128032992380904	BLATE	2019-04-15	2021-02-04
128032992380904	LAV	2021-01-06	\N
107097295816255	BEE	2017-01-23	2018-12-12
107097295816255	POLN	2020-10-23	2021-10-24
151022965079221	ARA	2016-12-06	2017-11-12
151022965079221	POILE	2016-10-27	2021-01-23
112031596898173	lATEX	2018-03-22	2019-11-15
213081650900924	POLN	2018-09-02	2021-11-06
213081650900924	LAV	2020-10-20	2021-05-15
213081650900924	ARA	2017-12-22	\N
178052502185535	LAV	2021-11-08	2021-11-08
178052502185535	POILE	2016-01-10	2016-02-17
295070626140542	LAV	2020-12-15	2021-07-04
226101586300159	BEE	2018-09-19	2021-11-04
226101586300159	GLUTN	2020-02-19	\N
226101586300159	ASPIR	2018-12-18	\N
226101586300159	GUEPE	2017-06-12	2017-12-28
226101586300159	LAV	2015-01-18	2020-08-21
120058752255719	ASPIR	2015-02-16	2021-03-10
120058752255719	lATEX	2015-08-07	\N
120058752255719	LAV	2015-10-27	\N
120058752255719	GUEPE	2021-04-22	2021-05-06
120058752255719	BEE	2018-05-24	\N
228101775407926	POLN	2018-08-11	2021-05-05
228101775407926	LAV	2020-03-03	2021-06-02
228101775407926	GLUTN	2018-12-19	2020-11-15
228101775407926	MOISI	2020-11-06	2020-11-10
251118467966521	POLN	2018-04-06	\N
251118467966521	PENIC	2021-01-27	2021-08-15
285115820360026	BLATE	2019-07-01	\N
142051862949049	ASPIR	2019-12-13	\N
142051862949049	POLN	2021-04-17	\N
142051862949049	PENIC	2020-10-03	\N
243014454534087	ASPIR	2019-03-12	2021-01-24
243014454534087	PENIC	2019-03-13	2019-10-27
181023381093240	POLN	2019-01-17	2019-01-28
151099301859840	GLUTN	2017-04-18	2020-11-06
151099301859840	ASPIR	2019-06-12	2020-08-01
151099301859840	ARA	2019-03-22	\N
151099301859840	GUEPE	2018-12-28	\N
126054747918290	LAV	2020-11-12	\N
126054747918290	GUEPE	2015-04-28	\N
126054747918290	ASPIR	2021-02-01	\N
294083240333014	ARA	2017-06-02	2018-02-22
294083240333014	MOISI	2018-12-24	\N
139051080064928	lATEX	2019-02-02	\N
139051080064928	POILE	2020-01-08	2020-12-02
139051080064928	ASPIR	2019-06-25	2021-07-05
139051080064928	MOISI	2016-07-28	\N
139051080064928	GUEPE	2019-11-07	\N
162128476044686	BLATE	2018-05-11	\N
162128476044686	lATEX	2021-10-23	\N
162128476044686	POILE	2020-04-21	\N
162128476044686	POLN	2015-10-25	\N
162128476044686	MOISI	2019-04-26	2020-12-06
237041083780905	PENIC	2021-06-04	2021-10-07
237041083780905	GLUTN	2021-05-04	2021-09-23
180097454476416	MOISI	2015-09-15	\N
180097454476416	ARA	2019-06-28	2021-10-11
180097454476416	POLN	2018-05-13	\N
180097454476416	POILE	2018-06-18	2019-03-15
180097454476416	BLATE	2021-03-10	2021-08-04
198019789185927	BLATE	2015-10-02	2018-06-23
198019789185927	MOISI	2018-02-19	\N
198019789185927	POLN	2016-10-22	2020-03-13
198019789185927	lATEX	2019-05-02	\N
198019789185927	ASPIR	2021-11-04	2021-11-16
289075326321716	GLUTN	2016-03-19	2018-05-05
289075326321716	lATEX	2020-05-12	\N
238044454322507	lATEX	2021-01-09	2021-04-12
238044454322507	POILE	2020-01-05	2020-04-25
204095944799952	BLATE	2020-10-06	2020-12-17
204095944799952	lATEX	2021-01-22	2021-04-04
204095944799952	ASPIR	2015-03-17	2019-07-02
204095944799952	POILE	2017-07-10	2017-11-09
204095944799952	PENIC	2019-12-03	2019-12-20
204028909048229	GLUTN	2017-05-14	\N
204028909048229	BLATE	2019-08-12	2020-12-27
279014234476269	POILE	2020-02-04	\N
279014234476269	LAV	2018-10-27	\N
279014234476269	MOISI	2016-01-13	\N
236070319011481	ASPIR	2017-06-12	\N
236070319011481	ARA	2019-01-01	2020-02-02
174048263332316	ASPIR	2017-03-20	2019-11-08
174048263332316	BLATE	2021-05-11	2021-11-12
174048263332316	GLUTN	2017-02-01	\N
174048263332316	GUEPE	2016-06-12	2017-12-18
174048263332316	POILE	2019-07-13	2019-12-03
286062791711375	ASPIR	2017-05-13	2020-05-25
286062791711375	MOISI	2018-12-24	2019-09-09
286062791711375	BEE	2019-04-13	\N
286062791711375	GUEPE	2021-08-01	\N
272111238460186	BEE	2016-06-27	2019-05-14
272111238460186	POILE	2019-07-08	2019-08-03
152111965056410	BLATE	2021-10-03	\N
152111965056410	GUEPE	2018-01-16	\N
152111965056410	MOISI	2015-06-24	2020-08-01
152111965056410	PENIC	2015-03-26	\N
152111965056410	POILE	2015-10-13	\N
165027813307360	lATEX	2021-03-01	2021-03-10
165027813307360	ARA	2020-08-01	2021-07-03
104059069162387	BLATE	2021-04-28	2021-05-09
104059069162387	GLUTN	2015-04-12	2017-03-01
104059069162387	PENIC	2021-02-24	\N
104059069162387	MOISI	2017-06-09	\N
104059069162387	LAV	2017-10-13	\N
188025191934459	POILE	2016-03-11	2018-10-07
188025191934459	PENIC	2018-12-11	2019-01-06
188025191934459	ASPIR	2015-06-02	2021-08-22
188025191934459	MOISI	2020-12-10	2020-12-18
232023864409457	BEE	2017-09-24	2020-09-25
232023864409457	POLN	2017-02-27	2017-04-05
117071617626555	PENIC	2018-05-27	\N
117071617626555	lATEX	2016-10-26	\N
117071617626555	MOISI	2020-03-28	\N
196036458217210	LAV	2015-09-04	2021-11-10
196036458217210	GLUTN	2017-01-02	\N
139096044741391	POILE	2021-07-11	\N
139096044741391	POLN	2015-12-10	2019-02-10
139096044741391	GUEPE	2019-12-11	2020-12-25
139096044741391	ARA	2021-03-14	2021-05-28
139096044741391	MOISI	2018-06-04	2020-11-18
161106377733801	BEE	2020-11-08	\N
161106377733801	MOISI	2021-07-03	2021-10-19
161106377733801	ASPIR	2021-07-02	2021-11-15
266031774123621	BEE	2015-05-21	\N
266031774123621	LAV	2017-10-21	2020-06-17
266031774123621	POILE	2020-10-21	2021-07-09
266031774123621	GUEPE	2018-09-04	\N
238082768160123	POILE	2017-05-18	\N
238082768160123	MOISI	2020-06-06	2021-03-25
238082768160123	PENIC	2018-10-05	\N
238082768160123	ARA	2018-08-20	2018-12-03
116089104911289	GLUTN	2017-09-16	2017-10-20
116089104911289	MOISI	2021-08-02	2021-11-08
116089104911289	BLATE	2021-01-17	2021-09-19
184013026653488	ASPIR	2021-01-05	2021-10-07
190062769594923	POLN	2021-03-05	2021-06-27
190062769594923	ARA	2019-05-23	2019-05-25
190062769594923	BEE	2019-07-21	2020-03-25
190062769594923	POILE	2021-10-05	2021-10-05
129051166985007	GUEPE	2019-06-20	2019-06-24
129051166985007	LAV	2017-05-24	\N
129051166985007	POLN	2016-08-22	\N
171110869020530	ASPIR	2016-01-25	2020-02-27
171110869020530	POLN	2015-11-11	2019-01-27
171110869020530	BEE	2017-02-16	2019-07-28
170085720360240	BEE	2015-09-27	\N
170085720360240	lATEX	2020-10-04	\N
170085720360240	LAV	2021-05-08	2021-10-17
128119566368842	GUEPE	2017-02-06	2020-03-24
128119566368842	BLATE	2021-10-16	2021-10-28
250072870574866	POILE	2020-01-05	2021-02-01
250072870574866	BLATE	2021-11-03	2021-11-09
250072870574866	LAV	2016-01-24	2017-06-06
275034106311549	POLN	2016-09-21	2018-02-11
293072659007230	BLATE	2018-09-28	2019-05-08
293072659007230	GLUTN	2015-12-11	2015-12-16
202010382752991	POLN	2018-09-07	\N
202010382752991	ARA	2020-02-16	\N
202010382752991	BEE	2017-12-24	2019-05-25
202010382752991	BLATE	2019-01-21	\N
202010382752991	POILE	2019-02-27	2021-05-03
119072545360121	ARA	2015-07-22	2020-07-26
119072545360121	BLATE	2015-05-21	2017-10-05
119072545360121	MOISI	2021-02-21	\N
119072545360121	ASPIR	2021-07-16	\N
213077721801746	lATEX	2021-01-02	\N
213077721801746	PENIC	2018-10-10	2020-03-08
294089748643596	GUEPE	2021-06-26	2021-06-27
294089748643596	lATEX	2017-12-07	\N
294089748643596	ARA	2015-10-03	\N
294089748643596	POILE	2019-03-17	2019-05-02
223120960061912	MOISI	2018-04-11	\N
223120960061912	POLN	2016-10-07	2019-05-09
223120960061912	lATEX	2017-03-05	2017-07-08
223120960061912	BEE	2020-02-27	\N
223120960061912	PENIC	2018-05-03	2021-03-17
186033137213249	PENIC	2020-03-20	\N
186033137213249	LAV	2020-01-15	\N
186033137213249	POILE	2016-04-07	2020-02-04
186033137213249	ASPIR	2015-03-09	2018-05-12
244013618672814	lATEX	2016-06-01	\N
244013618672814	BEE	2018-11-09	\N
244013618672814	GLUTN	2020-09-06	\N
196061733484675	BLATE	2016-02-20	2018-07-15
196061733484675	ARA	2021-10-09	\N
196061733484675	POILE	2019-06-12	2021-06-19
196061733484675	GLUTN	2019-02-09	2020-12-07
106089885680755	GUEPE	2018-08-21	\N
106089885680755	POILE	2017-12-27	2020-01-24
208101367016896	lATEX	2019-09-12	2020-01-26
208101367016896	LAV	2021-07-26	2021-07-27
208101367016896	ARA	2016-08-19	\N
139105087154042	POILE	2018-03-24	2018-04-18
139105087154042	GLUTN	2016-07-05	2019-10-19
139105087154042	POLN	2016-08-05	2021-02-08
139105087154042	LAV	2019-11-16	\N
158030363231988	GLUTN	2021-01-01	\N
158030363231988	ASPIR	2015-12-06	\N
158030363231988	PENIC	2015-05-23	\N
158030363231988	LAV	2016-10-08	2018-04-21
297076719709643	ARA	2020-07-27	\N
297076719709643	PENIC	2017-02-26	\N
222046381429882	LAV	2015-03-21	\N
222046381429882	ASPIR	2019-06-20	\N
222046381429882	GUEPE	2018-06-01	2018-11-16
222046381429882	MOISI	2021-09-23	\N
134049072360994	BEE	2015-04-14	2019-12-12
134049072360994	POLN	2015-04-01	\N
134049072360994	GUEPE	2020-02-25	\N
134049072360994	ASPIR	2021-08-04	\N
211086595791575	ARA	2017-12-01	2021-10-28
211086595791575	GLUTN	2018-01-09	\N
211086595791575	PENIC	2016-08-25	2017-02-09
239043603031156	lATEX	2020-03-21	\N
239043603031156	PENIC	2021-01-02	2021-01-25
239043603031156	POLN	2021-05-16	2021-11-15
239043603031156	MOISI	2017-10-03	2021-07-02
150017226774891	MOISI	2015-04-02	2015-04-17
150017226774891	GUEPE	2016-11-09	\N
150017226774891	POILE	2018-04-01	\N
150017226774891	LAV	2017-12-09	\N
290060531145979	MOISI	2021-04-10	2021-08-13
290060531145979	BLATE	2019-03-08	2020-07-28
290060531145979	ASPIR	2017-05-03	\N
290060531145979	LAV	2020-02-06	\N
290060531145979	POLN	2016-04-19	2017-12-10
125043167496449	ASPIR	2018-03-22	\N
125043167496449	lATEX	2019-07-07	2019-08-21
125043167496449	POLN	2021-02-09	2021-05-09
259029921552493	lATEX	2016-08-28	\N
259029921552493	GLUTN	2020-06-08	2020-06-22
259029921552493	POILE	2017-12-19	\N
259029921552493	GUEPE	2021-08-23	2021-09-13
165089604254636	BLATE	2018-09-03	2021-06-01
165089604254636	PENIC	2019-09-10	2019-11-02
165089604254636	GLUTN	2017-09-09	\N
165089604254636	GUEPE	2019-05-14	\N
169045466583502	POLN	2015-12-20	2021-05-16
155078862032976	BEE	2015-06-16	2016-10-21
155078862032976	MOISI	2021-07-17	2021-08-15
155078862032976	lATEX	2017-09-19	2017-10-22
155078862032976	POILE	2020-02-18	\N
155078862032976	PENIC	2016-09-20	2018-06-16
236050817608085	POLN	2015-02-05	2016-02-13
236050817608085	ASPIR	2017-08-28	\N
236050817608085	PENIC	2017-09-14	\N
228068017689713	PENIC	2017-10-26	\N
228068017689713	POLN	2018-04-18	2019-08-17
228068017689713	ASPIR	2017-02-28	\N
228068017689713	lATEX	2017-06-12	2019-03-26
139092699004560	MOISI	2021-05-07	2021-06-16
184080527855873	LAV	2015-09-19	2016-02-02
184080527855873	POLN	2021-05-25	\N
184080527855873	PENIC	2020-06-09	2021-11-08
184080527855873	lATEX	2017-10-14	\N
184080527855873	BLATE	2017-05-14	2018-06-25
159097071302004	MOISI	2018-03-20	\N
171113093221638	BLATE	2018-08-04	2021-11-11
171113093221638	LAV	2018-08-26	2019-03-04
171113093221638	BEE	2020-07-11	2020-11-18
171113093221638	ASPIR	2016-09-09	\N
256037369716944	ASPIR	2021-06-20	2021-09-04
256037369716944	POILE	2017-05-17	\N
141030952640812	BEE	2016-05-11	\N
141030952640812	BLATE	2021-03-23	\N
141030952640812	GUEPE	2021-09-16	2021-09-16
141030952640812	MOISI	2019-04-27	2021-09-13
264019381752416	BEE	2015-12-08	\N
264019381752416	ASPIR	2019-12-23	\N
264019381752416	POILE	2016-01-05	2019-07-22
206051413439664	POLN	2018-06-17	\N
206051413439664	BEE	2017-12-17	2017-12-19
206051413439664	POILE	2015-11-14	2015-12-17
206051413439664	GLUTN	2019-02-03	\N
206051413439664	ARA	2015-02-16	\N
117043894183463	lATEX	2019-04-14	2020-01-27
117043894183463	MOISI	2021-11-13	\N
117043894183463	POLN	2017-01-04	\N
117043894183463	BEE	2020-07-10	\N
282106583597519	BLATE	2020-07-02	2021-03-12
282106583597519	PENIC	2017-12-03	\N
282106583597519	ASPIR	2021-05-17	\N
282106583597519	LAV	2017-01-17	\N
126127518943951	POLN	2015-09-25	2021-07-16
129088384201146	BEE	2018-03-18	2019-02-07
129088384201146	BLATE	2015-06-11	\N
129088384201146	POLN	2017-03-04	2021-04-22
129088384201146	ASPIR	2019-10-08	2019-11-06
156127291989632	BEE	2015-12-19	2019-08-06
156127291989632	BLATE	2017-10-07	\N
117064052014050	LAV	2017-08-13	\N
117064052014050	BEE	2015-08-16	\N
117064052014050	PENIC	2018-06-19	\N
117064052014050	BLATE	2017-08-18	\N
266032587199748	MOISI	2018-03-21	2018-09-04
266032587199748	POILE	2016-08-16	\N
266032587199748	GUEPE	2018-08-23	\N
266032587199748	ARA	2016-08-27	2016-09-16
201068456551393	MOISI	2018-11-12	\N
201068456551393	GUEPE	2018-09-22	\N
201068456551393	ARA	2019-06-20	2020-08-24
201068456551393	GLUTN	2015-06-16	2018-09-21
280013103555645	LAV	2019-06-24	\N
280013103555645	POLN	2016-02-24	\N
280013103555645	GLUTN	2019-07-20	\N
288106819148682	LAV	2021-06-16	2021-07-19
220068901669705	PENIC	2015-04-03	2018-05-21
220068901669705	GLUTN	2020-09-23	\N
220068901669705	LAV	2021-09-20	2021-09-26
220068901669705	POILE	2020-03-05	\N
220068901669705	MOISI	2020-08-11	2020-11-16
218120824070079	ARA	2018-01-06	2020-04-10
218120824070079	GUEPE	2020-05-21	2020-08-28
218120824070079	BLATE	2015-02-04	\N
218120824070079	GLUTN	2019-03-10	\N
194075342972573	ARA	2018-05-03	2020-12-06
194075342972573	POILE	2021-06-20	2021-07-11
296099765223309	ARA	2018-02-02	2018-05-05
296099765223309	GLUTN	2019-11-04	\N
185021399708089	ASPIR	2020-05-02	2021-10-03
185021399708089	ARA	2015-11-09	\N
185021399708089	POLN	2020-01-14	2021-03-02
278094704116338	GUEPE	2018-11-09	2018-12-02
278094704116338	LAV	2020-01-16	2020-05-20
278094704116338	POLN	2021-06-02	2021-09-10
139105281222043	GLUTN	2016-09-03	2019-05-20
227083579705919	BEE	2021-10-14	\N
227083579705919	PENIC	2016-07-07	\N
195087761492606	MOISI	2016-03-26	\N
195087761492606	POLN	2018-08-27	\N
195087761492606	GLUTN	2020-03-25	2020-12-26
127100875228221	POLN	2020-12-22	2020-12-28
127100875228221	POILE	2017-10-18	\N
127100875228221	BEE	2019-06-06	2021-08-14
169122788622827	BLATE	2016-06-28	\N
169122788622827	PENIC	2018-07-02	\N
169122788622827	POILE	2017-07-25	2019-08-26
118111411157996	MOISI	2020-01-19	2020-11-03
118111411157996	ARA	2017-01-05	2018-01-11
118111411157996	POILE	2020-10-04	2021-09-21
118111411157996	GUEPE	2016-08-09	2019-09-15
254102671108666	LAV	2017-12-19	2017-12-23
254102671108666	ARA	2016-05-15	\N
254102671108666	BEE	2019-11-16	\N
113065641678643	lATEX	2017-03-01	2019-06-10
221021115240958	GLUTN	2017-04-04	2019-03-21
221021115240958	BLATE	2019-02-25	\N
221021115240958	ASPIR	2019-02-25	2019-02-27
221021115240958	ARA	2020-01-25	\N
287051297819393	MOISI	2015-05-23	\N
287051297819393	POILE	2021-04-20	2021-04-25
287051297819393	BEE	2021-01-27	\N
236071547970159	ARA	2020-09-19	2020-09-23
236071547970159	PENIC	2015-04-14	\N
236071547970159	MOISI	2018-04-04	2020-06-27
152074748442071	GUEPE	2019-02-27	2019-10-25
152074748442071	GLUTN	2016-03-06	2019-01-28
131084757421667	lATEX	2018-06-16	\N
131084757421667	GUEPE	2017-05-25	2021-04-01
131084757421667	LAV	2021-01-24	\N
131084757421667	POILE	2020-09-08	2020-10-27
131084757421667	ARA	2017-06-18	\N
108077100841690	BLATE	2020-07-04	2021-01-23
108077100841690	PENIC	2017-02-03	\N
181017147729962	BEE	2021-03-20	\N
181017147729962	lATEX	2017-05-27	2021-07-18
121071265687319	lATEX	2015-10-20	\N
121071265687319	POILE	2019-07-15	\N
121071265687319	LAV	2016-01-27	\N
121071265687319	BEE	2021-09-09	2021-10-04
115030403153781	MOISI	2019-05-22	\N
115030403153781	ARA	2019-10-25	\N
115030403153781	POILE	2019-12-28	2019-12-28
175073159041662	GUEPE	2021-07-14	\N
110042098683095	GUEPE	2015-01-06	\N
110042098683095	POILE	2019-03-22	\N
110042098683095	ARA	2018-10-14	2019-01-05
109030537258504	BLATE	2016-04-23	2018-03-16
109030537258504	ARA	2017-08-19	\N
109030537258504	PENIC	2017-02-12	2017-04-16
109030537258504	ASPIR	2018-11-16	2020-04-16
223066675112456	PENIC	2018-02-01	\N
282112984855467	LAV	2020-01-10	2020-04-05
282112984855467	lATEX	2015-11-10	2021-03-14
282112984855467	ARA	2021-03-17	\N
282112984855467	GLUTN	2021-04-11	\N
282112984855467	ASPIR	2020-12-22	2021-05-10
206015685037422	BLATE	2019-04-22	\N
206015685037422	lATEX	2019-11-10	2021-07-17
206015685037422	GLUTN	2015-03-04	\N
206015685037422	LAV	2017-09-20	2017-09-22
206015685037422	PENIC	2018-09-10	2020-11-07
186069087679009	lATEX	2015-09-03	2017-06-09
186069087679009	POLN	2020-05-10	2020-07-17
186069087679009	ARA	2015-04-21	\N
186069087679009	BEE	2020-07-26	2021-10-24
186069087679009	BLATE	2016-04-05	\N
216040451818667	POILE	2020-03-10	\N
216040451818667	BLATE	2021-01-10	\N
216040451818667	LAV	2015-07-28	\N
216040451818667	POLN	2018-02-25	2021-02-27
216040451818667	ASPIR	2015-09-15	2021-08-08
123107251805832	BEE	2019-06-23	\N
123107251805832	GLUTN	2020-01-16	2021-03-24
123107251805832	POLN	2021-01-05	2021-03-20
123107251805832	lATEX	2021-02-06	2021-09-24
273083395115649	POLN	2019-12-13	2020-02-19
273083395115649	GUEPE	2019-02-19	2020-01-15
273083395115649	BLATE	2015-03-24	\N
273083395115649	BEE	2021-06-02	2021-07-07
113061066882595	GUEPE	2016-07-05	2019-02-12
112032779042732	ARA	2021-05-05	\N
112032779042732	POLN	2019-02-08	2020-09-11
112032779042732	BLATE	2021-07-28	2021-09-24
112032779042732	BEE	2018-09-01	\N
256051093900976	MOISI	2021-06-07	\N
183112049563783	POLN	2019-10-01	2019-10-25
183112049563783	PENIC	2018-03-12	\N
183112049563783	GUEPE	2019-08-07	\N
187121135696356	lATEX	2021-02-27	\N
142101413261413	BEE	2018-11-16	\N
142101413261413	POILE	2017-03-08	\N
142101413261413	ASPIR	2018-11-16	2018-12-04
142101413261413	ARA	2021-11-01	2021-11-02
136097591466460	POLN	2017-02-08	\N
136097591466460	GLUTN	2017-08-03	\N
136097591466460	LAV	2018-12-12	\N
223115310429678	POLN	2020-04-02	\N
281038699937926	POILE	2021-10-15	\N
281038699937926	GLUTN	2020-12-14	\N
281038699937926	lATEX	2017-07-26	\N
281038699937926	ARA	2015-05-14	\N
200052554875542	BLATE	2016-08-23	\N
200052554875542	ASPIR	2021-07-05	\N
200052554875542	BEE	2018-03-10	\N
160103642429132	GUEPE	2017-05-16	\N
160103642429132	BLATE	2015-11-17	\N
160103642429132	lATEX	2017-03-17	2019-08-18
107087240250732	MOISI	2015-09-20	\N
107087240250732	BLATE	2017-03-26	2017-08-21
202123105157942	LAV	2019-01-16	2019-09-22
202123105157942	POLN	2019-08-02	2021-06-11
202123105157942	POILE	2017-01-05	\N
202123105157942	ASPIR	2020-02-07	\N
202123105157942	ARA	2015-05-04	2018-04-06
297096978369003	POILE	2017-02-10	2018-10-03
186021649778788	lATEX	2020-07-14	2020-09-13
186021649778788	PENIC	2020-07-18	\N
186021649778788	GUEPE	2021-06-24	2021-10-26
186021649778788	POLN	2020-02-04	\N
103095695159235	POILE	2017-06-21	2020-01-10
103095695159235	GUEPE	2020-10-19	\N
103095695159235	ARA	2015-10-18	2019-09-03
175066592387802	lATEX	2020-11-02	\N
113115246343642	LAV	2017-09-02	\N
113115246343642	POILE	2021-11-07	2021-11-15
113115246343642	lATEX	2020-05-15	2020-08-27
142038048913513	ARA	2021-08-05	\N
142038048913513	BEE	2016-05-05	2017-03-24
142038048913513	POLN	2019-11-14	\N
142038048913513	lATEX	2018-02-26	\N
142038048913513	POILE	2017-03-25	\N
176078894344648	GLUTN	2017-04-28	2019-09-01
176078894344648	BEE	2019-07-06	\N
255101453587957	GUEPE	2016-07-03	2016-07-16
236060592944147	GUEPE	2018-05-14	2018-12-16
286032428338414	LAV	2017-10-22	2020-12-23
286032428338414	POILE	2019-07-23	\N
286032428338414	POLN	2018-01-02	\N
286032428338414	BLATE	2018-04-16	2018-11-04
213092819479712	PENIC	2019-06-25	2020-12-20
213092819479712	POLN	2018-06-12	2021-04-01
167089520011854	BLATE	2020-10-27	2020-11-15
287018725817056	GLUTN	2020-02-21	2020-07-17
287018725817056	BLATE	2020-09-27	\N
287018725817056	PENIC	2015-01-05	\N
287018725817056	LAV	2017-01-16	2021-03-11
205062269993651	ARA	2017-01-13	\N
138060554444491	POLN	2020-06-19	2021-11-08
158069665674107	BLATE	2018-07-27	\N
157073274149735	POLN	2017-05-10	\N
212100642731642	BEE	2017-07-21	2021-08-02
241049099179176	BEE	2021-10-15	2021-10-21
241049099179176	PENIC	2016-03-23	2021-11-11
241049099179176	lATEX	2018-10-13	2018-10-25
241049099179176	POLN	2020-04-15	\N
241049099179176	ASPIR	2019-08-23	\N
226122696935272	GUEPE	2021-06-03	2021-10-13
226122696935272	PENIC	2016-12-25	2018-03-17
226122696935272	BLATE	2018-09-20	2021-08-27
226122696935272	lATEX	2020-12-09	\N
226122696935272	POLN	2017-11-08	2018-11-16
133119158204920	POILE	2020-06-21	2020-09-21
140018008302573	POILE	2016-06-04	2016-11-06
140018008302573	GLUTN	2015-01-19	\N
140018008302573	LAV	2015-06-26	\N
140018008302573	GUEPE	2020-10-11	2021-07-19
179024378361353	ASPIR	2020-03-12	2021-10-21
179024378361353	BLATE	2018-03-18	\N
179024378361353	LAV	2018-10-23	\N
223113006500836	PENIC	2020-11-14	\N
100109271865326	ARA	2019-10-11	\N
100109271865326	PENIC	2021-08-08	2021-09-25
150056887375968	MOISI	2016-02-19	\N
150056887375968	lATEX	2021-06-11	\N
150056887375968	PENIC	2017-03-01	2019-04-11
264107842330942	lATEX	2015-01-07	\N
264107842330942	ARA	2016-12-18	2016-12-18
264107842330942	ASPIR	2017-03-22	\N
264107842330942	GUEPE	2020-04-28	2020-05-11
264107842330942	PENIC	2019-05-12	2019-12-27
134020487954794	GUEPE	2015-08-26	\N
134020487954794	PENIC	2021-04-16	2021-05-16
134020487954794	POLN	2018-07-23	\N
150038037909168	GUEPE	2015-01-19	2018-08-26
150038037909168	BEE	2016-07-01	2020-11-17
150038037909168	GLUTN	2017-04-19	2020-07-11
114040705604665	ARA	2016-10-28	\N
114040705604665	ASPIR	2018-01-21	\N
281011552942390	BLATE	2017-01-15	\N
281011552942390	GUEPE	2015-09-03	\N
281011552942390	lATEX	2015-11-04	\N
208073703603064	GUEPE	2021-10-17	2021-11-06
195124129077459	BEE	2020-12-20	\N
203042945551495	POLN	2015-07-03	2016-08-13
283058967147128	POILE	2020-11-08	\N
118058843585359	GUEPE	2017-07-22	2018-02-10
118058843585359	POLN	2020-07-19	2020-08-21
118058843585359	LAV	2015-04-18	2017-09-08
118058843585359	PENIC	2021-03-27	2021-03-28
118058843585359	MOISI	2015-06-26	\N
245083736982839	MOISI	2018-08-28	2019-04-06
116019000258412	POILE	2019-11-03	\N
116019000258412	LAV	2018-07-04	\N
131120964176884	ARA	2017-11-07	\N
131120964176884	BLATE	2018-03-28	2021-05-02
131120964176884	GLUTN	2018-04-09	2021-11-10
131120964176884	POLN	2020-08-19	2020-11-12
131120964176884	LAV	2019-08-09	2019-11-18
149111387041541	BEE	2016-08-12	\N
153128900719727	PENIC	2016-05-02	\N
153128900719727	MOISI	2018-11-16	2021-02-20
150034197947334	GLUTN	2015-12-02	2016-09-11
245028537507582	ARA	2020-08-09	2020-12-04
245028537507582	ASPIR	2016-03-22	2020-08-15
245028537507582	GLUTN	2019-10-20	\N
252106588392132	POILE	2020-02-23	2020-08-07
252106588392132	POLN	2018-08-05	\N
252106588392132	LAV	2016-04-17	2021-08-08
163054889165115	LAV	2015-08-18	\N
163054889165115	BLATE	2017-11-08	\N
163054889165115	MOISI	2019-09-19	2019-09-21
114092770726295	POILE	2016-04-02	\N
114092770726295	BEE	2018-04-11	\N
251123729430821	MOISI	2021-01-12	\N
193071493716975	BEE	2021-04-09	2021-07-22
106099937166117	BLATE	2019-05-02	2020-11-03
106099937166117	BEE	2015-09-22	\N
106099937166117	POILE	2021-09-11	\N
106099937166117	ARA	2017-07-06	\N
106099937166117	ASPIR	2021-09-16	\N
131084231150591	GUEPE	2016-01-24	\N
131084231150591	POILE	2021-02-19	\N
131084231150591	PENIC	2017-03-12	2019-09-17
131084231150591	POLN	2017-02-20	\N
209027164298065	BEE	2016-08-24	\N
209027164298065	LAV	2019-05-19	\N
209027164298065	POLN	2015-11-16	\N
209027164298065	BLATE	2019-03-02	2019-05-20
199078543975254	GUEPE	2015-04-17	\N
199078543975254	BEE	2020-05-13	2020-06-15
100049631898104	lATEX	2021-03-18	\N
100049631898104	ARA	2018-03-13	\N
234053975548370	MOISI	2020-11-02	\N
234053975548370	PENIC	2017-01-08	\N
184025786706731	BEE	2019-10-16	\N
184025786706731	ARA	2021-02-17	2021-11-05
184025786706731	GLUTN	2021-06-23	\N
274022481152500	POLN	2017-03-18	2017-07-16
274022481152500	POILE	2015-09-18	\N
274022481152500	LAV	2020-09-11	\N
240026048838751	lATEX	2018-01-10	\N
240026048838751	MOISI	2017-11-11	2021-09-17
178054655023440	BEE	2020-08-15	\N
178054655023440	PENIC	2015-03-17	2021-10-27
178054655023440	GUEPE	2019-07-08	2021-02-18
178054655023440	BLATE	2020-05-10	\N
178054655023440	ARA	2015-10-18	\N
110080140197255	lATEX	2020-06-24	2021-06-27
110080140197255	POILE	2018-02-12	\N
110080140197255	PENIC	2019-12-27	\N
110080140197255	BEE	2020-10-04	2021-10-19
110080140197255	POLN	2020-03-07	\N
161034008075245	POLN	2021-10-09	2021-10-16
107032841366591	BLATE	2018-05-27	2021-10-09
258012906416470	LAV	2018-04-28	\N
258012906416470	BEE	2015-08-16	2018-03-13
258012906416470	ARA	2017-01-25	\N
258012906416470	BLATE	2018-04-16	2020-10-04
230118436329405	MOISI	2016-05-21	2017-09-21
230118436329405	POILE	2016-11-18	\N
230118436329405	GLUTN	2021-07-18	2021-07-21
181044191868718	GUEPE	2020-01-05	2021-11-05
181044191868718	MOISI	2015-11-05	2016-01-10
181044191868718	BEE	2018-04-28	2019-05-14
192016782931511	POLN	2017-03-24	2020-03-25
192016782931511	LAV	2016-03-08	2017-05-13
259074697674603	PENIC	2016-05-07	\N
259074697674603	LAV	2017-02-01	2018-03-20
259074697674603	ARA	2017-07-03	\N
259074697674603	ASPIR	2015-11-11	\N
259074697674603	POILE	2016-06-20	\N
127019244540438	ARA	2017-03-20	\N
148121190383571	lATEX	2016-10-05	\N
148121190383571	ARA	2021-06-24	\N
148121190383571	BEE	2015-02-04	2015-02-14
148121190383571	POILE	2021-01-22	2021-04-28
264107910075035	GUEPE	2016-02-06	\N
264107910075035	POLN	2019-09-25	2021-05-03
264107910075035	lATEX	2016-12-03	\N
264107910075035	BEE	2018-04-15	\N
264107910075035	BLATE	2021-01-15	\N
210030438953147	POLN	2017-08-13	\N
210030438953147	BLATE	2019-07-08	\N
210030438953147	PENIC	2019-07-02	\N
210030438953147	ARA	2018-06-28	2021-02-13
210042436071478	LAV	2017-03-05	\N
210042436071478	POLN	2021-10-27	2021-10-28
134051402379911	PENIC	2017-02-12	2019-09-05
134051402379911	GLUTN	2019-07-10	\N
196018757049140	BLATE	2020-09-24	2020-09-28
196018757049140	PENIC	2016-06-23	2016-10-03
170115855210295	ASPIR	2017-11-14	\N
170115855210295	POILE	2017-05-01	2019-04-08
170115855210295	MOISI	2018-12-06	\N
170115855210295	GLUTN	2020-01-15	\N
292032690622575	ARA	2016-04-08	2021-11-17
297025448866853	GLUTN	2016-06-14	\N
297025448866853	ASPIR	2017-09-02	\N
297025448866853	POILE	2019-06-08	\N
297025448866853	POLN	2015-10-19	\N
297025448866853	LAV	2016-09-17	\N
239057582114519	POLN	2021-11-05	\N
239057582114519	ASPIR	2017-11-17	2017-12-19
239057582114519	GLUTN	2016-12-25	2017-01-04
239057582114519	BEE	2021-02-10	\N
189061293903962	PENIC	2015-05-07	\N
189061293903962	POILE	2015-10-25	2018-10-25
189061293903962	POLN	2016-05-20	2020-03-27
107021159794718	ASPIR	2019-05-27	\N
107021159794718	GLUTN	2018-10-22	2019-08-02
107021159794718	LAV	2017-04-05	\N
107021159794718	PENIC	2020-02-08	\N
235050703254130	GUEPE	2018-03-11	\N
235050703254130	ASPIR	2021-10-19	2021-11-11
235050703254130	ARA	2017-02-14	2021-02-16
235050703254130	GLUTN	2020-06-23	2021-07-07
235050703254130	BLATE	2017-12-02	\N
225058455250413	POILE	2015-05-18	2020-01-15
225058455250413	PENIC	2016-09-23	2019-08-11
225058455250413	lATEX	2017-09-05	2021-10-17
150086595242939	PENIC	2016-11-03	\N
150086595242939	POILE	2020-01-23	2020-01-23
103076152831337	lATEX	2016-08-05	\N
103076152831337	LAV	2019-10-03	\N
198080243696000	POLN	2019-08-22	2020-02-17
198080243696000	MOISI	2018-01-15	\N
198080243696000	GUEPE	2015-01-01	2016-12-22
198080243696000	ASPIR	2020-09-10	\N
198080243696000	ARA	2016-11-06	2016-11-16
152011275394961	POLN	2020-01-10	2020-07-13
152011275394961	BEE	2019-09-24	\N
152011275394961	MOISI	2019-10-04	\N
152011275394961	ARA	2019-05-09	2021-11-13
152011275394961	lATEX	2019-12-07	\N
240121987869929	ASPIR	2015-06-14	\N
240121987869929	BLATE	2021-09-20	\N
121107075333327	ASPIR	2015-02-27	2016-11-07
290043665477208	BEE	2016-04-23	2016-11-11
290043665477208	lATEX	2019-07-25	\N
290043665477208	GLUTN	2020-07-22	\N
290043665477208	ASPIR	2016-03-05	\N
290043665477208	POLN	2020-09-11	2021-10-11
224039225017336	POILE	2018-04-19	\N
224039225017336	GLUTN	2016-07-18	\N
224039225017336	MOISI	2015-04-26	2016-11-15
255093111334747	MOISI	2019-11-18	2020-02-15
255093111334747	POILE	2016-12-14	\N
154070228992208	ASPIR	2019-10-22	2020-04-20
154070228992208	POILE	2021-08-14	2021-08-19
279121641670735	lATEX	2021-05-11	2021-09-10
279121641670735	POILE	2020-03-06	2020-04-16
266092921839948	LAV	2018-09-20	2018-12-19
266092921839948	POLN	2018-10-03	2020-08-17
266092921839948	BEE	2015-10-25	\N
283124185961943	BLATE	2016-11-07	\N
283124185961943	GUEPE	2017-11-10	2021-04-18
283124185961943	POLN	2020-05-27	2020-05-27
111013917857673	GLUTN	2015-11-14	2016-12-02
131109142556613	BEE	2021-03-25	\N
131109142556613	BLATE	2016-09-22	\N
127020452119710	PENIC	2019-09-16	2020-01-12
127020452119710	ASPIR	2018-05-26	\N
187014852065018	POILE	2017-01-22	2020-04-08
187014852065018	BLATE	2017-04-19	\N
169025278120012	lATEX	2016-10-19	2018-02-02
169025278120012	GLUTN	2017-05-09	2020-12-24
169025278120012	MOISI	2017-06-21	2019-04-10
169025278120012	BEE	2015-01-19	2017-07-20
169025278120012	ARA	2017-08-24	2019-05-06
143033632736665	POILE	2018-12-26	\N
240030208771657	BLATE	2021-03-25	2021-08-10
240030208771657	MOISI	2018-02-24	2021-02-24
240030208771657	GLUTN	2015-05-14	2017-03-07
240030208771657	ASPIR	2019-01-14	\N
240030208771657	BEE	2019-02-09	\N
231072312146616	LAV	2021-11-17	\N
231072312146616	MOISI	2015-06-23	2018-03-01
231072312146616	GUEPE	2019-07-09	\N
231072312146616	lATEX	2020-09-18	2021-02-24
135030745344836	LAV	2016-02-20	\N
135030745344836	lATEX	2019-04-13	2019-07-05
260059790196310	POLN	2019-01-13	\N
145041267838254	MOISI	2019-06-18	\N
145041267838254	ARA	2016-09-07	2016-12-12
145041267838254	PENIC	2020-04-21	\N
145041267838254	POILE	2021-11-16	2021-11-18
145041267838254	GLUTN	2016-06-14	2017-07-21
178067934684562	GUEPE	2021-01-12	2021-07-27
178067934684562	PENIC	2017-09-24	2019-08-06
178067934684562	LAV	2019-05-21	\N
178067934684562	lATEX	2015-01-07	2016-07-02
174053709791679	ASPIR	2020-02-07	2020-06-02
174053709791679	LAV	2016-10-21	\N
174053709791679	GUEPE	2019-10-22	\N
174053709791679	PENIC	2017-10-05	\N
174053709791679	POILE	2021-11-06	2021-11-14
142086019899660	MOISI	2017-06-07	2021-06-23
142086019899660	POLN	2016-01-10	2019-08-27
180084675181912	MOISI	2020-12-19	\N
180084675181912	POILE	2017-02-08	\N
180084675181912	POLN	2020-07-07	\N
131125067536259	POLN	2019-04-25	2019-12-05
131125067536259	BLATE	2017-08-23	\N
131125067536259	lATEX	2016-11-01	\N
131125067536259	ASPIR	2015-03-26	\N
149077433486489	LAV	2021-05-16	2021-07-27
149077433486489	GLUTN	2015-08-08	2018-06-06
149077433486489	lATEX	2021-10-07	\N
149077433486489	GUEPE	2021-10-19	2021-10-21
116032805072076	POILE	2019-03-17	\N
116032805072076	ASPIR	2019-05-28	\N
116032805072076	BLATE	2020-03-05	2020-06-07
224019865233132	BEE	2015-06-19	\N
224019865233132	GUEPE	2021-03-01	\N
224019865233132	MOISI	2020-01-08	\N
283097419522568	LAV	2017-10-09	\N
283097419522568	BEE	2015-06-22	\N
283097419522568	POLN	2015-01-26	\N
283097419522568	BLATE	2016-09-19	2017-11-13
230116145833140	lATEX	2020-03-07	2020-12-12
230116145833140	ARA	2016-06-02	2016-10-03
230116145833140	BEE	2017-03-27	2020-08-11
230116145833140	ASPIR	2019-02-24	\N
230116145833140	POILE	2020-07-21	\N
279055788448335	POILE	2016-02-17	2018-05-27
279055788448335	BLATE	2017-11-02	2017-12-02
279055788448335	MOISI	2021-04-07	2021-08-26
279055788448335	ASPIR	2017-08-19	2020-11-13
279055788448335	BEE	2017-02-26	\N
139058121016456	LAV	2018-02-20	\N
139058121016456	ARA	2019-04-03	2021-01-07
194094891582637	ARA	2015-02-25	\N
194094891582637	lATEX	2021-03-27	2021-09-24
139011591930760	POLN	2020-12-05	2020-12-28
139011591930760	LAV	2016-03-05	2021-08-19
139011591930760	PENIC	2018-04-03	2021-08-22
144116934442689	PENIC	2021-09-03	2021-10-28
144116934442689	ASPIR	2021-05-02	2021-05-21
144116934442689	BLATE	2015-02-24	2018-08-01
144116934442689	GLUTN	2018-03-12	\N
144116934442689	GUEPE	2021-05-18	2021-08-09
252030424521689	GUEPE	2017-09-18	2019-01-13
252030424521689	MOISI	2016-07-03	2016-07-08
252030424521689	GLUTN	2018-10-21	2020-12-08
252030424521689	lATEX	2016-04-07	\N
252030424521689	ARA	2019-02-19	\N
280076300617446	GLUTN	2019-04-04	\N
244027770559855	POLN	2021-05-22	2021-10-18
244027770559855	POILE	2016-03-06	\N
244027770559855	ASPIR	2018-07-07	2021-09-12
244027770559855	GLUTN	2021-04-02	2021-05-23
134044002643870	MOISI	2018-06-10	\N
134044002643870	BLATE	2017-07-19	\N
134044002643870	BEE	2019-03-25	\N
170084270924505	lATEX	2019-05-01	2020-07-21
170084270924505	GLUTN	2018-05-21	2020-03-24
170084270924505	GUEPE	2021-02-12	\N
170084270924505	ASPIR	2019-12-17	2020-07-28
170084270924505	BEE	2016-02-24	2020-02-27
147037410601226	PENIC	2017-09-28	2018-04-20
147037410601226	POILE	2016-03-24	2020-02-06
147037410601226	LAV	2021-10-12	\N
147037410601226	POLN	2018-08-21	\N
147037410601226	GLUTN	2019-07-25	2020-03-03
262128322011669	ARA	2017-02-06	\N
262128322011669	GUEPE	2016-11-15	2020-07-16
262128322011669	ASPIR	2016-01-03	2019-04-05
262128322011669	GLUTN	2018-07-28	2020-09-19
187102210975946	PENIC	2021-10-25	2021-10-28
187102210975946	GUEPE	2019-09-04	2021-08-08
230039788083545	GUEPE	2018-03-19	\N
230039788083545	POLN	2019-11-10	2019-12-18
140035393058158	LAV	2016-06-15	2018-03-24
140035393058158	POILE	2021-07-11	\N
158041701121347	PENIC	2017-08-17	2020-09-17
252034453461856	ASPIR	2017-04-15	2019-08-12
252034453461856	POILE	2019-07-19	2020-02-23
252034453461856	GUEPE	2016-11-12	2018-03-08
252034453461856	BLATE	2018-01-01	2019-05-19
252034453461856	LAV	2017-05-08	2020-06-17
278016346820968	LAV	2015-05-16	\N
278016346820968	MOISI	2019-02-28	\N
278016346820968	ASPIR	2015-06-25	2017-02-17
278016346820968	GUEPE	2020-06-19	2021-07-02
193068126328431	lATEX	2020-07-27	\N
193068126328431	GLUTN	2017-12-01	\N
228068852384413	POILE	2021-09-18	2021-09-21
228068852384413	LAV	2021-09-16	\N
228068852384413	GUEPE	2019-04-11	\N
228068852384413	PENIC	2016-11-17	2018-01-23
148112887355343	ASPIR	2020-06-14	2020-06-16
148112887355343	ARA	2019-03-23	2020-01-24
148112887355343	GLUTN	2016-05-23	\N
148112887355343	BLATE	2017-12-10	2021-08-18
175013717803592	lATEX	2015-01-02	2020-04-28
175013717803592	GLUTN	2021-08-28	\N
175013717803592	BEE	2016-05-23	\N
202017836106992	BEE	2016-02-20	\N
245102229936748	GUEPE	2019-06-16	\N
131085813863926	GLUTN	2016-04-16	\N
131085813863926	lATEX	2018-10-09	2021-05-13
281017548940709	PENIC	2018-11-10	2018-11-18
281017548940709	ARA	2020-10-22	\N
281017548940709	GUEPE	2019-04-23	\N
281017548940709	ASPIR	2018-11-11	2018-12-20
165118676503239	GUEPE	2020-12-27	\N
165118676503239	lATEX	2016-11-06	\N
165118676503239	POILE	2018-10-23	2018-11-13
165118676503239	ARA	2018-04-19	2020-09-09
117084718549821	POLN	2021-11-14	2021-11-14
117084718549821	LAV	2021-05-02	2021-08-17
117084718549821	GUEPE	2018-11-10	\N
117084718549821	POILE	2020-09-12	\N
117084718549821	ASPIR	2017-02-24	2018-12-06
124041724420932	ARA	2015-12-05	\N
142078663953463	GLUTN	2020-03-05	\N
142078663953463	LAV	2017-10-12	2017-11-07
142078663953463	lATEX	2017-01-05	\N
142078663953463	POLN	2019-05-13	\N
142078663953463	ASPIR	2015-03-20	\N
288072025161887	MOISI	2017-06-21	\N
288072025161887	GLUTN	2020-08-06	\N
285115989191758	POLN	2021-11-08	2021-11-08
285115989191758	MOISI	2016-02-25	\N
285115989191758	LAV	2021-07-06	2021-08-13
285115989191758	BEE	2017-12-26	\N
285115989191758	BLATE	2021-09-08	\N
193020420013248	GUEPE	2021-07-15	\N
193020420013248	POLN	2017-04-14	2018-08-25
193020420013248	BLATE	2020-11-16	2020-12-19
193020420013248	LAV	2018-06-15	\N
251083723773260	ARA	2017-09-22	2020-05-10
251083723773260	PENIC	2016-04-12	2021-09-01
251083723773260	POILE	2017-12-16	2019-11-11
211055538833854	GLUTN	2020-06-12	\N
211055538833854	lATEX	2020-10-26	\N
211055538833854	GUEPE	2018-12-05	2020-02-20
211055538833854	ARA	2020-10-25	2021-08-15
211055538833854	POLN	2017-11-16	\N
266011804752213	ASPIR	2017-07-07	2021-03-01
266011804752213	BLATE	2019-09-16	\N
266011804752213	MOISI	2019-03-18	2020-09-04
228105308454888	POLN	2016-03-12	\N
228105308454888	POILE	2019-11-11	\N
228105308454888	LAV	2017-07-07	\N
228105308454888	BEE	2021-06-11	\N
173041596006042	BLATE	2021-01-08	\N
173041596006042	POLN	2018-06-08	2019-01-25
173041596006042	GUEPE	2020-11-16	2021-09-20
173041596006042	MOISI	2016-08-13	\N
196066953664866	ARA	2020-03-09	2021-09-01
100097374384987	POLN	2017-07-19	2020-03-25
100097374384987	GUEPE	2018-04-27	\N
100097374384987	BEE	2021-11-16	2021-11-16
281027685467381	PENIC	2021-01-20	\N
281027685467381	BEE	2019-03-09	\N
281027685467381	LAV	2020-02-27	\N
281027685467381	POILE	2016-11-11	2017-02-04
281027685467381	lATEX	2021-08-08	2021-09-15
244054666231017	LAV	2015-01-03	\N
244054666231017	BLATE	2021-05-01	2021-07-28
145018037213375	GLUTN	2018-10-08	2019-10-22
145018037213375	POILE	2016-06-20	\N
145018037213375	BLATE	2019-05-22	2020-05-24
145018037213375	ASPIR	2016-02-17	\N
137014618658034	ASPIR	2021-11-10	2021-11-12
137014618658034	PENIC	2019-08-08	2020-08-09
137014618658034	MOISI	2015-08-09	\N
117035495904467	LAV	2017-11-13	\N
117035495904467	BEE	2020-02-05	\N
117035495904467	PENIC	2018-03-28	2020-11-13
117035495904467	ARA	2019-04-09	2019-12-03
120085453420861	PENIC	2021-11-07	\N
120085453420861	BEE	2019-10-13	2019-12-07
107062454569949	GUEPE	2019-05-23	\N
107062454569949	PENIC	2020-05-09	\N
107062454569949	POILE	2015-09-24	\N
174052321465035	lATEX	2017-03-01	\N
174052321465035	ASPIR	2017-04-28	2020-11-03
174052321465035	MOISI	2017-11-13	2019-07-02
174052321465035	PENIC	2021-06-16	\N
174052321465035	GUEPE	2020-08-23	2020-08-26
203082364962173	LAV	2015-06-20	\N
203082364962173	BEE	2021-01-02	\N
203082364962173	POILE	2015-07-23	2017-10-24
203082364962173	POLN	2016-04-27	2019-04-28
203082364962173	GUEPE	2018-01-04	2020-08-21
235018357073752	ASPIR	2017-01-17	2021-04-11
235018357073752	ARA	2021-09-17	2021-10-09
219103662330782	PENIC	2017-09-22	\N
242023117314654	ARA	2018-12-11	\N
242023117314654	lATEX	2021-08-13	\N
242023117314654	ASPIR	2018-03-07	\N
278024853925779	GUEPE	2021-03-09	\N
278024853925779	MOISI	2019-01-18	\N
278024853925779	BEE	2016-01-07	\N
278024853925779	ASPIR	2016-04-12	2018-01-13
166061059911408	GUEPE	2018-01-05	2018-09-12
166061059911408	BEE	2015-08-26	\N
143056272653974	lATEX	2016-10-12	2016-12-28
143056272653974	BLATE	2015-12-04	\N
143056272653974	LAV	2021-06-17	\N
143056272653974	POLN	2015-03-18	2021-04-25
143056272653974	PENIC	2015-08-05	2016-10-10
202082616139782	GUEPE	2019-12-04	\N
202082616139782	LAV	2021-05-16	\N
202082616139782	POILE	2018-11-07	\N
202082616139782	ASPIR	2015-02-28	\N
121119302153015	lATEX	2015-07-13	2016-08-11
121119302153015	GUEPE	2018-11-18	2019-08-18
254032393904711	GUEPE	2019-12-16	2020-07-12
254032393904711	POILE	2021-11-11	\N
254032393904711	MOISI	2021-11-11	2021-11-11
254032393904711	lATEX	2018-04-23	\N
237063613562087	BLATE	2020-08-04	2020-11-02
210069408347984	BLATE	2018-03-04	2020-09-17
210069408347984	POILE	2021-01-08	\N
210069408347984	PENIC	2015-05-06	2018-10-11
150050950892813	BLATE	2016-12-05	2016-12-27
150050950892813	GUEPE	2020-03-22	2021-02-01
264043641280038	ASPIR	2019-01-08	2021-02-24
137017091980101	lATEX	2018-05-15	2018-05-17
136020837557549	BEE	2020-04-17	\N
138066290675800	BEE	2021-07-12	2021-10-16
162108651894204	ASPIR	2016-05-07	2018-08-17
162108651894204	BEE	2018-06-14	2020-10-04
171045149446952	BEE	2017-01-11	2019-10-23
171045149446952	LAV	2018-04-01	\N
116057590333638	PENIC	2015-01-04	2016-06-22
189044619488168	GLUTN	2016-02-23	2021-04-03
189044619488168	lATEX	2018-01-21	\N
189044619488168	LAV	2020-05-17	2020-08-26
292077605072543	PENIC	2015-07-18	2019-08-21
292077605072543	BEE	2020-02-06	\N
292077605072543	GLUTN	2021-09-03	\N
292077605072543	LAV	2018-02-07	\N
252102748808594	GLUTN	2019-10-08	\N
252102748808594	POILE	2020-08-24	\N
252102748808594	ASPIR	2019-09-07	2020-03-24
252102748808594	PENIC	2018-10-23	\N
134063838698377	PENIC	2021-03-27	2021-07-14
134063838698377	MOISI	2015-01-02	2015-02-12
134063838698377	POLN	2020-08-03	2020-12-20
134063838698377	GUEPE	2021-07-02	\N
271081608987354	POILE	2016-02-04	2018-01-21
271081608987354	POLN	2018-12-07	2019-07-10
271081608987354	PENIC	2016-11-01	\N
135084429086369	BLATE	2017-06-21	2017-08-24
213018169533032	PENIC	2016-11-16	\N
213018169533032	POLN	2021-05-14	2021-07-17
213018169533032	LAV	2015-06-10	\N
213018169533032	POILE	2017-11-06	2020-12-08
224023519830794	GLUTN	2017-07-01	\N
224023519830794	MOISI	2020-02-14	\N
224023519830794	GUEPE	2016-08-18	2019-09-09
224023519830794	PENIC	2021-10-26	2021-11-17
224023519830794	LAV	2018-08-19	2021-02-09
113086414892889	GLUTN	2019-09-18	2021-04-26
113086414892889	MOISI	2017-09-22	2021-02-13
113086414892889	ARA	2016-06-14	\N
113086414892889	BLATE	2017-03-20	2017-12-08
113086414892889	POLN	2021-07-04	\N
145098366075373	BLATE	2015-01-28	\N
145098366075373	GLUTN	2019-06-17	2019-08-27
145098366075373	ARA	2017-01-19	\N
283100127930094	POLN	2016-02-02	\N
283100127930094	POILE	2019-09-22	2021-05-26
283100127930094	PENIC	2020-09-23	2020-10-26
283100127930094	GUEPE	2016-06-01	2016-10-14
108062368491491	POLN	2017-01-28	\N
108062368491491	BLATE	2017-11-07	\N
295054346609627	GLUTN	2019-07-09	\N
295054346609627	PENIC	2016-04-02	\N
295054346609627	ARA	2016-06-15	\N
175056307245608	POILE	2017-05-27	2019-10-10
175056307245608	lATEX	2015-09-20	2015-10-05
175056307245608	ARA	2018-12-25	\N
245125275586869	POLN	2015-06-26	\N
245125275586869	BLATE	2017-06-08	\N
245125275586869	GLUTN	2019-07-25	\N
245125275586869	PENIC	2021-06-10	\N
245125275586869	ARA	2021-05-03	2021-11-08
184026584934683	POLN	2018-11-02	\N
184026584934683	LAV	2018-09-08	2019-02-23
184026584934683	GLUTN	2018-01-17	\N
276109369398817	ARA	2019-01-01	2019-10-20
276109369398817	GUEPE	2016-01-26	2017-08-11
276109369398817	LAV	2016-04-20	\N
276109369398817	MOISI	2016-04-28	\N
276109369398817	PENIC	2015-07-14	2016-01-18
258047954598738	ARA	2016-08-21	\N
258047954598738	BEE	2015-06-13	2018-01-07
159026101937367	PENIC	2017-07-17	\N
281100914191380	GLUTN	2017-10-07	2018-08-25
281100914191380	POILE	2019-11-15	2020-05-08
265041036297803	PENIC	2019-10-18	\N
265041036297803	GLUTN	2016-07-20	2020-04-14
265041036297803	ASPIR	2017-08-13	2017-09-24
172027357912624	BLATE	2020-11-16	2021-11-17
172027357912624	ARA	2015-10-09	\N
172027357912624	ASPIR	2019-08-22	\N
146035915566546	POLN	2021-04-06	2021-11-13
146035915566546	BEE	2015-06-15	2018-09-02
146035915566546	PENIC	2017-02-19	2020-05-21
146035915566546	ARA	2018-09-18	\N
127013049115072	ARA	2021-10-18	\N
127013049115072	BEE	2020-03-25	\N
276074955165911	POLN	2016-06-08	\N
276074955165911	GLUTN	2015-05-04	\N
276074955165911	PENIC	2021-11-09	2021-11-17
274078327911985	GLUTN	2015-08-05	\N
297098982634129	ARA	2016-12-03	2018-10-28
297098982634129	POLN	2018-02-24	2018-10-13
297098982634129	GUEPE	2019-05-04	2021-05-14
266113030404841	BEE	2016-07-20	2016-10-12
266113030404841	GLUTN	2018-05-13	\N
266113030404841	BLATE	2021-05-23	2021-05-26
266113030404841	PENIC	2021-10-05	2021-11-11
266113030404841	ARA	2018-05-15	\N
291061465464580	ASPIR	2018-02-08	\N
291061465464580	GUEPE	2021-07-06	\N
291061465464580	MOISI	2017-02-11	\N
291061465464580	PENIC	2020-11-16	\N
291061465464580	POLN	2017-11-15	2020-09-22
297029265987716	ASPIR	2021-09-28	\N
297029265987716	GLUTN	2018-01-02	2021-08-03
278128075429694	ASPIR	2019-10-26	2019-12-13
184012353692245	BLATE	2020-05-15	2021-02-22
165068074963681	POILE	2020-12-09	\N
165068074963681	PENIC	2019-10-04	\N
165068074963681	ASPIR	2018-03-06	2019-06-16
188018753555015	PENIC	2020-03-07	2021-01-08
188018753555015	lATEX	2020-06-13	2021-04-05
188018753555015	GLUTN	2016-09-18	\N
125027234720831	BLATE	2016-08-13	2019-07-04
125027234720831	LAV	2016-10-23	2016-12-04
125027234720831	POILE	2018-07-12	2018-08-11
198095494635982	GLUTN	2018-02-04	\N
198095494635982	ARA	2021-04-02	2021-11-04
151119609719317	MOISI	2021-11-15	\N
151119609719317	POILE	2021-04-16	2021-10-02
151119609719317	BEE	2019-02-07	2021-03-12
178099170061457	POLN	2017-05-18	\N
178099170061457	GLUTN	2017-12-16	2020-01-14
178099170061457	PENIC	2016-12-24	2017-09-18
178099170061457	BLATE	2020-07-23	\N
178099170061457	ASPIR	2019-07-07	2020-03-22
238102455584257	BEE	2020-11-18	2021-05-17
238102455584257	GLUTN	2020-06-03	2021-05-13
174110177212641	lATEX	2020-07-09	\N
174110177212641	PENIC	2018-01-11	\N
174110177212641	GLUTN	2019-07-07	2019-07-15
247045170896320	GLUTN	2019-01-03	\N
182061185597144	POLN	2020-04-01	\N
182061185597144	ARA	2020-08-06	\N
216097269788636	BEE	2020-02-22	\N
216097269788636	MOISI	2017-04-02	\N
216097269788636	ASPIR	2019-12-02	2019-12-04
240098636102457	ARA	2015-09-01	\N
240098636102457	ASPIR	2020-04-25	\N
223027723041314	POILE	2016-05-27	\N
223027723041314	lATEX	2018-04-19	\N
223027723041314	LAV	2015-07-11	\N
142038029211702	ARA	2016-07-01	\N
142038029211702	LAV	2021-07-22	\N
142038029211702	lATEX	2017-08-17	\N
142038029211702	POLN	2020-05-01	\N
203105428294586	GLUTN	2019-12-25	\N
203105428294586	BLATE	2016-12-07	\N
127114505385305	BEE	2019-05-09	\N
127114505385305	LAV	2020-01-10	\N
127114505385305	GUEPE	2020-07-24	\N
127114505385305	POLN	2019-10-12	2020-02-04
127114505385305	lATEX	2021-02-28	2021-04-04
203115204316722	POLN	2017-05-25	\N
203115204316722	BLATE	2020-04-07	\N
143047530576868	GLUTN	2018-08-10	2021-05-28
252084845928826	GLUTN	2015-03-14	\N
252084845928826	PENIC	2017-10-25	2017-12-01
252084845928826	POLN	2018-07-25	\N
158083284418230	LAV	2015-12-22	\N
276013421462837	LAV	2019-04-28	2020-09-03
276013421462837	MOISI	2021-05-21	\N
276013421462837	POLN	2016-06-24	2019-09-26
276013421462837	GUEPE	2017-07-22	2019-06-14
184060750824654	BEE	2021-04-09	\N
184060750824654	PENIC	2015-08-10	2016-10-01
184060750824654	LAV	2018-11-13	2019-02-01
184060750824654	ASPIR	2020-04-28	2021-11-18
287129112205056	MOISI	2015-05-13	2019-10-09
287129112205056	ASPIR	2018-05-11	2020-01-07
287129112205056	LAV	2021-05-10	\N
108117505421653	ARA	2020-10-23	\N
108117505421653	GUEPE	2016-11-10	\N
108117505421653	BLATE	2019-03-12	\N
108117505421653	BEE	2021-08-22	\N
296109313485906	LAV	2021-09-16	2021-09-16
296109313485906	POILE	2016-08-13	2016-11-01
296109313485906	GLUTN	2017-01-01	2017-05-21
296109313485906	MOISI	2019-04-14	\N
296109313485906	BLATE	2017-02-13	2018-12-10
276060158258875	POILE	2021-09-23	\N
276060158258875	LAV	2019-10-05	\N
119071350672351	POILE	2015-02-07	2019-01-21
119071350672351	ASPIR	2018-10-22	2019-02-24
119071350672351	BEE	2020-10-18	\N
119071350672351	GLUTN	2019-04-11	2019-08-01
287073546978367	GUEPE	2016-08-18	\N
216034868105920	GUEPE	2016-04-12	\N
216034868105920	ASPIR	2018-10-28	2019-01-15
240108256892560	BEE	2017-12-28	\N
240108256892560	GLUTN	2017-03-21	2018-01-11
144060491514938	GUEPE	2019-03-22	2020-03-22
144060491514938	LAV	2018-10-06	\N
144060491514938	POLN	2015-11-12	\N
144060491514938	MOISI	2019-08-20	2019-11-10
144060491514938	GLUTN	2017-05-25	\N
263029938395133	GUEPE	2015-05-16	\N
263029938395133	PENIC	2018-07-06	2018-10-11
139028225880780	ASPIR	2016-10-05	\N
139044509081733	GLUTN	2017-12-11	2019-02-18
139044509081733	BEE	2016-04-09	2019-06-28
139044509081733	POILE	2018-12-14	\N
286034536711317	GLUTN	2015-01-20	2016-10-25
286034536711317	LAV	2021-11-01	2021-11-17
286034536711317	ASPIR	2015-04-22	\N
286034536711317	MOISI	2015-10-17	\N
286034536711317	POILE	2021-05-19	2021-08-05
267094158471577	PENIC	2019-09-06	\N
267094158471577	BEE	2017-08-17	2019-12-08
267094158471577	GUEPE	2020-07-01	\N
267094158471577	ARA	2015-12-21	2020-01-16
267094158471577	POLN	2015-12-23	2020-03-27
275017674182759	GLUTN	2020-12-09	\N
275017674182759	ASPIR	2018-04-09	2018-06-18
275017674182759	GUEPE	2017-02-20	2021-11-01
275017674182759	BLATE	2020-05-19	2020-09-15
275017674182759	PENIC	2021-09-15	\N
192125134535252	GUEPE	2019-08-22	2019-09-14
192125134535252	POLN	2019-03-05	\N
181028245089128	lATEX	2019-08-28	2021-03-24
181028245089128	BEE	2015-09-23	\N
181028245089128	BLATE	2020-11-17	2021-03-17
181028245089128	ARA	2019-04-19	2019-12-11
181028245089128	POLN	2017-04-12	\N
205124133484803	ASPIR	2020-03-07	\N
205124133484803	MOISI	2016-11-03	2020-07-18
205124133484803	LAV	2021-01-21	\N
205124133484803	ARA	2021-04-03	2021-10-28
205124133484803	GUEPE	2019-05-05	\N
141063251159329	POILE	2020-07-27	2021-10-27
141063251159329	BEE	2017-12-13	2018-01-15
295109643093570	MOISI	2020-09-26	\N
295109643093570	POILE	2017-12-17	2018-11-15
295109643093570	lATEX	2019-07-21	2019-07-24
100128404770065	lATEX	2020-05-28	2021-11-01
291072587130734	LAV	2017-04-02	2021-05-21
291072587130734	MOISI	2017-11-05	2020-04-21
291072587130734	PENIC	2016-08-18	2021-10-22
291072587130734	GUEPE	2020-03-28	2020-05-12
163114987429449	MOISI	2015-06-03	2016-12-02
163114987429449	POILE	2015-12-22	\N
163114987429449	GLUTN	2018-12-12	2020-04-05
163114987429449	lATEX	2019-11-04	2021-11-10
163114987429449	LAV	2016-04-18	2018-12-27
296123698284802	LAV	2021-06-20	2021-11-04
296123698284802	POLN	2018-10-24	2018-10-28
100120657067241	PENIC	2019-08-21	2020-11-12
100120657067241	MOISI	2016-12-19	\N
100120657067241	ASPIR	2018-11-02	2020-03-04
100120657067241	BEE	2021-03-06	2021-08-13
100120657067241	BLATE	2019-11-02	2021-11-18
220042537626746	BLATE	2021-06-10	2021-07-19
220042537626746	PENIC	2021-10-22	\N
220042537626746	LAV	2020-09-24	2020-12-04
117065165282646	MOISI	2020-10-20	\N
117065165282646	LAV	2021-09-08	\N
117065165282646	BLATE	2016-12-24	2020-07-21
209129284642422	ASPIR	2018-02-21	\N
209129284642422	MOISI	2019-12-09	2020-02-06
160018543311945	GUEPE	2021-04-14	2021-04-16
131018894086716	GLUTN	2019-10-25	\N
148071204427033	LAV	2019-07-06	2020-07-25
148071204427033	GLUTN	2019-01-15	2020-03-01
148071204427033	POILE	2018-03-11	2018-10-01
148071204427033	POLN	2019-08-10	2021-03-28
215055219516728	PENIC	2018-09-13	\N
215055219516728	LAV	2016-01-24	2016-11-10
215055219516728	ARA	2018-02-28	\N
288064789259254	MOISI	2019-09-20	\N
288064789259254	BEE	2016-10-12	2019-12-16
288064789259254	ASPIR	2021-10-08	\N
288064789259254	PENIC	2021-03-11	2021-03-27
209027484439592	POLN	2019-09-08	\N
209027484439592	POILE	2016-09-16	\N
112117737627127	ARA	2019-11-01	\N
212112177557168	BLATE	2015-02-21	2016-04-13
212112177557168	GLUTN	2021-07-24	2021-08-06
212112177557168	ASPIR	2019-06-07	\N
259124262367720	POLN	2021-06-02	\N
259124262367720	MOISI	2021-03-05	\N
243019440286294	BLATE	2017-11-01	\N
243019440286294	ARA	2015-06-19	2016-06-22
243019440286294	PENIC	2018-10-23	\N
250120320255028	GLUTN	2017-11-06	2021-04-06
250120320255028	POILE	2020-05-16	2020-05-22
250120320255028	lATEX	2020-06-22	2021-10-23
168044544530751	POILE	2015-03-03	2017-09-17
168044544530751	GUEPE	2018-05-28	\N
168044544530751	LAV	2020-03-02	\N
168044544530751	BLATE	2017-08-18	2017-09-28
168044544530751	PENIC	2019-10-05	2020-12-12
197085058533851	ARA	2016-01-17	2021-10-07
197085058533851	GLUTN	2018-10-25	2021-05-07
197085058533851	POILE	2020-03-22	\N
197085058533851	BEE	2015-11-03	2017-01-21
189118296921538	BEE	2015-11-02	\N
189118296921538	POILE	2018-08-26	2019-12-19
189118296921538	LAV	2019-11-03	2019-11-07
189118296921538	GLUTN	2017-06-06	2018-06-23
189118296921538	GUEPE	2016-10-10	\N
172127121780306	GLUTN	2020-03-22	\N
172127121780306	LAV	2019-04-04	2019-11-15
172127121780306	GUEPE	2015-11-16	2019-04-08
106012829360503	POILE	2018-08-16	\N
106012829360503	MOISI	2018-09-17	\N
106012829360503	POLN	2018-04-27	\N
106012829360503	lATEX	2017-12-24	\N
257010508547422	ARA	2020-05-20	2020-07-01
257010508547422	GUEPE	2021-10-09	\N
257010508547422	BEE	2021-01-09	\N
257010508547422	POLN	2016-06-21	2017-05-09
257010508547422	ASPIR	2018-08-07	2021-07-25
288119294124480	MOISI	2019-10-23	\N
288119294124480	PENIC	2015-09-21	2018-12-18
288119294124480	LAV	2018-05-26	\N
169046777385625	ASPIR	2018-10-06	2020-02-07
254063151017850	ASPIR	2020-08-08	\N
254063151017850	ARA	2020-11-13	2020-12-23
254063151017850	GUEPE	2021-02-13	2021-03-01
254063151017850	POILE	2018-08-19	2019-09-20
242118914204961	ARA	2021-01-26	2021-01-28
242118914204961	lATEX	2019-03-07	2019-09-08
242118914204961	POILE	2015-11-02	2019-03-03
242118914204961	GLUTN	2021-08-18	\N
290073918728392	GLUTN	2020-04-07	2020-11-12
290073918728392	ARA	2019-09-18	\N
118059785875590	GUEPE	2015-08-24	2020-11-03
118059785875590	LAV	2020-01-05	\N
118059785875590	GLUTN	2018-06-27	2020-03-20
118059785875590	PENIC	2016-08-19	2021-11-09
255123911821943	MOISI	2017-10-05	2020-09-02
255123911821943	PENIC	2018-09-15	2018-12-25
255123911821943	ARA	2021-05-10	2021-05-13
252121548594422	PENIC	2020-11-16	2020-11-18
252121548594422	POLN	2016-01-16	\N
252121548594422	MOISI	2018-09-12	2019-04-17
252121548594422	POILE	2018-05-09	2019-07-16
252121548594422	GLUTN	2019-07-28	2020-06-15
146083034518235	MOISI	2016-12-28	\N
146083034518235	POLN	2020-05-08	\N
146083034518235	GLUTN	2021-03-25	2021-06-06
255024434449320	POLN	2019-11-12	2020-04-03
255024434449320	BLATE	2018-06-27	\N
255024434449320	GUEPE	2020-10-22	\N
255024434449320	ASPIR	2021-05-09	\N
255024434449320	BEE	2019-05-02	\N
292067301425678	GLUTN	2019-02-08	2020-12-23
292067301425678	lATEX	2021-01-26	\N
292067301425678	LAV	2016-07-09	\N
292067301425678	PENIC	2021-10-04	2021-10-25
292067301425678	ASPIR	2018-04-10	2021-03-05
238124835633617	BEE	2017-11-03	\N
238124835633617	POILE	2017-02-17	2019-11-17
238124835633617	PENIC	2016-11-12	\N
238124835633617	MOISI	2015-09-15	2017-02-07
250100390302501	ASPIR	2020-10-28	\N
250100390302501	ARA	2017-04-08	2020-08-04
250100390302501	GLUTN	2015-09-22	\N
250100390302501	GUEPE	2016-08-12	2017-09-15
269028582321089	LAV	2018-07-17	\N
269028582321089	ASPIR	2019-07-27	2019-09-14
228075544768360	BEE	2016-01-25	\N
228075544768360	PENIC	2016-04-15	\N
115090459564033	GLUTN	2021-09-25	2021-09-25
136060268614388	BEE	2017-06-24	2017-10-24
136060268614388	LAV	2017-12-08	\N
136060268614388	POILE	2019-06-20	\N
136060268614388	BLATE	2015-04-05	2017-07-13
136060268614388	lATEX	2016-04-20	2018-01-21
239107525820988	GUEPE	2015-12-15	\N
239107525820988	BEE	2015-03-12	2018-09-25
277082499925687	PENIC	2018-08-18	\N
277082499925687	POLN	2018-08-01	2019-02-26
277082499925687	GLUTN	2015-09-20	\N
277082499925687	ASPIR	2020-10-14	\N
149061089953964	LAV	2015-10-24	2021-05-12
149061089953964	ARA	2016-08-06	\N
149061089953964	MOISI	2020-07-21	\N
149061089953964	lATEX	2017-06-21	2018-04-19
149061089953964	BEE	2019-09-07	2020-05-13
155099604479331	LAV	2017-09-07	2020-01-10
155099604479331	BEE	2020-02-07	\N
155099604479331	GUEPE	2020-08-03	\N
155099604479331	lATEX	2021-06-06	\N
249116658619254	PENIC	2015-09-13	\N
249116658619254	MOISI	2016-02-01	2021-04-19
249116658619254	POLN	2018-11-08	2018-11-10
249116658619254	GUEPE	2018-02-02	2020-03-20
248098356838047	LAV	2018-07-12	\N
248098356838047	GUEPE	2015-06-25	2020-05-11
248098356838047	ARA	2019-05-14	2021-02-24
248098356838047	PENIC	2019-08-19	2021-03-13
169058905574093	ARA	2019-09-20	\N
169058905574093	GLUTN	2015-09-14	2017-10-15
288015091637034	LAV	2017-03-20	2021-09-13
137113043274402	MOISI	2019-01-27	\N
137113043274402	LAV	2018-09-20	\N
257028814268392	BLATE	2021-04-09	\N
257028814268392	GUEPE	2015-03-22	\N
119062273668288	PENIC	2016-03-28	2021-03-28
119062273668288	lATEX	2020-07-24	2021-04-24
119062273668288	POILE	2016-08-25	2020-11-09
119062273668288	ASPIR	2021-11-12	\N
119062273668288	GLUTN	2019-09-27	2020-02-25
177077015655367	GLUTN	2018-09-12	\N
177077015655367	MOISI	2021-10-12	\N
177077015655367	PENIC	2021-03-10	\N
113025853213883	ASPIR	2020-10-08	2021-07-14
279049861076510	POILE	2020-12-15	\N
279049861076510	GLUTN	2016-05-21	\N
279049861076510	POLN	2020-01-07	\N
279049861076510	BLATE	2015-11-12	2017-02-12
279049861076510	BEE	2016-05-02	\N
234129579445893	GLUTN	2016-04-24	\N
234129579445893	BEE	2015-08-13	2019-09-13
234129579445893	BLATE	2019-09-05	\N
234129579445893	GUEPE	2016-11-02	\N
262075456464328	MOISI	2020-07-25	2021-01-26
262075456464328	POLN	2017-04-04	\N
262075456464328	ASPIR	2019-12-03	2020-09-11
103108171583767	LAV	2015-04-07	\N
103108171583767	lATEX	2017-08-05	\N
103108171583767	GUEPE	2021-09-09	\N
103108171583767	BLATE	2018-01-06	2021-08-18
103108171583767	PENIC	2018-06-02	\N
289098686609121	PENIC	2021-09-22	\N
135019316894863	BLATE	2021-05-19	2021-09-27
135019316894863	MOISI	2020-05-17	\N
135019316894863	POILE	2019-02-15	2020-12-09
135019316894863	GLUTN	2019-10-12	2019-11-12
135019316894863	POLN	2021-09-19	2021-09-27
143082928850324	ASPIR	2021-08-07	\N
143082928850324	GUEPE	2017-06-16	2017-11-11
143082928850324	PENIC	2018-10-07	\N
150112983981791	ARA	2021-07-09	2021-10-27
150112983981791	POLN	2019-04-04	2019-09-17
150112983981791	GUEPE	2015-10-09	\N
150112983981791	ASPIR	2015-06-28	\N
150112983981791	GLUTN	2020-06-10	2021-02-21
194093230655172	POILE	2015-03-19	2016-10-18
194093230655172	BEE	2015-04-12	\N
194093230655172	POLN	2020-04-20	2021-08-09
172081474790883	BLATE	2020-01-24	\N
249028848217580	LAV	2018-10-15	\N
249028848217580	GLUTN	2015-07-24	\N
249028848217580	BEE	2021-02-14	2021-08-12
110062997134954	lATEX	2020-03-03	2020-09-07
212049852961463	GLUTN	2018-01-05	2020-05-27
212049852961463	BLATE	2021-10-26	2021-11-16
212049852961463	LAV	2021-04-06	\N
212049852961463	POILE	2017-01-22	\N
212049852961463	BEE	2016-07-17	2021-10-06
279106952353170	GLUTN	2016-11-05	2020-04-22
279106952353170	BLATE	2019-09-18	\N
279106952353170	ASPIR	2015-01-25	\N
228118075183751	LAV	2018-03-02	2018-03-17
228118075183751	ASPIR	2015-04-04	2017-02-15
185032891472891	ASPIR	2015-03-23	\N
185032891472891	MOISI	2021-10-08	\N
176079215128294	POILE	2017-01-19	2020-11-05
176079215128294	GUEPE	2018-04-16	2021-03-15
227031686466265	ARA	2017-12-26	\N
227031686466265	GLUTN	2015-07-13	\N
227031686466265	POILE	2016-11-13	2021-04-20
227031686466265	lATEX	2019-03-22	2020-12-09
108095665815271	POLN	2017-09-26	2018-11-05
108095665815271	GLUTN	2015-04-01	\N
108095665815271	BLATE	2017-12-21	2021-05-16
108095665815271	MOISI	2019-01-24	\N
108095665815271	BEE	2015-08-02	\N
293067295193883	lATEX	2018-08-17	\N
293067295193883	ARA	2015-01-27	2021-02-22
293067295193883	PENIC	2020-01-18	2020-02-20
224030202539094	BEE	2016-05-09	\N
170054073041927	POILE	2016-10-17	\N
170054073041927	GLUTN	2020-07-19	2020-07-25
170054073041927	MOISI	2020-10-28	2021-04-05
170054073041927	ASPIR	2019-04-08	2019-05-08
170054073041927	LAV	2018-06-26	2020-12-01
187073819892261	GUEPE	2016-06-03	2020-09-25
187073819892261	POILE	2017-04-13	2018-12-01
187073819892261	LAV	2015-01-21	\N
187073819892261	BEE	2021-04-12	2021-08-08
187073819892261	BLATE	2017-06-06	\N
272100390058901	ASPIR	2018-12-04	\N
272100390058901	ARA	2016-07-17	\N
272100390058901	MOISI	2017-05-12	2019-02-06
199080501008050	GLUTN	2021-05-23	2021-09-18
110094961795134	BEE	2015-03-15	2018-02-09
110094961795134	POILE	2017-11-03	\N
217039324734896	ASPIR	2021-03-14	2021-11-11
217039324734896	LAV	2021-03-09	\N
217039324734896	POLN	2017-10-03	2021-05-04
217039324734896	ARA	2016-11-01	2018-08-26
217039324734896	GUEPE	2021-07-08	2021-10-02
174059385899556	GUEPE	2019-12-24	2021-01-26
174059385899556	GLUTN	2021-06-08	2021-08-24
174059385899556	BLATE	2017-02-02	\N
174059385899556	MOISI	2019-11-02	2019-11-10
174059385899556	LAV	2019-12-27	2020-02-01
169071676568835	BLATE	2018-11-17	2021-09-16
169071676568835	MOISI	2021-02-08	2021-11-17
169071676568835	POILE	2016-01-22	\N
225068887084592	POLN	2017-12-27	2019-09-16
225068887084592	lATEX	2015-05-14	\N
225068887084592	ARA	2015-03-08	\N
225068887084592	PENIC	2018-02-13	\N
225068887084592	LAV	2016-12-09	2018-05-23
285047209123387	BLATE	2016-03-02	2021-09-18
285047209123387	lATEX	2020-10-04	2021-04-12
172013763767596	GUEPE	2021-03-09	\N
272048448848606	POILE	2021-09-08	2021-11-04
272048448848606	MOISI	2018-11-03	\N
272048448848606	BEE	2018-10-02	2018-12-28
143040375736731	lATEX	2017-03-11	2021-06-07
149050153967537	POILE	2020-02-06	2020-09-09
149050153967537	PENIC	2015-06-18	\N
149050153967537	LAV	2016-04-13	2017-01-08
149050153967537	BLATE	2016-03-04	2018-06-26
116049935189022	GLUTN	2016-04-24	2017-06-16
116049935189022	LAV	2016-04-17	\N
188097216431952	BLATE	2020-11-06	\N
188097216431952	PENIC	2017-05-03	2020-09-02
188097216431952	POLN	2020-02-07	2021-08-27
216082764922433	ASPIR	2017-04-05	\N
224115970622441	GUEPE	2021-02-23	2021-07-10
224115970622441	PENIC	2018-09-27	2020-06-12
224115970622441	ASPIR	2017-11-14	\N
224115970622441	BLATE	2016-05-17	2020-08-19
224115970622441	MOISI	2017-02-27	\N
285114788952558	PENIC	2021-02-03	2021-10-06
247075491328391	lATEX	2016-12-27	2018-06-09
247075491328391	GUEPE	2017-04-12	2021-03-12
247075491328391	BEE	2021-02-13	2021-02-24
271022923220246	PENIC	2019-05-16	2019-10-23
271022923220246	lATEX	2020-12-28	2020-12-28
271022923220246	BLATE	2015-04-12	\N
271022923220246	ASPIR	2018-07-23	2018-08-20
271022923220246	GUEPE	2020-03-01	2020-12-09
257059520141788	lATEX	2017-01-24	\N
257059520141788	MOISI	2015-04-05	2015-09-18
240114567406709	ARA	2017-12-18	2019-11-10
240114567406709	PENIC	2018-01-18	2020-12-07
240114567406709	BEE	2018-09-23	\N
240114567406709	lATEX	2020-02-18	\N
240114567406709	BLATE	2016-04-24	\N
268088051496928	LAV	2015-12-21	2020-03-12
268088051496928	BEE	2016-04-11	\N
268088051496928	GUEPE	2015-01-14	2016-01-16
268088051496928	PENIC	2021-02-09	\N
268088051496928	lATEX	2018-11-15	2018-11-16
236045389806266	POILE	2017-06-22	\N
145026259569030	MOISI	2018-11-17	\N
145026259569030	ASPIR	2015-09-05	\N
145026259569030	BLATE	2020-11-01	\N
145026259569030	GUEPE	2016-04-18	\N
145026259569030	ARA	2020-12-15	\N
255091764125894	MOISI	2018-09-03	2019-04-10
255091764125894	ARA	2018-03-03	\N
255091764125894	ASPIR	2019-06-02	2019-09-02
255091764125894	BEE	2016-10-28	2021-01-09
246079035822823	PENIC	2021-05-23	2021-07-15
246079035822823	GUEPE	2020-04-27	2021-03-16
246079035822823	POLN	2020-05-10	2021-04-09
246079035822823	POILE	2017-02-18	\N
246079035822823	ASPIR	2018-05-06	\N
242043622468996	POILE	2015-11-11	\N
242043622468996	GUEPE	2015-05-25	\N
103096383824071	BLATE	2016-05-03	\N
103096383824071	ASPIR	2016-03-25	\N
103096383824071	ARA	2021-09-11	2021-09-27
103096383824071	GUEPE	2017-08-20	2018-07-26
268064292795561	PENIC	2019-11-01	2019-11-15
299111020477610	GLUTN	2018-04-10	\N
135045223209774	PENIC	2017-01-24	2017-12-01
135045223209774	BEE	2017-03-27	\N
135045223209774	ASPIR	2020-10-13	\N
135045223209774	GLUTN	2019-06-16	\N
153107527788126	BLATE	2019-11-03	2021-11-06
153107527788126	ARA	2020-08-16	2021-09-28
153107527788126	lATEX	2020-05-20	2021-08-09
171059332834846	BEE	2018-08-18	\N
171059332834846	lATEX	2021-04-20	\N
106011084231378	BLATE	2020-07-26	\N
106011084231378	lATEX	2016-01-27	2020-11-02
106011084231378	LAV	2019-01-12	\N
106011084231378	ASPIR	2016-07-23	2020-03-10
106011084231378	GLUTN	2015-08-12	\N
144058651158085	ARA	2019-10-14	2021-06-17
144058651158085	GUEPE	2015-02-23	\N
144058651158085	LAV	2018-06-01	\N
144058651158085	MOISI	2018-04-23	2018-06-06
144058651158085	POLN	2017-02-11	\N
297036084866434	BLATE	2018-05-20	2019-12-24
297036084866434	lATEX	2019-11-13	2021-06-08
104024782793871	LAV	2016-04-05	2016-10-09
104024782793871	PENIC	2015-06-21	\N
104024782793871	MOISI	2015-12-12	2020-03-07
256062556405124	LAV	2019-02-16	2021-06-10
256062556405124	PENIC	2021-10-01	2021-10-03
188057492936580	MOISI	2019-03-20	2020-03-28
188057492936580	BLATE	2016-03-04	\N
188057492936580	GLUTN	2021-02-14	\N
188057492936580	GUEPE	2021-09-02	\N
188057492936580	ARA	2016-06-24	\N
145107728311572	ASPIR	2018-12-13	\N
145107728311572	lATEX	2016-01-03	2016-05-13
145107728311572	PENIC	2021-09-26	2021-11-17
145107728311572	POILE	2016-02-08	\N
256025976064713	GLUTN	2021-03-10	2021-08-13
256025976064713	BLATE	2020-01-22	\N
256025976064713	ARA	2018-12-09	2020-06-20
256025976064713	lATEX	2019-08-21	2019-08-26
256025976064713	PENIC	2019-01-25	\N
156125231843210	GUEPE	2020-03-02	\N
156125231843210	LAV	2015-05-12	2021-02-09
108097522748111	lATEX	2016-05-26	\N
108097522748111	PENIC	2020-03-21	2021-02-03
108097522748111	POLN	2021-05-22	\N
116026335121455	POLN	2019-03-01	\N
116026335121455	PENIC	2017-04-09	2021-09-13
116026335121455	MOISI	2017-11-08	2019-07-15
116026335121455	lATEX	2016-11-17	2019-01-20
193033556420427	POILE	2020-08-08	2021-02-05
157103185444294	MOISI	2019-10-15	\N
157103185444294	BLATE	2019-12-12	\N
157103185444294	GLUTN	2016-11-10	\N
158125852966745	lATEX	2017-01-20	2021-01-23
158125852966745	ARA	2016-10-26	\N
158125852966745	POLN	2017-08-24	2021-01-27
158125852966745	BEE	2017-06-03	\N
245085054653774	POILE	2016-08-02	2017-01-12
245085054653774	LAV	2021-05-01	\N
245085054653774	GUEPE	2019-03-20	2021-09-03
129099269265203	BEE	2018-01-01	\N
129099269265203	ASPIR	2016-01-01	2016-06-28
137067952932213	PENIC	2018-10-15	2021-11-08
129015333191150	GUEPE	2019-09-10	\N
129015333191150	ARA	2019-08-01	\N
129015333191150	POLN	2018-02-12	2020-11-07
252076491934774	ASPIR	2018-05-04	\N
252076491934774	GLUTN	2015-09-12	\N
252076491934774	MOISI	2015-08-07	2018-12-12
252076491934774	BLATE	2020-01-05	\N
137084945054430	BEE	2019-02-07	2019-05-04
137084945054430	GUEPE	2016-04-12	2018-12-06
137084945054430	PENIC	2019-09-11	\N
123038603569252	GLUTN	2017-06-01	\N
123038603569252	LAV	2015-03-19	2018-10-01
284046374475926	POLN	2015-08-18	2021-01-18
162024692293914	PENIC	2017-09-08	2017-10-12
162024692293914	BEE	2017-01-02	2017-08-09
162024692293914	ARA	2015-09-17	2018-01-21
162024692293914	MOISI	2021-05-04	\N
162024692293914	lATEX	2015-11-08	\N
286071597914575	GUEPE	2017-09-28	\N
286071597914575	GLUTN	2021-06-10	\N
286071597914575	ARA	2018-06-17	\N
139062755438909	ARA	2021-11-07	2021-11-08
139062755438909	LAV	2019-04-09	\N
139062755438909	POILE	2017-12-27	\N
139062755438909	POLN	2021-08-14	2021-10-20
102019659160308	GUEPE	2020-02-27	2020-11-06
102019659160308	ASPIR	2017-03-21	2021-02-28
102019659160308	GLUTN	2016-01-19	2016-10-17
102019659160308	MOISI	2018-11-12	\N
150081201116183	POILE	2017-05-16	2021-09-12
150081201116183	GLUTN	2018-07-27	\N
147085285282844	PENIC	2021-05-03	\N
147085285282844	ARA	2016-11-08	2020-03-27
147085285282844	BLATE	2019-04-08	2021-06-02
295012888306237	BEE	2019-10-07	2020-01-07
295012888306237	GUEPE	2017-12-14	\N
228121380869080	GLUTN	2017-08-24	\N
228121380869080	POILE	2018-10-10	2020-01-11
228121380869080	BLATE	2018-12-15	2018-12-22
209076917524931	lATEX	2020-08-05	\N
209076917524931	MOISI	2017-04-18	\N
114128201353291	GUEPE	2018-11-03	2021-02-18
114128201353291	PENIC	2019-09-01	2019-09-13
140021024071878	ARA	2019-03-09	2021-09-02
140021024071878	lATEX	2016-09-10	2018-01-14
140021024071878	POLN	2019-04-16	\N
140021024071878	PENIC	2021-05-01	\N
140021024071878	GLUTN	2016-10-21	\N
214058422588031	PENIC	2015-10-02	2018-03-03
214058422588031	ARA	2019-02-26	2021-01-11
214058422588031	POLN	2021-09-18	\N
297018588389986	BEE	2016-03-13	2020-11-12
297018588389986	GUEPE	2019-09-11	\N
270091948045432	POLN	2018-07-22	\N
131085984245638	GLUTN	2015-08-04	2020-04-22
131085984245638	GUEPE	2021-07-04	\N
217077302350914	POLN	2018-07-07	\N
217077302350914	PENIC	2017-05-04	2020-04-05
217077302350914	BEE	2017-01-28	2021-05-01
217077302350914	GLUTN	2019-09-08	\N
247064950013140	POLN	2018-05-27	\N
247064950013140	GLUTN	2018-07-28	\N
247064950013140	MOISI	2019-06-08	\N
103065213906618	BLATE	2020-08-24	\N
103065213906618	BEE	2021-04-26	2021-06-09
264074023702284	GUEPE	2020-11-17	\N
264074023702284	MOISI	2016-02-10	\N
264074023702284	BEE	2015-04-13	\N
272103843045703	BLATE	2015-09-19	\N
272103843045703	LAV	2019-06-02	2020-06-12
272103843045703	GUEPE	2020-09-27	\N
272103843045703	GLUTN	2019-09-27	\N
272103843045703	lATEX	2018-09-25	2020-05-15
274088813916527	POILE	2019-04-03	\N
274088813916527	BLATE	2017-04-06	2019-06-08
274088813916527	lATEX	2016-06-14	2017-12-01
274088813916527	ASPIR	2018-07-06	2018-12-15
274088813916527	MOISI	2018-11-12	\N
208118561794850	POLN	2016-02-10	\N
208118561794850	PENIC	2020-05-25	2020-07-25
208118561794850	LAV	2015-11-02	\N
208118561794850	MOISI	2019-12-15	2021-04-23
208118561794850	GUEPE	2020-01-08	\N
138105592649180	PENIC	2017-11-13	\N
138105592649180	ARA	2019-03-07	2021-09-22
255088965332455	lATEX	2015-10-22	2017-01-26
255088965332455	GLUTN	2018-10-21	\N
255088965332455	ASPIR	2020-05-18	\N
255088965332455	LAV	2019-12-07	\N
243013407647544	PENIC	2021-10-26	2021-10-27
243013407647544	ARA	2016-11-01	\N
243013407647544	lATEX	2017-05-03	\N
243013407647544	BEE	2015-01-28	2017-01-28
208089025109136	BLATE	2016-10-18	\N
208089025109136	BEE	2016-01-10	2020-08-23
293129298699077	GLUTN	2016-05-19	2019-10-14
210043607648491	MOISI	2015-11-13	2018-08-04
210043607648491	ARA	2015-06-24	\N
210043607648491	GLUTN	2017-09-06	2021-06-27
210043607648491	PENIC	2019-10-01	\N
223122030311311	BLATE	2015-10-11	\N
223122030311311	lATEX	2018-10-12	\N
223122030311311	GLUTN	2016-03-05	\N
223122030311311	POILE	2019-02-18	\N
223122030311311	ASPIR	2019-03-01	\N
261019617230168	POILE	2017-12-17	\N
261019617230168	LAV	2021-09-17	2021-11-11
261019617230168	GLUTN	2015-05-16	\N
261019617230168	MOISI	2016-08-08	\N
261019617230168	lATEX	2020-01-28	2021-08-22
243066968428847	lATEX	2021-05-20	2021-11-16
243066968428847	GUEPE	2015-08-13	2018-01-02
243066968428847	BEE	2015-04-28	\N
243066968428847	MOISI	2020-06-21	2020-07-27
170080268839901	LAV	2020-03-01	2021-04-10
170080268839901	lATEX	2019-08-23	\N
170080268839901	GUEPE	2016-08-15	\N
170080268839901	BLATE	2016-08-17	\N
219116344306402	GUEPE	2020-04-28	\N
219116344306402	MOISI	2020-12-27	\N
179098881632515	BEE	2017-04-10	\N
179098881632515	POILE	2016-10-18	\N
179098881632515	ASPIR	2021-10-05	\N
179098881632515	GLUTN	2019-10-02	\N
179098881632515	PENIC	2021-09-10	\N
136114138407278	PENIC	2015-06-26	2020-09-14
136114138407278	BEE	2021-10-07	\N
281019819289565	PENIC	2015-05-15	2021-10-02
281019819289565	LAV	2021-03-14	2021-06-15
227073625053031	BLATE	2015-12-14	2017-04-03
227073625053031	lATEX	2018-12-12	2018-12-21
227073625053031	ARA	2015-04-18	2017-11-08
227073625053031	LAV	2016-12-24	\N
137012739426413	POLN	2018-01-17	\N
137012739426413	BLATE	2015-11-17	2015-12-17
137012739426413	GUEPE	2018-05-12	\N
126068767532596	MOISI	2017-05-14	\N
126068767532596	PENIC	2018-01-03	2021-11-11
126068767532596	ARA	2019-04-15	2019-09-05
126068767532596	GUEPE	2018-06-24	2021-11-16
126068767532596	POILE	2015-08-04	\N
297118813515304	ASPIR	2021-08-17	2021-10-01
297118813515304	POILE	2020-03-26	2020-07-27
297118813515304	ARA	2020-05-28	\N
297118813515304	POLN	2020-07-02	\N
102017878755115	GLUTN	2017-01-16	\N
102017878755115	LAV	2017-03-16	\N
102017878755115	GUEPE	2017-08-24	2020-03-02
131125282953657	MOISI	2015-06-13	2017-09-26
131125282953657	GUEPE	2020-01-15	\N
265121844820151	BLATE	2019-11-15	2019-11-18
265121844820151	ARA	2016-03-13	2017-05-09
265121844820151	LAV	2018-06-27	\N
166028647357667	POLN	2019-07-09	\N
118112410272245	POILE	2019-03-05	2019-07-10
118112410272245	MOISI	2015-01-11	2017-04-13
184029967452706	BEE	2019-09-23	2019-11-04
184029967452706	POLN	2016-09-28	2019-09-28
102085689984553	POILE	2019-04-27	\N
102085689984553	BEE	2018-12-11	2021-07-19
102085689984553	BLATE	2018-03-27	\N
102085689984553	ARA	2017-05-11	\N
102085689984553	LAV	2018-12-09	2019-11-06
164084503884247	ASPIR	2018-05-21	\N
164084503884247	BEE	2020-07-07	\N
164084503884247	BLATE	2020-06-15	\N
164084503884247	MOISI	2018-03-19	2018-11-12
135074940491607	ASPIR	2016-08-17	2016-12-06
135074940491607	POLN	2017-07-19	2021-04-04
199030716614074	LAV	2016-12-15	2017-01-16
260115670258424	POLN	2021-10-14	2021-10-24
260115670258424	GLUTN	2016-02-04	\N
260115670258424	PENIC	2019-03-10	2021-11-07
260115670258424	POILE	2018-05-26	2021-06-20
178092232278018	lATEX	2021-07-05	\N
178092232278018	GLUTN	2015-02-11	\N
178092232278018	ASPIR	2021-06-06	\N
131070172653837	GUEPE	2021-01-09	2021-05-01
252123340003556	POILE	2018-08-10	2021-04-22
252123340003556	ARA	2019-01-02	\N
270049403545237	BEE	2021-04-25	\N
270049403545237	MOISI	2018-12-20	2019-11-06
270049403545237	PENIC	2015-06-22	2020-12-23
270049403545237	POLN	2017-11-04	\N
270049403545237	GLUTN	2020-07-14	2020-09-02
122013583993734	POLN	2016-04-28	2021-06-17
122013583993734	lATEX	2021-08-25	\N
122013583993734	POILE	2019-04-01	2021-08-17
247064696896690	LAV	2015-09-26	2020-08-06
247064696896690	ASPIR	2017-05-16	2021-05-18
247064696896690	POILE	2019-07-21	2021-04-25
211103396685063	PENIC	2021-02-18	2021-06-25
211103396685063	MOISI	2021-05-26	2021-07-23
211103396685063	GLUTN	2019-07-14	2020-12-11
124068718826168	GUEPE	2019-03-09	2019-05-04
124068718826168	ARA	2020-09-11	\N
124068718826168	LAV	2018-03-13	\N
296038999707691	POLN	2017-09-17	2017-09-26
296038999707691	ASPIR	2021-11-11	\N
296038999707691	MOISI	2017-08-02	\N
141037987029076	PENIC	2019-11-08	2020-04-02
141037987029076	lATEX	2021-08-04	\N
201081626343750	LAV	2015-11-09	2015-12-06
201081626343750	lATEX	2021-09-22	\N
190047473188512	BEE	2019-04-07	\N
190047473188512	lATEX	2016-04-15	\N
190047473188512	LAV	2021-11-16	\N
209038216146851	lATEX	2015-01-15	2015-07-09
209038216146851	LAV	2018-02-08	\N
209038216146851	MOISI	2020-05-08	\N
209038216146851	BLATE	2015-06-15	\N
120027610567383	PENIC	2020-03-07	2020-11-10
120027610567383	MOISI	2021-09-07	\N
120027610567383	BEE	2020-09-11	2021-03-10
120027610567383	BLATE	2020-07-06	2021-01-24
118099632841858	GLUTN	2020-07-17	\N
118099632841858	POILE	2020-05-26	2020-07-12
118099632841858	lATEX	2018-05-13	\N
118099632841858	ARA	2015-11-01	\N
153023371372412	MOISI	2017-07-01	\N
153023371372412	BLATE	2015-11-07	2016-10-18
153023371372412	PENIC	2019-01-20	2019-07-23
153023371372412	BEE	2017-01-14	2021-08-06
220035719909604	PENIC	2015-02-03	2021-06-04
220035719909604	ASPIR	2016-06-25	2020-08-19
220035719909604	MOISI	2018-08-21	\N
299128835735359	BLATE	2016-11-04	\N
299128835735359	lATEX	2016-02-12	2019-12-15
171096323748369	GLUTN	2021-09-19	2021-11-10
171096323748369	BEE	2020-05-09	\N
171096323748369	POILE	2016-11-06	\N
171096323748369	GUEPE	2017-11-08	2017-12-15
171096323748369	ARA	2019-01-03	2019-01-07
249118020522088	GLUTN	2017-01-09	\N
249118020522088	POILE	2018-09-09	2018-11-04
279037176177857	MOISI	2019-04-08	2021-09-07
279037176177857	POLN	2017-07-05	2020-05-03
279037176177857	LAV	2021-07-09	\N
216050588792452	POLN	2015-02-14	\N
216050588792452	GUEPE	2021-01-10	\N
216050588792452	ASPIR	2019-06-06	2021-04-19
216050588792452	GLUTN	2018-03-09	\N
101027766706912	lATEX	2019-11-08	\N
259024064714624	ASPIR	2016-04-22	2020-12-19
270014064481086	POLN	2019-09-08	2019-11-12
270014064481086	ASPIR	2017-08-23	\N
152050826723518	GLUTN	2021-01-02	\N
152050826723518	ASPIR	2015-01-18	2018-09-10
152050826723518	BLATE	2017-02-09	2018-05-15
152050826723518	ARA	2020-05-21	\N
152050826723518	PENIC	2021-05-17	\N
231078668662003	BLATE	2020-03-26	2020-04-01
231078668662003	POLN	2019-09-19	2021-10-02
231078668662003	MOISI	2018-03-09	2018-03-11
147034386292786	ARA	2019-09-03	\N
182014842853195	GUEPE	2021-08-01	\N
182014842853195	POILE	2021-05-12	\N
182014842853195	BLATE	2017-04-26	2019-09-15
292083432286212	lATEX	2021-03-15	\N
292083432286212	BEE	2021-01-19	2021-09-23
292083432286212	MOISI	2016-02-13	2019-01-09
292083432286212	POLN	2021-06-18	2021-11-07
261055944395226	GUEPE	2018-05-07	2021-07-01
261055944395226	MOISI	2016-08-01	2017-06-09
261055944395226	POILE	2021-08-20	2021-08-24
261055944395226	GLUTN	2015-09-01	2018-05-22
261055944395226	BLATE	2019-03-08	\N
128055781153403	GLUTN	2019-05-20	2021-03-12
224059146621395	BEE	2016-04-27	\N
283114678495021	ARA	2018-03-09	2019-07-19
283114678495021	MOISI	2017-11-06	2019-11-14
283114678495021	POLN	2017-10-04	\N
283114678495021	BEE	2018-04-20	\N
283114678495021	POILE	2015-07-11	2019-11-01
178014634707159	BEE	2018-12-04	2018-12-28
213083916917722	MOISI	2016-01-02	\N
213083916917722	PENIC	2020-12-24	2020-12-28
213083916917722	GUEPE	2016-09-10	\N
213083916917722	POILE	2021-03-09	\N
213083916917722	ASPIR	2015-12-11	\N
215085796076693	MOISI	2015-09-08	2019-05-26
272071958103759	ARA	2020-02-05	\N
272071958103759	ASPIR	2018-08-05	\N
272071958103759	MOISI	2016-03-02	\N
272071958103759	POLN	2015-12-13	\N
272071958103759	GUEPE	2020-10-22	2020-10-24
202046097430545	PENIC	2016-05-21	\N
202046097430545	BEE	2018-02-19	\N
202046097430545	GLUTN	2018-05-06	2018-06-27
202046097430545	POLN	2020-11-11	2020-11-15
255053357438060	ASPIR	2017-02-23	\N
255053357438060	BLATE	2020-07-09	\N
255053357438060	BEE	2020-08-27	\N
255053357438060	GLUTN	2019-02-16	\N
143094758250605	GLUTN	2018-05-28	\N
143094758250605	LAV	2015-05-20	\N
143094758250605	GUEPE	2016-06-16	\N
143094758250605	POILE	2015-07-02	\N
135013147654144	lATEX	2016-02-25	\N
149056744712258	BLATE	2016-01-18	2021-09-16
149056744712258	ASPIR	2019-09-10	2020-08-12
149056744712258	BEE	2018-07-20	2021-05-05
149056744712258	lATEX	2018-11-10	2021-04-28
241091337496952	POILE	2020-05-06	2020-08-19
241091337496952	PENIC	2018-10-28	\N
241091337496952	ASPIR	2020-08-28	2021-05-08
241091337496952	BEE	2019-06-18	2019-07-07
237123674082614	GLUTN	2021-08-07	2021-10-08
237123674082614	BLATE	2018-03-09	\N
237123674082614	LAV	2019-05-26	\N
188107331612463	GUEPE	2018-01-10	2020-03-09
188107331612463	lATEX	2018-09-03	2020-11-01
146038139963472	ARA	2021-01-02	2021-04-26
146038139963472	BEE	2020-06-11	2021-02-15
146038139963472	lATEX	2019-02-05	\N
275071720303360	LAV	2018-09-23	\N
275071720303360	ARA	2020-10-02	\N
275071720303360	ASPIR	2015-03-03	\N
275071720303360	POILE	2016-10-26	2021-08-27
260055549848885	POILE	2020-06-06	\N
260055549848885	PENIC	2017-07-07	\N
214020543515529	BLATE	2019-01-18	2019-04-27
214020543515529	POILE	2020-11-17	\N
214020543515529	GLUTN	2018-05-15	2021-07-12
214020543515529	PENIC	2019-03-11	2020-10-26
135100709107338	POILE	2015-11-07	\N
135100709107338	ARA	2020-07-25	2020-12-27
135100709107338	PENIC	2020-10-18	\N
278106956056295	PENIC	2018-01-20	\N
278106956056295	BLATE	2016-06-15	2017-08-13
196044090469523	LAV	2015-12-12	2016-12-15
196044090469523	PENIC	2019-01-28	2021-09-09
196044090469523	ARA	2020-01-15	2020-07-17
196044090469523	MOISI	2016-04-11	2018-06-05
170032191239838	lATEX	2015-08-16	2021-07-04
170032191239838	GLUTN	2021-10-14	2021-10-25
262094703954561	lATEX	2021-11-16	2021-11-18
262094703954561	BLATE	2018-05-01	\N
262094703954561	LAV	2020-10-16	\N
262094703954561	POLN	2018-05-20	\N
262094703954561	PENIC	2018-01-15	\N
293098735454683	ARA	2020-10-15	\N
293098735454683	lATEX	2020-01-10	\N
293098735454683	ASPIR	2021-01-16	2021-03-17
293098735454683	POILE	2018-02-10	\N
114031662892732	GLUTN	2020-09-13	2021-10-25
114031662892732	BLATE	2015-12-26	\N
114031662892732	BEE	2015-02-06	2021-10-14
114031662892732	lATEX	2015-04-05	\N
233063938553717	ASPIR	2017-01-14	\N
233063938553717	BLATE	2018-09-23	2021-08-26
142027529465492	BLATE	2021-11-11	2021-11-18
268081386395744	MOISI	2020-04-27	2020-08-07
268081386395744	POILE	2020-09-19	2020-12-20
268081386395744	BEE	2015-03-27	\N
268081386395744	GLUTN	2018-06-04	\N
268081386395744	PENIC	2019-03-17	2020-10-23
119125003483214	GLUTN	2019-09-16	\N
119125003483214	LAV	2016-10-22	\N
119125003483214	BLATE	2019-09-06	2020-04-14
119125003483214	lATEX	2017-08-18	2019-12-10
119125003483214	ARA	2018-06-10	\N
260083942923902	POILE	2016-04-14	\N
281111914382515	MOISI	2017-08-26	2018-07-10
271010916937233	BEE	2019-06-25	2019-07-24
271010916937233	ASPIR	2021-06-18	2021-07-26
271010916937233	lATEX	2017-01-11	\N
271010916937233	ARA	2016-02-25	2016-06-22
271010916937233	LAV	2018-03-12	2018-09-15
131052658062338	GUEPE	2021-01-05	\N
131052658062338	BLATE	2021-05-15	2021-11-18
174018102858594	ASPIR	2021-04-26	\N
174018102858594	PENIC	2018-12-17	2020-09-06
174018102858594	ARA	2021-03-05	\N
150072095960502	POLN	2021-02-14	2021-11-02
156112101254314	GLUTN	2015-07-25	\N
156112101254314	POLN	2015-07-09	\N
156112101254314	BLATE	2016-01-01	\N
156112101254314	POILE	2019-03-06	2021-10-21
224043336251390	BLATE	2017-12-14	2017-12-24
267066331716920	BLATE	2016-10-08	\N
267066331716920	POILE	2021-03-26	2021-11-11
261077305981665	lATEX	2021-08-04	\N
261077305981665	LAV	2018-03-24	\N
115016947696529	lATEX	2015-06-20	2017-12-25
115016947696529	GLUTN	2020-10-16	\N
245044833929736	MOISI	2015-08-08	\N
297073818905849	POLN	2018-03-24	\N
297073818905849	BEE	2016-08-16	\N
297073818905849	BLATE	2017-03-25	2018-04-22
218112782420475	GLUTN	2020-01-19	2021-05-04
218112782420475	ASPIR	2016-09-09	\N
218112782420475	BEE	2019-09-24	2019-09-25
218112782420475	MOISI	2017-08-01	2021-10-20
253026744850990	ASPIR	2019-12-19	2021-01-20
253026744850990	GLUTN	2016-05-05	\N
253026744850990	GUEPE	2020-08-14	2021-09-05
203124780561391	ARA	2019-06-01	\N
203124780561391	MOISI	2015-03-12	2018-05-03
203124780561391	POLN	2018-06-13	2019-10-20
203124780561391	PENIC	2017-10-27	2019-12-28
158036596308209	PENIC	2019-08-27	2020-07-06
158036596308209	BEE	2018-02-11	2018-02-24
204038320321261	lATEX	2019-04-13	\N
204038320321261	ASPIR	2019-04-02	2019-11-03
204038320321261	GUEPE	2015-06-11	\N
204038320321261	GLUTN	2019-02-07	\N
269054468621668	PENIC	2016-01-02	2020-06-15
269054468621668	LAV	2021-10-27	\N
121086804762872	BEE	2021-01-24	2021-09-23
121086804762872	PENIC	2019-09-15	\N
121086804762872	POILE	2020-07-09	\N
201074157091853	ARA	2016-09-20	\N
126033690529208	LAV	2020-10-05	2020-11-10
210075736883420	BEE	2019-09-16	\N
210075736883420	ARA	2020-05-10	\N
210075736883420	PENIC	2021-05-17	2021-09-16
210075736883420	POLN	2015-08-11	2017-05-23
216089371391561	ASPIR	2021-04-10	2021-09-05
216089371391561	GLUTN	2018-10-09	\N
216089371391561	GUEPE	2020-09-04	2020-12-13
216089371391561	POILE	2019-09-03	2019-11-02
216089371391561	LAV	2015-09-01	2018-02-14
159034821642031	LAV	2016-03-02	2017-03-05
159034821642031	BEE	2015-08-17	2021-02-05
159034821642031	ARA	2019-01-27	2019-01-28
159034821642031	POILE	2021-06-16	\N
264017112670014	POILE	2016-12-23	2021-06-06
264017112670014	LAV	2016-12-21	\N
239085554893582	ASPIR	2018-06-14	\N
239085554893582	ARA	2016-08-17	\N
239085554893582	POILE	2021-09-09	\N
239085554893582	MOISI	2016-05-11	\N
239085554893582	GLUTN	2015-11-16	\N
276113638415091	PENIC	2019-11-13	\N
276113638415091	GLUTN	2017-01-21	2020-10-14
276113638415091	LAV	2015-04-04	\N
148053879024132	POILE	2015-06-26	\N
148053879024132	BEE	2021-02-19	2021-02-24
148053879024132	GLUTN	2016-04-05	\N
160036331293193	POLN	2020-01-09	\N
160036331293193	LAV	2021-11-02	2021-11-17
160036331293193	POILE	2019-05-13	\N
160036331293193	lATEX	2016-09-17	\N
160036331293193	MOISI	2016-12-05	\N
274044454242295	GUEPE	2019-06-25	\N
274044454242295	POILE	2015-07-07	\N
274044454242295	lATEX	2015-12-07	\N
274044454242295	PENIC	2018-12-19	\N
149012807148886	ARA	2017-03-18	\N
149012807148886	BEE	2015-10-12	2017-05-11
149012807148886	LAV	2015-05-28	\N
149012807148886	ASPIR	2021-05-06	\N
149012807148886	lATEX	2018-10-04	2020-11-12
292069883843039	BEE	2019-02-23	2020-01-07
292069883843039	GUEPE	2016-10-12	\N
102013760217462	ASPIR	2018-06-26	2019-08-27
102013760217462	lATEX	2018-09-16	\N
102013760217462	MOISI	2019-04-26	2021-06-17
175032006668491	POILE	2016-04-27	\N
175032006668491	GLUTN	2021-10-17	2021-10-22
175032006668491	BEE	2015-06-10	2015-11-16
175032006668491	MOISI	2015-11-12	2019-01-10
296072961678303	POILE	2019-04-26	2021-10-10
296072961678303	LAV	2017-02-28	2021-05-25
296072961678303	PENIC	2019-08-09	\N
296072961678303	BEE	2016-08-04	2021-04-22
186042352386031	MOISI	2019-08-27	\N
186042352386031	BEE	2020-10-15	2021-02-25
133057183683629	ASPIR	2019-01-12	2020-12-09
133057183683629	BEE	2021-01-23	2021-01-26
133057183683629	GUEPE	2017-09-22	2018-07-24
133057183683629	BLATE	2019-11-17	\N
239091146729071	GUEPE	2015-12-28	\N
263101694819786	GLUTN	2021-05-14	\N
161030812581007	lATEX	2018-01-02	2020-03-23
161030812581007	ARA	2018-05-22	\N
161030812581007	BEE	2015-04-02	2017-04-17
107093235177704	BEE	2015-01-06	\N
107093235177704	GLUTN	2021-09-14	\N
107093235177704	lATEX	2017-04-11	2017-04-19
212107700291388	lATEX	2016-08-07	2020-08-23
185068654919823	POILE	2021-09-20	\N
185068654919823	ARA	2017-11-18	\N
185068654919823	GUEPE	2015-11-07	\N
185068654919823	LAV	2017-10-03	2018-03-21
186124469172237	BEE	2020-01-02	\N
186124469172237	GLUTN	2019-08-15	\N
186124469172237	POILE	2015-12-07	2020-09-08
186124469172237	MOISI	2019-06-22	2019-08-10
129115117911004	BEE	2015-04-06	2019-08-19
129115117911004	ARA	2015-04-24	\N
129115117911004	lATEX	2015-06-19	\N
129115117911004	LAV	2017-12-08	\N
129115117911004	GLUTN	2020-03-23	2021-07-11
174109372159626	GUEPE	2020-09-05	2020-09-07
174109372159626	POILE	2017-12-22	2020-09-27
174109372159626	ARA	2019-01-08	\N
174109372159626	LAV	2016-05-10	\N
166063604370140	ASPIR	2018-02-07	\N
265124877010950	POILE	2018-02-10	2018-10-26
265124877010950	PENIC	2018-02-24	\N
265124877010950	MOISI	2019-08-15	2021-10-27
242082419543236	POILE	2020-02-02	\N
242082419543236	POLN	2021-03-16	2021-03-17
231055267153739	POLN	2015-05-25	2018-06-20
231055267153739	BLATE	2021-05-13	2021-10-16
231055267153739	GUEPE	2019-03-10	2019-05-21
183027292071405	PENIC	2019-05-09	\N
183027292071405	GLUTN	2017-06-08	2017-12-16
119062521839354	ARA	2016-05-09	2019-06-10
119062521839354	PENIC	2021-03-21	\N
119062521839354	LAV	2017-12-16	\N
119062521839354	BLATE	2020-06-07	2021-03-19
202103092588087	ASPIR	2018-03-09	2021-08-10
202103092588087	GUEPE	2021-02-26	\N
202103092588087	POILE	2017-02-05	\N
134055750788867	ARA	2016-12-19	2021-02-09
270096529380286	ASPIR	2017-02-04	\N
270096529380286	ARA	2016-06-01	2018-12-05
270096529380286	lATEX	2018-04-28	\N
201052199619458	ARA	2015-03-06	2018-11-17
201052199619458	GUEPE	2019-11-04	\N
201052199619458	LAV	2019-08-10	2021-04-02
201052199619458	ASPIR	2019-04-06	2019-08-11
164109917354484	lATEX	2016-04-12	\N
185031273229975	BLATE	2020-03-10	\N
185031273229975	ARA	2017-10-06	\N
165015991694361	GLUTN	2015-09-01	\N
165015991694361	POLN	2020-05-17	2020-10-13
181010871674560	BLATE	2015-10-16	\N
139050580745001	PENIC	2016-05-23	\N
139050580745001	ARA	2016-03-28	\N
139050580745001	BEE	2019-07-24	2021-03-15
139050580745001	ASPIR	2015-08-13	\N
139050580745001	LAV	2016-10-24	\N
277041387830758	GUEPE	2017-08-22	2021-06-19
115069364634634	GUEPE	2016-07-07	2021-01-15
115069364634634	LAV	2019-02-05	2019-06-20
115069364634634	POLN	2021-05-02	2021-08-17
115069364634634	BEE	2019-10-04	2021-04-01
115069364634634	ASPIR	2021-02-24	2021-07-12
241096000702739	ARA	2015-12-16	2016-09-11
241096000702739	BLATE	2017-11-11	2020-11-15
216048982722935	GUEPE	2020-12-17	\N
216048982722935	POILE	2017-11-07	\N
216048982722935	ASPIR	2016-09-18	2017-12-28
216048982722935	GLUTN	2016-04-16	2016-04-28
276043885107833	ARA	2018-02-22	\N
276043885107833	ASPIR	2018-10-09	\N
276043885107833	PENIC	2017-09-22	2020-07-13
257065888851792	POILE	2017-10-02	\N
116047632185619	POLN	2015-05-15	2018-11-04
116047632185619	lATEX	2015-09-11	\N
116047632185619	MOISI	2017-12-28	2021-08-03
116047632185619	ARA	2018-01-12	2020-12-07
237016326038243	GUEPE	2019-05-25	2021-01-09
237016326038243	MOISI	2021-06-02	2021-10-20
237016326038243	BLATE	2021-07-18	\N
280089567149014	POILE	2021-08-22	\N
280089567149014	ARA	2018-06-26	\N
280089567149014	GLUTN	2019-08-28	\N
280089567149014	ASPIR	2020-12-07	2021-09-25
280089567149014	GUEPE	2019-04-05	\N
177084821772201	BEE	2018-04-12	2019-07-10
177084821772201	ASPIR	2016-05-24	2020-04-02
177084821772201	GUEPE	2017-05-24	2018-09-08
177084821772201	lATEX	2015-10-28	2016-10-28
177084821772201	LAV	2015-09-23	2021-11-14
132111902031658	lATEX	2021-07-05	2021-11-01
132111902031658	BLATE	2015-09-24	\N
212077306419001	ARA	2018-01-15	\N
240070875310729	POILE	2021-07-21	2021-09-26
240070875310729	ARA	2019-12-28	2020-06-26
240070875310729	PENIC	2016-10-07	2019-12-06
240070875310729	lATEX	2018-07-08	2021-11-10
240070875310729	BLATE	2017-06-16	\N
293085789640582	BLATE	2015-01-03	\N
293085789640582	LAV	2015-03-28	2017-05-05
293085789640582	ARA	2017-10-26	\N
293085789640582	ASPIR	2015-01-03	\N
293085789640582	POILE	2018-05-05	\N
197028693449711	GUEPE	2020-09-01	2021-02-07
248050431160701	PENIC	2016-06-20	2021-09-02
234116778893942	LAV	2020-03-07	2021-08-04
234116778893942	ASPIR	2018-02-23	\N
234116778893942	BEE	2017-01-03	\N
234116778893942	ARA	2017-02-08	2018-06-23
291044306186509	lATEX	2019-11-02	2021-01-15
291044306186509	ARA	2015-02-20	\N
291044306186509	POLN	2017-11-04	2018-06-03
212033837523152	ASPIR	2015-02-21	\N
212033837523152	BEE	2016-02-28	2021-05-08
212033837523152	BLATE	2020-12-23	2021-11-07
212033837523152	GLUTN	2019-05-24	2019-07-11
163115995738082	PENIC	2016-06-18	\N
163115995738082	lATEX	2016-07-20	\N
163115995738082	BLATE	2016-05-13	\N
163115995738082	LAV	2016-07-14	\N
108080499169703	POILE	2021-03-02	2021-09-06
108080499169703	POLN	2016-07-20	2016-07-23
108080499169703	BLATE	2019-07-19	2019-10-03
273073748815960	GUEPE	2019-08-23	2021-10-03
273073748815960	GLUTN	2021-03-16	2021-05-03
273073748815960	MOISI	2018-06-13	2018-07-10
281076355672170	LAV	2021-01-01	\N
281076355672170	BEE	2015-12-21	\N
281076355672170	POLN	2021-11-03	2021-11-16
270109148488384	BEE	2017-10-26	\N
270109148488384	GUEPE	2021-03-08	\N
270109148488384	LAV	2018-08-16	\N
298094244775878	MOISI	2017-04-03	\N
298094244775878	BEE	2019-08-14	2020-12-15
298094244775878	lATEX	2020-01-11	2020-06-17
298094244775878	GLUTN	2016-08-20	2016-12-11
166108820419376	lATEX	2015-11-15	2015-12-07
166108820419376	POLN	2016-02-08	\N
294016552422681	GLUTN	2016-10-17	\N
294016552422681	BLATE	2018-10-13	\N
199101967924971	BLATE	2018-06-24	2019-09-01
199101967924971	ARA	2021-03-15	2021-05-15
199101967924971	lATEX	2020-11-11	2021-05-14
260044683856244	GLUTN	2021-08-14	\N
260044683856244	POLN	2021-06-28	\N
260044683856244	BLATE	2015-10-17	2015-12-26
260044683856244	PENIC	2017-04-20	\N
276076882663621	GUEPE	2017-12-12	2020-02-16
276076882663621	lATEX	2017-10-08	2018-07-23
276076882663621	MOISI	2021-05-19	2021-10-05
276076882663621	LAV	2015-09-14	\N
276076882663621	GLUTN	2020-01-20	2020-03-24
148122725413726	GUEPE	2020-01-25	\N
289010155406208	BEE	2021-04-05	2021-04-11
289010155406208	GLUTN	2016-11-02	2019-07-04
294060407584149	lATEX	2021-11-16	2021-11-18
294060407584149	GUEPE	2016-09-17	\N
294060407584149	BLATE	2017-09-16	\N
294060407584149	POLN	2021-02-26	2021-07-15
294060407584149	ASPIR	2017-05-04	\N
139065443729140	MOISI	2021-08-04	2021-09-28
139065443729140	LAV	2021-11-13	2021-11-17
139065443729140	lATEX	2019-12-23	2020-07-23
139065443729140	BLATE	2015-02-11	2019-04-12
139065443729140	BEE	2018-06-15	\N
166091666520458	BEE	2020-12-14	\N
166091666520458	ARA	2018-12-16	2021-07-09
166091666520458	GUEPE	2021-02-20	\N
119108066223991	ARA	2017-05-08	\N
119108066223991	GUEPE	2015-05-19	2021-03-13
119108066223991	BLATE	2018-05-11	2020-09-16
119108066223991	GLUTN	2017-12-11	2021-04-28
166120368218553	BLATE	2018-10-11	\N
166120368218553	ASPIR	2019-03-03	2020-12-08
196063036979567	BEE	2021-02-17	2021-10-13
196063036979567	GUEPE	2015-11-08	2021-08-01
196063036979567	ARA	2018-09-04	\N
287018783401310	MOISI	2016-12-12	2017-04-18
287018783401310	ASPIR	2015-08-03	\N
287018783401310	GUEPE	2019-08-20	2020-02-18
169123667085745	PENIC	2021-02-17	2021-08-13
169123667085745	BEE	2015-07-21	2017-09-28
169123667085745	GUEPE	2017-03-24	2019-10-15
291045917238489	BLATE	2019-07-15	\N
291045917238489	BEE	2018-03-15	2020-03-16
239107910465394	ASPIR	2019-01-20	2019-04-18
239107910465394	GUEPE	2021-09-10	2021-09-17
239107910465394	MOISI	2019-12-12	\N
239107910465394	POILE	2015-12-22	\N
122055679266216	LAV	2020-12-01	2020-12-20
118086297555680	LAV	2020-04-24	2020-05-18
118086297555680	lATEX	2015-08-28	2015-11-04
250115721904451	MOISI	2015-08-10	2017-11-12
250115721904451	BEE	2017-09-09	\N
250115721904451	GUEPE	2018-05-11	2018-10-27
127058106807061	ARA	2021-09-04	\N
127058106807061	POLN	2015-07-20	2015-12-27
200031594053188	POILE	2016-04-21	\N
200031594053188	MOISI	2019-11-06	\N
200031594053188	POLN	2019-04-01	2019-09-23
200031594053188	LAV	2020-10-11	\N
200031594053188	PENIC	2017-11-17	2021-02-01
193102778541743	ARA	2018-11-01	2021-08-22
193102778541743	BEE	2015-12-04	2019-07-24
193102778541743	GLUTN	2015-08-04	\N
193102778541743	lATEX	2018-07-20	2018-08-20
166066770602613	BEE	2016-04-10	\N
266097183420366	BLATE	2018-06-01	\N
266097183420366	GUEPE	2016-08-07	\N
266097183420366	BEE	2016-09-05	2016-10-08
266097183420366	ASPIR	2021-07-06	\N
266097183420366	GLUTN	2021-02-15	\N
106034249755113	BEE	2018-12-19	\N
106034249755113	PENIC	2017-12-02	2019-08-01
106034249755113	BLATE	2016-04-13	2019-09-07
288021514521235	POLN	2015-02-27	2015-07-10
288021514521235	POILE	2015-04-24	\N
288021514521235	MOISI	2021-05-06	\N
219047723431704	GUEPE	2016-07-14	2016-07-22
219047723431704	ARA	2016-10-04	2019-07-11
219047723431704	ASPIR	2020-08-01	\N
219047723431704	BEE	2016-10-07	\N
219047723431704	POILE	2016-05-28	\N
143018820407138	BLATE	2018-11-03	\N
143018820407138	GLUTN	2021-07-23	2021-09-07
206113724192459	PENIC	2015-11-18	\N
206113724192459	ASPIR	2020-04-19	2021-08-27
206113724192459	lATEX	2019-09-18	2019-12-13
206113724192459	POILE	2020-09-13	\N
206113724192459	GLUTN	2018-03-05	\N
247065902055612	PENIC	2019-03-10	2021-03-22
247065902055612	POILE	2021-11-15	2021-11-15
156095915334257	LAV	2021-07-08	2021-07-12
156095915334257	ARA	2021-04-10	2021-10-17
156095915334257	POILE	2018-01-13	2019-12-09
156095915334257	MOISI	2015-03-07	2015-05-15
156095915334257	BLATE	2017-05-09	2018-10-02
137119435589253	LAV	2019-10-01	\N
210057188504519	PENIC	2018-05-21	\N
210057188504519	BEE	2021-08-17	\N
168092323808223	POILE	2019-05-10	2019-12-25
168092323808223	ASPIR	2020-04-03	\N
168092323808223	BEE	2020-01-14	2020-02-25
168092323808223	GLUTN	2020-07-16	2020-07-26
121079326716109	BEE	2017-01-24	\N
121079326716109	MOISI	2017-12-28	2019-09-06
121079326716109	POILE	2015-04-20	\N
121079326716109	PENIC	2017-05-16	\N
208095993143744	LAV	2018-06-17	\N
208095993143744	POLN	2021-02-12	2021-09-11
208095993143744	PENIC	2021-07-10	2021-11-04
217109204772961	POLN	2020-11-14	2021-06-09
217109204772961	GUEPE	2020-07-07	2020-07-08
217109204772961	GLUTN	2019-01-07	\N
217109204772961	lATEX	2015-11-10	2016-07-01
250020760833943	LAV	2016-10-01	2019-06-24
297112356304318	POLN	2020-01-08	2021-09-27
297112356304318	lATEX	2019-04-21	2021-07-10
297112356304318	ARA	2016-01-10	2017-02-09
190083588374214	GUEPE	2017-10-12	2020-02-14
190083588374214	BLATE	2015-11-06	2021-03-25
190083588374214	PENIC	2018-06-15	2019-11-02
179094720815996	POLN	2015-01-06	\N
179094720815996	ASPIR	2021-07-06	\N
179094720815996	ARA	2016-10-26	\N
129033616838358	ARA	2020-04-03	\N
129033616838358	GUEPE	2017-09-18	2017-09-22
129033616838358	LAV	2020-06-05	2020-06-10
129033616838358	lATEX	2021-10-26	\N
138120841735658	POLN	2021-11-09	2021-11-14
138120841735658	GUEPE	2017-08-16	2021-07-16
138120841735658	MOISI	2015-02-16	\N
138120841735658	BLATE	2021-04-18	\N
259123094684548	POLN	2021-05-12	\N
259123094684548	GLUTN	2018-06-09	2021-10-04
259123094684548	lATEX	2019-04-25	2020-01-10
259123094684548	PENIC	2019-08-27	2020-09-15
259123094684548	ARA	2018-05-25	2020-03-22
111055160566338	LAV	2015-08-05	\N
113107456390850	GUEPE	2021-01-05	\N
113107456390850	ASPIR	2021-06-21	2021-09-04
113107456390850	BEE	2021-10-02	\N
244032415236016	ASPIR	2015-02-02	\N
244032415236016	GLUTN	2017-03-24	2018-08-20
244032415236016	POILE	2017-03-20	2021-10-19
184023991391628	PENIC	2020-06-15	\N
184023991391628	POLN	2015-09-12	\N
184023991391628	GUEPE	2015-05-20	2015-07-02
184023991391628	ARA	2015-07-01	\N
184023991391628	LAV	2021-03-19	\N
276029793747273	POLN	2021-08-14	2021-09-14
276029793747273	GLUTN	2021-06-25	\N
276029793747273	ARA	2015-12-10	2018-01-15
276029793747273	lATEX	2015-01-15	\N
276029793747273	ASPIR	2018-11-11	2021-05-12
134078170944188	BEE	2018-07-18	\N
134078170944188	ARA	2017-11-17	\N
134078170944188	GUEPE	2021-03-14	\N
246129551535565	MOISI	2016-05-02	\N
246129551535565	PENIC	2020-09-05	\N
246129551535565	GLUTN	2018-08-24	2021-02-22
246129551535565	ARA	2017-09-18	\N
221067404045732	GLUTN	2019-02-01	2020-12-11
221067404045732	POLN	2016-11-10	\N
172094668047237	lATEX	2018-12-11	2019-06-27
134042462939733	GLUTN	2020-03-19	2021-01-21
134042462939733	ARA	2019-07-06	\N
134042462939733	POLN	2021-08-06	\N
180128995054010	GUEPE	2020-04-19	2021-06-04
180128995054010	ASPIR	2019-09-14	2020-11-01
180128995054010	BEE	2021-07-05	2021-08-10
180128995054010	LAV	2015-05-24	\N
180128995054010	PENIC	2018-07-16	\N
210052462712009	POLN	2016-08-08	\N
158060792761175	ARA	2015-02-02	\N
158060792761175	LAV	2017-12-11	\N
158060792761175	BLATE	2021-02-12	\N
158060792761175	MOISI	2019-07-17	2019-08-26
292081637038605	ASPIR	2020-04-24	2021-06-21
292081637038605	MOISI	2020-06-16	2020-08-23
292081637038605	BEE	2020-07-20	2021-05-21
292081637038605	BLATE	2016-10-08	\N
126109239418435	ARA	2021-03-08	2021-07-13
126109239418435	GLUTN	2021-08-13	2021-11-04
126109239418435	lATEX	2015-07-13	2018-11-14
250037185243654	GLUTN	2018-01-19	2020-11-12
250037185243654	BLATE	2016-05-08	2018-05-28
201072681226547	GLUTN	2020-07-11	2020-09-02
239120237800324	GLUTN	2017-07-10	\N
239120237800324	lATEX	2017-09-16	\N
239120237800324	ASPIR	2020-10-21	2021-09-20
239120237800324	POLN	2021-09-08	2021-09-23
239120237800324	GUEPE	2015-11-14	2019-04-28
248126817619060	GLUTN	2017-09-28	\N
248126817619060	BEE	2017-12-11	2020-04-24
261113788102102	LAV	2015-02-24	2018-03-08
261113788102102	BEE	2015-12-02	\N
261113788102102	POILE	2019-03-07	2019-07-09
261113788102102	MOISI	2016-02-16	2017-06-24
261113788102102	PENIC	2020-12-23	\N
182011321936788	POLN	2019-09-26	2020-09-26
182011321936788	POILE	2015-08-16	2017-05-24
270022191753200	ARA	2018-04-23	\N
270022191753200	BEE	2017-12-06	\N
270022191753200	GLUTN	2016-11-01	\N
116066809892335	POLN	2017-05-25	2020-05-27
116066809892335	PENIC	2015-09-16	2018-11-05
116106724777292	BLATE	2017-05-13	2019-03-18
116106724777292	PENIC	2015-02-28	\N
157036866353328	lATEX	2017-11-11	2021-09-13
157036866353328	POLN	2021-01-16	2021-06-22
268040221926572	GUEPE	2016-01-08	\N
268040221926572	POILE	2015-08-16	2017-06-12
259029201046904	LAV	2018-09-19	\N
259029201046904	POILE	2015-04-18	2021-03-28
259029201046904	BEE	2017-12-19	2019-11-09
282038251008033	POILE	2021-10-27	2021-11-13
282038251008033	ARA	2015-01-12	2020-12-13
282038251008033	lATEX	2019-12-25	\N
129031456728988	MOISI	2019-06-15	2019-10-22
129031456728988	lATEX	2015-01-02	\N
129031456728988	ARA	2015-03-18	2020-04-26
129031456728988	BLATE	2019-06-26	\N
129031456728988	POLN	2019-09-01	\N
136023021781523	POLN	2018-12-03	\N
136023021781523	PENIC	2020-02-28	2020-05-07
136023021781523	lATEX	2016-04-03	2016-08-24
136023021781523	LAV	2021-09-06	2021-11-09
136023021781523	MOISI	2021-03-19	2021-04-10
147110274507518	GLUTN	2019-11-07	2021-06-07
147110274507518	BEE	2020-01-08	2020-11-04
147110274507518	POILE	2019-08-01	2021-10-03
147110274507518	LAV	2020-02-02	\N
153072150169408	ASPIR	2021-03-08	\N
153072150169408	MOISI	2017-11-18	2019-08-12
153072150169408	ARA	2019-10-15	2021-11-09
243077956746269	POILE	2017-12-13	\N
243077956746269	ASPIR	2020-05-22	2020-08-07
243077956746269	ARA	2016-03-10	\N
243077956746269	BLATE	2016-03-16	\N
243077956746269	GUEPE	2016-09-14	2017-10-10
291079297260025	GLUTN	2021-03-16	2021-05-20
291079297260025	ASPIR	2016-04-10	\N
262088041353654	GUEPE	2020-11-04	2021-03-25
262088041353654	GLUTN	2020-06-05	\N
262088041353654	BEE	2015-02-28	\N
262088041353654	lATEX	2019-01-02	2020-07-26
262088041353654	LAV	2019-01-08	\N
227042980363902	GUEPE	2020-07-25	\N
227042980363902	MOISI	2018-03-01	2019-07-04
225085330862476	lATEX	2016-06-20	\N
225085330862476	BLATE	2016-11-05	2021-01-15
225085330862476	PENIC	2017-05-16	2019-05-22
217081379554035	PENIC	2019-01-11	2020-01-20
217081379554035	LAV	2015-09-28	\N
298098122213462	LAV	2021-06-17	\N
298098122213462	POILE	2018-12-10	\N
276023787980654	PENIC	2016-07-08	\N
214114566129124	PENIC	2019-10-21	\N
214114566129124	POLN	2015-09-06	\N
214114566129124	POILE	2016-05-10	\N
214114566129124	ASPIR	2021-02-19	\N
214114566129124	LAV	2016-02-12	2016-07-26
220113495911050	POLN	2021-03-25	\N
220113495911050	MOISI	2016-10-18	\N
220113495911050	GUEPE	2016-11-15	2017-10-02
220113495911050	PENIC	2018-03-03	2021-10-03
209118599554171	BEE	2021-02-05	\N
209118599554171	LAV	2017-12-09	2018-08-06
209118599554171	PENIC	2018-03-27	2020-12-06
209118599554171	lATEX	2020-08-20	2021-10-23
209118599554171	ASPIR	2015-12-19	\N
237107264212189	BLATE	2016-08-19	\N
237107264212189	ASPIR	2018-01-13	2018-06-12
251020364469865	BEE	2017-08-12	\N
122125838145935	BEE	2017-06-08	\N
122125838145935	PENIC	2016-07-19	\N
122125838145935	GUEPE	2015-05-04	\N
242048258949364	POILE	2018-08-27	\N
242048258949364	BLATE	2016-09-28	\N
256123186185406	MOISI	2018-06-05	2018-10-11
256123186185406	LAV	2021-05-06	2021-06-21
179045444422744	GLUTN	2016-03-17	2019-06-04
179045444422744	POILE	2015-01-04	2017-01-13
179045444422744	BEE	2019-11-10	2020-06-12
166062449407106	BEE	2021-08-19	\N
166062449407106	GLUTN	2020-05-02	2021-06-05
166062449407106	POLN	2017-10-08	2020-09-03
166062449407106	lATEX	2016-10-06	\N
233087289261865	ASPIR	2018-01-10	\N
233087289261865	PENIC	2019-02-18	2019-02-20
233087289261865	BLATE	2020-11-14	\N
233087289261865	LAV	2017-08-27	2021-09-09
233087289261865	ARA	2017-06-19	2020-04-20
197069985519854	lATEX	2020-09-21	\N
197069985519854	BEE	2015-12-16	\N
197069985519854	PENIC	2021-07-14	\N
197069985519854	ASPIR	2018-09-13	2018-11-09
197069985519854	POLN	2021-10-15	\N
190029314791340	GUEPE	2019-11-04	\N
190029314791340	BLATE	2016-02-27	2018-02-27
190029314791340	POILE	2019-03-27	\N
190029314791340	PENIC	2017-02-03	2019-08-17
227126597924105	lATEX	2021-09-06	\N
227126597924105	BEE	2019-03-26	2019-03-26
227126597924105	PENIC	2019-06-17	2021-10-24
227126597924105	GLUTN	2018-09-22	\N
157121022621522	MOISI	2019-08-15	\N
157121022621522	LAV	2016-11-08	\N
157121022621522	BLATE	2017-10-27	2021-07-16
157121022621522	PENIC	2016-03-25	2018-04-15
143092918371476	lATEX	2021-10-12	2021-11-18
143092918371476	LAV	2019-09-26	2019-11-17
222042520288908	LAV	2021-09-07	\N
222042520288908	lATEX	2020-09-01	2020-11-07
222042520288908	ASPIR	2015-10-26	2016-02-07
202071437767230	POILE	2016-03-16	2019-10-23
202071437767230	MOISI	2016-04-14	2016-11-16
202071437767230	GUEPE	2015-05-26	\N
202071437767230	BEE	2017-12-15	2017-12-15
256063692412136	BEE	2021-02-04	\N
256063692412136	LAV	2015-09-15	2019-04-14
256063692412136	POLN	2020-12-05	\N
131057674892840	LAV	2021-11-16	2021-11-17
131057674892840	GLUTN	2016-11-05	\N
240023495790364	POLN	2015-08-03	\N
255035172533923	BEE	2020-02-08	2021-04-18
255035172533923	GLUTN	2016-11-16	\N
255035172533923	lATEX	2020-09-25	2020-12-02
255035172533923	ARA	2016-11-07	2016-11-13
255035172533923	PENIC	2016-01-19	2019-01-24
272065307866110	lATEX	2016-10-01	2020-03-28
255049439681923	BEE	2017-12-05	\N
255049439681923	GLUTN	2015-12-27	\N
255049439681923	LAV	2016-05-15	\N
121079926115784	PENIC	2016-09-07	\N
121079926115784	POLN	2015-07-03	2020-02-23
179063322934496	MOISI	2017-06-01	\N
179063322934496	BEE	2018-04-13	\N
179063322934496	GUEPE	2017-10-17	2018-07-03
179063322934496	BLATE	2019-11-14	\N
231090596408156	ASPIR	2016-07-05	2018-06-01
231090596408156	GUEPE	2020-09-20	\N
231090596408156	MOISI	2016-12-10	\N
231090596408156	LAV	2016-01-22	\N
286109172934315	POLN	2021-02-19	2021-11-07
286109172934315	lATEX	2020-01-01	2021-05-27
265127996967450	BEE	2018-02-18	2018-09-14
265127996967450	POILE	2020-06-11	\N
265127996967450	ARA	2019-01-19	2020-11-07
190075925899731	ASPIR	2020-01-11	2021-09-10
120119820079715	GLUTN	2015-06-11	\N
271125052129400	ASPIR	2019-02-18	\N
271125052129400	lATEX	2021-10-01	\N
271125052129400	BEE	2019-06-11	2020-10-09
271125052129400	PENIC	2019-11-18	\N
271125052129400	BLATE	2020-09-26	2021-03-14
155035914169601	lATEX	2020-08-01	2020-08-06
155035914169601	POLN	2017-10-09	\N
155035914169601	BEE	2015-04-03	2017-02-20
287120454199264	MOISI	2021-03-07	2021-04-06
287120454199264	POLN	2020-04-26	\N
278090644287533	BEE	2015-07-17	\N
278090644287533	POLN	2015-03-28	\N
278090644287533	lATEX	2019-07-04	2021-04-05
278090644287533	GUEPE	2019-03-08	\N
109083319834772	GLUTN	2019-07-17	2019-12-25
109083319834772	MOISI	2017-06-02	\N
226084549434468	BLATE	2018-03-12	2021-02-12
226084549434468	POILE	2018-03-24	2021-01-08
226084549434468	ASPIR	2015-04-16	\N
292121669134423	MOISI	2018-07-13	\N
292121669134423	BLATE	2019-01-01	\N
292121669134423	BEE	2015-01-24	\N
253024126306890	BEE	2018-06-13	2018-10-26
253024126306890	lATEX	2016-10-10	2016-12-02
253024126306890	ARA	2020-11-06	\N
238029027037430	GUEPE	2016-03-08	2018-02-26
238029027037430	BEE	2017-06-23	\N
238029027037430	lATEX	2016-11-13	\N
238029027037430	PENIC	2019-11-07	2021-11-10
238029027037430	GLUTN	2016-12-08	\N
228082057152542	BEE	2021-01-08	\N
228082057152542	GUEPE	2021-09-11	2021-11-08
125117547327936	LAV	2019-05-20	\N
125117547327936	ASPIR	2015-02-17	\N
125117547327936	lATEX	2018-09-25	\N
125117547327936	POLN	2020-01-27	2021-02-20
125117547327936	BEE	2018-07-15	\N
290035800595956	PENIC	2016-06-19	\N
290035800595956	BLATE	2018-09-28	\N
147068405424686	BEE	2015-03-13	2016-05-07
201122582689823	POLN	2018-02-02	2019-04-28
234042399113177	lATEX	2020-12-25	2021-01-15
234042399113177	LAV	2021-10-11	2021-11-18
166036483219145	LAV	2018-04-22	2019-08-06
166036483219145	ARA	2020-01-26	\N
166036483219145	BEE	2021-03-26	2021-11-01
257074140156085	lATEX	2020-11-13	\N
257074140156085	ARA	2018-09-03	\N
241102233744196	ASPIR	2017-01-13	2020-09-20
241102233744196	BLATE	2018-04-25	2020-04-27
241102233744196	GLUTN	2020-09-07	2020-11-09
235041796027551	ASPIR	2017-12-04	\N
235041796027551	MOISI	2016-06-28	\N
235041796027551	PENIC	2017-05-16	\N
280030696037033	lATEX	2015-03-14	2016-07-21
258052232199718	LAV	2015-04-24	2021-06-22
258052232199718	POILE	2015-07-13	2018-01-13
258052232199718	BLATE	2019-02-07	2020-10-19
258052232199718	MOISI	2015-02-20	2015-04-03
258052232199718	lATEX	2021-08-16	\N
195089048997652	PENIC	2017-10-20	\N
195089048997652	POILE	2020-06-23	2021-06-23
195089048997652	LAV	2017-02-10	2018-02-19
224012297078722	lATEX	2020-04-28	\N
224012297078722	POILE	2019-06-12	\N
133096044501013	GLUTN	2019-01-09	2021-01-28
133096044501013	ASPIR	2021-10-26	\N
105079641276488	BLATE	2021-10-24	2021-11-02
105079641276488	MOISI	2015-07-12	\N
105079641276488	lATEX	2015-09-26	2015-11-12
265037138611063	GUEPE	2021-02-15	2021-02-21
265037138611063	ARA	2019-03-13	\N
269061340475625	POLN	2017-09-04	2019-08-21
269061340475625	BEE	2016-11-14	2020-08-25
289038293978883	POILE	2015-04-08	2020-11-06
289038293978883	BLATE	2017-03-06	2019-10-01
289038293978883	ARA	2016-08-22	\N
268102515480863	POILE	2020-11-07	\N
268102515480863	ASPIR	2020-03-06	\N
268102515480863	BLATE	2018-12-06	\N
262017315373034	GUEPE	2020-08-04	2020-11-12
262017315373034	BLATE	2019-04-07	\N
262017315373034	POLN	2016-05-24	\N
262017315373034	GLUTN	2016-08-27	\N
275115595725603	lATEX	2019-02-19	\N
168117966463592	MOISI	2019-09-24	\N
294015158916742	LAV	2018-05-14	2021-02-05
294015158916742	lATEX	2019-11-04	2021-10-25
229049188967727	BEE	2020-09-28	2020-10-03
229049188967727	ASPIR	2020-10-24	\N
229049188967727	GUEPE	2016-06-03	\N
229049188967727	lATEX	2021-10-05	2021-10-21
229049188967727	GLUTN	2020-06-09	\N
248020336265548	PENIC	2021-09-20	2021-10-22
248020336265548	LAV	2020-08-10	2021-01-04
248020336265548	GUEPE	2016-09-17	2017-05-15
248020336265548	MOISI	2021-09-21	\N
248020336265548	GLUTN	2021-04-24	\N
261061517818802	PENIC	2016-09-04	\N
261061517818802	POLN	2018-07-28	\N
261061517818802	ASPIR	2016-08-13	\N
261061517818802	BLATE	2020-05-19	\N
261061517818802	lATEX	2017-07-04	2021-05-23
218067839543144	lATEX	2019-12-15	2019-12-22
218067839543144	LAV	2020-01-21	\N
218067839543144	GUEPE	2018-10-15	\N
218067839543144	GLUTN	2020-11-02	2021-08-02
137035076043920	BEE	2015-02-26	2018-07-27
137035076043920	POLN	2017-12-05	\N
277029962435780	POILE	2016-08-17	\N
277029962435780	BLATE	2015-12-09	2017-10-06
277029962435780	ASPIR	2020-12-14	2020-12-24
187050790840456	lATEX	2020-02-20	2021-03-24
187050790840456	GUEPE	2017-07-10	2020-06-17
258016165795720	ARA	2018-03-01	\N
258016165795720	MOISI	2020-12-20	2021-10-02
258016165795720	POLN	2019-10-19	\N
258016165795720	GUEPE	2016-04-21	2020-04-26
258016165795720	GLUTN	2016-09-20	\N
238100948951460	ASPIR	2015-06-08	\N
264127794964901	BEE	2019-02-15	2021-11-08
264127794964901	GLUTN	2016-10-23	2021-04-23
264127794964901	POLN	2019-04-20	\N
264127794964901	ASPIR	2018-07-18	2019-01-18
264127794964901	GUEPE	2020-04-25	2020-09-21
217015419621733	PENIC	2018-06-25	\N
217015419621733	lATEX	2019-10-11	2021-08-13
217015419621733	ARA	2016-12-02	\N
217015419621733	BEE	2016-07-21	2017-01-21
217015419621733	BLATE	2017-02-07	\N
147094894800840	MOISI	2016-03-18	\N
147094894800840	ARA	2015-07-27	2015-09-09
147094894800840	BEE	2016-02-05	2020-03-27
203054662307902	lATEX	2018-12-07	2021-11-15
203054662307902	BEE	2017-06-27	2017-08-06
203054662307902	MOISI	2018-03-28	\N
243102394343966	MOISI	2017-12-04	2018-08-12
243102394343966	POLN	2018-03-07	\N
243102394343966	BLATE	2021-11-05	2021-11-06
243102394343966	GUEPE	2016-05-06	2020-10-01
235015710631442	PENIC	2019-02-06	\N
235015710631442	lATEX	2015-02-08	\N
235015710631442	POILE	2020-12-11	\N
235015710631442	MOISI	2019-09-03	2020-03-27
292110340538775	BLATE	2018-07-20	2020-11-12
292110340538775	LAV	2018-03-27	\N
292110340538775	POLN	2015-08-16	2020-10-15
292110340538775	BEE	2015-11-14	\N
172044633042546	POLN	2016-11-04	\N
172044633042546	LAV	2017-10-28	\N
272074630342514	MOISI	2019-08-13	\N
272074630342514	GLUTN	2016-12-21	2020-11-18
272074630342514	BEE	2017-09-12	2017-09-19
272074630342514	ARA	2020-09-23	\N
205106177189757	GUEPE	2020-07-16	\N
205106177189757	BEE	2018-11-15	\N
205106177189757	GLUTN	2015-11-17	\N
205106177189757	POILE	2019-11-14	2019-11-18
205106177189757	BLATE	2020-06-08	2021-09-10
163095683355072	POILE	2018-01-19	\N
163095683355072	GUEPE	2017-08-07	2020-08-26
163095683355072	ARA	2017-08-06	2020-06-10
163095683355072	POLN	2015-06-27	2018-12-06
118066904629610	LAV	2020-04-17	\N
118066904629610	BEE	2017-01-10	\N
118066904629610	BLATE	2017-10-02	2019-12-13
118066904629610	MOISI	2016-08-22	\N
293097683511915	POILE	2019-07-12	\N
293097683511915	MOISI	2016-02-08	2020-10-09
293097683511915	BEE	2017-08-09	2018-03-12
293097683511915	LAV	2019-07-13	2019-08-26
293097683511915	BLATE	2016-05-03	2020-11-18
288019756939738	POILE	2016-08-22	2019-11-15
288019756939738	POLN	2016-11-12	2018-04-17
171125291347716	LAV	2015-07-21	\N
171125291347716	BLATE	2015-02-23	\N
171125291347716	GLUTN	2015-02-22	\N
209086618622243	POILE	2021-10-26	\N
209086618622243	ARA	2020-01-27	\N
209086618622243	MOISI	2016-08-22	\N
209086618622243	BLATE	2018-08-05	\N
209086618622243	ASPIR	2017-06-12	\N
211052198016337	LAV	2018-09-25	\N
211052198016337	POILE	2017-03-10	\N
211052198016337	ARA	2017-02-16	\N
269041356249776	LAV	2017-01-05	2018-12-27
269041356249776	ASPIR	2021-11-06	2021-11-07
269041356249776	POILE	2016-02-11	2017-12-24
239129600838387	ASPIR	2016-01-03	\N
239129600838387	GUEPE	2018-07-09	\N
239129600838387	GLUTN	2021-10-25	\N
239129600838387	ARA	2021-11-17	2021-11-17
239129600838387	lATEX	2017-05-05	\N
144020579570087	MOISI	2015-05-10	2018-02-04
144020579570087	ASPIR	2015-02-08	\N
144020579570087	BEE	2015-12-09	\N
157076554613448	LAV	2021-08-03	2021-10-06
157076554613448	BLATE	2018-09-11	\N
157076554613448	GUEPE	2015-05-13	\N
157076554613448	POLN	2020-11-13	\N
157076554613448	lATEX	2018-05-13	\N
157129459270583	lATEX	2018-09-02	2020-07-05
157129459270583	BEE	2021-05-14	2021-09-28
197028070992122	MOISI	2017-01-14	\N
197028070992122	GUEPE	2020-07-27	2021-07-28
197028070992122	ASPIR	2016-02-25	\N
197028070992122	lATEX	2018-04-06	\N
225106058149347	GUEPE	2015-05-20	2016-05-22
225106058149347	PENIC	2016-08-17	\N
225106058149347	LAV	2019-05-04	\N
225106058149347	BLATE	2018-09-18	\N
225106058149347	POILE	2021-10-25	2021-11-15
153022679819804	PENIC	2017-06-11	2018-01-09
122117120832828	PENIC	2019-04-03	2020-12-03
108105169006820	PENIC	2015-12-10	\N
108105169006820	lATEX	2020-02-09	\N
108105169006820	ARA	2018-08-11	2021-03-08
108105169006820	BLATE	2020-03-19	2021-06-20
108105169006820	ASPIR	2015-07-06	\N
133085507042722	POLN	2015-09-28	\N
133085507042722	BEE	2018-04-11	\N
133085507042722	GLUTN	2019-07-10	2020-07-17
133085507042722	PENIC	2019-02-27	\N
299032100194543	PENIC	2017-05-10	\N
299032100194543	GUEPE	2018-02-27	2018-06-28
299032100194543	LAV	2021-07-07	2021-08-19
299032100194543	MOISI	2018-02-18	2021-11-03
299032100194543	POLN	2017-11-13	\N
285111122122687	POLN	2016-03-17	\N
285111122122687	ASPIR	2019-03-17	2021-05-01
285111122122687	ARA	2015-02-23	2019-05-14
105111064681116	BLATE	2016-05-09	2017-06-02
105111064681116	GUEPE	2017-07-06	\N
105111064681116	POILE	2020-07-13	\N
105111064681116	lATEX	2015-03-20	2018-02-15
105111064681116	ASPIR	2017-11-10	2018-11-14
106069855306956	GUEPE	2019-05-28	\N
106069855306956	BLATE	2018-05-05	\N
235025043023266	POILE	2015-04-23	2018-09-08
235025043023266	POLN	2016-10-11	\N
259031305534854	MOISI	2017-12-16	2017-12-19
259031305534854	ARA	2016-03-17	\N
259031305534854	GUEPE	2015-12-24	2018-12-26
259031305534854	POLN	2020-12-10	2020-12-11
164018247653927	BLATE	2021-07-05	\N
164018247653927	lATEX	2015-02-06	\N
255111462999163	BLATE	2015-12-22	\N
255111462999163	GUEPE	2017-06-10	\N
255111462999163	GLUTN	2021-03-23	2021-08-07
149016464115574	LAV	2020-10-20	2021-03-22
149016464115574	GLUTN	2016-04-08	2021-04-15
216080798565109	POILE	2019-11-14	2020-04-11
216080798565109	POLN	2017-10-15	\N
176038914084519	PENIC	2019-08-19	2020-08-20
274016315753078	ARA	2016-10-07	2017-07-12
274016315753078	BLATE	2019-04-05	2019-11-13
274016315753078	POLN	2017-02-04	\N
274016315753078	BEE	2017-10-19	\N
274016315753078	GUEPE	2015-01-05	2021-11-15
144104148447610	lATEX	2019-07-04	\N
144104148447610	POILE	2017-04-20	2021-05-08
169041874795154	LAV	2016-08-27	2021-03-23
129092551504840	GUEPE	2016-06-24	\N
170104318565314	POLN	2019-08-10	2019-09-17
274114292533681	GUEPE	2017-02-01	2017-04-01
274114292533681	POLN	2016-05-11	2020-09-09
274114292533681	ASPIR	2021-08-18	2021-08-27
274114292533681	POILE	2020-06-11	2020-12-05
237072348150692	LAV	2019-09-03	2020-04-19
237072348150692	lATEX	2020-08-23	2021-04-23
237072348150692	BLATE	2016-11-15	2017-09-11
283124902489728	GLUTN	2018-04-27	2021-05-16
283124902489728	POLN	2021-07-26	\N
283124902489728	lATEX	2021-07-01	2021-10-17
140010920647767	BEE	2016-11-09	\N
236033297541443	ARA	2020-01-01	\N
236033297541443	BLATE	2018-10-28	2018-11-04
117072352261008	POILE	2018-09-13	\N
117072352261008	ARA	2021-01-10	2021-09-16
117072352261008	BLATE	2020-10-21	\N
253108676231602	ARA	2021-01-19	2021-09-04
214048310374407	MOISI	2020-01-15	2020-10-22
214048310374407	PENIC	2017-04-11	2019-07-19
214048310374407	BLATE	2020-12-19	2020-12-20
214048310374407	BEE	2018-02-26	\N
283034579380856	LAV	2020-10-28	2020-12-28
283034579380856	lATEX	2019-04-22	\N
283034579380856	ARA	2015-03-19	\N
283034579380856	BEE	2019-10-01	2019-11-12
283034579380856	GUEPE	2018-06-05	\N
239040683301450	ARA	2019-12-19	2021-05-05
239040683301450	GUEPE	2017-09-12	2018-04-01
239040683301450	POLN	2021-08-03	2021-10-17
220079068523025	POILE	2018-06-17	\N
142112061521891	BLATE	2015-09-13	\N
142112061521891	BEE	2019-12-08	2019-12-13
142112061521891	lATEX	2015-06-20	2020-09-05
142112061521891	MOISI	2020-08-10	2020-09-13
228102829065978	ASPIR	2018-09-13	2021-08-03
108034713413292	ARA	2021-04-26	\N
108034713413292	lATEX	2021-07-09	2021-07-10
108034713413292	MOISI	2019-01-22	2020-08-02
108034713413292	POLN	2017-07-09	2019-12-25
108034713413292	BEE	2018-12-18	2019-01-20
161114713933201	POLN	2018-08-05	\N
271024262039407	ARA	2019-02-09	\N
116071026258730	BEE	2020-06-16	\N
116071026258730	ASPIR	2016-07-16	2020-02-13
116071026258730	lATEX	2019-06-07	2020-03-22
290054393404594	ARA	2017-05-06	\N
290054393404594	MOISI	2018-04-17	2021-07-16
299083781186978	POILE	2016-12-01	2017-01-22
299083781186978	BEE	2016-10-02	\N
197104772238319	POLN	2019-08-07	\N
197104772238319	lATEX	2017-11-02	\N
197104772238319	POILE	2019-03-06	2020-01-06
197104772238319	ASPIR	2016-11-01	2021-02-27
221021276653204	GUEPE	2015-04-25	\N
221021276653204	POILE	2019-06-18	2020-11-07
221021276653204	BEE	2020-01-02	2021-08-15
221021276653204	MOISI	2016-09-11	\N
134026849374442	ARA	2019-12-15	\N
134026849374442	POLN	2017-01-04	2018-03-11
134026849374442	BLATE	2017-12-11	\N
134026849374442	POILE	2017-04-20	\N
133119344929516	LAV	2016-04-26	2021-05-24
166049821238905	POLN	2021-03-12	\N
166049821238905	ARA	2018-10-22	\N
166049821238905	ASPIR	2016-11-15	\N
166049821238905	PENIC	2021-09-21	\N
166049821238905	GLUTN	2021-07-27	2021-07-27
102046285253211	LAV	2018-02-18	2021-01-05
102046285253211	ARA	2018-12-06	\N
137121652381278	MOISI	2020-02-13	2021-01-26
137121652381278	ARA	2019-01-09	\N
137121652381278	LAV	2020-01-25	2021-08-21
137121652381278	GUEPE	2017-09-04	2018-09-21
137121652381278	PENIC	2020-05-12	2021-04-12
155077696371044	BLATE	2018-08-22	\N
155077696371044	lATEX	2020-09-05	\N
155077696371044	GUEPE	2021-06-14	\N
155077696371044	ARA	2018-12-19	\N
155077696371044	PENIC	2016-11-17	2019-10-01
161010244798916	ARA	2020-04-26	\N
161010244798916	GLUTN	2016-10-13	\N
161010244798916	POILE	2020-06-19	2021-05-12
161010244798916	POLN	2017-12-02	2021-06-16
161010244798916	GUEPE	2019-08-02	\N
151110869486625	GLUTN	2016-11-10	\N
151110869486625	BLATE	2021-05-14	2021-08-27
151110869486625	POLN	2018-10-03	2021-01-02
151110869486625	GUEPE	2019-07-12	\N
151110869486625	lATEX	2017-02-03	2021-06-17
277044366026913	GLUTN	2021-07-14	\N
277044366026913	POLN	2017-05-28	\N
144035676655040	GLUTN	2016-08-25	\N
144035676655040	POILE	2020-11-18	\N
144035676655040	ASPIR	2019-04-23	2021-03-10
144035676655040	PENIC	2017-03-20	2019-06-06
144035676655040	lATEX	2016-03-22	2017-11-08
189098056291549	ASPIR	2018-02-09	\N
189098056291549	LAV	2016-05-08	2017-07-08
278089373283395	GLUTN	2017-09-08	\N
278089373283395	GUEPE	2019-06-16	2019-11-15
156074123250805	lATEX	2019-10-25	\N
156074123250805	LAV	2015-05-27	\N
148069830978569	POLN	2019-12-22	\N
148069830978569	MOISI	2019-05-21	2021-06-25
148069830978569	GUEPE	2016-03-12	\N
212060310868943	GLUTN	2018-01-25	2021-05-01
212060310868943	ASPIR	2019-10-23	2019-10-25
212060310868943	GUEPE	2020-08-26	2020-09-11
212060310868943	PENIC	2019-02-24	\N
162058741598167	GUEPE	2019-06-28	\N
162058741598167	BLATE	2015-12-12	2018-03-02
162058741598167	LAV	2016-02-16	\N
162058741598167	lATEX	2016-06-18	\N
169097507276185	ARA	2020-12-28	2020-12-28
169097507276185	LAV	2016-03-22	\N
169097507276185	GLUTN	2020-07-25	\N
169097507276185	POLN	2015-03-06	\N
205095024579593	lATEX	2015-10-14	\N
205095024579593	ASPIR	2015-01-10	2017-12-19
299048039616883	BEE	2015-11-16	\N
299048039616883	ARA	2016-12-18	\N
299048039616883	GUEPE	2017-07-25	2019-04-07
299048039616883	PENIC	2015-01-11	\N
150060303807110	BLATE	2017-06-03	\N
126109435891127	ASPIR	2016-08-27	2018-06-16
126109435891127	BEE	2019-01-16	\N
126109435891127	lATEX	2017-09-27	2018-06-27
275063951087350	BEE	2021-08-17	\N
275063951087350	MOISI	2015-06-17	\N
275063951087350	PENIC	2017-01-08	\N
194015343162633	GUEPE	2021-09-19	2021-10-03
194015343162633	PENIC	2017-04-18	2020-07-23
194015343162633	lATEX	2016-02-24	\N
194015343162633	BEE	2020-08-14	\N
101056300934406	LAV	2018-01-20	2021-04-11
101056300934406	POLN	2021-08-05	\N
101056300934406	lATEX	2015-07-17	2018-09-13
101056300934406	POILE	2021-05-09	\N
240073988379421	BEE	2019-02-06	\N
240073988379421	POLN	2015-05-02	\N
240073988379421	GLUTN	2020-05-02	2021-10-12
240073988379421	MOISI	2019-11-16	2021-02-28
240073988379421	lATEX	2020-07-26	2020-12-08
260111580647383	MOISI	2021-05-10	2021-05-27
260111580647383	GUEPE	2018-11-16	2021-02-24
260111580647383	POILE	2015-05-23	2018-12-02
260111580647383	POLN	2016-10-24	2020-09-10
120056823338977	PENIC	2018-09-18	\N
120056823338977	ASPIR	2015-05-05	2020-07-12
120056823338977	lATEX	2016-02-23	2017-07-04
119109623992764	POLN	2015-06-17	\N
119109623992764	GUEPE	2017-09-10	2020-05-01
119109623992764	PENIC	2015-06-17	2015-10-16
101039612534949	BEE	2016-03-14	2020-08-22
101039612534949	lATEX	2017-08-03	2018-02-02
101039612534949	LAV	2021-02-05	2021-07-03
101039612534949	GUEPE	2019-07-06	2019-12-02
239023073644392	GUEPE	2021-07-09	\N
239023073644392	BEE	2020-06-03	\N
239023073644392	ASPIR	2021-06-27	\N
239023073644392	ARA	2020-03-04	\N
239023073644392	POLN	2020-07-22	2020-09-13
203017476426702	BEE	2021-06-23	2021-06-25
203017476426702	POLN	2018-03-04	\N
203017476426702	MOISI	2015-12-01	2016-06-08
252106418593026	lATEX	2016-12-08	\N
252106418593026	ASPIR	2019-05-01	2021-10-01
252092112764860	POLN	2020-05-19	\N
252092112764860	lATEX	2015-04-07	2017-11-16
189014693292991	GUEPE	2018-08-03	\N
189014693292991	POILE	2020-02-22	2020-09-05
189014693292991	PENIC	2017-04-08	2017-08-20
189014693292991	ARA	2017-06-01	2020-04-24
157070363992818	GLUTN	2020-10-08	2021-03-21
157070363992818	ASPIR	2019-08-23	2020-01-11
157070363992818	POILE	2019-11-06	2021-03-07
253095437283501	MOISI	2015-01-04	\N
229097103116120	BLATE	2020-08-15	\N
203038685064147	PENIC	2020-05-27	\N
244106583543744	POLN	2021-04-02	2021-06-26
244106583543744	GLUTN	2017-03-18	2019-08-06
244106583543744	LAV	2019-02-14	\N
244106583543744	MOISI	2021-02-25	2021-04-23
137011911189687	LAV	2018-12-15	\N
137011911189687	GUEPE	2019-03-24	2019-12-24
127015812688118	ASPIR	2018-05-10	\N
127015812688118	lATEX	2016-02-15	\N
127015812688118	ARA	2015-04-05	2020-02-28
127015812688118	GLUTN	2020-12-24	\N
174126989550917	PENIC	2020-11-17	\N
174126989550917	ARA	2015-11-16	\N
174126989550917	BLATE	2018-10-21	2019-08-03
174126989550917	LAV	2017-03-19	2021-07-06
206067332177665	BLATE	2015-03-22	\N
206067332177665	LAV	2020-08-15	2021-02-13
206067332177665	GLUTN	2018-12-19	\N
206067332177665	POLN	2019-02-15	2021-03-09
265053211557745	POILE	2016-01-18	2020-07-03
262016873894611	POILE	2017-08-27	2017-08-28
262016873894611	GUEPE	2021-05-03	2021-06-18
262016873894611	BEE	2019-01-02	2021-03-19
171066719027259	POLN	2015-06-04	2016-06-13
171066719027259	ARA	2018-10-21	2021-07-27
171066719027259	MOISI	2015-09-08	\N
171066719027259	BLATE	2017-05-25	\N
171066719027259	BEE	2016-10-06	\N
267109108065202	MOISI	2015-08-03	2021-06-20
267109108065202	ASPIR	2020-04-21	\N
267109108065202	POLN	2016-02-26	\N
266019956812570	ASPIR	2016-01-26	2017-01-28
266019956812570	POILE	2016-08-03	2016-11-14
266019956812570	MOISI	2018-02-13	\N
252111777841915	GLUTN	2021-10-20	\N
164038608632119	lATEX	2021-09-02	\N
164038608632119	ASPIR	2020-12-19	\N
164038608632119	POLN	2016-01-02	2020-07-05
131101434250337	LAV	2019-05-14	\N
131101434250337	MOISI	2016-10-04	\N
131101434250337	ARA	2015-10-09	2021-06-24
230124336513645	GLUTN	2015-04-25	\N
230124336513645	lATEX	2018-04-25	\N
230124336513645	ARA	2017-09-27	2018-08-15
212051079375206	GLUTN	2018-08-10	2021-02-14
212051079375206	BLATE	2017-07-05	\N
212051079375206	LAV	2021-08-12	2021-10-07
207036199333762	GLUTN	2020-07-26	\N
207036199333762	GUEPE	2016-11-13	2021-08-24
207036199333762	POILE	2018-05-01	\N
207036199333762	PENIC	2015-11-03	\N
195039969007673	ARA	2021-03-02	2021-08-28
195039969007673	POILE	2017-06-07	\N
221029479428090	PENIC	2021-01-05	\N
221029479428090	GLUTN	2021-06-13	2021-08-24
110066257611314	GUEPE	2016-02-18	2019-05-05
223078053552461	GUEPE	2016-12-14	\N
223078053552461	ASPIR	2021-09-10	\N
223078053552461	POILE	2017-07-04	\N
243017583288790	BLATE	2017-09-25	\N
243017583288790	MOISI	2015-12-01	2015-12-20
202024773805862	POLN	2021-03-18	\N
202024773805862	LAV	2015-07-07	\N
145056354127107	GUEPE	2019-10-09	\N
199010342734983	PENIC	2017-05-28	2019-09-04
199010342734983	POLN	2021-10-17	2021-10-22
199010342734983	POILE	2020-04-25	2021-09-07
199010342734983	ARA	2021-05-10	2021-05-19
204036557077489	LAV	2017-07-15	2017-12-13
204036557077489	PENIC	2016-10-03	2019-12-18
204036557077489	BLATE	2018-05-03	\N
204036557077489	GLUTN	2015-04-11	\N
204036557077489	POLN	2017-10-04	2020-04-12
289040697244116	LAV	2020-08-04	2021-02-10
289040697244116	ARA	2020-10-22	\N
289040697244116	BEE	2020-08-03	\N
138084307765388	ASPIR	2017-11-13	\N
138084307765388	GLUTN	2017-12-21	\N
138084307765388	BEE	2017-08-01	2018-12-21
245106940503490	LAV	2017-06-21	2017-06-23
245106940503490	POILE	2016-10-25	\N
179073352261725	BLATE	2018-07-05	\N
179073352261725	LAV	2019-11-06	2019-12-25
179073352261725	ARA	2018-05-08	\N
298032738731346	GUEPE	2019-05-12	\N
243082614270684	GLUTN	2016-12-24	\N
243082614270684	BEE	2015-05-04	\N
243082614270684	MOISI	2015-01-19	\N
243082614270684	POLN	2015-03-18	\N
243082614270684	BLATE	2015-05-04	\N
255086087623452	BEE	2019-11-07	\N
255086087623452	lATEX	2019-06-19	2020-07-07
144015615260843	GUEPE	2016-04-23	\N
144015615260843	LAV	2019-04-17	2019-11-07
144015615260843	POILE	2020-04-05	2020-10-16
144015615260843	GLUTN	2018-12-16	2021-01-18
144015615260843	BEE	2017-08-04	\N
212101169913710	POILE	2018-06-13	2020-12-21
212101169913710	lATEX	2015-12-28	2019-02-26
212101169913710	GUEPE	2020-06-19	2021-04-02
180088976677729	GLUTN	2019-11-04	\N
180088976677729	BLATE	2015-09-05	2018-06-08
109015975211104	ARA	2017-01-05	2017-02-06
110114341425639	ASPIR	2015-10-12	\N
110114341425639	GUEPE	2016-11-12	\N
110114341425639	GLUTN	2019-04-16	\N
110114341425639	ARA	2021-02-28	\N
110114341425639	PENIC	2017-08-22	\N
206033830025756	lATEX	2015-11-04	\N
258112655293107	BEE	2021-10-20	\N
157054327406685	LAV	2018-07-21	2019-02-09
258086115253449	LAV	2017-12-05	\N
258086115253449	ARA	2017-06-08	\N
258086115253449	BLATE	2015-09-10	\N
122128399094364	PENIC	2019-09-04	2019-10-16
122128399094364	POILE	2017-11-02	\N
122128399094364	POLN	2021-04-10	2021-08-13
148069955003476	PENIC	2016-03-24	\N
148069955003476	GLUTN	2021-08-25	\N
180020359139629	lATEX	2015-05-14	\N
180020359139629	GLUTN	2015-02-06	2019-01-28
180020359139629	ASPIR	2016-11-15	\N
180020359139629	POILE	2015-02-01	2019-01-14
180020359139629	BLATE	2016-11-18	2021-03-17
156060915698166	PENIC	2016-05-10	2020-02-06
156060915698166	MOISI	2020-06-21	\N
156060915698166	GLUTN	2020-11-15	2021-06-03
177103352992307	GLUTN	2021-05-23	\N
177103352992307	BEE	2020-12-17	2021-09-15
177103352992307	ARA	2021-05-11	\N
255099147198042	BEE	2019-02-23	\N
255099147198042	LAV	2017-08-28	\N
173088238558496	LAV	2019-11-15	2020-03-22
173088238558496	GUEPE	2017-05-20	\N
156119474815307	POLN	2018-01-20	\N
156119474815307	LAV	2015-10-24	2017-01-18
156119474815307	ASPIR	2016-02-04	\N
156119474815307	BLATE	2015-06-18	2019-04-15
156119474815307	GLUTN	2015-09-12	2015-10-22
166081296763649	ARA	2021-06-05	2021-09-19
138074248401105	GLUTN	2018-08-11	2018-08-18
138074248401105	BLATE	2017-07-24	\N
138074248401105	lATEX	2020-06-08	\N
140119959250877	MOISI	2020-07-23	\N
172051108200956	MOISI	2015-03-26	2020-10-25
172051108200956	LAV	2016-03-07	\N
172051108200956	GLUTN	2016-03-15	2016-08-17
134053265437083	BLATE	2018-12-03	\N
134053265437083	ARA	2021-02-19	\N
134053265437083	LAV	2020-11-12	\N
134053265437083	POILE	2017-02-21	2017-03-17
198111260505320	LAV	2015-11-04	\N
198111260505320	GLUTN	2016-07-17	2017-01-18
198111260505320	POLN	2019-06-22	2019-12-24
198111260505320	MOISI	2017-08-24	\N
256074987484479	POILE	2015-11-06	\N
256074987484479	GUEPE	2016-12-19	2016-12-21
256074987484479	LAV	2016-01-03	\N
256074987484479	GLUTN	2015-10-10	2015-10-22
199127252136345	ARA	2019-02-15	\N
199127252136345	lATEX	2016-04-14	2021-07-06
199127252136345	POLN	2019-03-21	\N
262038778938203	MOISI	2016-03-23	\N
262038778938203	ARA	2020-02-12	2021-06-05
262038778938203	BLATE	2015-11-14	2017-11-18
262038778938203	PENIC	2016-09-14	2020-09-16
262038778938203	lATEX	2015-09-28	\N
233109092062205	POLN	2016-11-02	\N
233109092062205	LAV	2019-12-25	2019-12-26
233109092062205	BEE	2020-04-09	\N
180057367414637	BLATE	2020-12-15	\N
117121559056457	LAV	2018-04-02	\N
117121559056457	POILE	2016-07-13	\N
117121559056457	BLATE	2018-05-01	2019-11-14
117121559056457	BEE	2017-05-16	2018-04-23
240022636962670	lATEX	2019-06-10	2021-02-24
240022636962670	ARA	2017-05-20	2020-10-10
240022636962670	POLN	2018-04-15	2020-11-07
240022636962670	PENIC	2017-08-22	\N
277122777128078	MOISI	2016-12-12	2020-05-07
160025901759025	MOISI	2019-12-07	2020-11-05
127081156734983	GUEPE	2017-05-10	\N
127081156734983	MOISI	2016-11-13	2017-07-07
127081156734983	lATEX	2020-09-15	2021-03-19
127081156734983	BEE	2018-04-04	\N
127081156734983	PENIC	2020-12-08	2020-12-28
288119690626128	GUEPE	2016-12-06	\N
288119690626128	ASPIR	2019-06-11	\N
288119690626128	LAV	2017-09-21	2020-04-09
286058534258713	GUEPE	2015-08-03	2019-01-24
286058534258713	PENIC	2019-12-14	2019-12-20
149061136795769	GLUTN	2020-10-15	\N
149061136795769	ASPIR	2020-08-16	\N
149061136795769	POLN	2015-04-15	2015-08-01
149061136795769	BLATE	2017-08-09	2021-03-16
245070516446550	GLUTN	2021-05-27	\N
245070516446550	POLN	2018-04-06	2021-07-18
245070516446550	BEE	2021-01-07	\N
245070516446550	POILE	2021-10-20	2021-10-20
230026753623669	PENIC	2015-08-04	2016-07-12
230026753623669	ASPIR	2019-02-23	\N
102035825373803	BEE	2019-06-19	\N
102035825373803	ASPIR	2017-08-28	\N
102035825373803	POLN	2018-11-18	\N
180028509811169	POILE	2020-02-02	\N
180028509811169	ARA	2017-02-20	2020-06-10
180028509811169	GLUTN	2020-02-25	\N
180028509811169	BEE	2020-01-04	\N
216074033954453	lATEX	2019-01-25	\N
216074033954453	BLATE	2015-12-11	\N
216074033954453	ASPIR	2021-09-05	2021-10-17
216074033954453	GLUTN	2015-12-13	\N
293094751937192	GLUTN	2021-02-11	\N
147061886221913	ARA	2020-05-18	\N
147061886221913	POILE	2019-09-26	\N
223028798999363	BLATE	2019-12-05	\N
223028798999363	ASPIR	2016-10-25	\N
232052892461325	POILE	2021-07-01	2021-09-22
101120424360755	PENIC	2018-03-17	2019-08-12
101120424360755	BEE	2018-01-13	2021-09-11
101120424360755	ARA	2019-09-28	\N
101120424360755	MOISI	2019-11-06	\N
221067551980230	ARA	2019-12-20	2021-08-11
221067551980230	BLATE	2020-10-07	\N
221067551980230	POLN	2016-12-17	2018-03-25
221067551980230	LAV	2018-08-22	2020-09-18
240114616700691	ASPIR	2015-12-17	\N
240114616700691	LAV	2015-06-14	\N
193077753289249	lATEX	2015-12-24	2019-07-28
193077753289249	PENIC	2015-02-25	2017-06-02
265116744621785	PENIC	2019-02-24	2019-08-20
242043149777286	PENIC	2021-01-22	2021-09-21
242043149777286	GLUTN	2019-05-13	\N
242043149777286	POILE	2015-01-10	2017-06-01
242043149777286	POLN	2019-05-21	2021-04-28
133057095110202	BEE	2020-06-20	\N
133057095110202	MOISI	2017-06-27	2017-11-02
133057095110202	lATEX	2021-01-27	\N
296025362844675	GLUTN	2017-02-16	\N
119118453408165	BEE	2018-09-27	2020-12-28
119118453408165	LAV	2017-06-13	2020-03-12
119118453408165	POLN	2017-07-25	2021-07-28
119118453408165	lATEX	2020-11-04	2021-07-02
235051633057734	PENIC	2021-03-07	\N
235051633057734	lATEX	2015-07-21	\N
235051633057734	MOISI	2019-05-15	\N
235051633057734	GUEPE	2021-07-09	2021-11-12
235051633057734	BLATE	2021-10-01	2021-11-17
278090615498741	GUEPE	2019-07-09	2019-07-11
167087766989559	PENIC	2021-04-06	2021-09-16
167087766989559	POLN	2020-02-05	2020-09-05
167087766989559	lATEX	2015-12-11	\N
291031559371140	lATEX	2019-07-27	2019-07-28
291031559371140	ASPIR	2018-07-13	\N
291031559371140	MOISI	2017-06-08	\N
247087976437659	POLN	2021-03-20	2021-07-16
247087976437659	BLATE	2018-02-21	2020-01-09
247087976437659	ARA	2021-05-24	2021-11-04
247087976437659	lATEX	2018-09-22	2020-11-01
247087976437659	ASPIR	2019-04-09	2021-05-15
194060824711882	POILE	2019-05-25	2020-10-01
292032841511432	ARA	2021-03-10	\N
292032841511432	BEE	2015-08-21	2018-07-21
292032841511432	GUEPE	2017-09-01	2018-12-20
185098166371591	ARA	2016-04-19	\N
185098166371591	ASPIR	2020-02-09	\N
185098166371591	lATEX	2018-07-19	\N
185098166371591	BLATE	2018-08-20	2018-10-03
185098166371591	POLN	2015-05-22	2021-05-23
221067001545141	ASPIR	2019-06-20	2020-05-02
221067001545141	GLUTN	2020-10-12	2020-12-14
221067001545141	POLN	2019-09-10	\N
200125523886081	PENIC	2020-09-04	\N
260094752288347	BLATE	2020-04-19	\N
260094752288347	GUEPE	2017-10-22	2018-01-28
281036969136109	LAV	2016-01-23	2017-02-27
281036969136109	GUEPE	2018-10-27	\N
281036969136109	POILE	2019-10-03	\N
281036969136109	BEE	2018-08-07	2018-12-09
281036969136109	POLN	2018-05-07	2018-10-07
272070106053457	LAV	2019-05-21	\N
272070106053457	POILE	2017-01-24	\N
272070106053457	MOISI	2021-05-12	\N
272070106053457	GUEPE	2019-12-20	2020-11-06
272070106053457	POLN	2015-09-11	\N
199063889574962	lATEX	2019-01-11	2021-01-17
145021483919530	POILE	2020-08-18	2021-04-11
145021483919530	POLN	2017-08-24	2019-09-10
145021483919530	GUEPE	2016-07-16	\N
175025581397787	ASPIR	2016-04-24	\N
195015259294765	lATEX	2019-11-14	\N
195015259294765	LAV	2015-07-08	2017-11-15
195015259294765	POILE	2018-07-17	2021-06-13
195015259294765	POLN	2017-06-20	\N
195015259294765	ASPIR	2021-07-12	\N
157014415900863	GLUTN	2017-08-27	2017-10-27
157014415900863	BLATE	2019-09-08	\N
189058437714714	BLATE	2015-06-28	2018-07-21
189058437714714	lATEX	2016-01-05	2020-03-01
189058437714714	ASPIR	2021-06-07	2021-11-10
189058437714714	MOISI	2015-03-27	2019-12-22
189058437714714	ARA	2021-04-19	\N
287110819788543	LAV	2018-07-04	2018-08-13
287110819788543	GLUTN	2017-09-05	\N
230112913478191	POILE	2019-09-26	\N
230112913478191	MOISI	2016-03-02	\N
230112913478191	lATEX	2019-06-11	\N
230112913478191	BEE	2015-12-17	\N
194108897647962	PENIC	2017-08-21	\N
194108897647962	LAV	2019-10-24	\N
194108897647962	BLATE	2015-11-01	2015-11-18
194108897647962	ASPIR	2017-06-02	\N
278033263543368	GUEPE	2018-06-08	2021-07-26
278033263543368	ARA	2017-07-20	2020-06-12
278033263543368	BLATE	2016-09-19	2021-09-24
278033263543368	GLUTN	2015-01-13	2020-12-21
278033263543368	LAV	2019-10-25	2021-10-25
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.services (ids, nom, loc) FROM stdin;
1	Urgence	A1
2	Pediatrie	A2
3	Neurologie	A3
4	Traumatologie	B1
5	Cardiologie	B2
6	Radiologie	A1
\.


--
-- Data for Name: travaille; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.travaille (medecin, services, fonction, anciennete) FROM stdin;
1	1	Chef de service	2017-05-11
2	1	interne	2020-11-24
3	2	Chef de service	2015-02-27
4	2	Chef de nuit	2018-01-02
5	3	Neurologue	2021-02-06
6	4	Chef de service	2017-05-12
7	4	Anestesiste	2018-09-18
8	5	Chef de service	2019-06-19
9	5	medecin	2019-06-19
10	3	Chef de service	2019-06-19
11	6	Chef de service	2019-06-19
12	6	Operateur radio	2019-06-19
\.


--
-- Name: actemed_ida_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actemed_ida_seq', 4110, true);


--
-- Name: medecinh_idm_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medecinh_idm_seq', 12, true);


--
-- Name: services_ids_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.services_ids_seq', 6, true);


--
-- Name: actemed actemed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actemed
    ADD CONSTRAINT actemed_pkey PRIMARY KEY (ida);


--
-- Name: allergies allergies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allergies
    ADD CONSTRAINT allergies_pkey PRIMARY KEY (code);


--
-- Name: dateentre dateentre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dateentre
    ADD CONSTRAINT dateentre_pkey PRIMARY KEY (datee);


--
-- Name: fichier fichier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fichier
    ADD CONSTRAINT fichier_pkey PRIMARY KEY (nom);


--
-- Name: medecinh medecinh_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medecinh
    ADD CONSTRAINT medecinh_pkey PRIMARY KEY (idm);


--
-- Name: medecint medecint_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medecint
    ADD CONSTRAINT medecint_pkey PRIMARY KEY (npro);


--
-- Name: passepar passepar_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passepar
    ADD CONSTRAINT passepar_pkey PRIMARY KEY (patient, services, datee);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (numsecu);


--
-- Name: possede possede_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_pkey PRIMARY KEY (patient, allergie);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (ids);


--
-- Name: travaille travaille_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.travaille
    ADD CONSTRAINT travaille_pkey PRIMARY KEY (medecin, services);


--
-- Name: actemed actemed_medecin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actemed
    ADD CONSTRAINT actemed_medecin_fkey FOREIGN KEY (medecin) REFERENCES public.medecinh(idm) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: actemed actemed_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actemed
    ADD CONSTRAINT actemed_patient_fkey FOREIGN KEY (patient) REFERENCES public.patients(numsecu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fichier fichier_actemed_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fichier
    ADD CONSTRAINT fichier_actemed_fkey FOREIGN KEY (actemed) REFERENCES public.actemed(ida) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: passepar passepar_datee_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passepar
    ADD CONSTRAINT passepar_datee_fkey FOREIGN KEY (datee) REFERENCES public.dateentre(datee) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: passepar passepar_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passepar
    ADD CONSTRAINT passepar_patient_fkey FOREIGN KEY (patient) REFERENCES public.patients(numsecu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: passepar passepar_services_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.passepar
    ADD CONSTRAINT passepar_services_fkey FOREIGN KEY (services) REFERENCES public.services(ids) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: patients patients_medecint_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_medecint_fkey FOREIGN KEY (medecint) REFERENCES public.medecint(npro) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: possede possede_allergie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_allergie_fkey FOREIGN KEY (allergie) REFERENCES public.allergies(code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: possede possede_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.possede
    ADD CONSTRAINT possede_patient_fkey FOREIGN KEY (patient) REFERENCES public.patients(numsecu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: travaille travaille_medecin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.travaille
    ADD CONSTRAINT travaille_medecin_fkey FOREIGN KEY (medecin) REFERENCES public.medecinh(idm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: travaille travaille_services_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.travaille
    ADD CONSTRAINT travaille_services_fkey FOREIGN KEY (services) REFERENCES public.services(ids) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

