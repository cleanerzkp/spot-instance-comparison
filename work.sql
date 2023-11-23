--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0 (Homebrew)

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
-- Name: CloudProviders; Type: TABLE; Schema: public; Owner: kacper
--

CREATE TABLE public."CloudProviders" (
    "providerID" character varying(3) NOT NULL,
    name character varying(255),
    "API_endpoint" character varying(255),
    data_frequency character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."CloudProviders" OWNER TO kacper;

--
-- Name: CloudProviders_providerID_seq; Type: SEQUENCE; Schema: public; Owner: kacper
--

CREATE SEQUENCE public."CloudProviders_providerID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CloudProviders_providerID_seq" OWNER TO kacper;

--
-- Name: CloudProviders_providerID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kacper
--

ALTER SEQUENCE public."CloudProviders_providerID_seq" OWNED BY public."CloudProviders"."providerID";


--
-- Name: InstanceTypes; Type: TABLE; Schema: public; Owner: kacper
--

CREATE TABLE public."InstanceTypes" (
    "instanceID" integer NOT NULL,
    "providerID" character varying(3),
    name character varying(255),
    "vCPU" integer,
    "RAM_GB" integer,
    category character varying(20),
    "comparisonGroup" character varying(255),
    "grouping" character varying(255)
);


ALTER TABLE public."InstanceTypes" OWNER TO kacper;

--
-- Name: InstanceTypes_instanceID_seq; Type: SEQUENCE; Schema: public; Owner: kacper
--

CREATE SEQUENCE public."InstanceTypes_instanceID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."InstanceTypes_instanceID_seq" OWNER TO kacper;

--
-- Name: InstanceTypes_instanceID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kacper
--

ALTER SEQUENCE public."InstanceTypes_instanceID_seq" OWNED BY public."InstanceTypes"."instanceID";


--
-- Name: Regions; Type: TABLE; Schema: public; Owner: kacper
--

CREATE TABLE public."Regions" (
    "regionID" integer NOT NULL,
    name character varying(255),
    "standardizedRegion" character varying(255),
    "providerID" character varying(3),
    "regionCategory" text,
    "SKU" character varying(255)
);


ALTER TABLE public."Regions" OWNER TO kacper;

--
-- Name: Regions_regionID_seq; Type: SEQUENCE; Schema: public; Owner: kacper
--

CREATE SEQUENCE public."Regions_regionID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Regions_regionID_seq" OWNER TO kacper;

--
-- Name: Regions_regionID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kacper
--

ALTER SEQUENCE public."Regions_regionID_seq" OWNED BY public."Regions"."regionID";


--
-- Name: SpotPricings; Type: TABLE; Schema: public; Owner: kacper
--

CREATE TABLE public."SpotPricings" (
    "pricingID" integer NOT NULL,
    name text,
    "regionCategory" text,
    date timestamp with time zone,
    price numeric(10,4),
    "timestamp" timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "grouping" text,
    "providerID" character varying(3)
);


ALTER TABLE public."SpotPricings" OWNER TO kacper;

--
-- Name: SpotPricings_pricingID_seq; Type: SEQUENCE; Schema: public; Owner: kacper
--

CREATE SEQUENCE public."SpotPricings_pricingID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."SpotPricings_pricingID_seq" OWNER TO kacper;

--
-- Name: SpotPricings_pricingID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kacper
--

ALTER SEQUENCE public."SpotPricings_pricingID_seq" OWNED BY public."SpotPricings"."pricingID";


--
-- Name: CloudProviders providerID; Type: DEFAULT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."CloudProviders" ALTER COLUMN "providerID" SET DEFAULT nextval('public."CloudProviders_providerID_seq"'::regclass);


--
-- Name: InstanceTypes instanceID; Type: DEFAULT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."InstanceTypes" ALTER COLUMN "instanceID" SET DEFAULT nextval('public."InstanceTypes_instanceID_seq"'::regclass);


--
-- Name: Regions regionID; Type: DEFAULT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."Regions" ALTER COLUMN "regionID" SET DEFAULT nextval('public."Regions_regionID_seq"'::regclass);


--
-- Name: SpotPricings pricingID; Type: DEFAULT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."SpotPricings" ALTER COLUMN "pricingID" SET DEFAULT nextval('public."SpotPricings_pricingID_seq"'::regclass);


--
-- Data for Name: CloudProviders; Type: TABLE DATA; Schema: public; Owner: kacper
--

INSERT INTO public."CloudProviders" ("providerID", name, "API_endpoint", data_frequency, "createdAt", "updatedAt") VALUES;
ALB	Alibaba	https://ecs.aliyuncs.com	1hour	2023-10-22 12:51:33.996807+02	2023-10-22 12:51:33.996807+02
AWS	AWS	https://ec2.amazonaws.com	24hrs	2023-10-22 12:51:33.996807+02	2023-10-22 12:51:33.996807+02
AZR	Azure	https://management.azure.com	few hours	2023-10-22 12:51:33.996807+02	2023-10-22 12:51:33.996807+02
GCP	Google Cloud Platform	https://compute.googleapis.com	few hours	2023-10-22 12:51:33.996807+02	2023-10-22 12:51:33.996807+02
\.


--
-- Data for Name: InstanceTypes; Type: TABLE DATA; Schema: public; Owner: kacper
--

INSERT INTO public."InstanceTypes" ("instanceID", "providerID", name, "vCPU", "RAM_GB", category, "comparisonGroup", "grouping") VALUES;
3	AWS	t4g.xlarge	4	16	general-purpose	AWS-t4g.xlarge-general-purpose-GP1	GP1
7	GCP	e2-standard-4	4	16	general-purpose	GCP-e2-standard-4-general-purpose-GP1	GP1
4	AWS	c6a.xlarge	4	8	compute-optimized	AWS-c6a.xlarge-compute-optimized-CO1	CO1
8	GCP	c2-standard-4	4	16	compute-optimized	GCP-c2-standard-4-compute-optimized-CO1	CO1
1	ALB	ecs.g5.xlarge	4	16	general-purpose	ALB-ecs.g6a.xlarge-general-purpose-GP1	GP1
5	AZR	B4ms	4	16	general-purpose	AZR-B4ms-general-purpose-GP1	GP1
6	AZR	D4s_v3	4	8	compute-optimized	AZR-F4s v2-compute-optimized-CO1	CO1
2	ALB	ecs.c6.xlarge	4	8	compute-optimized	ALB-ecs.c6a.xlarge-compute-optimized-CO1	CO1
\.


--
-- Data for Name: Regions; Type: TABLE DATA; Schema: public; Owner: kacper
--

INSERT INTO public."Regions" ("regionID", name, "standardizedRegion", "providerID", "regionCategory", "SKU") VALUES;
1	us-east-1	us-east	ALB	ALB-us-east	\N
6	us-west-1	us-west	AWS	AWS-us-west	\N
9	eu-central-1	europe-central	ALB	ALB-europe-central	\N
16	middleeast-north1	near-east	GCP	GCP-near-east	\N
11	polandcentral	europe-central	AZR	AZR-europe-central	\N
7	westus	us-west	AZR	AZR-us-west	\N
15	israelcentral	near-east	AZR	AZR-near-east	\N
3	eastus	us-east	AZR	AZR-us-east	\N
12	europe-central1	europe-central	GCP	GCP-europe-central	\N
17	ap-south-1	asia-india	ALB	ALB-asia	\N
18	ap-south-1	asia-india	AWS	AWS-asia	\N
19	southindia	asia-india	AZR	AZR-asia	\N
20	asia-south1	asia-india	GCP	GCP-asia	\N
4	northamerica-northeast1	us-east	GCP	GCP-us-east	\N
13	me-central-1	near-east	ALB	ALB-near-east	\N
14	me-south-1	near-east	AWS	AWS-near-east	\N
8	us-west1	us-west	GCP	GCP-us-west	\N
5	us-west-1	us-west	ALB	ALB-us-west	\N
2	us-east-1	us-east	AWS	AWS-us-east	\N
10	eu-central-1	europe-central	AWS	AWS-europe-central	\N
\.


--
-- Data for Name: SpotPricings; Type: TABLE DATA; Schema: public; Owner: kacper
--

COPY public."SpotPricings" ("pricingID", name, "regionCategory", date, price, "timestamp", "createdAt", "updatedAt", "grouping", "providerID") VALUES;
3679	D4s_v3-compute-optimized	AZR-eastus	2023-11-15 22:00:00+01	0.1231	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:19.896+01	CO1	AZR
3680	D4s_v3-compute-optimized	AZR-southindia	2023-11-15 22:00:00+01	0.1571	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:19.896+01	CO1	AZR
3681	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-16 01:00:00+01	0.0250	2023-11-17 21:25:25.129+01	2023-11-16 18:59:02.445+01	2023-11-17 21:25:25.131+01	GP1	ALB
3682	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-16 01:00:00+01	0.0380	2023-11-17 21:25:27.04+01	2023-11-16 18:59:04.528+01	2023-11-17 21:25:27.044+01	GP1	ALB
3683	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-16 01:00:00+01	0.0390	2023-11-17 21:25:29.155+01	2023-11-16 18:59:07.167+01	2023-11-17 21:25:29.157+01	GP1	ALB
3684	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-16 01:00:00+01	0.0370	2023-11-17 21:25:35.068+01	2023-11-16 18:59:12.766+01	2023-11-17 21:25:35.07+01	GP1	ALB
3685	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-16 01:00:00+01	0.0250	2023-11-17 21:25:35.618+01	2023-11-16 18:59:13.378+01	2023-11-17 21:25:35.62+01	CO1	ALB
3686	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-16 01:00:00+01	0.0350	2023-11-17 21:25:35.919+01	2023-11-16 18:59:13.803+01	2023-11-17 21:25:35.921+01	CO1	ALB
3687	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-16 01:00:00+01	0.0325	2023-11-17 21:25:37.679+01	2023-11-16 18:59:14.909+01	2023-11-17 21:25:37.682+01	CO1	ALB
3688	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-16 01:00:00+01	0.0420	2023-11-17 21:25:38.895+01	2023-11-16 18:59:15.761+01	2023-11-17 21:25:38.896+01	CO1	ALB
3689	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-16 01:00:00+01	0.0250	2023-11-17 21:25:40.675+01	2023-11-16 18:59:17.308+01	2023-11-17 21:25:40.677+01	CO1	ALB
3512	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-11 00:00:00+01	0.1585	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.813+01	CO1	AZR
3517	D4s_v3-compute-optimized	AZR-southindia	2023-11-11 00:00:00+01	0.1571	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.835+01	CO1	AZR
2170	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-23 02:00:00+02	0.0460	2023-11-03 10:42:18.263+01	2023-11-03 10:42:18.264+01	2023-11-03 10:42:18.264+01	CO1	ALB
2171	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-24 02:00:00+02	0.0460	2023-11-03 10:42:18.265+01	2023-11-03 10:42:18.265+01	2023-11-03 10:42:18.265+01	CO1	ALB
2172	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-25 02:00:00+02	0.0460	2023-11-03 10:42:18.266+01	2023-11-03 10:42:18.266+01	2023-11-03 10:42:18.266+01	CO1	ALB
2173	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-26 02:00:00+02	0.0460	2023-11-03 10:42:18.268+01	2023-11-03 10:42:18.268+01	2023-11-03 10:42:18.268+01	CO1	ALB
2175	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-28 02:00:00+02	0.0460	2023-11-03 10:42:18.382+01	2023-11-03 10:42:18.382+01	2023-11-03 10:42:18.382+01	CO1	ALB
2176	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-29 02:00:00+02	0.0460	2023-11-03 10:42:18.384+01	2023-11-03 10:42:18.385+01	2023-11-03 10:42:18.385+01	CO1	ALB
3511	B4ms-general-purpose	AZR-israelcentral	2023-11-11 00:00:00+01	0.2423	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.833+01	GP1	AZR
3516	B4ms-general-purpose	AZR-eastus	2023-11-11 00:00:00+01	0.1965	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.953+01	GP1	AZR
3690	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-15 22:00:00+01	0.0649	2023-11-17 21:25:43.492+01	2023-11-16 18:59:21.793+01	2023-11-17 21:25:43.497+01	GP1	AWS
3695	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-15 22:00:00+01	0.0707	2023-11-17 21:25:43.974+01	2023-11-16 18:59:21.937+01	2023-11-17 21:25:43.98+01	GP1	AWS
3694	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-15 22:00:00+01	0.0329	2023-11-17 21:25:44.182+01	2023-11-16 18:59:21.921+01	2023-11-17 21:25:44.188+01	GP1	AWS
3693	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-15 22:00:00+01	0.0549	2023-11-17 21:25:44.258+01	2023-11-16 18:59:21.914+01	2023-11-17 21:25:44.264+01	CO1	AWS
3696	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-15 22:00:00+01	0.0553	2023-11-17 21:25:44.259+01	2023-11-16 18:59:21.969+01	2023-11-17 21:25:44.264+01	GP1	AWS
3515	B4ms-general-purpose	AZR-westus	2023-11-11 00:00:00+01	0.2405	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.864+01	GP1	AZR
3518	D4s_v3-compute-optimized	AZR-eastus	2023-11-11 00:00:00+01	0.1231	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.868+01	CO1	AZR
3513	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-11 00:00:00+01	0.1530	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.874+01	CO1	AZR
3698	e2-standard-4-general-purpose	GCP-us-west2	2023-11-15 22:00:00+01	0.2620	2023-11-16 18:59:30.014+01	2023-11-16 18:59:30.014+01	2023-11-16 18:59:30.014+01	GP1	GCP
3699	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-15 22:00:00+01	0.3554	2023-11-16 18:59:30.017+01	2023-11-16 18:59:30.017+01	2023-11-16 18:59:30.017+01	CO1	GCP
3700	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-15 22:00:00+01	0.1951	2023-11-16 18:59:30.019+01	2023-11-16 18:59:30.019+01	2023-11-16 18:59:30.019+01	CO1	GCP
3701	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-15 22:00:00+01	0.2399	2023-11-16 18:59:30.021+01	2023-11-16 18:59:30.021+01	2023-11-16 18:59:30.021+01	GP1	GCP
3702	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-15 22:00:00+01	0.2810	2023-11-16 18:59:30.023+01	2023-11-16 18:59:30.023+01	2023-11-16 18:59:30.023+01	GP1	GCP
3703	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-15 22:00:00+01	0.3809	2023-11-16 18:59:30.025+01	2023-11-16 18:59:30.025+01	2023-11-16 18:59:30.025+01	CO1	GCP
3704	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-15 22:00:00+01	0.3330	2023-11-16 18:59:30.026+01	2023-11-16 18:59:30.026+01	2023-11-16 18:59:30.026+01	CO1	GCP
3705	e2-standard-4-general-purpose	GCP-us-east4	2023-11-15 22:00:00+01	0.2457	2023-11-16 18:59:30.028+01	2023-11-16 18:59:30.028+01	2023-11-16 18:59:30.028+01	GP1	GCP
3706	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-15 22:00:00+01	0.3252	2023-11-16 18:59:30.03+01	2023-11-16 18:59:30.03+01	2023-11-16 18:59:30.03+01	CO1	GCP
3707	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-15 22:00:00+01	0.2620	2023-11-16 18:59:30.031+01	2023-11-16 18:59:30.031+01	2023-11-16 18:59:30.031+01	GP1	GCP
3691	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-15 22:00:00+01	0.0704	2023-11-17 21:25:43.49+01	2023-11-16 18:59:21.805+01	2023-11-17 21:25:43.495+01	CO1	AWS
3692	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-15 22:00:00+01	0.0804	2023-11-17 21:25:43.982+01	2023-11-16 18:59:21.906+01	2023-11-17 21:25:43.988+01	CO1	AWS
3697	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-15 22:00:00+01	0.0753	2023-11-17 21:25:44.257+01	2023-11-16 18:59:21.972+01	2023-11-17 21:25:44.263+01	CO1	AWS
2250	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-01 01:00:00+01	0.0350	2023-11-03 11:36:42.018+01	2023-11-03 11:36:42.018+01	2023-11-03 11:36:42.018+01	CO1	ALB
3514	B4ms-general-purpose	AZR-polandcentral	2023-11-11 00:00:00+01	0.2498	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.875+01	GP1	AZR
2254	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-30 01:00:00+01	0.0250	2023-11-03 11:36:42.355+01	2023-11-03 11:36:42.355+01	2023-11-03 11:36:42.355+01	GP1	ALB
2257	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-31 01:00:00+01	0.0250	2023-11-03 11:36:42.359+01	2023-11-03 11:36:42.36+01	2023-11-03 11:36:42.36+01	GP1	ALB
1704	B4ms-general-purpose	AZR-polandcentral	2023-10-01 02:00:00+02	1670.0000	2023-10-31 00:04:32.184+01	2023-10-31 00:04:32.184+01	2023-10-31 15:19:32.842+01	GP1	AZR
2267	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-30 01:00:00+01	0.0390	2023-11-03 11:36:42.465+01	2023-11-03 11:36:42.465+01	2023-11-03 11:36:42.465+01	GP1	ALB
2269	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-31 01:00:00+01	0.0390	2023-11-03 11:36:42.467+01	2023-11-03 11:36:42.467+01	2023-11-03 11:36:42.467+01	GP1	ALB
2271	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-01 01:00:00+01	0.0390	2023-11-03 11:36:42.468+01	2023-11-03 11:36:42.468+01	2023-11-03 11:36:42.468+01	GP1	ALB
2181	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-03 01:00:00+01	0.0864	2023-11-03 10:43:21.985+01	2023-11-03 10:43:21.985+01	2023-11-04 12:40:01.664+01	CO1	AWS
2252	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-03 01:00:00+01	0.0350	2023-11-04 13:26:21.631+01	2023-11-03 11:36:42.025+01	2023-11-04 13:26:21.632+01	CO1	ALB
2183	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-03 01:00:00+01	0.0852	2023-11-03 10:43:22.379+01	2023-11-03 10:43:22.379+01	2023-11-04 12:40:01.318+01	CO1	AWS
2180	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-03 01:00:00+01	0.0505	2023-11-03 10:43:21.445+01	2023-11-03 10:43:21.445+01	2023-11-04 12:40:01.66+01	GP1	AWS
2244	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-30 01:00:00+01	0.0380	2023-11-03 11:36:41.923+01	2023-11-03 11:36:41.924+01	2023-11-03 11:36:41.924+01	GP1	ALB
2245	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-31 01:00:00+01	0.0380	2023-11-03 11:36:41.937+01	2023-11-03 11:36:41.937+01	2023-11-03 11:36:41.937+01	GP1	ALB
2275	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-03 01:00:00+01	0.0390	2023-11-04 13:26:20.235+01	2023-11-03 11:36:42.47+01	2023-11-04 13:26:20.238+01	GP1	ALB
2278	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-30 01:00:00+01	0.0250	2023-11-03 11:36:42.941+01	2023-11-03 11:36:42.941+01	2023-11-03 11:36:42.941+01	CO1	ALB
2248	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-30 01:00:00+01	0.0359	2023-11-03 11:36:42.013+01	2023-11-03 11:36:42.013+01	2023-11-03 11:36:42.013+01	CO1	ALB
2280	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-31 01:00:00+01	0.0250	2023-11-03 11:36:42.943+01	2023-11-03 11:36:42.943+01	2023-11-03 11:36:42.943+01	CO1	ALB
2249	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-31 01:00:00+01	0.0350	2023-11-03 11:36:42.015+01	2023-11-03 11:36:42.016+01	2023-11-03 11:36:42.016+01	CO1	ALB
2281	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-01 01:00:00+01	0.0250	2023-11-03 11:36:42.945+01	2023-11-03 11:36:42.945+01	2023-11-03 11:36:42.945+01	CO1	ALB
2265	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-03 01:00:00+01	0.0250	2023-11-04 13:26:17.63+01	2023-11-03 11:36:42.366+01	2023-11-04 13:26:17.632+01	GP1	ALB
2177	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-03 01:00:00+01	0.0628	2023-11-03 10:43:20.419+01	2023-11-03 10:43:20.42+01	2023-11-04 12:40:00.934+01	GP1	AWS
2178	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-03 01:00:00+01	0.0837	2023-11-03 10:43:20.451+01	2023-11-03 10:43:20.451+01	2023-11-04 12:40:00.943+01	CO1	AWS
2246	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-02 01:00:00+01	0.0380	2023-11-03 11:36:41.945+01	2023-11-03 11:36:41.945+01	2023-11-03 16:26:18.949+01	GP1	ALB
2182	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-03 01:00:00+01	0.0765	2023-11-03 10:43:22.277+01	2023-11-03 10:43:22.277+01	2023-11-04 12:40:01.321+01	GP1	AWS
3709	B4ms-general-purpose	AZR-polandcentral	2023-11-16 22:00:00+01	0.2498	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.057+01	GP1	AZR
2251	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-02 01:00:00+01	0.0350	2023-11-03 11:36:42.022+01	2023-11-03 11:36:42.022+01	2023-11-03 16:26:22.278+01	CO1	ALB
3710	B4ms-general-purpose	AZR-israelcentral	2023-11-16 22:00:00+01	0.2423	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.076+01	GP1	AZR
3712	B4ms-general-purpose	AZR-eastus	2023-11-16 22:00:00+01	0.1965	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.081+01	GP1	AZR
2273	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-02 01:00:00+01	0.0390	2023-11-03 11:36:42.469+01	2023-11-03 11:36:42.469+01	2023-11-03 16:26:20.618+01	GP1	ALB
3708	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-16 22:00:00+01	0.1585	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.087+01	CO1	AZR
2263	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-02 01:00:00+01	0.0250	2023-11-03 11:36:42.365+01	2023-11-03 11:36:42.365+01	2023-11-03 16:26:18.466+01	GP1	ALB
1709	e2-standard-4-general-purpose	GCP-europe-central	2023-10-31 17:17:34.004+01	0.2620	2023-10-31 17:17:34.004+01	2023-10-31 17:17:34.005+01	2023-10-31 17:17:34.005+01	GP1	GCP
2262	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-03 01:00:00+01	0.0250	2023-11-04 13:26:21.422+01	2023-11-03 11:36:42.365+01	2023-11-04 13:26:21.424+01	CO1	ALB
1712	e2-standard-4-general-purpose	GCP-near-east	2023-10-31 17:17:36.368+01	0.2620	2023-10-31 17:17:36.368+01	2023-10-31 17:17:36.368+01	2023-10-31 17:17:36.368+01	GP1	GCP
3232	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-06 00:00:00+01	0.1530	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.384+01	CO1	AZR
1715	e2-standard-4-general-purpose	GCP-asia	2023-10-31 17:17:38.586+01	0.2620	2023-10-31 17:17:38.586+01	2023-10-31 17:17:38.586+01	2023-10-31 17:17:38.586+01	GP1	GCP
1718	e2-standard-4-general-purpose	GCP-us-west	2023-10-31 17:17:40.918+01	0.2620	2023-10-31 17:17:40.918+01	2023-10-31 17:17:40.918+01	2023-10-31 17:17:40.918+01	GP1	GCP
1721	e2-standard-4-general-purpose	GCP-us-east	2023-10-31 17:17:43.864+01	0.2620	2023-10-31 17:17:43.864+01	2023-10-31 17:17:43.864+01	2023-10-31 17:17:43.864+01	GP1	GCP
1724	c2-standard-4-compute-optimized	GCP-europe-central	2023-10-31 17:17:46.281+01	0.2620	2023-10-31 17:17:46.281+01	2023-10-31 17:17:46.282+01	2023-10-31 17:17:46.282+01	CO1	GCP
3529	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-11 01:00:00+01	0.0250	2023-11-11 22:40:54.584+01	2023-11-11 22:40:54.592+01	2023-11-11 22:40:54.592+01	CO1	ALB
3519	B4ms-general-purpose	AZR-southindia	2023-11-11 00:00:00+01	0.2335	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:54.899+01	GP1	AZR
1727	c2-standard-4-compute-optimized	GCP-near-east	2023-10-31 17:17:50.002+01	0.2620	2023-10-31 17:17:50.002+01	2023-10-31 17:17:50.002+01	2023-10-31 17:17:50.002+01	CO1	GCP
3520	D4s_v3-compute-optimized	AZR-westus	2023-11-11 00:00:00+01	0.1381	2023-11-11 00:00:00+01	2023-11-11 00:00:00+01	2023-11-11 22:40:55+01	CO1	AZR
3521	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-11 01:00:00+01	0.0250	2023-11-12 11:14:53.647+01	2023-11-11 22:40:39.635+01	2023-11-12 11:14:53.651+01	GP1	ALB
1730	c2-standard-4-compute-optimized	GCP-asia	2023-10-31 17:17:53.442+01	0.2620	2023-10-31 17:17:53.442+01	2023-10-31 17:17:53.442+01	2023-10-31 17:17:53.442+01	CO1	GCP
3522	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-11 01:00:00+01	0.0380	2023-11-12 11:14:56.408+01	2023-11-11 22:40:41.573+01	2023-11-12 11:14:56.411+01	GP1	ALB
3525	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-11 01:00:00+01	0.0250	2023-11-12 11:15:04.847+01	2023-11-11 22:40:50.633+01	2023-11-12 11:15:04.852+01	CO1	ALB
1733	c2-standard-4-compute-optimized	GCP-us-west	2023-10-31 17:17:56.864+01	0.2620	2023-10-31 17:17:56.864+01	2023-10-31 17:17:56.865+01	2023-10-31 17:17:56.865+01	CO1	GCP
1736	c2-standard-4-compute-optimized	GCP-us-east	2023-10-31 17:18:00.281+01	0.2620	2023-10-31 17:18:00.281+01	2023-10-31 17:18:00.281+01	2023-10-31 17:18:00.281+01	CO1	GCP
3711	B4ms-general-purpose	AZR-westus	2023-11-16 22:00:00+01	0.2405	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.051+01	GP1	AZR
3464	e2-standard-4-general-purpose	GCP-us-west2	2023-11-10 00:00:00+01	0.2620	2023-11-10 14:29:05.728+01	2023-11-10 13:49:43.292+01	2023-11-10 14:29:05.728+01	GP1	GCP
3465	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-10 00:00:00+01	0.3554	2023-11-10 14:29:05.73+01	2023-11-10 13:49:43.297+01	2023-11-10 14:29:05.73+01	CO1	GCP
2253	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-30 01:00:00+01	0.0250	2023-11-03 11:36:42.354+01	2023-11-03 11:36:42.354+01	2023-11-03 11:36:42.354+01	CO1	ALB
2256	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-31 01:00:00+01	0.0250	2023-11-03 11:36:42.357+01	2023-11-03 11:36:42.358+01	2023-11-03 11:36:42.358+01	CO1	ALB
2259	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-01 01:00:00+01	0.0250	2023-11-03 11:36:42.362+01	2023-11-03 11:36:42.362+01	2023-11-03 11:36:42.362+01	CO1	ALB
3466	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-10 00:00:00+01	0.1951	2023-11-10 14:29:05.731+01	2023-11-10 13:49:43.299+01	2023-11-10 14:29:05.731+01	CO1	GCP
3467	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-10 00:00:00+01	0.2399	2023-11-10 14:29:05.758+01	2023-11-10 13:49:43.301+01	2023-11-10 14:29:05.758+01	GP1	GCP
3468	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-10 00:00:00+01	0.2810	2023-11-10 14:29:05.762+01	2023-11-10 13:49:43.303+01	2023-11-10 14:29:05.762+01	GP1	GCP
3469	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-10 00:00:00+01	0.3809	2023-11-10 14:29:05.764+01	2023-11-10 13:49:43.306+01	2023-11-10 14:29:05.764+01	CO1	GCP
3470	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-10 00:00:00+01	0.3330	2023-11-10 14:29:05.779+01	2023-11-10 13:49:43.308+01	2023-11-10 14:29:05.78+01	CO1	GCP
3471	e2-standard-4-general-purpose	GCP-us-east4	2023-11-10 00:00:00+01	0.2457	2023-11-10 14:29:05.783+01	2023-11-10 13:49:43.31+01	2023-11-10 14:29:05.783+01	GP1	GCP
3472	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-10 00:00:00+01	0.3252	2023-11-10 14:29:05.788+01	2023-11-10 13:49:43.312+01	2023-11-10 14:29:05.788+01	CO1	GCP
3473	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-10 00:00:00+01	0.2620	2023-11-10 14:29:05.791+01	2023-11-10 13:49:43.314+01	2023-11-10 14:29:05.791+01	GP1	GCP
2260	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-02 01:00:00+01	0.0250	2023-11-03 11:36:42.364+01	2023-11-03 11:36:42.364+01	2023-11-03 16:26:22.033+01	CO1	ALB
2179	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-03 01:00:00+01	0.0779	2023-11-03 10:43:21.403+01	2023-11-03 10:43:21.403+01	2023-11-04 12:40:01.657+01	CO1	AWS
3523	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-11 01:00:00+01	0.0390	2023-11-11 22:40:44.014+01	2023-11-11 22:40:44.022+01	2023-11-11 22:40:44.022+01	GP1	ALB
3524	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-11 01:00:00+01	0.0370	2023-11-11 22:40:50.193+01	2023-11-11 22:40:50.199+01	2023-11-11 22:40:50.199+01	GP1	ALB
3526	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-11 01:00:00+01	0.0360	2023-11-11 22:40:50.8+01	2023-11-11 22:40:50.806+01	2023-11-11 22:40:50.806+01	CO1	ALB
3527	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-11 01:00:00+01	0.0325	2023-11-11 22:40:52.186+01	2023-11-11 22:40:52.194+01	2023-11-11 22:40:52.194+01	CO1	ALB
3528	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-11 01:00:00+01	0.0420	2023-11-11 22:40:52.972+01	2023-11-11 22:40:52.978+01	2023-11-11 22:40:52.978+01	CO1	ALB
1739	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-31 01:00:00+01	0.0587	2023-10-31 17:36:16.819+01	2023-10-31 17:36:16.819+01	2023-10-31 17:36:16.819+01	GP1	AWS
1740	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-31 01:00:00+01	0.0951	2023-10-31 17:36:16.864+01	2023-10-31 17:36:16.864+01	2023-10-31 17:36:16.864+01	CO1	AWS
1741	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-31 01:00:00+01	0.0273	2023-10-31 17:36:17.379+01	2023-10-31 17:36:17.379+01	2023-10-31 17:36:17.379+01	GP1	AWS
1742	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-31 01:00:00+01	0.0798	2023-10-31 17:36:17.599+01	2023-10-31 17:36:17.599+01	2023-10-31 17:36:17.599+01	CO1	AWS
1743	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-31 01:00:00+01	0.0500	2023-10-31 17:36:17.68+01	2023-10-31 17:36:17.68+01	2023-10-31 17:36:17.68+01	GP1	AWS
1744	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-30 01:00:00+01	0.0492	2023-10-31 17:36:17.681+01	2023-10-31 17:36:17.682+01	2023-10-31 17:36:17.682+01	GP1	AWS
1745	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-29 02:00:00+02	0.0502	2023-10-31 17:36:17.683+01	2023-10-31 17:36:17.683+01	2023-10-31 17:36:17.683+01	GP1	AWS
1746	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-28 02:00:00+02	0.0504	2023-10-31 17:36:17.684+01	2023-10-31 17:36:17.684+01	2023-10-31 17:36:17.684+01	GP1	AWS
1747	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-27 02:00:00+02	0.0505	2023-10-31 17:36:17.685+01	2023-10-31 17:36:17.685+01	2023-10-31 17:36:17.685+01	GP1	AWS
1748	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-26 02:00:00+02	0.0500	2023-10-31 17:36:17.686+01	2023-10-31 17:36:17.686+01	2023-10-31 17:36:17.686+01	GP1	AWS
1749	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-25 02:00:00+02	0.0508	2023-10-31 17:36:17.688+01	2023-10-31 17:36:17.688+01	2023-10-31 17:36:17.688+01	GP1	AWS
1750	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-24 02:00:00+02	0.0492	2023-10-31 17:36:17.689+01	2023-10-31 17:36:17.689+01	2023-10-31 17:36:17.689+01	GP1	AWS
1751	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-23 02:00:00+02	0.0507	2023-10-31 17:36:17.69+01	2023-10-31 17:36:17.69+01	2023-10-31 17:36:17.69+01	GP1	AWS
1752	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-22 02:00:00+02	0.0499	2023-10-31 17:36:17.694+01	2023-10-31 17:36:17.694+01	2023-10-31 17:36:17.694+01	GP1	AWS
1753	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-21 02:00:00+02	0.0506	2023-10-31 17:36:17.697+01	2023-10-31 17:36:17.698+01	2023-10-31 17:36:17.698+01	GP1	AWS
1754	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-20 02:00:00+02	0.0507	2023-10-31 17:36:17.701+01	2023-10-31 17:36:17.701+01	2023-10-31 17:36:17.701+01	GP1	AWS
1755	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-19 02:00:00+02	0.0501	2023-10-31 17:36:17.704+01	2023-10-31 17:36:17.704+01	2023-10-31 17:36:17.704+01	GP1	AWS
1756	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-18 02:00:00+02	0.0509	2023-10-31 17:36:17.708+01	2023-10-31 17:36:17.708+01	2023-10-31 17:36:17.708+01	GP1	AWS
1757	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-17 02:00:00+02	0.0504	2023-10-31 17:36:17.711+01	2023-10-31 17:36:17.712+01	2023-10-31 17:36:17.712+01	GP1	AWS
1758	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-16 02:00:00+02	0.0501	2023-10-31 17:36:17.715+01	2023-10-31 17:36:17.715+01	2023-10-31 17:36:17.715+01	GP1	AWS
1759	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-15 02:00:00+02	0.0505	2023-10-31 17:36:17.718+01	2023-10-31 17:36:17.718+01	2023-10-31 17:36:17.718+01	GP1	AWS
1760	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-14 02:00:00+02	0.0504	2023-10-31 17:36:17.72+01	2023-10-31 17:36:17.72+01	2023-10-31 17:36:17.72+01	GP1	AWS
1761	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-13 02:00:00+02	0.0499	2023-10-31 17:36:17.722+01	2023-10-31 17:36:17.722+01	2023-10-31 17:36:17.722+01	GP1	AWS
1762	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-12 02:00:00+02	0.0497	2023-10-31 17:36:17.724+01	2023-10-31 17:36:17.724+01	2023-10-31 17:36:17.724+01	GP1	AWS
1763	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-11 02:00:00+02	0.0491	2023-10-31 17:36:17.725+01	2023-10-31 17:36:17.725+01	2023-10-31 17:36:17.725+01	GP1	AWS
1764	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-10 02:00:00+02	0.0497	2023-10-31 17:36:17.727+01	2023-10-31 17:36:17.727+01	2023-10-31 17:36:17.727+01	GP1	AWS
1765	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-09 02:00:00+02	0.0491	2023-10-31 17:36:17.728+01	2023-10-31 17:36:17.728+01	2023-10-31 17:36:17.728+01	GP1	AWS
1766	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-08 02:00:00+02	0.0496	2023-10-31 17:36:17.733+01	2023-10-31 17:36:17.733+01	2023-10-31 17:36:17.733+01	GP1	AWS
1767	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-07 02:00:00+02	0.0494	2023-10-31 17:36:17.736+01	2023-10-31 17:36:17.736+01	2023-10-31 17:36:17.736+01	GP1	AWS
1768	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-06 02:00:00+02	0.0491	2023-10-31 17:36:17.737+01	2023-10-31 17:36:17.737+01	2023-10-31 17:36:17.737+01	GP1	AWS
1769	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-05 02:00:00+02	0.0491	2023-10-31 17:36:17.738+01	2023-10-31 17:36:17.738+01	2023-10-31 17:36:17.738+01	GP1	AWS
1770	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-04 02:00:00+02	0.0490	2023-10-31 17:36:17.74+01	2023-10-31 17:36:17.74+01	2023-10-31 17:36:17.74+01	GP1	AWS
1771	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-03 02:00:00+02	0.0493	2023-10-31 17:36:17.741+01	2023-10-31 17:36:17.741+01	2023-10-31 17:36:17.741+01	GP1	AWS
1772	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-02 02:00:00+02	0.0492	2023-10-31 17:36:17.743+01	2023-10-31 17:36:17.743+01	2023-10-31 17:36:17.743+01	GP1	AWS
1773	t4g.xlarge-general-purpose	AWS-us-west-1	2023-10-01 02:00:00+02	0.0492	2023-10-31 17:36:17.744+01	2023-10-31 17:36:17.744+01	2023-10-31 17:36:17.744+01	GP1	AWS
1774	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-30 02:00:00+02	0.0490	2023-10-31 17:36:17.745+01	2023-10-31 17:36:17.745+01	2023-10-31 17:36:17.745+01	GP1	AWS
1775	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-29 02:00:00+02	0.0490	2023-10-31 17:36:17.746+01	2023-10-31 17:36:17.746+01	2023-10-31 17:36:17.746+01	GP1	AWS
1776	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-28 02:00:00+02	0.0494	2023-10-31 17:36:17.747+01	2023-10-31 17:36:17.747+01	2023-10-31 17:36:17.747+01	GP1	AWS
1777	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-27 02:00:00+02	0.0495	2023-10-31 17:36:17.747+01	2023-10-31 17:36:17.747+01	2023-10-31 17:36:17.747+01	GP1	AWS
1778	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-26 02:00:00+02	0.0499	2023-10-31 17:36:17.748+01	2023-10-31 17:36:17.748+01	2023-10-31 17:36:17.748+01	GP1	AWS
1779	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-25 02:00:00+02	0.0501	2023-10-31 17:36:17.749+01	2023-10-31 17:36:17.749+01	2023-10-31 17:36:17.749+01	GP1	AWS
1780	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-24 02:00:00+02	0.0500	2023-10-31 17:36:17.75+01	2023-10-31 17:36:17.75+01	2023-10-31 17:36:17.75+01	GP1	AWS
1781	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-23 02:00:00+02	0.0499	2023-10-31 17:36:17.751+01	2023-10-31 17:36:17.751+01	2023-10-31 17:36:17.751+01	GP1	AWS
1782	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-22 02:00:00+02	0.0494	2023-10-31 17:36:17.752+01	2023-10-31 17:36:17.752+01	2023-10-31 17:36:17.752+01	GP1	AWS
1783	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-21 02:00:00+02	0.0490	2023-10-31 17:36:17.753+01	2023-10-31 17:36:17.753+01	2023-10-31 17:36:17.753+01	GP1	AWS
1784	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-20 02:00:00+02	0.0495	2023-10-31 17:36:17.754+01	2023-10-31 17:36:17.754+01	2023-10-31 17:36:17.754+01	GP1	AWS
1785	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-19 02:00:00+02	0.0492	2023-10-31 17:36:17.754+01	2023-10-31 17:36:17.754+01	2023-10-31 17:36:17.754+01	GP1	AWS
1786	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-18 02:00:00+02	0.0501	2023-10-31 17:36:17.755+01	2023-10-31 17:36:17.755+01	2023-10-31 17:36:17.755+01	GP1	AWS
1787	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-17 02:00:00+02	0.0505	2023-10-31 17:36:17.756+01	2023-10-31 17:36:17.756+01	2023-10-31 17:36:17.756+01	GP1	AWS
1788	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-16 02:00:00+02	0.0506	2023-10-31 17:36:17.757+01	2023-10-31 17:36:17.757+01	2023-10-31 17:36:17.757+01	GP1	AWS
1789	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-15 02:00:00+02	0.0512	2023-10-31 17:36:17.759+01	2023-10-31 17:36:17.759+01	2023-10-31 17:36:17.759+01	GP1	AWS
1790	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-14 02:00:00+02	0.0508	2023-10-31 17:36:17.76+01	2023-10-31 17:36:17.76+01	2023-10-31 17:36:17.76+01	GP1	AWS
1791	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-13 02:00:00+02	0.0510	2023-10-31 17:36:17.761+01	2023-10-31 17:36:17.761+01	2023-10-31 17:36:17.761+01	GP1	AWS
1792	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-12 02:00:00+02	0.0511	2023-10-31 17:36:17.762+01	2023-10-31 17:36:17.762+01	2023-10-31 17:36:17.762+01	GP1	AWS
1793	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-11 02:00:00+02	0.0519	2023-10-31 17:36:17.763+01	2023-10-31 17:36:17.763+01	2023-10-31 17:36:17.763+01	GP1	AWS
1794	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-10 02:00:00+02	0.0521	2023-10-31 17:36:17.764+01	2023-10-31 17:36:17.764+01	2023-10-31 17:36:17.764+01	GP1	AWS
1795	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-09 02:00:00+02	0.0526	2023-10-31 17:36:17.764+01	2023-10-31 17:36:17.764+01	2023-10-31 17:36:17.764+01	GP1	AWS
1796	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-08 02:00:00+02	0.0535	2023-10-31 17:36:17.765+01	2023-10-31 17:36:17.765+01	2023-10-31 17:36:17.765+01	GP1	AWS
1797	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-07 02:00:00+02	0.0540	2023-10-31 17:36:17.766+01	2023-10-31 17:36:17.766+01	2023-10-31 17:36:17.766+01	GP1	AWS
1798	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-06 02:00:00+02	0.0545	2023-10-31 17:36:17.767+01	2023-10-31 17:36:17.767+01	2023-10-31 17:36:17.767+01	GP1	AWS
1799	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-05 02:00:00+02	0.0544	2023-10-31 17:36:17.768+01	2023-10-31 17:36:17.768+01	2023-10-31 17:36:17.768+01	GP1	AWS
1800	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-04 02:00:00+02	0.0548	2023-10-31 17:36:17.769+01	2023-10-31 17:36:17.769+01	2023-10-31 17:36:17.769+01	GP1	AWS
1801	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-03 02:00:00+02	0.0556	2023-10-31 17:36:17.77+01	2023-10-31 17:36:17.77+01	2023-10-31 17:36:17.77+01	GP1	AWS
1802	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-02 02:00:00+02	0.0554	2023-10-31 17:36:17.771+01	2023-10-31 17:36:17.771+01	2023-10-31 17:36:17.771+01	GP1	AWS
1803	t4g.xlarge-general-purpose	AWS-us-west-1	2023-09-01 02:00:00+02	0.0554	2023-10-31 17:36:17.772+01	2023-10-31 17:36:17.772+01	2023-10-31 17:36:17.772+01	GP1	AWS
1804	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-31 01:00:00+01	0.0845	2023-10-31 17:36:18+01	2023-10-31 17:36:18+01	2023-10-31 17:36:18+01	CO1	AWS
1805	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-31 01:00:00+01	0.0836	2023-10-31 17:36:18.328+01	2023-10-31 17:36:18.328+01	2023-10-31 17:36:18.328+01	CO1	AWS
1806	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-30 01:00:00+01	0.0874	2023-10-31 17:36:18.329+01	2023-10-31 17:36:18.329+01	2023-10-31 17:36:18.329+01	CO1	AWS
3343	E2 Instance Core running in Los Angeles	GCP-us-west2	2023-11-07 00:00:00+01	0.2620	2023-11-07 21:03:14.771+01	2023-11-07 19:32:12.499+01	2023-11-07 21:03:14.772+01	e2-instance-core-running-in-los-angeles-us-west2	\N
3477	B4ms-general-purpose	AZR-israelcentral	2023-11-10 00:00:00+01	0.2423	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.299+01	GP1	AZR
3480	B4ms-general-purpose	AZR-southindia	2023-11-10 00:00:00+01	0.2335	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.335+01	GP1	AZR
3474	B4ms-general-purpose	AZR-westus	2023-11-10 00:00:00+01	0.2405	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.346+01	GP1	AZR
3530	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-11 00:00:00+01	0.0823	2023-11-12 11:15:16.117+01	2023-11-11 22:40:58.746+01	2023-11-12 11:15:16.121+01	CO1	AWS
3715	D4s_v3-compute-optimized	AZR-southindia	2023-11-16 22:00:00+01	0.1571	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.071+01	CO1	AZR
3714	D4s_v3-compute-optimized	AZR-westus	2023-11-16 22:00:00+01	0.1381	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.099+01	CO1	AZR
3713	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-16 22:00:00+01	0.1530	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.129+01	CO1	AZR
3538	e2-standard-4-general-purpose	GCP-us-west2	2023-11-11 00:00:00+01	0.2620	2023-11-11 22:41:04.358+01	2023-11-11 22:41:04.358+01	2023-11-11 22:41:04.358+01	GP1	GCP
3476	B4ms-general-purpose	AZR-eastus	2023-11-10 00:00:00+01	0.1965	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.309+01	GP1	AZR
3539	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-11 00:00:00+01	0.3554	2023-11-11 22:41:04.363+01	2023-11-11 22:41:04.363+01	2023-11-11 22:41:04.363+01	CO1	GCP
3540	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-11 00:00:00+01	0.1951	2023-11-11 22:41:04.365+01	2023-11-11 22:41:04.365+01	2023-11-11 22:41:04.365+01	CO1	GCP
3475	B4ms-general-purpose	AZR-polandcentral	2023-11-10 00:00:00+01	0.2498	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.311+01	GP1	AZR
3481	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-10 00:00:00+01	0.1530	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.333+01	CO1	AZR
1807	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-29 02:00:00+02	0.0858	2023-10-31 17:36:18.333+01	2023-10-31 17:36:18.333+01	2023-10-31 17:36:18.333+01	CO1	AWS
1808	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-28 02:00:00+02	0.0867	2023-10-31 17:36:18.336+01	2023-10-31 17:36:18.336+01	2023-10-31 17:36:18.336+01	CO1	AWS
1809	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-27 02:00:00+02	0.0865	2023-10-31 17:36:18.338+01	2023-10-31 17:36:18.338+01	2023-10-31 17:36:18.338+01	CO1	AWS
1810	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-26 02:00:00+02	0.0852	2023-10-31 17:36:18.339+01	2023-10-31 17:36:18.339+01	2023-10-31 17:36:18.339+01	CO1	AWS
1811	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-25 02:00:00+02	0.0846	2023-10-31 17:36:18.34+01	2023-10-31 17:36:18.34+01	2023-10-31 17:36:18.34+01	CO1	AWS
1812	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-24 02:00:00+02	0.0851	2023-10-31 17:36:18.343+01	2023-10-31 17:36:18.343+01	2023-10-31 17:36:18.343+01	CO1	AWS
1813	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-23 02:00:00+02	0.0844	2023-10-31 17:36:18.346+01	2023-10-31 17:36:18.346+01	2023-10-31 17:36:18.346+01	CO1	AWS
1814	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-22 02:00:00+02	0.0845	2023-10-31 17:36:18.349+01	2023-10-31 17:36:18.349+01	2023-10-31 17:36:18.349+01	CO1	AWS
1815	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-21 02:00:00+02	0.0839	2023-10-31 17:36:18.352+01	2023-10-31 17:36:18.352+01	2023-10-31 17:36:18.352+01	CO1	AWS
1816	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-20 02:00:00+02	0.0851	2023-10-31 17:36:18.354+01	2023-10-31 17:36:18.354+01	2023-10-31 17:36:18.354+01	CO1	AWS
1817	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-19 02:00:00+02	0.0835	2023-10-31 17:36:18.355+01	2023-10-31 17:36:18.356+01	2023-10-31 17:36:18.356+01	CO1	AWS
1818	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-18 02:00:00+02	0.0846	2023-10-31 17:36:18.357+01	2023-10-31 17:36:18.357+01	2023-10-31 17:36:18.357+01	CO1	AWS
1819	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-17 02:00:00+02	0.0833	2023-10-31 17:36:18.359+01	2023-10-31 17:36:18.359+01	2023-10-31 17:36:18.359+01	CO1	AWS
1820	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-16 02:00:00+02	0.0827	2023-10-31 17:36:18.361+01	2023-10-31 17:36:18.362+01	2023-10-31 17:36:18.362+01	CO1	AWS
1821	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-15 02:00:00+02	0.0818	2023-10-31 17:36:18.365+01	2023-10-31 17:36:18.365+01	2023-10-31 17:36:18.365+01	CO1	AWS
1823	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-14 02:00:00+02	0.0831	2023-10-31 17:36:18.366+01	2023-10-31 17:36:18.366+01	2023-10-31 17:36:18.366+01	CO1	AWS
1824	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-13 02:00:00+02	0.0832	2023-10-31 17:36:18.367+01	2023-10-31 17:36:18.367+01	2023-10-31 17:36:18.367+01	CO1	AWS
1825	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-12 02:00:00+02	0.0854	2023-10-31 17:36:18.368+01	2023-10-31 17:36:18.369+01	2023-10-31 17:36:18.369+01	CO1	AWS
1826	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-11 02:00:00+02	0.0852	2023-10-31 17:36:18.37+01	2023-10-31 17:36:18.37+01	2023-10-31 17:36:18.37+01	CO1	AWS
1827	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-10 02:00:00+02	0.0848	2023-10-31 17:36:18.371+01	2023-10-31 17:36:18.371+01	2023-10-31 17:36:18.371+01	CO1	AWS
1828	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-09 02:00:00+02	0.0859	2023-10-31 17:36:18.372+01	2023-10-31 17:36:18.372+01	2023-10-31 17:36:18.372+01	CO1	AWS
1829	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-08 02:00:00+02	0.0858	2023-10-31 17:36:18.373+01	2023-10-31 17:36:18.373+01	2023-10-31 17:36:18.373+01	CO1	AWS
1830	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-07 02:00:00+02	0.0852	2023-10-31 17:36:18.375+01	2023-10-31 17:36:18.375+01	2023-10-31 17:36:18.375+01	CO1	AWS
1831	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-06 02:00:00+02	0.0854	2023-10-31 17:36:18.378+01	2023-10-31 17:36:18.378+01	2023-10-31 17:36:18.378+01	CO1	AWS
1832	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-05 02:00:00+02	0.0853	2023-10-31 17:36:18.379+01	2023-10-31 17:36:18.379+01	2023-10-31 17:36:18.379+01	CO1	AWS
1833	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-04 02:00:00+02	0.0854	2023-10-31 17:36:18.38+01	2023-10-31 17:36:18.38+01	2023-10-31 17:36:18.38+01	CO1	AWS
1834	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-03 02:00:00+02	0.0858	2023-10-31 17:36:18.382+01	2023-10-31 17:36:18.382+01	2023-10-31 17:36:18.382+01	CO1	AWS
1835	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-02 02:00:00+02	0.0861	2023-10-31 17:36:18.383+01	2023-10-31 17:36:18.383+01	2023-10-31 17:36:18.383+01	CO1	AWS
1836	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-10-01 02:00:00+02	0.0851	2023-10-31 17:36:18.384+01	2023-10-31 17:36:18.384+01	2023-10-31 17:36:18.384+01	CO1	AWS
1837	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-30 02:00:00+02	0.0842	2023-10-31 17:36:18.385+01	2023-10-31 17:36:18.385+01	2023-10-31 17:36:18.385+01	CO1	AWS
1838	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-29 02:00:00+02	0.0840	2023-10-31 17:36:18.386+01	2023-10-31 17:36:18.386+01	2023-10-31 17:36:18.386+01	CO1	AWS
1839	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-28 02:00:00+02	0.0843	2023-10-31 17:36:18.388+01	2023-10-31 17:36:18.388+01	2023-10-31 17:36:18.388+01	CO1	AWS
1840	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-27 02:00:00+02	0.0842	2023-10-31 17:36:18.389+01	2023-10-31 17:36:18.389+01	2023-10-31 17:36:18.389+01	CO1	AWS
1841	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-26 02:00:00+02	0.0843	2023-10-31 17:36:18.39+01	2023-10-31 17:36:18.39+01	2023-10-31 17:36:18.39+01	CO1	AWS
1842	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-25 02:00:00+02	0.0850	2023-10-31 17:36:18.391+01	2023-10-31 17:36:18.391+01	2023-10-31 17:36:18.391+01	CO1	AWS
1843	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-24 02:00:00+02	0.0849	2023-10-31 17:36:18.392+01	2023-10-31 17:36:18.392+01	2023-10-31 17:36:18.392+01	CO1	AWS
1844	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-23 02:00:00+02	0.0851	2023-10-31 17:36:18.394+01	2023-10-31 17:36:18.395+01	2023-10-31 17:36:18.395+01	CO1	AWS
1845	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-22 02:00:00+02	0.0849	2023-10-31 17:36:18.396+01	2023-10-31 17:36:18.396+01	2023-10-31 17:36:18.396+01	CO1	AWS
1846	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-21 02:00:00+02	0.0849	2023-10-31 17:36:18.397+01	2023-10-31 17:36:18.397+01	2023-10-31 17:36:18.397+01	CO1	AWS
1847	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-20 02:00:00+02	0.0844	2023-10-31 17:36:18.398+01	2023-10-31 17:36:18.398+01	2023-10-31 17:36:18.398+01	CO1	AWS
1848	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-19 02:00:00+02	0.0839	2023-10-31 17:36:18.399+01	2023-10-31 17:36:18.399+01	2023-10-31 17:36:18.399+01	CO1	AWS
1849	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-18 02:00:00+02	0.0844	2023-10-31 17:36:18.4+01	2023-10-31 17:36:18.4+01	2023-10-31 17:36:18.4+01	CO1	AWS
1850	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-17 02:00:00+02	0.0822	2023-10-31 17:36:18.403+01	2023-10-31 17:36:18.403+01	2023-10-31 17:36:18.403+01	CO1	AWS
1851	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-16 02:00:00+02	0.0829	2023-10-31 17:36:18.404+01	2023-10-31 17:36:18.404+01	2023-10-31 17:36:18.404+01	CO1	AWS
1852	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-15 02:00:00+02	0.0806	2023-10-31 17:36:18.405+01	2023-10-31 17:36:18.405+01	2023-10-31 17:36:18.405+01	CO1	AWS
1853	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-14 02:00:00+02	0.0810	2023-10-31 17:36:18.406+01	2023-10-31 17:36:18.406+01	2023-10-31 17:36:18.406+01	CO1	AWS
1854	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-13 02:00:00+02	0.0802	2023-10-31 17:36:18.407+01	2023-10-31 17:36:18.407+01	2023-10-31 17:36:18.407+01	CO1	AWS
3541	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-11 00:00:00+01	0.2399	2023-11-11 22:41:04.366+01	2023-11-11 22:41:04.366+01	2023-11-11 22:41:04.366+01	GP1	GCP
3542	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-11 00:00:00+01	0.2810	2023-11-11 22:41:04.367+01	2023-11-11 22:41:04.367+01	2023-11-11 22:41:04.367+01	GP1	GCP
3543	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-11 00:00:00+01	0.3809	2023-11-11 22:41:04.369+01	2023-11-11 22:41:04.369+01	2023-11-11 22:41:04.369+01	CO1	GCP
3544	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-11 00:00:00+01	0.3330	2023-11-11 22:41:04.37+01	2023-11-11 22:41:04.37+01	2023-11-11 22:41:04.37+01	CO1	GCP
3545	e2-standard-4-general-purpose	GCP-us-east4	2023-11-11 00:00:00+01	0.2457	2023-11-11 22:41:04.372+01	2023-11-11 22:41:04.372+01	2023-11-11 22:41:04.372+01	GP1	GCP
3536	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-11 00:00:00+01	0.0834	2023-11-12 11:15:16.448+01	2023-11-11 22:40:59.285+01	2023-11-12 11:15:16.452+01	CO1	AWS
3537	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-11 00:00:00+01	0.0744	2023-11-12 11:15:16.475+01	2023-11-11 22:40:59.306+01	2023-11-12 11:15:16.477+01	GP1	AWS
3534	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-11 00:00:00+01	0.0667	2023-11-12 11:15:16.581+01	2023-11-11 22:40:59.172+01	2023-11-12 11:15:16.584+01	GP1	AWS
3535	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-11 00:00:00+01	0.0724	2023-11-12 11:15:16.751+01	2023-11-11 22:40:59.195+01	2023-11-12 11:15:16.756+01	CO1	AWS
3533	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-11 00:00:00+01	0.0695	2023-11-12 11:15:17.224+01	2023-11-11 22:40:59.101+01	2023-11-12 11:15:17.226+01	CO1	AWS
3532	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-11 00:00:00+01	0.0318	2023-11-12 11:15:17.224+01	2023-11-11 22:40:59.087+01	2023-11-12 11:15:17.226+01	GP1	AWS
1822	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-31 01:00:00+01	0.0766	2023-10-31 17:36:18.365+01	2023-10-31 17:36:18.365+01	2023-10-31 17:36:18.365+01	GP1	AWS
2007	B4ms-general-purpose	AZR-polandcentral	2023-11-02 11:02:43.529+01	0.2498	2023-11-02 11:02:43.529+01	2023-11-02 11:02:43.529+01	2023-11-02 11:02:43.531+01	GP1	AZR
2008	B4ms-general-purpose	AZR-israelcentral	2023-11-02 11:02:43.538+01	0.2423	2023-11-02 11:02:43.538+01	2023-11-02 11:02:43.538+01	2023-11-02 11:02:43.538+01	GP1	AZR
2009	B4ms-general-purpose	AZR-southindia	2023-11-02 11:02:43.545+01	0.2335	2023-11-02 11:02:43.545+01	2023-11-02 11:02:43.545+01	2023-11-02 11:02:43.545+01	GP1	AZR
2010	D4s_v3-compute-optimized	AZR-eastus2	2023-11-02 11:02:43.548+01	0.1249	2023-11-02 11:02:43.548+01	2023-11-02 11:02:43.548+01	2023-11-02 11:02:43.548+01	CO1	AZR
2011	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-02 11:02:43.549+01	0.1585	2023-11-02 11:02:43.549+01	2023-11-02 11:02:43.549+01	2023-11-02 11:02:43.549+01	CO1	AZR
2012	B4ms-general-purpose	AZR-eastus2	2023-11-02 11:02:43.554+01	0.1965	2023-11-02 11:02:43.554+01	2023-11-02 11:02:43.554+01	2023-11-02 11:02:43.554+01	GP1	AZR
2184	B4ms-general-purpose	AZR-polandcentral	2023-11-03 10:43:37.386+01	0.2498	2023-11-03 10:43:37.386+01	2023-11-03 10:43:37.386+01	2023-11-03 10:43:37.387+01	GP1	AZR
2185	B4ms-general-purpose	AZR-israelcentral	2023-11-03 10:43:37.395+01	0.2423	2023-11-03 10:43:37.395+01	2023-11-03 10:43:37.395+01	2023-11-03 10:43:37.395+01	GP1	AZR
2186	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-03 10:43:37.396+01	0.1585	2023-11-03 10:43:37.396+01	2023-11-03 10:43:37.396+01	2023-11-03 10:43:37.396+01	CO1	AZR
2294	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-03 01:00:00+01	0.0301	2023-11-03 16:06:18.715+01	2023-11-03 16:06:18.715+01	2023-11-04 12:40:01.654+01	GP1	AWS
2255	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-30 01:00:00+01	0.0460	2023-11-03 11:36:42.356+01	2023-11-03 11:36:42.356+01	2023-11-03 11:36:42.356+01	CO1	ALB
2258	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-31 01:00:00+01	0.0460	2023-11-03 11:36:42.362+01	2023-11-03 11:36:42.362+01	2023-11-03 11:36:42.362+01	CO1	ALB
2261	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-01 01:00:00+01	0.0460	2023-11-03 11:36:42.364+01	2023-11-03 11:36:42.364+01	2023-11-03 11:36:42.364+01	CO1	ALB
2276	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-03 01:00:00+01	0.0337	2023-11-04 13:26:22.615+01	2023-11-03 11:36:42.471+01	2023-11-04 13:26:22.618+01	CO1	ALB
2268	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-30 01:00:00+01	0.0360	2023-11-03 11:36:42.465+01	2023-11-03 11:36:42.465+01	2023-11-03 11:36:42.465+01	CO1	ALB
2270	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-31 01:00:00+01	0.0358	2023-11-03 11:36:42.467+01	2023-11-03 11:36:42.467+01	2023-11-03 11:36:42.467+01	CO1	ALB
2272	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-01 01:00:00+01	0.0340	2023-11-03 11:36:42.468+01	2023-11-03 11:36:42.468+01	2023-11-03 11:36:42.468+01	CO1	ALB
2277	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-30 01:00:00+01	0.0325	2023-11-03 11:36:42.94+01	2023-11-03 11:36:42.94+01	2023-11-03 11:36:42.94+01	GP1	ALB
2279	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-31 01:00:00+01	0.0359	2023-11-03 11:36:42.942+01	2023-11-03 11:36:42.942+01	2023-11-03 11:36:42.942+01	GP1	ALB
3484	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-10 01:00:00+01	0.0250	2023-11-11 22:40:39.624+01	2023-11-10 14:13:11.727+01	2023-11-11 22:40:39.627+01	GP1	ALB
3485	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-10 01:00:00+01	0.0380	2023-11-11 22:40:41.567+01	2023-11-10 14:13:12.758+01	2023-11-11 22:40:41.57+01	GP1	ALB
3486	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-10 01:00:00+01	0.0390	2023-11-11 22:40:44.014+01	2023-11-10 14:13:18.102+01	2023-11-11 22:40:44.018+01	GP1	ALB
3487	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-10 01:00:00+01	0.0370	2023-11-11 22:40:50.193+01	2023-11-10 14:13:20.22+01	2023-11-11 22:40:50.196+01	GP1	ALB
3490	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-10 01:00:00+01	0.0460	2023-11-10 14:13:21.833+01	2023-11-10 14:13:21.841+01	2023-11-10 14:13:21.841+01	CO1	ALB
3488	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-10 01:00:00+01	0.0250	2023-11-11 22:40:50.627+01	2023-11-10 14:13:20.649+01	2023-11-11 22:40:50.63+01	CO1	ALB
3489	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-10 01:00:00+01	0.0360	2023-11-11 22:40:50.8+01	2023-11-10 14:13:20.872+01	2023-11-11 22:40:50.803+01	CO1	ALB
3491	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-10 01:00:00+01	0.0325	2023-11-11 22:40:52.186+01	2023-11-10 14:13:23.301+01	2023-11-11 22:40:52.19+01	CO1	ALB
2282	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-02 01:00:00+01	0.0370	2023-11-03 11:36:42.945+01	2023-11-03 11:36:42.945+01	2023-11-03 16:26:21.613+01	GP1	ALB
2264	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-02 01:00:00+01	0.0460	2023-11-03 11:36:42.366+01	2023-11-03 11:36:42.366+01	2023-11-03 16:26:22.733+01	CO1	ALB
3492	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-10 01:00:00+01	0.0250	2023-11-11 22:40:54.584+01	2023-11-10 14:13:23.93+01	2023-11-11 22:40:54.588+01	CO1	ALB
2274	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-02 01:00:00+01	0.0340	2023-11-03 11:36:42.469+01	2023-11-03 11:36:42.469+01	2023-11-03 16:26:23.499+01	CO1	ALB
3718	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-17 01:00:00+01	0.0250	2023-11-17 21:25:25.129+01	2023-11-17 10:37:13.84+01	2023-11-17 21:25:25.133+01	GP1	ALB
3719	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-17 01:00:00+01	0.0380	2023-11-17 21:25:27.04+01	2023-11-17 10:37:15.483+01	2023-11-17 21:25:27.047+01	GP1	ALB
3720	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-17 01:00:00+01	0.0390	2023-11-17 21:25:29.155+01	2023-11-17 10:37:18.515+01	2023-11-17 21:25:29.161+01	GP1	ALB
3721	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-17 01:00:00+01	0.0370	2023-11-17 21:25:35.068+01	2023-11-17 10:37:23.547+01	2023-11-17 21:25:35.075+01	GP1	ALB
3722	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-17 01:00:00+01	0.0250	2023-11-17 21:25:35.618+01	2023-11-17 10:37:25.12+01	2023-11-17 21:25:35.624+01	CO1	ALB
3723	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-17 01:00:00+01	0.0350	2023-11-17 21:25:35.919+01	2023-11-17 10:37:25.568+01	2023-11-17 21:25:35.925+01	CO1	ALB
3724	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-17 01:00:00+01	0.0325	2023-11-17 21:25:37.679+01	2023-11-17 10:37:27.039+01	2023-11-17 21:25:37.686+01	CO1	ALB
3478	D4s_v3-compute-optimized	AZR-westus	2023-11-10 00:00:00+01	0.1381	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.341+01	CO1	AZR
3483	D4s_v3-compute-optimized	AZR-southindia	2023-11-10 00:00:00+01	0.1571	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.362+01	CO1	AZR
3546	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-11 00:00:00+01	0.3252	2023-11-11 22:41:04.374+01	2023-11-11 22:41:04.374+01	2023-11-11 22:41:04.374+01	CO1	GCP
3547	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-11 00:00:00+01	0.2620	2023-11-11 22:41:04.376+01	2023-11-11 22:41:04.377+01	2023-11-11 22:41:04.377+01	GP1	GCP
3725	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-17 01:00:00+01	0.0420	2023-11-17 21:25:38.895+01	2023-11-17 10:37:28.523+01	2023-11-17 21:25:38.9+01	CO1	ALB
3716	B4ms-general-purpose	AZR-southindia	2023-11-16 22:00:00+01	0.2335	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.075+01	GP1	AZR
3726	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-17 01:00:00+01	0.0250	2023-11-17 21:25:40.675+01	2023-11-17 10:37:30.469+01	2023-11-17 21:25:40.681+01	CO1	ALB
3717	D4s_v3-compute-optimized	AZR-eastus	2023-11-16 22:00:00+01	0.1231	2023-11-16 22:00:00+01	2023-11-16 22:00:00+01	2023-11-17 21:25:41.079+01	CO1	AZR
1855	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-12 02:00:00+02	0.0780	2023-10-31 17:36:18.408+01	2023-10-31 17:36:18.408+01	2023-10-31 17:36:18.408+01	CO1	AWS
1856	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-11 02:00:00+02	0.0774	2023-10-31 17:36:18.41+01	2023-10-31 17:36:18.41+01	2023-10-31 17:36:18.41+01	CO1	AWS
1857	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-10 02:00:00+02	0.0770	2023-10-31 17:36:18.413+01	2023-10-31 17:36:18.413+01	2023-10-31 17:36:18.413+01	CO1	AWS
1858	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-09 02:00:00+02	0.0767	2023-10-31 17:36:18.414+01	2023-10-31 17:36:18.414+01	2023-10-31 17:36:18.414+01	CO1	AWS
1859	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-08 02:00:00+02	0.0787	2023-10-31 17:36:18.415+01	2023-10-31 17:36:18.415+01	2023-10-31 17:36:18.415+01	CO1	AWS
1860	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-07 02:00:00+02	0.0761	2023-10-31 17:36:18.416+01	2023-10-31 17:36:18.416+01	2023-10-31 17:36:18.416+01	CO1	AWS
1861	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-06 02:00:00+02	0.0790	2023-10-31 17:36:18.417+01	2023-10-31 17:36:18.417+01	2023-10-31 17:36:18.417+01	CO1	AWS
1862	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-05 02:00:00+02	0.0776	2023-10-31 17:36:18.419+01	2023-10-31 17:36:18.419+01	2023-10-31 17:36:18.419+01	CO1	AWS
1863	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-04 02:00:00+02	0.0779	2023-10-31 17:36:18.42+01	2023-10-31 17:36:18.42+01	2023-10-31 17:36:18.42+01	CO1	AWS
1864	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-03 02:00:00+02	0.0794	2023-10-31 17:36:18.421+01	2023-10-31 17:36:18.421+01	2023-10-31 17:36:18.421+01	CO1	AWS
1865	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-02 02:00:00+02	0.0786	2023-10-31 17:36:18.422+01	2023-10-31 17:36:18.422+01	2023-10-31 17:36:18.422+01	CO1	AWS
1866	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-09-01 02:00:00+02	0.0791	2023-10-31 17:36:18.423+01	2023-10-31 17:36:18.423+01	2023-10-31 17:36:18.423+01	CO1	AWS
2013	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-02 11:02:43.552+01	0.1530	2023-11-02 11:02:43.552+01	2023-11-02 11:02:43.552+01	2023-11-02 11:02:43.552+01	CO1	AZR
2189	B4ms-general-purpose	AZR-eastus	2023-11-03 10:43:37.414+01	0.1965	2023-11-03 10:43:37.414+01	2023-11-03 10:43:37.414+01	2023-11-03 10:43:37.414+01	GP1	AZR
3727	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-16 22:00:00+01	0.0716	2023-11-17 21:25:43.49+01	2023-11-17 10:37:34.076+01	2023-11-17 21:25:43.493+01	CO1	AWS
3359	C2D AMD Instance Ram running in Frankfurt	GCP-europe-west3	2023-11-07 00:00:00+01	0.5100	2023-11-07 21:03:14.785+01	2023-11-07 20:45:54.617+01	2023-11-07 21:03:14.785+01	unknown-grouping	GCP
3730	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-16 22:00:00+01	0.0805	2023-11-17 21:25:43.982+01	2023-11-17 10:37:34.392+01	2023-11-17 21:25:43.984+01	CO1	AWS
3732	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-16 22:00:00+01	0.0530	2023-11-17 21:25:44.258+01	2023-11-17 10:37:34.571+01	2023-11-17 21:25:44.261+01	CO1	AWS
3731	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-16 22:00:00+01	0.0559	2023-11-17 21:25:44.259+01	2023-11-17 10:37:34.551+01	2023-11-17 21:25:44.262+01	GP1	AWS
3479	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-10 00:00:00+01	0.1585	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.323+01	CO1	AZR
3482	D4s_v3-compute-optimized	AZR-eastus	2023-11-10 00:00:00+01	0.1231	2023-11-10 00:00:00+01	2023-11-10 00:00:00+01	2023-11-10 14:28:56.34+01	CO1	AZR
3551	B4ms-general-purpose	AZR-southindia	2023-11-12 00:00:00+01	0.2335	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:12.135+01	GP1	AZR
3549	B4ms-general-purpose	AZR-israelcentral	2023-11-12 00:00:00+01	0.2423	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:12.153+01	GP1	AZR
3548	B4ms-general-purpose	AZR-eastus	2023-11-12 00:00:00+01	0.1965	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:12.156+01	GP1	AZR
3550	B4ms-general-purpose	AZR-polandcentral	2023-11-12 00:00:00+01	0.2498	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:12.474+01	GP1	AZR
3553	D4s_v3-compute-optimized	AZR-eastus	2023-11-12 00:00:00+01	0.1231	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:13.479+01	CO1	AZR
3552	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-12 00:00:00+01	0.1585	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:13.483+01	CO1	AZR
3555	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-12 00:00:00+01	0.1530	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:13.483+01	CO1	AZR
3579	B4ms-general-purpose	AZR-israelcentral	2023-11-13 22:00:00+01	0.2423	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:00.557+01	GP1	AZR
3583	B4ms-general-purpose	AZR-southindia	2023-11-13 22:00:00+01	0.2335	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:00.574+01	GP1	AZR
3582	B4ms-general-purpose	AZR-westus	2023-11-13 22:00:00+01	0.2405	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:00.575+01	GP1	AZR
3587	D4s_v3-compute-optimized	AZR-southindia	2023-11-13 22:00:00+01	0.1571	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:01.485+01	CO1	AZR
3584	D4s_v3-compute-optimized	AZR-westus	2023-11-13 22:00:00+01	0.1381	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:01.486+01	CO1	AZR
3585	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-13 22:00:00+01	0.1530	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:01.5+01	CO1	AZR
3236	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-05 01:00:00+01	0.0250	2023-11-06 14:38:39.204+01	2023-11-06 13:15:08.073+01	2023-11-06 14:38:39.208+01	GP1	ALB
3237	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-06 01:00:00+01	0.0250	2023-11-06 14:38:39.204+01	2023-11-06 13:15:08.076+01	2023-11-06 14:38:39.209+01	GP1	ALB
3238	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-05 01:00:00+01	0.0380	2023-11-06 14:38:39.614+01	2023-11-06 13:15:09.031+01	2023-11-06 14:38:39.615+01	GP1	ALB
3239	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-06 01:00:00+01	0.0380	2023-11-06 14:38:39.614+01	2023-11-06 13:15:09.035+01	2023-11-06 14:38:39.618+01	GP1	ALB
3240	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-05 01:00:00+01	0.0390	2023-11-06 14:38:43.589+01	2023-11-06 13:15:13.073+01	2023-11-06 14:38:43.591+01	GP1	ALB
3241	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-06 01:00:00+01	0.0390	2023-11-06 14:38:43.589+01	2023-11-06 13:15:13.077+01	2023-11-06 14:38:43.606+01	GP1	ALB
3242	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-05 01:00:00+01	0.0410	2023-11-06 14:38:44.251+01	2023-11-06 13:15:15.463+01	2023-11-06 14:38:44.252+01	GP1	ALB
3243	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-06 01:00:00+01	0.0383	2023-11-06 14:38:44.251+01	2023-11-06 13:15:15.465+01	2023-11-06 14:38:44.254+01	GP1	ALB
3244	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-05 01:00:00+01	0.0250	2023-11-06 14:38:44.663+01	2023-11-06 13:15:15.903+01	2023-11-06 14:38:44.665+01	CO1	ALB
2014	B4ms-general-purpose	AZR-westus	2023-11-02 11:02:43.564+01	0.2405	2023-11-02 11:02:43.564+01	2023-11-02 11:02:43.564+01	2023-11-02 11:02:43.564+01	GP1	AZR
2015	D4s_v3-compute-optimized	AZR-westus	2023-11-02 11:02:43.574+01	0.1381	2023-11-02 11:02:43.574+01	2023-11-02 11:02:43.574+01	2023-11-02 11:02:43.574+01	CO1	AZR
2016	D4s_v3-compute-optimized	AZR-southindia	2023-11-02 11:02:43.598+01	0.1571	2023-11-02 11:02:43.598+01	2023-11-02 11:02:43.598+01	2023-11-02 11:02:43.598+01	CO1	AZR
2190	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-03 10:43:37.415+01	0.1530	2023-11-03 10:43:37.415+01	2023-11-03 10:43:37.415+01	2023-11-03 10:43:37.415+01	CO1	AZR
2191	D4s_v3-compute-optimized	AZR-westus	2023-11-03 10:43:37.421+01	0.1381	2023-11-03 10:43:37.421+01	2023-11-03 10:43:37.421+01	2023-11-03 10:43:37.421+01	CO1	AZR
2192	D4s_v3-compute-optimized	AZR-eastus	2023-11-03 10:43:37.423+01	0.1231	2023-11-03 10:43:37.423+01	2023-11-03 10:43:37.423+01	2023-11-03 10:43:37.423+01	CO1	AZR
2193	D4s_v3-compute-optimized	AZR-southindia	2023-11-03 10:43:37.441+01	0.1571	2023-11-03 10:43:37.441+01	2023-11-03 10:43:37.441+01	2023-11-03 10:43:37.441+01	CO1	AZR
3245	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-06 01:00:00+01	0.0250	2023-11-06 14:38:44.663+01	2023-11-06 13:15:15.906+01	2023-11-06 14:38:44.667+01	CO1	ALB
3246	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-05 01:00:00+01	0.0350	2023-11-06 14:38:44.904+01	2023-11-06 13:15:16.076+01	2023-11-06 14:38:44.908+01	CO1	ALB
3247	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-06 01:00:00+01	0.0350	2023-11-06 14:38:44.904+01	2023-11-06 13:15:16.077+01	2023-11-06 14:38:44.912+01	CO1	ALB
3248	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-05 01:00:00+01	0.0460	2023-11-06 14:38:46.07+01	2023-11-06 13:15:16.966+01	2023-11-06 14:38:46.072+01	CO1	ALB
3249	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-06 01:00:00+01	0.0460	2023-11-06 14:38:46.07+01	2023-11-06 13:15:16.971+01	2023-11-06 14:38:46.075+01	CO1	ALB
3250	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-05 01:00:00+01	0.0325	2023-11-06 14:38:47.428+01	2023-11-06 13:15:18.322+01	2023-11-06 14:38:47.431+01	CO1	ALB
3251	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-06 01:00:00+01	0.0325	2023-11-06 14:38:47.428+01	2023-11-06 13:15:18.326+01	2023-11-06 14:38:47.436+01	CO1	ALB
3252	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-05 01:00:00+01	0.0250	2023-11-06 14:38:48.066+01	2023-11-06 13:15:19.626+01	2023-11-06 14:38:48.068+01	CO1	ALB
3253	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-06 01:00:00+01	0.0250	2023-11-06 14:38:48.066+01	2023-11-06 13:15:19.629+01	2023-11-06 14:38:48.071+01	CO1	ALB
3235	D4s_v3-compute-optimized	AZR-eastus	2023-11-06 00:00:00+01	0.1231	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.399+01	CO1	AZR
3360	C2D AMD Instance Core running in Doha	GCP-me-central1	2023-11-07 00:00:00+01	0.3592	2023-11-07 21:03:14.776+01	2023-11-07 21:03:14.776+01	2023-11-07 21:03:14.776+01	unknown-grouping	GCP
3361	C2D AMD Instance Core running in Los Angeles	GCP-us-west2	2023-11-07 00:00:00+01	0.3554	2023-11-07 21:03:14.78+01	2023-11-07 21:03:14.78+01	2023-11-07 21:03:14.78+01	unknown-grouping	GCP
3362	C2D AMD Instance Core running in Mumbai	GCP-asia-south1	2023-11-07 00:00:00+01	0.1951	2023-11-07 21:03:14.782+01	2023-11-07 21:03:14.782+01	2023-11-07 21:03:14.782+01	unknown-grouping	GCP
3573	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-12 00:00:00+01	0.2810	2023-11-12 11:15:24.521+01	2023-11-12 11:15:24.521+01	2023-11-12 11:15:24.521+01	GP1	GCP
3495	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-09 00:00:00+01	0.0726	2023-11-10 14:29:00.094+01	2023-11-10 14:13:28.432+01	2023-11-10 14:29:00.098+01	CO1	AWS
3574	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-12 00:00:00+01	0.3809	2023-11-12 11:15:24.522+01	2023-11-12 11:15:24.522+01	2023-11-12 11:15:24.522+01	CO1	GCP
3500	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-09 00:00:00+01	0.0837	2023-11-10 14:29:00.516+01	2023-11-10 14:13:28.664+01	2023-11-10 14:29:00.524+01	CO1	AWS
3493	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-10 00:00:00+01	0.0728	2023-11-11 22:40:59.194+01	2023-11-10 14:13:28.426+01	2023-11-11 22:40:59.197+01	CO1	AWS
3502	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-09 00:00:00+01	0.0524	2023-11-10 14:29:00.701+01	2023-11-10 14:13:28.759+01	2023-11-10 14:29:00.707+01	GP1	AWS
3498	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-10 00:00:00+01	0.0829	2023-11-11 22:40:59.284+01	2023-11-10 14:13:28.661+01	2023-11-11 22:40:59.286+01	CO1	AWS
3504	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-09 00:00:00+01	0.0834	2023-11-10 14:29:00.712+01	2023-11-10 14:13:28.791+01	2023-11-10 14:29:00.719+01	CO1	AWS
3556	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-12 01:00:00+01	0.0250	2023-11-12 11:14:53.647+01	2023-11-12 11:14:53.658+01	2023-11-12 11:14:53.658+01	GP1	ALB
3506	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-09 00:00:00+01	0.0720	2023-11-10 14:29:00.783+01	2023-11-10 14:13:28.92+01	2023-11-10 14:29:00.785+01	CO1	AWS
3503	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-10 00:00:00+01	0.0833	2023-11-11 22:40:58.744+01	2023-11-10 14:13:28.787+01	2023-11-11 22:40:58.749+01	CO1	AWS
3501	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-10 00:00:00+01	0.0529	2023-11-11 22:40:58.745+01	2023-11-10 14:13:28.756+01	2023-11-11 22:40:58.75+01	GP1	AWS
3507	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-10 00:00:00+01	0.0317	2023-11-11 22:40:59.086+01	2023-11-10 14:13:28.939+01	2023-11-11 22:40:59.09+01	GP1	AWS
3508	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-09 00:00:00+01	0.0280	2023-11-11 22:40:59.086+01	2023-11-10 14:13:28.941+01	2023-11-11 22:40:59.091+01	GP1	AWS
3505	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-10 00:00:00+01	0.0705	2023-11-11 22:40:59.1+01	2023-11-10 14:13:28.918+01	2023-11-11 22:40:59.102+01	CO1	AWS
3559	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-12 01:00:00+01	0.0380	2023-11-12 11:14:56.408+01	2023-11-12 11:14:56.418+01	2023-11-12 11:14:56.418+01	GP1	ALB
3560	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-12 01:00:00+01	0.0250	2023-11-12 11:15:04.847+01	2023-11-12 11:15:04.857+01	2023-11-12 11:15:04.857+01	CO1	ALB
3558	B4ms-general-purpose	AZR-westus	2023-11-12 00:00:00+01	0.2405	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:12.133+01	GP1	AZR
3554	D4s_v3-compute-optimized	AZR-southindia	2023-11-12 00:00:00+01	0.1571	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:13.153+01	CO1	AZR
3557	D4s_v3-compute-optimized	AZR-westus	2023-11-12 00:00:00+01	0.1381	2023-11-12 00:00:00+01	2023-11-12 00:00:00+01	2023-11-12 11:15:13.304+01	CO1	AZR
3568	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-12 00:00:00+01	0.0318	2023-11-12 11:15:17.224+01	2023-11-12 11:15:17.225+01	2023-11-12 11:15:17.225+01	GP1	AWS
3569	e2-standard-4-general-purpose	GCP-us-west2	2023-11-12 00:00:00+01	0.2620	2023-11-12 11:15:24.511+01	2023-11-12 11:15:24.512+01	2023-11-12 11:15:24.512+01	GP1	GCP
3570	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-12 00:00:00+01	0.3554	2023-11-12 11:15:24.514+01	2023-11-12 11:15:24.514+01	2023-11-12 11:15:24.514+01	CO1	GCP
3571	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-12 00:00:00+01	0.1951	2023-11-12 11:15:24.517+01	2023-11-12 11:15:24.518+01	2023-11-12 11:15:24.518+01	CO1	GCP
3572	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-12 00:00:00+01	0.2399	2023-11-12 11:15:24.519+01	2023-11-12 11:15:24.519+01	2023-11-12 11:15:24.519+01	GP1	GCP
3575	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-12 00:00:00+01	0.3330	2023-11-12 11:15:24.525+01	2023-11-12 11:15:24.525+01	2023-11-12 11:15:24.525+01	CO1	GCP
3576	e2-standard-4-general-purpose	GCP-us-east4	2023-11-12 00:00:00+01	0.2457	2023-11-12 11:15:24.526+01	2023-11-12 11:15:24.526+01	2023-11-12 11:15:24.526+01	GP1	GCP
3577	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-12 00:00:00+01	0.3252	2023-11-12 11:15:24.527+01	2023-11-12 11:15:24.527+01	2023-11-12 11:15:24.527+01	CO1	GCP
3578	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-12 00:00:00+01	0.2620	2023-11-12 11:15:24.528+01	2023-11-12 11:15:24.528+01	2023-11-12 11:15:24.528+01	GP1	GCP
3580	B4ms-general-purpose	AZR-polandcentral	2023-11-13 22:00:00+01	0.2498	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:00.518+01	GP1	AZR
3581	B4ms-general-purpose	AZR-eastus	2023-11-13 22:00:00+01	0.1965	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:00.571+01	GP1	AZR
3586	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-13 22:00:00+01	0.1585	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:01.481+01	CO1	AZR
1897	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-01 01:00:00+01	0.0250	2023-11-01 17:29:15.825+01	2023-11-01 17:29:15.826+01	2023-11-01 17:29:15.826+01	GP1	ALB
1898	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-01 01:00:00+01	0.0380	2023-11-01 17:29:15.965+01	2023-11-01 17:29:15.965+01	2023-11-01 17:29:15.965+01	GP1	ALB
1899	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-01 01:00:00+01	0.0370	2023-11-01 17:29:17.604+01	2023-11-01 17:29:17.604+01	2023-11-01 17:29:17.604+01	GP1	ALB
2017	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-03 02:00:00+02	0.0390	2023-11-02 16:41:11.122+01	2023-11-02 16:41:11.123+01	2023-11-02 16:41:11.123+01	GP1	ALB
2018	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-04 02:00:00+02	0.0390	2023-11-02 16:41:11.135+01	2023-11-02 16:41:11.135+01	2023-11-02 16:41:11.135+01	GP1	ALB
2019	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-05 02:00:00+02	0.0390	2023-11-02 16:41:11.137+01	2023-11-02 16:41:11.137+01	2023-11-02 16:41:11.137+01	GP1	ALB
2020	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-06 02:00:00+02	0.0390	2023-11-02 16:41:11.139+01	2023-11-02 16:41:11.14+01	2023-11-02 16:41:11.14+01	GP1	ALB
2021	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-07 02:00:00+02	0.0390	2023-11-02 16:41:11.143+01	2023-11-02 16:41:11.143+01	2023-11-02 16:41:11.143+01	GP1	ALB
2022	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-08 02:00:00+02	0.0390	2023-11-02 16:41:11.146+01	2023-11-02 16:41:11.146+01	2023-11-02 16:41:11.146+01	GP1	ALB
2023	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-09 02:00:00+02	0.0390	2023-11-02 16:41:11.148+01	2023-11-02 16:41:11.149+01	2023-11-02 16:41:11.149+01	GP1	ALB
2024	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-10 02:00:00+02	0.0390	2023-11-02 16:41:11.151+01	2023-11-02 16:41:11.152+01	2023-11-02 16:41:11.152+01	GP1	ALB
2025	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-11 02:00:00+02	0.0390	2023-11-02 16:41:11.153+01	2023-11-02 16:41:11.154+01	2023-11-02 16:41:11.154+01	GP1	ALB
2026	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-12 02:00:00+02	0.0390	2023-11-02 16:41:11.157+01	2023-11-02 16:41:11.157+01	2023-11-02 16:41:11.157+01	GP1	ALB
2027	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-13 02:00:00+02	0.0390	2023-11-02 16:41:11.16+01	2023-11-02 16:41:11.16+01	2023-11-02 16:41:11.16+01	GP1	ALB
2028	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-14 02:00:00+02	0.0390	2023-11-02 16:41:11.162+01	2023-11-02 16:41:11.162+01	2023-11-02 16:41:11.162+01	GP1	ALB
2029	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-15 02:00:00+02	0.0390	2023-11-02 16:41:11.163+01	2023-11-02 16:41:11.163+01	2023-11-02 16:41:11.163+01	GP1	ALB
2030	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-16 02:00:00+02	0.0390	2023-11-02 16:41:11.164+01	2023-11-02 16:41:11.164+01	2023-11-02 16:41:11.164+01	GP1	ALB
2031	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-17 02:00:00+02	0.0390	2023-11-02 16:41:11.165+01	2023-11-02 16:41:11.165+01	2023-11-02 16:41:11.165+01	GP1	ALB
2032	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-18 02:00:00+02	0.0390	2023-11-02 16:41:11.167+01	2023-11-02 16:41:11.167+01	2023-11-02 16:41:11.167+01	GP1	ALB
2033	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-19 02:00:00+02	0.0390	2023-11-02 16:41:11.168+01	2023-11-02 16:41:11.168+01	2023-11-02 16:41:11.168+01	GP1	ALB
2034	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-20 02:00:00+02	0.0390	2023-11-02 16:41:11.169+01	2023-11-02 16:41:11.169+01	2023-11-02 16:41:11.169+01	GP1	ALB
2035	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-21 02:00:00+02	0.0390	2023-11-02 16:41:11.17+01	2023-11-02 16:41:11.17+01	2023-11-02 16:41:11.17+01	GP1	ALB
2036	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-22 02:00:00+02	0.0390	2023-11-02 16:41:11.172+01	2023-11-02 16:41:11.173+01	2023-11-02 16:41:11.173+01	GP1	ALB
2037	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-23 02:00:00+02	0.0390	2023-11-02 16:41:11.175+01	2023-11-02 16:41:11.175+01	2023-11-02 16:41:11.175+01	GP1	ALB
2038	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-24 02:00:00+02	0.0390	2023-11-02 16:41:11.176+01	2023-11-02 16:41:11.176+01	2023-11-02 16:41:11.176+01	GP1	ALB
2039	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-25 02:00:00+02	0.0390	2023-11-02 16:41:11.177+01	2023-11-02 16:41:11.177+01	2023-11-02 16:41:11.177+01	GP1	ALB
2040	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-26 02:00:00+02	0.0390	2023-11-02 16:41:11.202+01	2023-11-02 16:41:11.202+01	2023-11-02 16:41:11.202+01	GP1	ALB
2041	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-27 02:00:00+02	0.0390	2023-11-02 16:41:11.204+01	2023-11-02 16:41:11.204+01	2023-11-02 16:41:11.204+01	GP1	ALB
2042	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-28 02:00:00+02	0.0390	2023-11-02 16:41:11.206+01	2023-11-02 16:41:11.206+01	2023-11-02 16:41:11.206+01	GP1	ALB
2194	e2-standard-4-general-purpose	GCP-near-east	2023-11-03 10:43:59.51+01	0.2620	2023-11-03 10:43:59.51+01	2023-11-03 10:43:59.511+01	2023-11-03 10:43:59.511+01	GP1	GCP
3234	D4s_v3-compute-optimized	AZR-westus	2023-11-06 00:00:00+01	0.1381	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.379+01	CO1	AZR
2199	e2-standard-4-general-purpose	GCP-us-east	2023-11-03 10:44:01.766+01	0.2620	2023-11-03 10:44:01.766+01	2023-11-03 10:44:01.766+01	2023-11-03 10:44:01.766+01	GP1	GCP
3499	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-09 00:00:00+01	0.0739	2023-11-10 14:29:00.55+01	2023-11-10 14:13:28.663+01	2023-11-10 14:29:00.557+01	GP1	AWS
3494	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-10 00:00:00+01	0.0670	2023-11-11 22:40:59.17+01	2023-11-10 14:13:28.428+01	2023-11-11 22:40:59.174+01	GP1	AWS
3497	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-10 00:00:00+01	0.0736	2023-11-11 22:40:59.304+01	2023-11-10 14:13:28.658+01	2023-11-11 22:40:59.307+01	GP1	AWS
2204	e2-standard-4-general-purpose	GCP-europe-central	2023-11-03 10:44:03.648+01	0.2620	2023-11-03 10:44:03.648+01	2023-11-03 10:44:03.648+01	2023-11-03 10:44:03.648+01	GP1	GCP
2209	e2-standard-4-general-purpose	GCP-asia-india	2023-11-03 10:44:06.248+01	0.2620	2023-11-03 10:44:06.248+01	2023-11-03 10:44:06.248+01	2023-11-03 10:44:06.248+01	GP1	GCP
3363	E2	GCP-us-west2	2023-11-07 00:00:00+01	0.2620	2023-11-07 23:32:26.749+01	2023-11-07 21:06:10.224+01	2023-11-07 23:32:26.75+01	unknown-grouping	GCP
3364	C2D	GCP-me-central1	2023-11-07 00:00:00+01	0.3592	2023-11-07 23:32:26.756+01	2023-11-07 21:06:10.23+01	2023-11-07 23:32:26.756+01	unknown-grouping	GCP
2214	e2-standard-4-general-purpose	GCP-us-west	2023-11-03 10:44:09.388+01	0.2620	2023-11-03 10:44:09.388+01	2023-11-03 10:44:09.389+01	2023-11-03 10:44:09.389+01	GP1	GCP
3365	C2D	GCP-us-west2	2023-11-07 00:00:00+01	0.3554	2023-11-07 23:32:26.758+01	2023-11-07 21:06:10.233+01	2023-11-07 23:32:26.758+01	unknown-grouping	GCP
3366	C2D	GCP-asia-south1	2023-11-07 00:00:00+01	0.1951	2023-11-07 23:32:26.764+01	2023-11-07 21:06:10.236+01	2023-11-07 23:32:26.764+01	unknown-grouping	GCP
3367	C2D	GCP-europe-west3	2023-11-07 00:00:00+01	0.5100	2023-11-07 23:32:26.766+01	2023-11-07 21:06:10.238+01	2023-11-07 23:32:26.766+01	unknown-grouping	GCP
2219	c2-standard-4-compute-optimized	GCP-near-east	2023-11-03 10:44:11.989+01	0.2620	2023-11-03 10:44:11.989+01	2023-11-03 10:44:11.99+01	2023-11-03 10:44:11.99+01	CO1	GCP
3589	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-13 01:00:00+01	0.0250	2023-11-14 07:24:44.206+01	2023-11-14 07:24:44.208+01	2023-11-14 07:24:44.208+01	GP1	ALB
2224	c2-standard-4-compute-optimized	GCP-us-east	2023-11-03 10:44:14.33+01	0.2620	2023-11-03 10:44:14.33+01	2023-11-03 10:44:14.33+01	2023-11-03 10:44:14.33+01	CO1	GCP
3496	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-09 00:00:00+01	0.0664	2023-11-10 14:29:00.095+01	2023-11-10 14:13:28.434+01	2023-11-10 14:29:00.098+01	GP1	AWS
3561	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-12 00:00:00+01	0.0838	2023-11-12 11:15:16.117+01	2023-11-12 11:15:16.119+01	2023-11-12 11:15:16.119+01	CO1	AWS
3562	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-12 00:00:00+01	0.0541	2023-11-12 11:15:16.289+01	2023-11-12 11:15:16.291+01	2023-11-12 11:15:16.291+01	GP1	AWS
3531	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-11 00:00:00+01	0.0528	2023-11-12 11:15:16.289+01	2023-11-11 22:40:58.748+01	2023-11-12 11:15:16.292+01	GP1	AWS
3563	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-12 00:00:00+01	0.0842	2023-11-12 11:15:16.448+01	2023-11-12 11:15:16.45+01	2023-11-12 11:15:16.45+01	CO1	AWS
3564	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-12 00:00:00+01	0.0723	2023-11-12 11:15:16.475+01	2023-11-12 11:15:16.476+01	2023-11-12 11:15:16.476+01	GP1	AWS
3565	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-12 00:00:00+01	0.0677	2023-11-12 11:15:16.581+01	2023-11-12 11:15:16.582+01	2023-11-12 11:15:16.582+01	GP1	AWS
3566	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-12 00:00:00+01	0.0750	2023-11-12 11:15:16.751+01	2023-11-12 11:15:16.753+01	2023-11-12 11:15:16.753+01	CO1	AWS
3567	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-12 00:00:00+01	0.0658	2023-11-12 11:15:17.224+01	2023-11-12 11:15:17.225+01	2023-11-12 11:15:17.225+01	CO1	AWS
3591	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-13 01:00:00+01	0.0380	2023-11-14 07:24:46.193+01	2023-11-14 07:24:46.195+01	2023-11-14 07:24:46.195+01	GP1	ALB
3593	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-13 01:00:00+01	0.0390	2023-11-14 07:24:48.767+01	2023-11-14 07:24:48.769+01	2023-11-14 07:24:48.769+01	GP1	ALB
3595	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-13 01:00:00+01	0.0370	2023-11-14 07:24:54.212+01	2023-11-14 07:24:54.214+01	2023-11-14 07:24:54.214+01	GP1	ALB
3590	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-14 01:00:00+01	0.0250	2023-11-15 16:07:29.565+01	2023-11-14 07:24:44.21+01	2023-11-15 16:07:29.567+01	GP1	ALB
3592	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-14 01:00:00+01	0.0380	2023-11-15 16:07:31.462+01	2023-11-14 07:24:46.196+01	2023-11-15 16:07:31.468+01	GP1	ALB
3594	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-14 01:00:00+01	0.0390	2023-11-15 16:07:33.337+01	2023-11-14 07:24:48.772+01	2023-11-15 16:07:33.339+01	GP1	ALB
3596	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-14 01:00:00+01	0.0370	2023-11-15 16:07:38.128+01	2023-11-14 07:24:54.217+01	2023-11-15 16:07:38.13+01	GP1	ALB
1900	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-02 02:00:00+02	0.0400	2023-11-01 17:36:35.907+01	2023-11-01 17:36:35.907+01	2023-11-01 17:36:35.907+01	GP1	ALB
1901	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-03 02:00:00+02	0.0400	2023-11-01 17:36:35.912+01	2023-11-01 17:36:35.912+01	2023-11-01 17:36:35.912+01	GP1	ALB
1902	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-04 02:00:00+02	0.0400	2023-11-01 17:36:35.914+01	2023-11-01 17:36:35.914+01	2023-11-01 17:36:35.914+01	GP1	ALB
1903	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-05 02:00:00+02	0.0400	2023-11-01 17:36:35.916+01	2023-11-01 17:36:35.916+01	2023-11-01 17:36:35.916+01	GP1	ALB
1904	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-06 02:00:00+02	0.0400	2023-11-01 17:36:35.918+01	2023-11-01 17:36:35.918+01	2023-11-01 17:36:35.918+01	GP1	ALB
1905	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-07 02:00:00+02	0.0400	2023-11-01 17:36:35.921+01	2023-11-01 17:36:35.921+01	2023-11-01 17:36:35.921+01	GP1	ALB
1906	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-08 02:00:00+02	0.0400	2023-11-01 17:36:35.923+01	2023-11-01 17:36:35.923+01	2023-11-01 17:36:35.923+01	GP1	ALB
1907	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-09 02:00:00+02	0.0400	2023-11-01 17:36:35.925+01	2023-11-01 17:36:35.925+01	2023-11-01 17:36:35.925+01	GP1	ALB
1908	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-10 02:00:00+02	0.0400	2023-11-01 17:36:35.926+01	2023-11-01 17:36:35.926+01	2023-11-01 17:36:35.926+01	GP1	ALB
1909	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-11 02:00:00+02	0.0400	2023-11-01 17:36:35.927+01	2023-11-01 17:36:35.927+01	2023-11-01 17:36:35.927+01	GP1	ALB
1910	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-12 02:00:00+02	0.0400	2023-11-01 17:36:35.928+01	2023-11-01 17:36:35.928+01	2023-11-01 17:36:35.928+01	GP1	ALB
1911	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-13 02:00:00+02	0.0400	2023-11-01 17:36:35.929+01	2023-11-01 17:36:35.929+01	2023-11-01 17:36:35.929+01	GP1	ALB
1912	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-14 02:00:00+02	0.0433	2023-11-01 17:36:35.931+01	2023-11-01 17:36:35.931+01	2023-11-01 17:36:35.931+01	GP1	ALB
1913	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-15 02:00:00+02	0.0460	2023-11-01 17:36:35.932+01	2023-11-01 17:36:35.932+01	2023-11-01 17:36:35.932+01	GP1	ALB
1914	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-16 02:00:00+02	0.0460	2023-11-01 17:36:35.933+01	2023-11-01 17:36:35.933+01	2023-11-01 17:36:35.933+01	GP1	ALB
1915	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-17 02:00:00+02	0.0460	2023-11-01 17:36:35.935+01	2023-11-01 17:36:35.935+01	2023-11-01 17:36:35.935+01	GP1	ALB
1916	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-18 02:00:00+02	0.0460	2023-11-01 17:36:35.937+01	2023-11-01 17:36:35.937+01	2023-11-01 17:36:35.937+01	GP1	ALB
1917	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-19 02:00:00+02	0.0460	2023-11-01 17:36:35.938+01	2023-11-01 17:36:35.938+01	2023-11-01 17:36:35.938+01	GP1	ALB
1918	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-20 02:00:00+02	0.0460	2023-11-01 17:36:35.94+01	2023-11-01 17:36:35.94+01	2023-11-01 17:36:35.94+01	GP1	ALB
1919	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-21 02:00:00+02	0.0460	2023-11-01 17:36:35.941+01	2023-11-01 17:36:35.941+01	2023-11-01 17:36:35.941+01	GP1	ALB
1920	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-22 02:00:00+02	0.0460	2023-11-01 17:36:35.942+01	2023-11-01 17:36:35.942+01	2023-11-01 17:36:35.942+01	GP1	ALB
1921	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-23 02:00:00+02	0.0460	2023-11-01 17:36:35.943+01	2023-11-01 17:36:35.943+01	2023-11-01 17:36:35.943+01	GP1	ALB
1922	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-24 02:00:00+02	0.0460	2023-11-01 17:36:35.944+01	2023-11-01 17:36:35.944+01	2023-11-01 17:36:35.944+01	GP1	ALB
1923	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-25 02:00:00+02	0.0460	2023-11-01 17:36:35.945+01	2023-11-01 17:36:35.945+01	2023-11-01 17:36:35.945+01	GP1	ALB
1924	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-26 02:00:00+02	0.0460	2023-11-01 17:36:35.946+01	2023-11-01 17:36:35.946+01	2023-11-01 17:36:35.946+01	GP1	ALB
1925	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-27 02:00:00+02	0.0460	2023-11-01 17:36:35.947+01	2023-11-01 17:36:35.947+01	2023-11-01 17:36:35.947+01	GP1	ALB
1926	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-02 02:00:00+02	0.0250	2023-11-01 17:36:36.564+01	2023-11-01 17:36:36.564+01	2023-11-01 17:36:36.564+01	GP1	ALB
1927	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-03 02:00:00+02	0.0250	2023-11-01 17:36:36.566+01	2023-11-01 17:36:36.566+01	2023-11-01 17:36:36.566+01	GP1	ALB
1928	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-04 02:00:00+02	0.0250	2023-11-01 17:36:36.623+01	2023-11-01 17:36:36.623+01	2023-11-01 17:36:36.623+01	GP1	ALB
1930	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-05 02:00:00+02	0.0250	2023-11-01 17:36:36.626+01	2023-11-01 17:36:36.626+01	2023-11-01 17:36:36.626+01	GP1	ALB
1931	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-06 02:00:00+02	0.0250	2023-11-01 17:36:36.63+01	2023-11-01 17:36:36.63+01	2023-11-01 17:36:36.63+01	GP1	ALB
1933	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-07 02:00:00+02	0.0250	2023-11-01 17:36:36.633+01	2023-11-01 17:36:36.633+01	2023-11-01 17:36:36.633+01	GP1	ALB
1935	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-08 02:00:00+02	0.0250	2023-11-01 17:36:36.636+01	2023-11-01 17:36:36.636+01	2023-11-01 17:36:36.636+01	GP1	ALB
1937	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-09 02:00:00+02	0.0250	2023-11-01 17:36:36.638+01	2023-11-01 17:36:36.638+01	2023-11-01 17:36:36.638+01	GP1	ALB
1939	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-10 02:00:00+02	0.0250	2023-11-01 17:36:36.639+01	2023-11-01 17:36:36.639+01	2023-11-01 17:36:36.639+01	GP1	ALB
1941	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-11 02:00:00+02	0.0250	2023-11-01 17:36:36.64+01	2023-11-01 17:36:36.64+01	2023-11-01 17:36:36.64+01	GP1	ALB
1943	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-12 02:00:00+02	0.0250	2023-11-01 17:36:36.641+01	2023-11-01 17:36:36.641+01	2023-11-01 17:36:36.641+01	GP1	ALB
1945	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-13 02:00:00+02	0.0250	2023-11-01 17:36:36.642+01	2023-11-01 17:36:36.642+01	2023-11-01 17:36:36.642+01	GP1	ALB
1947	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-14 02:00:00+02	0.0250	2023-11-01 17:36:36.644+01	2023-11-01 17:36:36.644+01	2023-11-01 17:36:36.644+01	GP1	ALB
1949	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-15 02:00:00+02	0.0250	2023-11-01 17:36:36.646+01	2023-11-01 17:36:36.646+01	2023-11-01 17:36:36.646+01	GP1	ALB
1951	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-16 02:00:00+02	0.0250	2023-11-01 17:36:36.647+01	2023-11-01 17:36:36.647+01	2023-11-01 17:36:36.647+01	GP1	ALB
1953	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-17 02:00:00+02	0.0250	2023-11-01 17:36:36.648+01	2023-11-01 17:36:36.648+01	2023-11-01 17:36:36.648+01	GP1	ALB
1955	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-18 02:00:00+02	0.0250	2023-11-01 17:36:36.649+01	2023-11-01 17:36:36.649+01	2023-11-01 17:36:36.649+01	GP1	ALB
1957	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-19 02:00:00+02	0.0250	2023-11-01 17:36:36.651+01	2023-11-01 17:36:36.651+01	2023-11-01 17:36:36.651+01	GP1	ALB
1959	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-20 02:00:00+02	0.0250	2023-11-01 17:36:36.652+01	2023-11-01 17:36:36.652+01	2023-11-01 17:36:36.652+01	GP1	ALB
1961	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-21 02:00:00+02	0.0250	2023-11-01 17:36:36.654+01	2023-11-01 17:36:36.654+01	2023-11-01 17:36:36.654+01	GP1	ALB
1963	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-22 02:00:00+02	0.0250	2023-11-01 17:36:36.655+01	2023-11-01 17:36:36.655+01	2023-11-01 17:36:36.655+01	GP1	ALB
1965	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-23 02:00:00+02	0.0250	2023-11-01 17:36:36.656+01	2023-11-01 17:36:36.656+01	2023-11-01 17:36:36.656+01	GP1	ALB
1967	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-24 02:00:00+02	0.0250	2023-11-01 17:36:36.657+01	2023-11-01 17:36:36.657+01	2023-11-01 17:36:36.657+01	GP1	ALB
1969	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-25 02:00:00+02	0.0250	2023-11-01 17:36:36.66+01	2023-11-01 17:36:36.66+01	2023-11-01 17:36:36.66+01	GP1	ALB
1971	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-26 02:00:00+02	0.0250	2023-11-01 17:36:36.661+01	2023-11-01 17:36:36.661+01	2023-11-01 17:36:36.661+01	GP1	ALB
1973	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-27 02:00:00+02	0.0250	2023-11-01 17:36:36.662+01	2023-11-01 17:36:36.662+01	2023-11-01 17:36:36.662+01	GP1	ALB
2043	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-29 02:00:00+02	0.0460	2023-11-03 10:40:07.128+01	2023-11-03 10:40:07.129+01	2023-11-03 10:40:07.129+01	GP1	ALB
2044	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-04 02:00:00+02	0.0350	2023-11-03 10:40:07.315+01	2023-11-03 10:40:07.315+01	2023-11-03 10:40:07.315+01	CO1	ALB
2045	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-05 02:00:00+02	0.0350	2023-11-03 10:40:07.321+01	2023-11-03 10:40:07.321+01	2023-11-03 10:40:07.321+01	CO1	ALB
2046	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-06 02:00:00+02	0.0350	2023-11-03 10:40:07.324+01	2023-11-03 10:40:07.324+01	2023-11-03 10:40:07.324+01	CO1	ALB
2047	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-07 02:00:00+02	0.0350	2023-11-03 10:40:07.328+01	2023-11-03 10:40:07.328+01	2023-11-03 10:40:07.328+01	CO1	ALB
2048	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-08 02:00:00+02	0.0350	2023-11-03 10:40:07.332+01	2023-11-03 10:40:07.332+01	2023-11-03 10:40:07.332+01	CO1	ALB
2049	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-09 02:00:00+02	0.0350	2023-11-03 10:40:07.337+01	2023-11-03 10:40:07.337+01	2023-11-03 10:40:07.337+01	CO1	ALB
2050	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-10 02:00:00+02	0.0350	2023-11-03 10:40:07.343+01	2023-11-03 10:40:07.343+01	2023-11-03 10:40:07.343+01	CO1	ALB
2051	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-11 02:00:00+02	0.0350	2023-11-03 10:40:07.346+01	2023-11-03 10:40:07.346+01	2023-11-03 10:40:07.346+01	CO1	ALB
2052	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-12 02:00:00+02	0.0350	2023-11-03 10:40:07.35+01	2023-11-03 10:40:07.35+01	2023-11-03 10:40:07.35+01	CO1	ALB
1929	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-02 02:00:00+02	0.0370	2023-11-01 17:36:36.625+01	2023-11-01 17:36:36.625+01	2023-11-01 17:36:36.625+01	GP1	ALB
1932	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-03 02:00:00+02	0.0370	2023-11-01 17:36:36.63+01	2023-11-01 17:36:36.63+01	2023-11-01 17:36:36.63+01	GP1	ALB
1934	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-04 02:00:00+02	0.0370	2023-11-01 17:36:36.634+01	2023-11-01 17:36:36.634+01	2023-11-01 17:36:36.634+01	GP1	ALB
1936	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-05 02:00:00+02	0.0370	2023-11-01 17:36:36.637+01	2023-11-01 17:36:36.637+01	2023-11-01 17:36:36.637+01	GP1	ALB
1938	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-06 02:00:00+02	0.0370	2023-11-01 17:36:36.638+01	2023-11-01 17:36:36.638+01	2023-11-01 17:36:36.638+01	GP1	ALB
1940	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-07 02:00:00+02	0.0370	2023-11-01 17:36:36.639+01	2023-11-01 17:36:36.639+01	2023-11-01 17:36:36.639+01	GP1	ALB
1942	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-08 02:00:00+02	0.0370	2023-11-01 17:36:36.641+01	2023-11-01 17:36:36.641+01	2023-11-01 17:36:36.641+01	GP1	ALB
1944	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-09 02:00:00+02	0.0370	2023-11-01 17:36:36.642+01	2023-11-01 17:36:36.642+01	2023-11-01 17:36:36.642+01	GP1	ALB
1946	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-10 02:00:00+02	0.0370	2023-11-01 17:36:36.643+01	2023-11-01 17:36:36.643+01	2023-11-01 17:36:36.643+01	GP1	ALB
1948	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-11 02:00:00+02	0.0370	2023-11-01 17:36:36.645+01	2023-11-01 17:36:36.645+01	2023-11-01 17:36:36.645+01	GP1	ALB
1950	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-12 02:00:00+02	0.0370	2023-11-01 17:36:36.646+01	2023-11-01 17:36:36.646+01	2023-11-01 17:36:36.646+01	GP1	ALB
1952	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-13 02:00:00+02	0.0370	2023-11-01 17:36:36.647+01	2023-11-01 17:36:36.647+01	2023-11-01 17:36:36.647+01	GP1	ALB
1954	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-14 02:00:00+02	0.0370	2023-11-01 17:36:36.648+01	2023-11-01 17:36:36.649+01	2023-11-01 17:36:36.649+01	GP1	ALB
1956	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-15 02:00:00+02	0.0370	2023-11-01 17:36:36.65+01	2023-11-01 17:36:36.65+01	2023-11-01 17:36:36.65+01	GP1	ALB
1958	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-16 02:00:00+02	0.0370	2023-11-01 17:36:36.651+01	2023-11-01 17:36:36.651+01	2023-11-01 17:36:36.651+01	GP1	ALB
1960	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-17 02:00:00+02	0.0370	2023-11-01 17:36:36.653+01	2023-11-01 17:36:36.653+01	2023-11-01 17:36:36.653+01	GP1	ALB
1962	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-18 02:00:00+02	0.0453	2023-11-01 17:36:36.654+01	2023-11-01 17:36:36.654+01	2023-11-01 17:36:36.654+01	GP1	ALB
1964	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-19 02:00:00+02	0.0530	2023-11-01 17:36:36.655+01	2023-11-01 17:36:36.655+01	2023-11-01 17:36:36.655+01	GP1	ALB
1966	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-20 02:00:00+02	0.0530	2023-11-01 17:36:36.656+01	2023-11-01 17:36:36.656+01	2023-11-01 17:36:36.656+01	GP1	ALB
1968	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-21 02:00:00+02	0.0530	2023-11-01 17:36:36.657+01	2023-11-01 17:36:36.657+01	2023-11-01 17:36:36.657+01	GP1	ALB
1970	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-22 02:00:00+02	0.0530	2023-11-01 17:36:36.66+01	2023-11-01 17:36:36.66+01	2023-11-01 17:36:36.66+01	GP1	ALB
1972	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-23 02:00:00+02	0.0530	2023-11-01 17:36:36.662+01	2023-11-01 17:36:36.662+01	2023-11-01 17:36:36.662+01	GP1	ALB
1974	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-24 02:00:00+02	0.0530	2023-11-01 17:36:36.663+01	2023-11-01 17:36:36.663+01	2023-11-01 17:36:36.663+01	GP1	ALB
1975	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-25 02:00:00+02	0.0530	2023-11-01 17:36:36.664+01	2023-11-01 17:36:36.664+01	2023-11-01 17:36:36.664+01	GP1	ALB
1976	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-26 02:00:00+02	0.0530	2023-11-01 17:36:36.665+01	2023-11-01 17:36:36.665+01	2023-11-01 17:36:36.665+01	GP1	ALB
1977	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-27 02:00:00+02	0.0465	2023-11-01 17:36:36.666+01	2023-11-01 17:36:36.666+01	2023-11-01 17:36:36.666+01	GP1	ALB
2054	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-14 02:00:00+02	0.0350	2023-11-03 10:40:07.354+01	2023-11-03 10:40:07.354+01	2023-11-03 10:40:07.354+01	CO1	ALB
2055	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-15 02:00:00+02	0.0350	2023-11-03 10:40:07.356+01	2023-11-03 10:40:07.356+01	2023-11-03 10:40:07.356+01	CO1	ALB
2056	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-16 02:00:00+02	0.0350	2023-11-03 10:40:07.357+01	2023-11-03 10:40:07.357+01	2023-11-03 10:40:07.357+01	CO1	ALB
2057	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-17 02:00:00+02	0.0350	2023-11-03 10:40:07.359+01	2023-11-03 10:40:07.359+01	2023-11-03 10:40:07.359+01	CO1	ALB
2058	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-18 02:00:00+02	0.0350	2023-11-03 10:40:07.361+01	2023-11-03 10:40:07.361+01	2023-11-03 10:40:07.361+01	CO1	ALB
2059	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-19 02:00:00+02	0.0350	2023-11-03 10:40:07.363+01	2023-11-03 10:40:07.363+01	2023-11-03 10:40:07.363+01	CO1	ALB
2060	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-20 02:00:00+02	0.0350	2023-11-03 10:40:07.364+01	2023-11-03 10:40:07.364+01	2023-11-03 10:40:07.364+01	CO1	ALB
2061	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-21 02:00:00+02	0.0350	2023-11-03 10:40:07.365+01	2023-11-03 10:40:07.365+01	2023-11-03 10:40:07.365+01	CO1	ALB
2062	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-22 02:00:00+02	0.0350	2023-11-03 10:40:07.366+01	2023-11-03 10:40:07.366+01	2023-11-03 10:40:07.366+01	CO1	ALB
2063	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-23 02:00:00+02	0.0350	2023-11-03 10:40:07.368+01	2023-11-03 10:40:07.368+01	2023-11-03 10:40:07.368+01	CO1	ALB
2064	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-24 02:00:00+02	0.0350	2023-11-03 10:40:07.37+01	2023-11-03 10:40:07.37+01	2023-11-03 10:40:07.37+01	CO1	ALB
2065	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-25 02:00:00+02	0.0350	2023-11-03 10:40:07.372+01	2023-11-03 10:40:07.372+01	2023-11-03 10:40:07.372+01	CO1	ALB
2066	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-26 02:00:00+02	0.0350	2023-11-03 10:40:07.375+01	2023-11-03 10:40:07.375+01	2023-11-03 10:40:07.375+01	CO1	ALB
2067	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-27 02:00:00+02	0.0350	2023-11-03 10:40:07.377+01	2023-11-03 10:40:07.377+01	2023-11-03 10:40:07.377+01	CO1	ALB
2068	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-28 02:00:00+02	0.0350	2023-11-03 10:40:07.378+01	2023-11-03 10:40:07.378+01	2023-11-03 10:40:07.378+01	CO1	ALB
2069	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-10-29 02:00:00+02	0.0350	2023-11-03 10:40:07.379+01	2023-11-03 10:40:07.379+01	2023-11-03 10:40:07.379+01	CO1	ALB
2070	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-04 02:00:00+02	0.0250	2023-11-03 10:40:08.204+01	2023-11-03 10:40:08.204+01	2023-11-03 10:40:08.204+01	CO1	ALB
2071	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-05 02:00:00+02	0.0250	2023-11-03 10:40:08.206+01	2023-11-03 10:40:08.206+01	2023-11-03 10:40:08.206+01	CO1	ALB
2072	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-06 02:00:00+02	0.0250	2023-11-03 10:40:08.209+01	2023-11-03 10:40:08.209+01	2023-11-03 10:40:08.209+01	CO1	ALB
2073	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-07 02:00:00+02	0.0250	2023-11-03 10:40:08.211+01	2023-11-03 10:40:08.211+01	2023-11-03 10:40:08.211+01	CO1	ALB
2074	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-08 02:00:00+02	0.0250	2023-11-03 10:40:08.214+01	2023-11-03 10:40:08.214+01	2023-11-03 10:40:08.214+01	CO1	ALB
2075	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-09 02:00:00+02	0.0250	2023-11-03 10:40:08.216+01	2023-11-03 10:40:08.216+01	2023-11-03 10:40:08.216+01	CO1	ALB
2076	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-10 02:00:00+02	0.0250	2023-11-03 10:40:08.217+01	2023-11-03 10:40:08.217+01	2023-11-03 10:40:08.217+01	CO1	ALB
2077	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-11 02:00:00+02	0.0250	2023-11-03 10:40:08.221+01	2023-11-03 10:40:08.221+01	2023-11-03 10:40:08.221+01	CO1	ALB
2078	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-12 02:00:00+02	0.0250	2023-11-03 10:40:08.223+01	2023-11-03 10:40:08.224+01	2023-11-03 10:40:08.224+01	CO1	ALB
2079	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-13 02:00:00+02	0.0250	2023-11-03 10:40:08.225+01	2023-11-03 10:40:08.226+01	2023-11-03 10:40:08.226+01	CO1	ALB
2080	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-14 02:00:00+02	0.0250	2023-11-03 10:40:08.227+01	2023-11-03 10:40:08.227+01	2023-11-03 10:40:08.227+01	CO1	ALB
2081	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-15 02:00:00+02	0.0250	2023-11-03 10:40:08.228+01	2023-11-03 10:40:08.228+01	2023-11-03 10:40:08.228+01	CO1	ALB
2082	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-16 02:00:00+02	0.0250	2023-11-03 10:40:08.23+01	2023-11-03 10:40:08.23+01	2023-11-03 10:40:08.23+01	CO1	ALB
2083	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-17 02:00:00+02	0.0250	2023-11-03 10:40:08.231+01	2023-11-03 10:40:08.231+01	2023-11-03 10:40:08.231+01	CO1	ALB
2084	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-18 02:00:00+02	0.0250	2023-11-03 10:40:08.232+01	2023-11-03 10:40:08.232+01	2023-11-03 10:40:08.232+01	CO1	ALB
2085	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-19 02:00:00+02	0.0250	2023-11-03 10:40:08.233+01	2023-11-03 10:40:08.233+01	2023-11-03 10:40:08.233+01	CO1	ALB
2086	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-20 02:00:00+02	0.0250	2023-11-03 10:40:08.234+01	2023-11-03 10:40:08.234+01	2023-11-03 10:40:08.234+01	CO1	ALB
2087	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-21 02:00:00+02	0.0250	2023-11-03 10:40:08.235+01	2023-11-03 10:40:08.235+01	2023-11-03 10:40:08.235+01	CO1	ALB
2088	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-22 02:00:00+02	0.0250	2023-11-03 10:40:08.237+01	2023-11-03 10:40:08.237+01	2023-11-03 10:40:08.237+01	CO1	ALB
2089	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-23 02:00:00+02	0.0250	2023-11-03 10:40:08.239+01	2023-11-03 10:40:08.239+01	2023-11-03 10:40:08.239+01	CO1	ALB
2090	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-24 02:00:00+02	0.0250	2023-11-03 10:40:08.24+01	2023-11-03 10:40:08.24+01	2023-11-03 10:40:08.24+01	CO1	ALB
1978	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-01 01:00:00+01	0.0601	2023-11-01 23:24:11.652+01	2023-11-01 23:24:11.653+01	2023-11-01 23:24:11.653+01	GP1	AWS
1979	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-01 01:00:00+01	0.0930	2023-11-01 23:24:11.695+01	2023-11-01 23:24:11.695+01	2023-11-01 23:24:11.695+01	CO1	AWS
1980	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-01 01:00:00+01	0.0301	2023-11-01 23:24:12.225+01	2023-11-01 23:24:12.225+01	2023-11-01 23:24:12.225+01	GP1	AWS
1981	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-01 01:00:00+01	0.0784	2023-11-01 23:24:12.432+01	2023-11-01 23:24:12.432+01	2023-11-01 23:24:12.432+01	CO1	AWS
1982	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-01 01:00:00+01	0.0502	2023-11-01 23:24:12.715+01	2023-11-01 23:24:12.715+01	2023-11-01 23:24:12.715+01	GP1	AWS
1983	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-01 01:00:00+01	0.0859	2023-11-01 23:24:12.937+01	2023-11-01 23:24:12.937+01	2023-11-01 23:24:12.937+01	CO1	AWS
1984	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-01 01:00:00+01	0.0841	2023-11-01 23:24:13.177+01	2023-11-01 23:24:13.177+01	2023-11-01 23:24:13.177+01	CO1	AWS
1985	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-01 01:00:00+01	0.0758	2023-11-01 23:24:13.506+01	2023-11-01 23:24:13.506+01	2023-11-01 23:24:13.506+01	GP1	AWS
2091	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-25 02:00:00+02	0.0250	2023-11-03 10:40:08.241+01	2023-11-03 10:40:08.241+01	2023-11-03 10:40:08.241+01	CO1	ALB
2092	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-26 02:00:00+02	0.0250	2023-11-03 10:40:08.242+01	2023-11-03 10:40:08.242+01	2023-11-03 10:40:08.242+01	CO1	ALB
2093	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-27 02:00:00+02	0.0250	2023-11-03 10:40:08.244+01	2023-11-03 10:40:08.244+01	2023-11-03 10:40:08.244+01	CO1	ALB
2094	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-28 02:00:00+02	0.0250	2023-11-03 10:40:08.245+01	2023-11-03 10:40:08.245+01	2023-11-03 10:40:08.245+01	CO1	ALB
2095	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-10-29 02:00:00+02	0.0250	2023-11-03 10:40:08.246+01	2023-11-03 10:40:08.246+01	2023-11-03 10:40:08.246+01	CO1	ALB
2096	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-04 02:00:00+02	0.0250	2023-11-03 10:40:08.375+01	2023-11-03 10:40:08.375+01	2023-11-03 10:40:08.375+01	CO1	ALB
2097	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-05 02:00:00+02	0.0250	2023-11-03 10:40:08.377+01	2023-11-03 10:40:08.377+01	2023-11-03 10:40:08.377+01	CO1	ALB
2098	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-06 02:00:00+02	0.0250	2023-11-03 10:40:08.379+01	2023-11-03 10:40:08.379+01	2023-11-03 10:40:08.379+01	CO1	ALB
2099	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-07 02:00:00+02	0.0250	2023-11-03 10:40:08.38+01	2023-11-03 10:40:08.38+01	2023-11-03 10:40:08.38+01	CO1	ALB
2100	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-08 02:00:00+02	0.0250	2023-11-03 10:40:08.381+01	2023-11-03 10:40:08.381+01	2023-11-03 10:40:08.381+01	CO1	ALB
2101	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-09 02:00:00+02	0.0250	2023-11-03 10:40:08.382+01	2023-11-03 10:40:08.382+01	2023-11-03 10:40:08.382+01	CO1	ALB
2102	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-10 02:00:00+02	0.0250	2023-11-03 10:40:08.383+01	2023-11-03 10:40:08.383+01	2023-11-03 10:40:08.383+01	CO1	ALB
2103	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-11 02:00:00+02	0.0250	2023-11-03 10:40:08.385+01	2023-11-03 10:40:08.385+01	2023-11-03 10:40:08.385+01	CO1	ALB
2104	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-12 02:00:00+02	0.0250	2023-11-03 10:40:08.386+01	2023-11-03 10:40:08.386+01	2023-11-03 10:40:08.386+01	CO1	ALB
2105	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-13 02:00:00+02	0.0250	2023-11-03 10:40:08.388+01	2023-11-03 10:40:08.388+01	2023-11-03 10:40:08.388+01	CO1	ALB
2106	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-14 02:00:00+02	0.0250	2023-11-03 10:40:08.39+01	2023-11-03 10:40:08.39+01	2023-11-03 10:40:08.39+01	CO1	ALB
2107	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-15 02:00:00+02	0.0250	2023-11-03 10:40:08.391+01	2023-11-03 10:40:08.391+01	2023-11-03 10:40:08.391+01	CO1	ALB
2108	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-16 02:00:00+02	0.0250	2023-11-03 10:40:08.391+01	2023-11-03 10:40:08.391+01	2023-11-03 10:40:08.391+01	CO1	ALB
2109	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-17 02:00:00+02	0.0250	2023-11-03 10:40:08.392+01	2023-11-03 10:40:08.392+01	2023-11-03 10:40:08.392+01	CO1	ALB
2110	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-18 02:00:00+02	0.0250	2023-11-03 10:40:08.393+01	2023-11-03 10:40:08.393+01	2023-11-03 10:40:08.393+01	CO1	ALB
2111	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-19 02:00:00+02	0.0250	2023-11-03 10:40:08.397+01	2023-11-03 10:40:08.397+01	2023-11-03 10:40:08.397+01	CO1	ALB
2112	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-20 02:00:00+02	0.0250	2023-11-03 10:40:08.398+01	2023-11-03 10:40:08.398+01	2023-11-03 10:40:08.398+01	CO1	ALB
2113	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-21 02:00:00+02	0.0250	2023-11-03 10:40:08.399+01	2023-11-03 10:40:08.399+01	2023-11-03 10:40:08.399+01	CO1	ALB
2114	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-22 02:00:00+02	0.0250	2023-11-03 10:40:08.4+01	2023-11-03 10:40:08.4+01	2023-11-03 10:40:08.4+01	CO1	ALB
2115	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-23 02:00:00+02	0.0250	2023-11-03 10:40:08.402+01	2023-11-03 10:40:08.402+01	2023-11-03 10:40:08.402+01	CO1	ALB
2116	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-24 02:00:00+02	0.0250	2023-11-03 10:40:08.404+01	2023-11-03 10:40:08.404+01	2023-11-03 10:40:08.404+01	CO1	ALB
2117	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-25 02:00:00+02	0.0250	2023-11-03 10:40:08.406+01	2023-11-03 10:40:08.406+01	2023-11-03 10:40:08.406+01	CO1	ALB
2118	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-26 02:00:00+02	0.0250	2023-11-03 10:40:08.408+01	2023-11-03 10:40:08.408+01	2023-11-03 10:40:08.408+01	CO1	ALB
2119	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-27 02:00:00+02	0.0250	2023-11-03 10:40:08.41+01	2023-11-03 10:40:08.41+01	2023-11-03 10:40:08.41+01	CO1	ALB
2120	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-28 02:00:00+02	0.0250	2023-11-03 10:40:08.411+01	2023-11-03 10:40:08.411+01	2023-11-03 10:40:08.411+01	CO1	ALB
2121	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-10-29 02:00:00+02	0.0250	2023-11-03 10:40:08.412+01	2023-11-03 10:40:08.412+01	2023-11-03 10:40:08.412+01	CO1	ALB
2122	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-29 02:00:00+02	0.0250	2023-11-03 10:40:08.502+01	2023-11-03 10:40:08.502+01	2023-11-03 10:40:08.502+01	GP1	ALB
2123	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-29 02:00:00+02	0.0370	2023-11-03 10:40:08.566+01	2023-11-03 10:40:08.566+01	2023-11-03 10:40:08.566+01	GP1	ALB
2124	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-10-29 02:00:00+02	0.0390	2023-11-03 10:40:08.944+01	2023-11-03 10:40:08.944+01	2023-11-03 10:40:08.944+01	GP1	ALB
2125	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-04 02:00:00+02	0.0310	2023-11-03 10:40:09.156+01	2023-11-03 10:40:09.157+01	2023-11-03 10:40:09.157+01	CO1	ALB
2126	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-05 02:00:00+02	0.0310	2023-11-03 10:40:09.16+01	2023-11-03 10:40:09.16+01	2023-11-03 10:40:09.16+01	CO1	ALB
2127	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-06 02:00:00+02	0.0310	2023-11-03 10:40:09.166+01	2023-11-03 10:40:09.166+01	2023-11-03 10:40:09.166+01	CO1	ALB
2128	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-07 02:00:00+02	0.0310	2023-11-03 10:40:09.171+01	2023-11-03 10:40:09.171+01	2023-11-03 10:40:09.171+01	CO1	ALB
2129	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-08 02:00:00+02	0.0310	2023-11-03 10:40:09.175+01	2023-11-03 10:40:09.175+01	2023-11-03 10:40:09.175+01	CO1	ALB
2130	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-09 02:00:00+02	0.0310	2023-11-03 10:40:09.195+01	2023-11-03 10:40:09.195+01	2023-11-03 10:40:09.195+01	CO1	ALB
2131	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-10 02:00:00+02	0.0310	2023-11-03 10:40:09.2+01	2023-11-03 10:40:09.2+01	2023-11-03 10:40:09.2+01	CO1	ALB
2132	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-11 02:00:00+02	0.0310	2023-11-03 10:40:09.203+01	2023-11-03 10:40:09.203+01	2023-11-03 10:40:09.203+01	CO1	ALB
2133	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-12 02:00:00+02	0.0310	2023-11-03 10:40:09.205+01	2023-11-03 10:40:09.205+01	2023-11-03 10:40:09.205+01	CO1	ALB
2134	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-13 02:00:00+02	0.0310	2023-11-03 10:40:09.206+01	2023-11-03 10:40:09.206+01	2023-11-03 10:40:09.206+01	CO1	ALB
2135	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-14 02:00:00+02	0.0310	2023-11-03 10:40:09.207+01	2023-11-03 10:40:09.207+01	2023-11-03 10:40:09.207+01	CO1	ALB
2136	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-15 02:00:00+02	0.0310	2023-11-03 10:40:09.208+01	2023-11-03 10:40:09.209+01	2023-11-03 10:40:09.209+01	CO1	ALB
2137	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-16 02:00:00+02	0.0310	2023-11-03 10:40:09.21+01	2023-11-03 10:40:09.21+01	2023-11-03 10:40:09.21+01	CO1	ALB
2138	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-17 02:00:00+02	0.0310	2023-11-03 10:40:09.211+01	2023-11-03 10:40:09.211+01	2023-11-03 10:40:09.211+01	CO1	ALB
2139	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-18 02:00:00+02	0.0334	2023-11-03 10:40:09.212+01	2023-11-03 10:40:09.212+01	2023-11-03 10:40:09.212+01	CO1	ALB
2140	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-19 02:00:00+02	0.0340	2023-11-03 10:40:09.214+01	2023-11-03 10:40:09.215+01	2023-11-03 10:40:09.215+01	CO1	ALB
2141	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-20 02:00:00+02	0.0340	2023-11-03 10:40:09.217+01	2023-11-03 10:40:09.217+01	2023-11-03 10:40:09.217+01	CO1	ALB
2142	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-21 02:00:00+02	0.0340	2023-11-03 10:40:09.219+01	2023-11-03 10:40:09.219+01	2023-11-03 10:40:09.219+01	CO1	ALB
2143	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-22 02:00:00+02	0.0313	2023-11-03 10:40:09.221+01	2023-11-03 10:40:09.221+01	2023-11-03 10:40:09.221+01	CO1	ALB
2144	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-23 02:00:00+02	0.0310	2023-11-03 10:40:09.222+01	2023-11-03 10:40:09.222+01	2023-11-03 10:40:09.222+01	CO1	ALB
1986	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-02 01:00:00+01	0.0609	2023-11-02 09:17:08.488+01	2023-11-02 09:17:08.489+01	2023-11-02 09:17:08.489+01	GP1	AWS
1987	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-02 01:00:00+01	0.0882	2023-11-02 09:17:08.843+01	2023-11-02 09:17:08.843+01	2023-11-02 09:17:08.843+01	CO1	AWS
1988	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-02 01:00:00+01	0.0852	2023-11-02 09:17:09.248+01	2023-11-02 09:17:09.248+01	2023-11-02 09:17:09.248+01	CO1	AWS
1989	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-02 01:00:00+01	0.0761	2023-11-02 09:17:09.278+01	2023-11-02 09:17:09.278+01	2023-11-02 09:17:09.278+01	GP1	AWS
2145	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-24 02:00:00+02	0.0310	2023-11-03 10:40:09.223+01	2023-11-03 10:40:09.223+01	2023-11-03 10:40:09.223+01	CO1	ALB
2146	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-25 02:00:00+02	0.0310	2023-11-03 10:40:09.225+01	2023-11-03 10:40:09.225+01	2023-11-03 10:40:09.225+01	CO1	ALB
2147	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-26 02:00:00+02	0.0319	2023-11-03 10:40:09.226+01	2023-11-03 10:40:09.226+01	2023-11-03 10:40:09.226+01	CO1	ALB
2148	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-27 02:00:00+02	0.0320	2023-11-03 10:40:09.227+01	2023-11-03 10:40:09.227+01	2023-11-03 10:40:09.227+01	CO1	ALB
2149	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-28 02:00:00+02	0.0320	2023-11-03 10:40:09.228+01	2023-11-03 10:40:09.228+01	2023-11-03 10:40:09.228+01	CO1	ALB
2150	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-10-29 02:00:00+02	0.0320	2023-11-03 10:40:09.231+01	2023-11-03 10:40:09.231+01	2023-11-03 10:40:09.231+01	CO1	ALB
2229	c2-standard-4-compute-optimized	GCP-europe-central	2023-11-03 10:44:16.831+01	0.2620	2023-11-03 10:44:16.831+01	2023-11-03 10:44:16.832+01	2023-11-03 10:44:16.832+01	CO1	GCP
2289	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-03 01:00:00+01	0.0370	2023-11-04 13:26:20.999+01	2023-11-03 12:17:55.956+01	2023-11-04 13:26:21.002+01	GP1	ALB
3254	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-06 09:00:00+01	0.0675	2023-11-06 13:55:49.358+01	2023-11-06 13:55:49.359+01	2023-11-06 13:55:49.359+01	GP1	AWS
3255	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-05 09:00:00+01	0.0650	2023-11-06 13:55:49.365+01	2023-11-06 13:55:49.365+01	2023-11-06 13:55:49.365+01	GP1	AWS
2234	c2-standard-4-compute-optimized	GCP-asia-india	2023-11-03 10:44:20.05+01	0.2620	2023-11-03 10:44:20.05+01	2023-11-03 10:44:20.05+01	2023-11-03 10:44:20.05+01	CO1	GCP
3257	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-06 09:00:00+01	0.0733	2023-11-06 13:55:49.39+01	2023-11-06 13:55:49.39+01	2023-11-06 13:55:49.39+01	CO1	AWS
3258	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-05 09:00:00+01	0.0779	2023-11-06 13:55:49.394+01	2023-11-06 13:55:49.394+01	2023-11-06 13:55:49.394+01	CO1	AWS
3509	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-09 01:00:00+01	0.0420	2023-11-10 14:28:54.043+01	2023-11-10 14:28:54.047+01	2023-11-10 14:28:54.047+01	CO1	ALB
2239	c2-standard-4-compute-optimized	GCP-us-west	2023-11-03 10:44:22.521+01	0.2620	2023-11-03 10:44:22.521+01	2023-11-03 10:44:22.522+01	2023-11-03 10:44:22.522+01	CO1	GCP
3263	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-06 09:00:00+01	0.0773	2023-11-06 13:55:50.007+01	2023-11-06 13:55:50.007+01	2023-11-06 13:55:50.007+01	GP1	AWS
3264	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-05 09:00:00+01	0.0750	2023-11-06 13:55:50.009+01	2023-11-06 13:55:50.009+01	2023-11-06 13:55:50.009+01	GP1	AWS
3510	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-10 01:00:00+01	0.0420	2023-11-11 22:40:52.972+01	2023-11-10 14:28:54.052+01	2023-11-11 22:40:52.975+01	CO1	ALB
3368	e2-standard-4-general-purpose	GCP-near-east	2023-11-07 09:00:00+01	0.5100	2023-11-07 23:23:29.186+01	2023-11-07 23:23:29.186+01	2023-11-07 23:35:51.743+01	GP1	GCP
3597	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-13 01:00:00+01	0.0250	2023-11-14 07:24:54.73+01	2023-11-14 07:24:54.732+01	2023-11-14 07:24:54.732+01	CO1	ALB
3373	c2-standard-4-compute-optimized	GCP-near-east	2023-11-07 09:00:00+01	0.5100	2023-11-07 23:23:41.134+01	2023-11-07 23:23:41.134+01	2023-11-07 23:36:04.959+01	CO1	GCP
3267	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-06 09:00:00+01	0.0328	2023-11-06 13:55:50.306+01	2023-11-06 13:55:50.306+01	2023-11-06 13:55:50.306+01	GP1	AWS
2290	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-02 01:00:00+01	0.0250	2023-11-03 12:17:59.674+01	2023-11-03 12:17:59.674+01	2023-11-03 16:26:24.133+01	CO1	ALB
3599	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-13 01:00:00+01	0.0360	2023-11-14 07:24:55.876+01	2023-11-14 07:24:55.877+01	2023-11-14 07:24:55.877+01	CO1	ALB
3601	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-13 01:00:00+01	0.0325	2023-11-14 07:24:57.368+01	2023-11-14 07:24:57.369+01	2023-11-14 07:24:57.369+01	CO1	ALB
3369	e2-standard-4-general-purpose	GCP-us-east	2023-11-07 09:00:00+01	0.5100	2023-11-07 23:23:30.956+01	2023-11-07 23:23:30.956+01	2023-11-07 23:35:54.32+01	GP1	GCP
3374	c2-standard-4-compute-optimized	GCP-us-east	2023-11-07 09:00:00+01	0.5100	2023-11-07 23:23:43.39+01	2023-11-07 23:23:43.39+01	2023-11-07 23:36:06.545+01	CO1	GCP
3603	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-13 01:00:00+01	0.0420	2023-11-14 07:24:58.474+01	2023-11-14 07:24:58.476+01	2023-11-14 07:24:58.476+01	CO1	ALB
3605	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-13 01:00:00+01	0.0250	2023-11-14 07:25:00.032+01	2023-11-14 07:25:00.034+01	2023-11-14 07:25:00.034+01	CO1	ALB
3598	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-14 01:00:00+01	0.0250	2023-11-15 16:07:38.711+01	2023-11-14 07:24:54.736+01	2023-11-15 16:07:38.715+01	CO1	ALB
3600	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-14 01:00:00+01	0.0360	2023-11-15 16:07:39.89+01	2023-11-14 07:24:55.879+01	2023-11-15 16:07:39.892+01	CO1	ALB
3602	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-14 01:00:00+01	0.0325	2023-11-15 16:07:41.064+01	2023-11-14 07:24:57.372+01	2023-11-15 16:07:41.066+01	CO1	ALB
3604	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-14 01:00:00+01	0.0420	2023-11-15 16:07:42.467+01	2023-11-14 07:24:58.479+01	2023-11-15 16:07:42.469+01	CO1	ALB
3606	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-14 01:00:00+01	0.0250	2023-11-15 16:07:43.316+01	2023-11-14 07:25:00.037+01	2023-11-15 16:07:43.317+01	CO1	ALB
3729	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-16 22:00:00+01	0.0711	2023-11-17 21:25:43.974+01	2023-11-17 10:37:34.388+01	2023-11-17 21:25:43.977+01	GP1	AWS
3733	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-16 22:00:00+01	0.0328	2023-11-17 21:25:44.182+01	2023-11-17 10:37:34.574+01	2023-11-17 21:25:44.183+01	GP1	AWS
3734	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-16 22:00:00+01	0.0756	2023-11-17 21:25:44.257+01	2023-11-17 10:37:34.598+01	2023-11-17 21:25:44.26+01	CO1	AWS
3735	e2-standard-4-general-purpose	GCP-us-west2	2023-11-16 22:00:00+01	0.2620	2023-11-17 21:25:51.247+01	2023-11-17 10:37:42.386+01	2023-11-17 21:25:51.247+01	GP1	GCP
3736	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-16 22:00:00+01	0.3554	2023-11-17 21:25:51.249+01	2023-11-17 10:37:42.393+01	2023-11-17 21:25:51.249+01	CO1	GCP
3737	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-16 22:00:00+01	0.1951	2023-11-17 21:25:51.256+01	2023-11-17 10:37:42.396+01	2023-11-17 21:25:51.256+01	CO1	GCP
3738	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-16 22:00:00+01	0.2399	2023-11-17 21:25:51.258+01	2023-11-17 10:37:42.4+01	2023-11-17 21:25:51.258+01	GP1	GCP
3739	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-16 22:00:00+01	0.2810	2023-11-17 21:25:51.262+01	2023-11-17 10:37:42.402+01	2023-11-17 21:25:51.262+01	GP1	GCP
3740	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-16 22:00:00+01	0.3809	2023-11-17 21:25:51.264+01	2023-11-17 10:37:42.403+01	2023-11-17 21:25:51.264+01	CO1	GCP
3741	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-16 22:00:00+01	0.3330	2023-11-17 21:25:51.265+01	2023-11-17 10:37:42.405+01	2023-11-17 21:25:51.265+01	CO1	GCP
2314	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-03 09:00:00+01	0.0250	2023-11-03 17:53:47.648+01	2023-11-03 17:53:47.687+01	2023-11-06 13:56:27.501+01	CO1	ALB
3742	e2-standard-4-general-purpose	GCP-us-east4	2023-11-16 22:00:00+01	0.2457	2023-11-17 21:25:51.267+01	2023-11-17 10:37:42.407+01	2023-11-17 21:25:51.267+01	GP1	GCP
3743	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-16 22:00:00+01	0.3252	2023-11-17 21:25:51.269+01	2023-11-17 10:37:42.409+01	2023-11-17 21:25:51.269+01	CO1	GCP
3744	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-16 22:00:00+01	0.2620	2023-11-17 21:25:51.27+01	2023-11-17 10:37:42.41+01	2023-11-17 21:25:51.27+01	GP1	GCP
1207	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-27 02:00:00+02	0.0586	2023-10-30 19:55:09.635+01	2023-10-30 19:55:09.635+01	2023-10-30 19:55:09.635+01	GP1	AWS
1208	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-26 02:00:00+02	0.0594	2023-10-30 19:55:09.637+01	2023-10-30 19:55:09.637+01	2023-10-30 19:55:09.637+01	GP1	AWS
1209	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-25 02:00:00+02	0.0584	2023-10-30 19:55:09.638+01	2023-10-30 19:55:09.638+01	2023-10-30 19:55:09.638+01	GP1	AWS
1210	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-24 02:00:00+02	0.0582	2023-10-30 19:55:09.639+01	2023-10-30 19:55:09.639+01	2023-10-30 19:55:09.639+01	GP1	AWS
1211	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-23 02:00:00+02	0.0579	2023-10-30 19:55:09.641+01	2023-10-30 19:55:09.641+01	2023-10-30 19:55:09.641+01	GP1	AWS
1204	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-30 01:00:00+01	0.0588	2023-10-30 19:55:09.626+01	2023-10-30 19:55:09.627+01	2023-10-30 19:55:09.627+01	GP1	AWS
1205	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-29 02:00:00+02	0.0590	2023-10-30 19:55:09.631+01	2023-10-30 19:55:09.632+01	2023-10-30 19:55:09.632+01	GP1	AWS
1206	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-28 02:00:00+02	0.0590	2023-10-30 19:55:09.633+01	2023-10-30 19:55:09.633+01	2023-10-30 19:55:09.633+01	GP1	AWS
1212	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-22 02:00:00+02	0.0579	2023-10-30 19:55:09.643+01	2023-10-30 19:55:09.643+01	2023-10-30 19:55:09.643+01	GP1	AWS
1213	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-21 02:00:00+02	0.0579	2023-10-30 19:55:09.644+01	2023-10-30 19:55:09.644+01	2023-10-30 19:55:09.644+01	GP1	AWS
1214	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-20 02:00:00+02	0.0575	2023-10-30 19:55:09.646+01	2023-10-30 19:55:09.646+01	2023-10-30 19:55:09.646+01	GP1	AWS
1215	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-19 02:00:00+02	0.0572	2023-10-30 19:55:09.647+01	2023-10-30 19:55:09.647+01	2023-10-30 19:55:09.647+01	GP1	AWS
1216	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-18 02:00:00+02	0.0566	2023-10-30 19:55:09.648+01	2023-10-30 19:55:09.648+01	2023-10-30 19:55:09.648+01	GP1	AWS
1217	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-17 02:00:00+02	0.0561	2023-10-30 19:55:09.649+01	2023-10-30 19:55:09.649+01	2023-10-30 19:55:09.649+01	GP1	AWS
1218	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-16 02:00:00+02	0.0558	2023-10-30 19:55:09.65+01	2023-10-30 19:55:09.65+01	2023-10-30 19:55:09.65+01	GP1	AWS
1219	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-15 02:00:00+02	0.0556	2023-10-30 19:55:09.651+01	2023-10-30 19:55:09.651+01	2023-10-30 19:55:09.651+01	GP1	AWS
1220	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-14 02:00:00+02	0.0552	2023-10-30 19:55:09.652+01	2023-10-30 19:55:09.652+01	2023-10-30 19:55:09.652+01	GP1	AWS
1221	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-13 02:00:00+02	0.0552	2023-10-30 19:55:09.653+01	2023-10-30 19:55:09.653+01	2023-10-30 19:55:09.653+01	GP1	AWS
1222	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-12 02:00:00+02	0.0555	2023-10-30 19:55:09.654+01	2023-10-30 19:55:09.654+01	2023-10-30 19:55:09.654+01	GP1	AWS
1223	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-11 02:00:00+02	0.0555	2023-10-30 19:55:09.655+01	2023-10-30 19:55:09.655+01	2023-10-30 19:55:09.655+01	GP1	AWS
1224	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-10 02:00:00+02	0.0555	2023-10-30 19:55:09.656+01	2023-10-30 19:55:09.656+01	2023-10-30 19:55:09.656+01	GP1	AWS
1225	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-09 02:00:00+02	0.0549	2023-10-30 19:55:09.658+01	2023-10-30 19:55:09.658+01	2023-10-30 19:55:09.658+01	GP1	AWS
1226	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-08 02:00:00+02	0.0555	2023-10-30 19:55:09.659+01	2023-10-30 19:55:09.659+01	2023-10-30 19:55:09.659+01	GP1	AWS
1227	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-07 02:00:00+02	0.0568	2023-10-30 19:55:09.66+01	2023-10-30 19:55:09.66+01	2023-10-30 19:55:09.66+01	GP1	AWS
1228	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-06 02:00:00+02	0.0556	2023-10-30 19:55:09.661+01	2023-10-30 19:55:09.662+01	2023-10-30 19:55:09.662+01	GP1	AWS
1229	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-05 02:00:00+02	0.0562	2023-10-30 19:55:09.663+01	2023-10-30 19:55:09.663+01	2023-10-30 19:55:09.663+01	GP1	AWS
1230	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-04 02:00:00+02	0.0563	2023-10-30 19:55:09.664+01	2023-10-30 19:55:09.664+01	2023-10-30 19:55:09.664+01	GP1	AWS
1231	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-03 02:00:00+02	0.0563	2023-10-30 19:55:09.665+01	2023-10-30 19:55:09.665+01	2023-10-30 19:55:09.665+01	GP1	AWS
1232	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-02 02:00:00+02	0.0569	2023-10-30 19:55:09.665+01	2023-10-30 19:55:09.665+01	2023-10-30 19:55:09.665+01	GP1	AWS
1233	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-10-01 02:00:00+02	0.0575	2023-10-30 19:55:09.666+01	2023-10-30 19:55:09.666+01	2023-10-30 19:55:09.666+01	GP1	AWS
1234	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-30 02:00:00+02	0.0573	2023-10-30 19:55:09.667+01	2023-10-30 19:55:09.667+01	2023-10-30 19:55:09.667+01	GP1	AWS
1235	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-29 02:00:00+02	0.0570	2023-10-30 19:55:09.668+01	2023-10-30 19:55:09.668+01	2023-10-30 19:55:09.668+01	GP1	AWS
1236	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-28 02:00:00+02	0.0583	2023-10-30 19:55:09.669+01	2023-10-30 19:55:09.669+01	2023-10-30 19:55:09.669+01	GP1	AWS
1237	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-27 02:00:00+02	0.0580	2023-10-30 19:55:09.669+01	2023-10-30 19:55:09.67+01	2023-10-30 19:55:09.67+01	GP1	AWS
1238	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-26 02:00:00+02	0.0585	2023-10-30 19:55:09.671+01	2023-10-30 19:55:09.671+01	2023-10-30 19:55:09.671+01	GP1	AWS
1239	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-25 02:00:00+02	0.0590	2023-10-30 19:55:09.672+01	2023-10-30 19:55:09.672+01	2023-10-30 19:55:09.672+01	GP1	AWS
1240	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-24 02:00:00+02	0.0586	2023-10-30 19:55:09.672+01	2023-10-30 19:55:09.672+01	2023-10-30 19:55:09.672+01	GP1	AWS
1241	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-23 02:00:00+02	0.0595	2023-10-30 19:55:09.674+01	2023-10-30 19:55:09.674+01	2023-10-30 19:55:09.674+01	GP1	AWS
1242	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-22 02:00:00+02	0.0593	2023-10-30 19:55:09.675+01	2023-10-30 19:55:09.675+01	2023-10-30 19:55:09.675+01	GP1	AWS
1243	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-21 02:00:00+02	0.0596	2023-10-30 19:55:09.676+01	2023-10-30 19:55:09.676+01	2023-10-30 19:55:09.676+01	GP1	AWS
1244	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-20 02:00:00+02	0.0605	2023-10-30 19:55:09.677+01	2023-10-30 19:55:09.677+01	2023-10-30 19:55:09.677+01	GP1	AWS
1245	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-19 02:00:00+02	0.0606	2023-10-30 19:55:09.678+01	2023-10-30 19:55:09.678+01	2023-10-30 19:55:09.678+01	GP1	AWS
1246	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-18 02:00:00+02	0.0608	2023-10-30 19:55:09.679+01	2023-10-30 19:55:09.679+01	2023-10-30 19:55:09.679+01	GP1	AWS
1247	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-17 02:00:00+02	0.0603	2023-10-30 19:55:09.679+01	2023-10-30 19:55:09.679+01	2023-10-30 19:55:09.679+01	GP1	AWS
1248	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-16 02:00:00+02	0.0614	2023-10-30 19:55:09.68+01	2023-10-30 19:55:09.68+01	2023-10-30 19:55:09.68+01	GP1	AWS
1249	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-15 02:00:00+02	0.0599	2023-10-30 19:55:09.681+01	2023-10-30 19:55:09.681+01	2023-10-30 19:55:09.681+01	GP1	AWS
1250	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-14 02:00:00+02	0.0597	2023-10-30 19:55:09.683+01	2023-10-30 19:55:09.683+01	2023-10-30 19:55:09.683+01	GP1	AWS
1251	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-13 02:00:00+02	0.0605	2023-10-30 19:55:09.684+01	2023-10-30 19:55:09.684+01	2023-10-30 19:55:09.684+01	GP1	AWS
1252	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-12 02:00:00+02	0.0588	2023-10-30 19:55:09.685+01	2023-10-30 19:55:09.685+01	2023-10-30 19:55:09.685+01	GP1	AWS
1253	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-11 02:00:00+02	0.0609	2023-10-30 19:55:09.686+01	2023-10-30 19:55:09.686+01	2023-10-30 19:55:09.686+01	GP1	AWS
1254	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-10 02:00:00+02	0.0601	2023-10-30 19:55:09.687+01	2023-10-30 19:55:09.687+01	2023-10-30 19:55:09.687+01	GP1	AWS
1255	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-09 02:00:00+02	0.0617	2023-10-30 19:55:09.687+01	2023-10-30 19:55:09.687+01	2023-10-30 19:55:09.687+01	GP1	AWS
1256	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-08 02:00:00+02	0.0614	2023-10-30 19:55:09.689+01	2023-10-30 19:55:09.689+01	2023-10-30 19:55:09.689+01	GP1	AWS
1257	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-07 02:00:00+02	0.0628	2023-10-30 19:55:09.69+01	2023-10-30 19:55:09.69+01	2023-10-30 19:55:09.69+01	GP1	AWS
1258	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-06 02:00:00+02	0.0618	2023-10-30 19:55:09.691+01	2023-10-30 19:55:09.691+01	2023-10-30 19:55:09.691+01	GP1	AWS
1259	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-05 02:00:00+02	0.0624	2023-10-30 19:55:09.692+01	2023-10-30 19:55:09.693+01	2023-10-30 19:55:09.693+01	GP1	AWS
1260	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-04 02:00:00+02	0.0621	2023-10-30 19:55:09.693+01	2023-10-30 19:55:09.693+01	2023-10-30 19:55:09.693+01	GP1	AWS
1261	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-03 02:00:00+02	0.0641	2023-10-30 19:55:09.694+01	2023-10-30 19:55:09.695+01	2023-10-30 19:55:09.695+01	GP1	AWS
1262	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-02 02:00:00+02	0.0632	2023-10-30 19:55:09.695+01	2023-10-30 19:55:09.695+01	2023-10-30 19:55:09.695+01	GP1	AWS
1263	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-09-01 02:00:00+02	0.0642	2023-10-30 19:55:09.696+01	2023-10-30 19:55:09.696+01	2023-10-30 19:55:09.696+01	GP1	AWS
1264	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-08-31 02:00:00+02	0.0647	2023-10-30 19:55:09.697+01	2023-10-30 19:55:09.697+01	2023-10-30 19:55:09.697+01	GP1	AWS
1265	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-30 01:00:00+01	0.0952	2023-10-30 19:55:09.888+01	2023-10-30 19:55:09.888+01	2023-10-30 19:55:09.888+01	CO1	AWS
1266	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-29 02:00:00+02	0.0973	2023-10-30 19:55:09.889+01	2023-10-30 19:55:09.889+01	2023-10-30 19:55:09.889+01	CO1	AWS
1267	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-28 02:00:00+02	0.0969	2023-10-30 19:55:09.89+01	2023-10-30 19:55:09.89+01	2023-10-30 19:55:09.89+01	CO1	AWS
1268	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-27 02:00:00+02	0.0967	2023-10-30 19:55:09.891+01	2023-10-30 19:55:09.891+01	2023-10-30 19:55:09.891+01	CO1	AWS
1269	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-26 02:00:00+02	0.0960	2023-10-30 19:55:09.892+01	2023-10-30 19:55:09.892+01	2023-10-30 19:55:09.892+01	CO1	AWS
1270	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-25 02:00:00+02	0.0982	2023-10-30 19:55:09.893+01	2023-10-30 19:55:09.893+01	2023-10-30 19:55:09.893+01	CO1	AWS
1271	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-24 02:00:00+02	0.0969	2023-10-30 19:55:09.894+01	2023-10-30 19:55:09.894+01	2023-10-30 19:55:09.894+01	CO1	AWS
1272	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-23 02:00:00+02	0.0972	2023-10-30 19:55:09.897+01	2023-10-30 19:55:09.897+01	2023-10-30 19:55:09.897+01	CO1	AWS
1273	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-22 02:00:00+02	0.0939	2023-10-30 19:55:09.898+01	2023-10-30 19:55:09.898+01	2023-10-30 19:55:09.898+01	CO1	AWS
1274	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-21 02:00:00+02	0.0976	2023-10-30 19:55:09.899+01	2023-10-30 19:55:09.899+01	2023-10-30 19:55:09.899+01	CO1	AWS
1275	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-20 02:00:00+02	0.0981	2023-10-30 19:55:09.899+01	2023-10-30 19:55:09.9+01	2023-10-30 19:55:09.9+01	CO1	AWS
1276	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-19 02:00:00+02	0.0974	2023-10-30 19:55:09.9+01	2023-10-30 19:55:09.9+01	2023-10-30 19:55:09.9+01	CO1	AWS
1277	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-18 02:00:00+02	0.0991	2023-10-30 19:55:09.901+01	2023-10-30 19:55:09.901+01	2023-10-30 19:55:09.901+01	CO1	AWS
1278	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-17 02:00:00+02	0.0985	2023-10-30 19:55:09.902+01	2023-10-30 19:55:09.902+01	2023-10-30 19:55:09.902+01	CO1	AWS
1279	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-16 02:00:00+02	0.0995	2023-10-30 19:55:09.903+01	2023-10-30 19:55:09.903+01	2023-10-30 19:55:09.903+01	CO1	AWS
1280	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-15 02:00:00+02	0.0980	2023-10-30 19:55:09.904+01	2023-10-30 19:55:09.904+01	2023-10-30 19:55:09.904+01	CO1	AWS
1281	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-14 02:00:00+02	0.0992	2023-10-30 19:55:09.905+01	2023-10-30 19:55:09.905+01	2023-10-30 19:55:09.905+01	CO1	AWS
1282	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-13 02:00:00+02	0.0992	2023-10-30 19:55:09.905+01	2023-10-30 19:55:09.905+01	2023-10-30 19:55:09.905+01	CO1	AWS
1283	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-12 02:00:00+02	0.0997	2023-10-30 19:55:09.907+01	2023-10-30 19:55:09.907+01	2023-10-30 19:55:09.907+01	CO1	AWS
1284	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-11 02:00:00+02	0.0984	2023-10-30 19:55:09.908+01	2023-10-30 19:55:09.908+01	2023-10-30 19:55:09.908+01	CO1	AWS
1285	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-10 02:00:00+02	0.0993	2023-10-30 19:55:09.909+01	2023-10-30 19:55:09.909+01	2023-10-30 19:55:09.909+01	CO1	AWS
1286	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-09 02:00:00+02	0.0996	2023-10-30 19:55:09.91+01	2023-10-30 19:55:09.91+01	2023-10-30 19:55:09.91+01	CO1	AWS
1287	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-08 02:00:00+02	0.0992	2023-10-30 19:55:09.912+01	2023-10-30 19:55:09.912+01	2023-10-30 19:55:09.912+01	CO1	AWS
1288	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-07 02:00:00+02	0.0995	2023-10-30 19:55:09.913+01	2023-10-30 19:55:09.913+01	2023-10-30 19:55:09.913+01	CO1	AWS
1289	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-06 02:00:00+02	0.1003	2023-10-30 19:55:09.915+01	2023-10-30 19:55:09.915+01	2023-10-30 19:55:09.915+01	CO1	AWS
1290	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-05 02:00:00+02	0.1002	2023-10-30 19:55:09.915+01	2023-10-30 19:55:09.915+01	2023-10-30 19:55:09.915+01	CO1	AWS
1291	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-04 02:00:00+02	0.1007	2023-10-30 19:55:09.916+01	2023-10-30 19:55:09.916+01	2023-10-30 19:55:09.916+01	CO1	AWS
1292	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-03 02:00:00+02	0.0996	2023-10-30 19:55:09.917+01	2023-10-30 19:55:09.917+01	2023-10-30 19:55:09.917+01	CO1	AWS
1293	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-02 02:00:00+02	0.1015	2023-10-30 19:55:09.918+01	2023-10-30 19:55:09.918+01	2023-10-30 19:55:09.918+01	CO1	AWS
1294	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-10-01 02:00:00+02	0.1004	2023-10-30 19:55:09.919+01	2023-10-30 19:55:09.919+01	2023-10-30 19:55:09.919+01	CO1	AWS
1295	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-30 02:00:00+02	0.1019	2023-10-30 19:55:09.92+01	2023-10-30 19:55:09.92+01	2023-10-30 19:55:09.92+01	CO1	AWS
1296	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-29 02:00:00+02	0.1008	2023-10-30 19:55:09.921+01	2023-10-30 19:55:09.921+01	2023-10-30 19:55:09.921+01	CO1	AWS
1297	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-28 02:00:00+02	0.1017	2023-10-30 19:55:09.922+01	2023-10-30 19:55:09.922+01	2023-10-30 19:55:09.922+01	CO1	AWS
1298	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-27 02:00:00+02	0.1009	2023-10-30 19:55:09.923+01	2023-10-30 19:55:09.923+01	2023-10-30 19:55:09.923+01	CO1	AWS
1299	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-26 02:00:00+02	0.1025	2023-10-30 19:55:09.924+01	2023-10-30 19:55:09.924+01	2023-10-30 19:55:09.924+01	CO1	AWS
1300	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-25 02:00:00+02	0.1017	2023-10-30 19:55:09.924+01	2023-10-30 19:55:09.925+01	2023-10-30 19:55:09.925+01	CO1	AWS
1301	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-24 02:00:00+02	0.1063	2023-10-30 19:55:09.925+01	2023-10-30 19:55:09.925+01	2023-10-30 19:55:09.925+01	CO1	AWS
1302	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-23 02:00:00+02	0.1055	2023-10-30 19:55:09.926+01	2023-10-30 19:55:09.926+01	2023-10-30 19:55:09.926+01	CO1	AWS
1303	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-22 02:00:00+02	0.1011	2023-10-30 19:55:09.927+01	2023-10-30 19:55:09.927+01	2023-10-30 19:55:09.927+01	CO1	AWS
1304	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-21 02:00:00+02	0.1057	2023-10-30 19:55:09.928+01	2023-10-30 19:55:09.928+01	2023-10-30 19:55:09.928+01	CO1	AWS
1305	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-20 02:00:00+02	0.1003	2023-10-30 19:55:09.929+01	2023-10-30 19:55:09.929+01	2023-10-30 19:55:09.929+01	CO1	AWS
1306	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-19 02:00:00+02	0.1039	2023-10-30 19:55:09.93+01	2023-10-30 19:55:09.93+01	2023-10-30 19:55:09.93+01	CO1	AWS
1307	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-18 02:00:00+02	0.1027	2023-10-30 19:55:09.931+01	2023-10-30 19:55:09.931+01	2023-10-30 19:55:09.931+01	CO1	AWS
1308	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-17 02:00:00+02	0.1050	2023-10-30 19:55:09.932+01	2023-10-30 19:55:09.932+01	2023-10-30 19:55:09.932+01	CO1	AWS
1309	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-16 02:00:00+02	0.1065	2023-10-30 19:55:09.933+01	2023-10-30 19:55:09.933+01	2023-10-30 19:55:09.933+01	CO1	AWS
1310	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-15 02:00:00+02	0.1020	2023-10-30 19:55:09.933+01	2023-10-30 19:55:09.933+01	2023-10-30 19:55:09.933+01	CO1	AWS
1311	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-14 02:00:00+02	0.1055	2023-10-30 19:55:09.934+01	2023-10-30 19:55:09.934+01	2023-10-30 19:55:09.934+01	CO1	AWS
1312	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-13 02:00:00+02	0.1068	2023-10-30 19:55:09.935+01	2023-10-30 19:55:09.935+01	2023-10-30 19:55:09.935+01	CO1	AWS
1313	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-12 02:00:00+02	0.1070	2023-10-30 19:55:09.936+01	2023-10-30 19:55:09.936+01	2023-10-30 19:55:09.936+01	CO1	AWS
1314	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-11 02:00:00+02	0.1070	2023-10-30 19:55:09.937+01	2023-10-30 19:55:09.937+01	2023-10-30 19:55:09.937+01	CO1	AWS
1315	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-10 02:00:00+02	0.1035	2023-10-30 19:55:09.938+01	2023-10-30 19:55:09.938+01	2023-10-30 19:55:09.938+01	CO1	AWS
1316	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-09 02:00:00+02	0.1065	2023-10-30 19:55:09.939+01	2023-10-30 19:55:09.939+01	2023-10-30 19:55:09.939+01	CO1	AWS
1317	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-08 02:00:00+02	0.1068	2023-10-30 19:55:09.94+01	2023-10-30 19:55:09.94+01	2023-10-30 19:55:09.94+01	CO1	AWS
1318	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-07 02:00:00+02	0.1067	2023-10-30 19:55:09.941+01	2023-10-30 19:55:09.941+01	2023-10-30 19:55:09.941+01	CO1	AWS
1319	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-06 02:00:00+02	0.1068	2023-10-30 19:55:09.943+01	2023-10-30 19:55:09.943+01	2023-10-30 19:55:09.943+01	CO1	AWS
1320	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-05 02:00:00+02	0.1084	2023-10-30 19:55:09.944+01	2023-10-30 19:55:09.944+01	2023-10-30 19:55:09.944+01	CO1	AWS
1321	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-04 02:00:00+02	0.1089	2023-10-30 19:55:09.945+01	2023-10-30 19:55:09.945+01	2023-10-30 19:55:09.945+01	CO1	AWS
1322	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-03 02:00:00+02	0.1054	2023-10-30 19:55:09.946+01	2023-10-30 19:55:09.946+01	2023-10-30 19:55:09.946+01	CO1	AWS
1323	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-02 02:00:00+02	0.1080	2023-10-30 19:55:09.947+01	2023-10-30 19:55:09.947+01	2023-10-30 19:55:09.947+01	CO1	AWS
1324	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-09-01 02:00:00+02	0.1066	2023-10-30 19:55:09.948+01	2023-10-30 19:55:09.948+01	2023-10-30 19:55:09.948+01	CO1	AWS
1325	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-08-31 02:00:00+02	0.1064	2023-10-30 19:55:09.949+01	2023-10-30 19:55:09.949+01	2023-10-30 19:55:09.949+01	CO1	AWS
1326	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-30 01:00:00+01	0.0322	2023-10-30 19:55:10.652+01	2023-10-30 19:55:10.652+01	2023-10-30 19:55:10.652+01	GP1	AWS
1327	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-29 02:00:00+02	0.0296	2023-10-30 19:55:10.653+01	2023-10-30 19:55:10.653+01	2023-10-30 19:55:10.653+01	GP1	AWS
1328	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-28 02:00:00+02	0.0315	2023-10-30 19:55:10.655+01	2023-10-30 19:55:10.655+01	2023-10-30 19:55:10.655+01	GP1	AWS
1329	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-27 02:00:00+02	0.0301	2023-10-30 19:55:10.655+01	2023-10-30 19:55:10.655+01	2023-10-30 19:55:10.655+01	GP1	AWS
1330	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-26 02:00:00+02	0.0326	2023-10-30 19:55:10.656+01	2023-10-30 19:55:10.656+01	2023-10-30 19:55:10.656+01	GP1	AWS
1331	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-25 02:00:00+02	0.0324	2023-10-30 19:55:10.657+01	2023-10-30 19:55:10.657+01	2023-10-30 19:55:10.657+01	GP1	AWS
1332	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-24 02:00:00+02	0.0296	2023-10-30 19:55:10.659+01	2023-10-30 19:55:10.659+01	2023-10-30 19:55:10.659+01	GP1	AWS
1333	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-23 02:00:00+02	0.0297	2023-10-30 19:55:10.66+01	2023-10-30 19:55:10.66+01	2023-10-30 19:55:10.66+01	GP1	AWS
1334	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-22 02:00:00+02	0.0325	2023-10-30 19:55:10.661+01	2023-10-30 19:55:10.661+01	2023-10-30 19:55:10.661+01	GP1	AWS
1335	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-21 02:00:00+02	0.0318	2023-10-30 19:55:10.662+01	2023-10-30 19:55:10.662+01	2023-10-30 19:55:10.662+01	GP1	AWS
1336	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-20 02:00:00+02	0.0320	2023-10-30 19:55:10.663+01	2023-10-30 19:55:10.663+01	2023-10-30 19:55:10.663+01	GP1	AWS
1337	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-19 02:00:00+02	0.0306	2023-10-30 19:55:10.664+01	2023-10-30 19:55:10.664+01	2023-10-30 19:55:10.664+01	GP1	AWS
1338	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-18 02:00:00+02	0.0315	2023-10-30 19:55:10.665+01	2023-10-30 19:55:10.665+01	2023-10-30 19:55:10.665+01	GP1	AWS
1339	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-17 02:00:00+02	0.0307	2023-10-30 19:55:10.666+01	2023-10-30 19:55:10.666+01	2023-10-30 19:55:10.666+01	GP1	AWS
1340	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-16 02:00:00+02	0.0309	2023-10-30 19:55:10.668+01	2023-10-30 19:55:10.668+01	2023-10-30 19:55:10.668+01	GP1	AWS
1341	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-15 02:00:00+02	0.0303	2023-10-30 19:55:10.669+01	2023-10-30 19:55:10.669+01	2023-10-30 19:55:10.669+01	GP1	AWS
1342	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-14 02:00:00+02	0.0303	2023-10-30 19:55:10.67+01	2023-10-30 19:55:10.67+01	2023-10-30 19:55:10.67+01	GP1	AWS
1343	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-13 02:00:00+02	0.0298	2023-10-30 19:55:10.671+01	2023-10-30 19:55:10.671+01	2023-10-30 19:55:10.671+01	GP1	AWS
1344	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-12 02:00:00+02	0.0308	2023-10-30 19:55:10.672+01	2023-10-30 19:55:10.672+01	2023-10-30 19:55:10.672+01	GP1	AWS
1345	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-11 02:00:00+02	0.0309	2023-10-30 19:55:10.672+01	2023-10-30 19:55:10.672+01	2023-10-30 19:55:10.672+01	GP1	AWS
1346	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-10 02:00:00+02	0.0313	2023-10-30 19:55:10.673+01	2023-10-30 19:55:10.673+01	2023-10-30 19:55:10.673+01	GP1	AWS
1347	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-09 02:00:00+02	0.0311	2023-10-30 19:55:10.674+01	2023-10-30 19:55:10.674+01	2023-10-30 19:55:10.674+01	GP1	AWS
1348	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-08 02:00:00+02	0.0309	2023-10-30 19:55:10.675+01	2023-10-30 19:55:10.675+01	2023-10-30 19:55:10.675+01	GP1	AWS
1349	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-07 02:00:00+02	0.0311	2023-10-30 19:55:10.676+01	2023-10-30 19:55:10.676+01	2023-10-30 19:55:10.676+01	GP1	AWS
1350	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-06 02:00:00+02	0.0320	2023-10-30 19:55:10.677+01	2023-10-30 19:55:10.677+01	2023-10-30 19:55:10.677+01	GP1	AWS
1351	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-05 02:00:00+02	0.0320	2023-10-30 19:55:10.678+01	2023-10-30 19:55:10.678+01	2023-10-30 19:55:10.678+01	GP1	AWS
1352	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-04 02:00:00+02	0.0324	2023-10-30 19:55:10.679+01	2023-10-30 19:55:10.679+01	2023-10-30 19:55:10.679+01	GP1	AWS
1353	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-03 02:00:00+02	0.0330	2023-10-30 19:55:10.679+01	2023-10-30 19:55:10.679+01	2023-10-30 19:55:10.679+01	GP1	AWS
1354	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-02 02:00:00+02	0.0328	2023-10-30 19:55:10.681+01	2023-10-30 19:55:10.681+01	2023-10-30 19:55:10.681+01	GP1	AWS
1355	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-10-01 02:00:00+02	0.0330	2023-10-30 19:55:10.682+01	2023-10-30 19:55:10.682+01	2023-10-30 19:55:10.682+01	GP1	AWS
1356	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-30 02:00:00+02	0.0338	2023-10-30 19:55:10.683+01	2023-10-30 19:55:10.683+01	2023-10-30 19:55:10.683+01	GP1	AWS
1357	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-29 02:00:00+02	0.0335	2023-10-30 19:55:10.684+01	2023-10-30 19:55:10.684+01	2023-10-30 19:55:10.684+01	GP1	AWS
1358	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-28 02:00:00+02	0.0330	2023-10-30 19:55:10.684+01	2023-10-30 19:55:10.684+01	2023-10-30 19:55:10.684+01	GP1	AWS
1359	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-27 02:00:00+02	0.0309	2023-10-30 19:55:10.685+01	2023-10-30 19:55:10.685+01	2023-10-30 19:55:10.685+01	GP1	AWS
1360	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-26 02:00:00+02	0.0329	2023-10-30 19:55:10.686+01	2023-10-30 19:55:10.686+01	2023-10-30 19:55:10.686+01	GP1	AWS
1361	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-25 02:00:00+02	0.0300	2023-10-30 19:55:10.687+01	2023-10-30 19:55:10.687+01	2023-10-30 19:55:10.687+01	GP1	AWS
1362	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-24 02:00:00+02	0.0295	2023-10-30 19:55:10.688+01	2023-10-30 19:55:10.688+01	2023-10-30 19:55:10.688+01	GP1	AWS
1363	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-23 02:00:00+02	0.0297	2023-10-30 19:55:10.689+01	2023-10-30 19:55:10.689+01	2023-10-30 19:55:10.689+01	GP1	AWS
1364	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-22 02:00:00+02	0.0305	2023-10-30 19:55:10.689+01	2023-10-30 19:55:10.689+01	2023-10-30 19:55:10.689+01	GP1	AWS
1365	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-21 02:00:00+02	0.0315	2023-10-30 19:55:10.69+01	2023-10-30 19:55:10.691+01	2023-10-30 19:55:10.691+01	GP1	AWS
1366	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-20 02:00:00+02	0.0315	2023-10-30 19:55:10.692+01	2023-10-30 19:55:10.692+01	2023-10-30 19:55:10.692+01	GP1	AWS
1367	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-19 02:00:00+02	0.0303	2023-10-30 19:55:10.693+01	2023-10-30 19:55:10.693+01	2023-10-30 19:55:10.693+01	GP1	AWS
1368	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-18 02:00:00+02	0.0311	2023-10-30 19:55:10.694+01	2023-10-30 19:55:10.694+01	2023-10-30 19:55:10.694+01	GP1	AWS
1369	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-17 02:00:00+02	0.0320	2023-10-30 19:55:10.695+01	2023-10-30 19:55:10.695+01	2023-10-30 19:55:10.695+01	GP1	AWS
1370	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-16 02:00:00+02	0.0308	2023-10-30 19:55:10.696+01	2023-10-30 19:55:10.696+01	2023-10-30 19:55:10.696+01	GP1	AWS
1371	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-15 02:00:00+02	0.0311	2023-10-30 19:55:10.697+01	2023-10-30 19:55:10.697+01	2023-10-30 19:55:10.697+01	GP1	AWS
1372	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-14 02:00:00+02	0.0318	2023-10-30 19:55:10.698+01	2023-10-30 19:55:10.698+01	2023-10-30 19:55:10.698+01	GP1	AWS
1373	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-13 02:00:00+02	0.0318	2023-10-30 19:55:10.698+01	2023-10-30 19:55:10.698+01	2023-10-30 19:55:10.698+01	GP1	AWS
1374	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-12 02:00:00+02	0.0319	2023-10-30 19:55:10.699+01	2023-10-30 19:55:10.699+01	2023-10-30 19:55:10.699+01	GP1	AWS
1375	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-11 02:00:00+02	0.0301	2023-10-30 19:55:10.7+01	2023-10-30 19:55:10.7+01	2023-10-30 19:55:10.7+01	GP1	AWS
1376	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-10 02:00:00+02	0.0300	2023-10-30 19:55:10.701+01	2023-10-30 19:55:10.701+01	2023-10-30 19:55:10.701+01	GP1	AWS
1377	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-09 02:00:00+02	0.0313	2023-10-30 19:55:10.702+01	2023-10-30 19:55:10.702+01	2023-10-30 19:55:10.702+01	GP1	AWS
1378	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-08 02:00:00+02	0.0301	2023-10-30 19:55:10.702+01	2023-10-30 19:55:10.703+01	2023-10-30 19:55:10.703+01	GP1	AWS
1379	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-07 02:00:00+02	0.0316	2023-10-30 19:55:10.703+01	2023-10-30 19:55:10.703+01	2023-10-30 19:55:10.703+01	GP1	AWS
1380	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-06 02:00:00+02	0.0317	2023-10-30 19:55:10.704+01	2023-10-30 19:55:10.704+01	2023-10-30 19:55:10.704+01	GP1	AWS
1381	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-05 02:00:00+02	0.0316	2023-10-30 19:55:10.705+01	2023-10-30 19:55:10.705+01	2023-10-30 19:55:10.705+01	GP1	AWS
1382	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-04 02:00:00+02	0.0318	2023-10-30 19:55:10.706+01	2023-10-30 19:55:10.706+01	2023-10-30 19:55:10.706+01	GP1	AWS
1383	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-03 02:00:00+02	0.0319	2023-10-30 19:55:10.707+01	2023-10-30 19:55:10.707+01	2023-10-30 19:55:10.707+01	GP1	AWS
1384	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-02 02:00:00+02	0.0321	2023-10-30 19:55:10.708+01	2023-10-30 19:55:10.708+01	2023-10-30 19:55:10.708+01	GP1	AWS
1385	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-09-01 02:00:00+02	0.0325	2023-10-30 19:55:10.709+01	2023-10-30 19:55:10.709+01	2023-10-30 19:55:10.709+01	GP1	AWS
1386	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-08-31 02:00:00+02	0.0312	2023-10-30 19:55:10.71+01	2023-10-30 19:55:10.71+01	2023-10-30 19:55:10.71+01	GP1	AWS
1387	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-08-30 02:00:00+02	0.0269	2023-10-30 19:55:10.711+01	2023-10-30 19:55:10.711+01	2023-10-30 19:55:10.711+01	GP1	AWS
1388	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-30 01:00:00+01	0.0790	2023-10-30 19:55:10.838+01	2023-10-30 19:55:10.839+01	2023-10-30 19:55:10.839+01	CO1	AWS
1389	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-29 02:00:00+02	0.0793	2023-10-30 19:55:10.84+01	2023-10-30 19:55:10.84+01	2023-10-30 19:55:10.84+01	CO1	AWS
1390	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-28 02:00:00+02	0.0786	2023-10-30 19:55:10.841+01	2023-10-30 19:55:10.841+01	2023-10-30 19:55:10.841+01	CO1	AWS
1391	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-27 02:00:00+02	0.0776	2023-10-30 19:55:10.842+01	2023-10-30 19:55:10.842+01	2023-10-30 19:55:10.842+01	CO1	AWS
1392	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-26 02:00:00+02	0.0774	2023-10-30 19:55:10.843+01	2023-10-30 19:55:10.843+01	2023-10-30 19:55:10.843+01	CO1	AWS
1393	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-25 02:00:00+02	0.0780	2023-10-30 19:55:10.845+01	2023-10-30 19:55:10.845+01	2023-10-30 19:55:10.845+01	CO1	AWS
1394	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-24 02:00:00+02	0.0770	2023-10-30 19:55:10.846+01	2023-10-30 19:55:10.846+01	2023-10-30 19:55:10.846+01	CO1	AWS
1395	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-23 02:00:00+02	0.0776	2023-10-30 19:55:10.847+01	2023-10-30 19:55:10.847+01	2023-10-30 19:55:10.847+01	CO1	AWS
1396	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-22 02:00:00+02	0.0785	2023-10-30 19:55:10.849+01	2023-10-30 19:55:10.849+01	2023-10-30 19:55:10.849+01	CO1	AWS
1397	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-21 02:00:00+02	0.0789	2023-10-30 19:55:10.85+01	2023-10-30 19:55:10.85+01	2023-10-30 19:55:10.85+01	CO1	AWS
1398	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-20 02:00:00+02	0.0793	2023-10-30 19:55:10.851+01	2023-10-30 19:55:10.851+01	2023-10-30 19:55:10.851+01	CO1	AWS
1399	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-19 02:00:00+02	0.0792	2023-10-30 19:55:10.852+01	2023-10-30 19:55:10.852+01	2023-10-30 19:55:10.852+01	CO1	AWS
1400	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-18 02:00:00+02	0.0796	2023-10-30 19:55:10.853+01	2023-10-30 19:55:10.853+01	2023-10-30 19:55:10.853+01	CO1	AWS
1401	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-17 02:00:00+02	0.0785	2023-10-30 19:55:10.854+01	2023-10-30 19:55:10.854+01	2023-10-30 19:55:10.854+01	CO1	AWS
1402	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-16 02:00:00+02	0.0796	2023-10-30 19:55:10.855+01	2023-10-30 19:55:10.855+01	2023-10-30 19:55:10.855+01	CO1	AWS
1403	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-15 02:00:00+02	0.0792	2023-10-30 19:55:10.856+01	2023-10-30 19:55:10.856+01	2023-10-30 19:55:10.856+01	CO1	AWS
1404	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-14 02:00:00+02	0.0791	2023-10-30 19:55:10.857+01	2023-10-30 19:55:10.857+01	2023-10-30 19:55:10.857+01	CO1	AWS
1405	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-13 02:00:00+02	0.0794	2023-10-30 19:55:10.858+01	2023-10-30 19:55:10.858+01	2023-10-30 19:55:10.858+01	CO1	AWS
1406	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-12 02:00:00+02	0.0795	2023-10-30 19:55:10.859+01	2023-10-30 19:55:10.859+01	2023-10-30 19:55:10.859+01	CO1	AWS
1407	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-11 02:00:00+02	0.0797	2023-10-30 19:55:10.86+01	2023-10-30 19:55:10.86+01	2023-10-30 19:55:10.86+01	CO1	AWS
1408	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-10 02:00:00+02	0.0797	2023-10-30 19:55:10.861+01	2023-10-30 19:55:10.861+01	2023-10-30 19:55:10.861+01	CO1	AWS
1409	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-09 02:00:00+02	0.0800	2023-10-30 19:55:10.862+01	2023-10-30 19:55:10.862+01	2023-10-30 19:55:10.862+01	CO1	AWS
1410	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-08 02:00:00+02	0.0807	2023-10-30 19:55:10.863+01	2023-10-30 19:55:10.863+01	2023-10-30 19:55:10.863+01	CO1	AWS
1411	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-07 02:00:00+02	0.0814	2023-10-30 19:55:10.864+01	2023-10-30 19:55:10.864+01	2023-10-30 19:55:10.864+01	CO1	AWS
1412	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-06 02:00:00+02	0.0817	2023-10-30 19:55:10.864+01	2023-10-30 19:55:10.864+01	2023-10-30 19:55:10.864+01	CO1	AWS
1413	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-05 02:00:00+02	0.0817	2023-10-30 19:55:10.865+01	2023-10-30 19:55:10.865+01	2023-10-30 19:55:10.865+01	CO1	AWS
1414	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-04 02:00:00+02	0.0819	2023-10-30 19:55:10.866+01	2023-10-30 19:55:10.866+01	2023-10-30 19:55:10.866+01	CO1	AWS
1415	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-03 02:00:00+02	0.0823	2023-10-30 19:55:10.867+01	2023-10-30 19:55:10.867+01	2023-10-30 19:55:10.867+01	CO1	AWS
1416	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-02 02:00:00+02	0.0824	2023-10-30 19:55:10.867+01	2023-10-30 19:55:10.867+01	2023-10-30 19:55:10.867+01	CO1	AWS
1417	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-10-01 02:00:00+02	0.0824	2023-10-30 19:55:10.868+01	2023-10-30 19:55:10.868+01	2023-10-30 19:55:10.868+01	CO1	AWS
1418	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-30 02:00:00+02	0.0821	2023-10-30 19:55:10.869+01	2023-10-30 19:55:10.869+01	2023-10-30 19:55:10.869+01	CO1	AWS
1419	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-29 02:00:00+02	0.0819	2023-10-30 19:55:10.87+01	2023-10-30 19:55:10.87+01	2023-10-30 19:55:10.87+01	CO1	AWS
1420	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-28 02:00:00+02	0.0823	2023-10-30 19:55:10.871+01	2023-10-30 19:55:10.871+01	2023-10-30 19:55:10.871+01	CO1	AWS
1421	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-27 02:00:00+02	0.0821	2023-10-30 19:55:10.872+01	2023-10-30 19:55:10.872+01	2023-10-30 19:55:10.872+01	CO1	AWS
1422	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-26 02:00:00+02	0.0813	2023-10-30 19:55:10.873+01	2023-10-30 19:55:10.873+01	2023-10-30 19:55:10.873+01	CO1	AWS
1423	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-25 02:00:00+02	0.0817	2023-10-30 19:55:10.874+01	2023-10-30 19:55:10.874+01	2023-10-30 19:55:10.874+01	CO1	AWS
1424	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-24 02:00:00+02	0.0821	2023-10-30 19:55:10.875+01	2023-10-30 19:55:10.875+01	2023-10-30 19:55:10.875+01	CO1	AWS
1425	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-23 02:00:00+02	0.0824	2023-10-30 19:55:10.876+01	2023-10-30 19:55:10.876+01	2023-10-30 19:55:10.876+01	CO1	AWS
1426	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-22 02:00:00+02	0.0818	2023-10-30 19:55:10.877+01	2023-10-30 19:55:10.877+01	2023-10-30 19:55:10.877+01	CO1	AWS
1427	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-21 02:00:00+02	0.0808	2023-10-30 19:55:10.879+01	2023-10-30 19:55:10.879+01	2023-10-30 19:55:10.879+01	CO1	AWS
1428	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-20 02:00:00+02	0.0802	2023-10-30 19:55:10.88+01	2023-10-30 19:55:10.88+01	2023-10-30 19:55:10.88+01	CO1	AWS
1429	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-19 02:00:00+02	0.0796	2023-10-30 19:55:10.881+01	2023-10-30 19:55:10.881+01	2023-10-30 19:55:10.881+01	CO1	AWS
1430	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-18 02:00:00+02	0.0791	2023-10-30 19:55:10.882+01	2023-10-30 19:55:10.882+01	2023-10-30 19:55:10.882+01	CO1	AWS
1431	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-17 02:00:00+02	0.0786	2023-10-30 19:55:10.883+01	2023-10-30 19:55:10.883+01	2023-10-30 19:55:10.883+01	CO1	AWS
1432	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-16 02:00:00+02	0.0770	2023-10-30 19:55:10.884+01	2023-10-30 19:55:10.884+01	2023-10-30 19:55:10.884+01	CO1	AWS
1433	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-15 02:00:00+02	0.0772	2023-10-30 19:55:10.885+01	2023-10-30 19:55:10.885+01	2023-10-30 19:55:10.885+01	CO1	AWS
1434	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-14 02:00:00+02	0.0764	2023-10-30 19:55:10.886+01	2023-10-30 19:55:10.886+01	2023-10-30 19:55:10.886+01	CO1	AWS
1435	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-13 02:00:00+02	0.0761	2023-10-30 19:55:10.887+01	2023-10-30 19:55:10.887+01	2023-10-30 19:55:10.887+01	CO1	AWS
1436	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-12 02:00:00+02	0.0764	2023-10-30 19:55:10.888+01	2023-10-30 19:55:10.888+01	2023-10-30 19:55:10.888+01	CO1	AWS
1437	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-11 02:00:00+02	0.0754	2023-10-30 19:55:10.888+01	2023-10-30 19:55:10.888+01	2023-10-30 19:55:10.888+01	CO1	AWS
1438	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-10 02:00:00+02	0.0755	2023-10-30 19:55:10.889+01	2023-10-30 19:55:10.889+01	2023-10-30 19:55:10.889+01	CO1	AWS
1439	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-09 02:00:00+02	0.0741	2023-10-30 19:55:10.89+01	2023-10-30 19:55:10.89+01	2023-10-30 19:55:10.89+01	CO1	AWS
1440	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-08 02:00:00+02	0.0736	2023-10-30 19:55:10.89+01	2023-10-30 19:55:10.89+01	2023-10-30 19:55:10.89+01	CO1	AWS
1441	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-07 02:00:00+02	0.0735	2023-10-30 19:55:10.891+01	2023-10-30 19:55:10.891+01	2023-10-30 19:55:10.891+01	CO1	AWS
1442	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-06 02:00:00+02	0.0742	2023-10-30 19:55:10.893+01	2023-10-30 19:55:10.893+01	2023-10-30 19:55:10.893+01	CO1	AWS
1443	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-05 02:00:00+02	0.0743	2023-10-30 19:55:10.893+01	2023-10-30 19:55:10.893+01	2023-10-30 19:55:10.893+01	CO1	AWS
1444	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-04 02:00:00+02	0.0770	2023-10-30 19:55:10.894+01	2023-10-30 19:55:10.894+01	2023-10-30 19:55:10.894+01	CO1	AWS
1445	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-03 02:00:00+02	0.0765	2023-10-30 19:55:10.895+01	2023-10-30 19:55:10.895+01	2023-10-30 19:55:10.895+01	CO1	AWS
1446	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-02 02:00:00+02	0.0781	2023-10-30 19:55:10.895+01	2023-10-30 19:55:10.895+01	2023-10-30 19:55:10.895+01	CO1	AWS
1447	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-09-01 02:00:00+02	0.0770	2023-10-30 19:55:10.896+01	2023-10-30 19:55:10.896+01	2023-10-30 19:55:10.896+01	CO1	AWS
1448	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-08-31 02:00:00+02	0.0779	2023-10-30 19:55:10.897+01	2023-10-30 19:55:10.897+01	2023-10-30 19:55:10.897+01	CO1	AWS
1449	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-30 01:00:00+01	0.0854	2023-10-30 19:55:11.415+01	2023-10-30 19:55:11.415+01	2023-10-30 19:55:11.415+01	CO1	AWS
1450	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-29 02:00:00+02	0.0845	2023-10-30 19:55:11.416+01	2023-10-30 19:55:11.416+01	2023-10-30 19:55:11.416+01	CO1	AWS
1451	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-28 02:00:00+02	0.0856	2023-10-30 19:55:11.417+01	2023-10-30 19:55:11.417+01	2023-10-30 19:55:11.417+01	CO1	AWS
1452	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-27 02:00:00+02	0.0868	2023-10-30 19:55:11.418+01	2023-10-30 19:55:11.418+01	2023-10-30 19:55:11.418+01	CO1	AWS
1453	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-26 02:00:00+02	0.0873	2023-10-30 19:55:11.419+01	2023-10-30 19:55:11.419+01	2023-10-30 19:55:11.419+01	CO1	AWS
1454	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-25 02:00:00+02	0.0883	2023-10-30 19:55:11.42+01	2023-10-30 19:55:11.42+01	2023-10-30 19:55:11.42+01	CO1	AWS
1455	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-24 02:00:00+02	0.0893	2023-10-30 19:55:11.42+01	2023-10-30 19:55:11.42+01	2023-10-30 19:55:11.42+01	CO1	AWS
1456	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-23 02:00:00+02	0.0901	2023-10-30 19:55:11.421+01	2023-10-30 19:55:11.421+01	2023-10-30 19:55:11.421+01	CO1	AWS
1457	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-22 02:00:00+02	0.0903	2023-10-30 19:55:11.422+01	2023-10-30 19:55:11.422+01	2023-10-30 19:55:11.422+01	CO1	AWS
1458	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-21 02:00:00+02	0.0925	2023-10-30 19:55:11.423+01	2023-10-30 19:55:11.423+01	2023-10-30 19:55:11.423+01	CO1	AWS
1459	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-20 02:00:00+02	0.0954	2023-10-30 19:55:11.423+01	2023-10-30 19:55:11.423+01	2023-10-30 19:55:11.423+01	CO1	AWS
1460	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-19 02:00:00+02	0.0954	2023-10-30 19:55:11.424+01	2023-10-30 19:55:11.424+01	2023-10-30 19:55:11.424+01	CO1	AWS
1461	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-18 02:00:00+02	0.0938	2023-10-30 19:55:11.427+01	2023-10-30 19:55:11.427+01	2023-10-30 19:55:11.427+01	CO1	AWS
1462	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-17 02:00:00+02	0.1016	2023-10-30 19:55:11.428+01	2023-10-30 19:55:11.428+01	2023-10-30 19:55:11.428+01	CO1	AWS
1463	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-16 02:00:00+02	0.1024	2023-10-30 19:55:11.429+01	2023-10-30 19:55:11.429+01	2023-10-30 19:55:11.429+01	CO1	AWS
1464	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-15 02:00:00+02	0.1035	2023-10-30 19:55:11.43+01	2023-10-30 19:55:11.43+01	2023-10-30 19:55:11.43+01	CO1	AWS
1465	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-14 02:00:00+02	0.1053	2023-10-30 19:55:11.431+01	2023-10-30 19:55:11.431+01	2023-10-30 19:55:11.431+01	CO1	AWS
1466	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-13 02:00:00+02	0.1059	2023-10-30 19:55:11.433+01	2023-10-30 19:55:11.433+01	2023-10-30 19:55:11.433+01	CO1	AWS
1467	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-12 02:00:00+02	0.1054	2023-10-30 19:55:11.434+01	2023-10-30 19:55:11.434+01	2023-10-30 19:55:11.434+01	CO1	AWS
1468	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-11 02:00:00+02	0.1116	2023-10-30 19:55:11.435+01	2023-10-30 19:55:11.435+01	2023-10-30 19:55:11.435+01	CO1	AWS
1469	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-10 02:00:00+02	0.1141	2023-10-30 19:55:11.436+01	2023-10-30 19:55:11.436+01	2023-10-30 19:55:11.436+01	CO1	AWS
1470	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-09 02:00:00+02	0.1156	2023-10-30 19:55:11.437+01	2023-10-30 19:55:11.437+01	2023-10-30 19:55:11.437+01	CO1	AWS
1471	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-08 02:00:00+02	0.1153	2023-10-30 19:55:11.439+01	2023-10-30 19:55:11.439+01	2023-10-30 19:55:11.439+01	CO1	AWS
1472	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-07 02:00:00+02	0.1180	2023-10-30 19:55:11.44+01	2023-10-30 19:55:11.44+01	2023-10-30 19:55:11.44+01	CO1	AWS
1473	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-06 02:00:00+02	0.1182	2023-10-30 19:55:11.441+01	2023-10-30 19:55:11.441+01	2023-10-30 19:55:11.441+01	CO1	AWS
1474	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-05 02:00:00+02	0.1195	2023-10-30 19:55:11.442+01	2023-10-30 19:55:11.442+01	2023-10-30 19:55:11.442+01	CO1	AWS
1475	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-04 02:00:00+02	0.1222	2023-10-30 19:55:11.446+01	2023-10-30 19:55:11.446+01	2023-10-30 19:55:11.446+01	CO1	AWS
1476	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-03 02:00:00+02	0.1241	2023-10-30 19:55:11.447+01	2023-10-30 19:55:11.447+01	2023-10-30 19:55:11.447+01	CO1	AWS
1477	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-02 02:00:00+02	0.1264	2023-10-30 19:55:11.448+01	2023-10-30 19:55:11.448+01	2023-10-30 19:55:11.448+01	CO1	AWS
1478	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-10-01 02:00:00+02	0.1259	2023-10-30 19:55:11.448+01	2023-10-30 19:55:11.448+01	2023-10-30 19:55:11.448+01	CO1	AWS
1479	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-30 02:00:00+02	0.1260	2023-10-30 19:55:11.449+01	2023-10-30 19:55:11.449+01	2023-10-30 19:55:11.449+01	CO1	AWS
1480	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-29 02:00:00+02	0.1254	2023-10-30 19:55:11.45+01	2023-10-30 19:55:11.45+01	2023-10-30 19:55:11.45+01	CO1	AWS
1481	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-28 02:00:00+02	0.1255	2023-10-30 19:55:11.451+01	2023-10-30 19:55:11.451+01	2023-10-30 19:55:11.451+01	CO1	AWS
1482	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-27 02:00:00+02	0.1254	2023-10-30 19:55:11.452+01	2023-10-30 19:55:11.452+01	2023-10-30 19:55:11.452+01	CO1	AWS
1483	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-26 02:00:00+02	0.1253	2023-10-30 19:55:11.453+01	2023-10-30 19:55:11.453+01	2023-10-30 19:55:11.453+01	CO1	AWS
1484	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-25 02:00:00+02	0.1251	2023-10-30 19:55:11.455+01	2023-10-30 19:55:11.455+01	2023-10-30 19:55:11.455+01	CO1	AWS
1485	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-24 02:00:00+02	0.1250	2023-10-30 19:55:11.455+01	2023-10-30 19:55:11.455+01	2023-10-30 19:55:11.455+01	CO1	AWS
1486	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-23 02:00:00+02	0.1253	2023-10-30 19:55:11.456+01	2023-10-30 19:55:11.456+01	2023-10-30 19:55:11.456+01	CO1	AWS
1487	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-22 02:00:00+02	0.1251	2023-10-30 19:55:11.457+01	2023-10-30 19:55:11.457+01	2023-10-30 19:55:11.457+01	CO1	AWS
1488	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-21 02:00:00+02	0.1255	2023-10-30 19:55:11.458+01	2023-10-30 19:55:11.458+01	2023-10-30 19:55:11.458+01	CO1	AWS
1489	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-20 02:00:00+02	0.1248	2023-10-30 19:55:11.46+01	2023-10-30 19:55:11.46+01	2023-10-30 19:55:11.46+01	CO1	AWS
1490	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-19 02:00:00+02	0.1249	2023-10-30 19:55:11.461+01	2023-10-30 19:55:11.461+01	2023-10-30 19:55:11.461+01	CO1	AWS
1491	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-18 02:00:00+02	0.1253	2023-10-30 19:55:11.462+01	2023-10-30 19:55:11.462+01	2023-10-30 19:55:11.462+01	CO1	AWS
1492	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-17 02:00:00+02	0.1253	2023-10-30 19:55:11.463+01	2023-10-30 19:55:11.463+01	2023-10-30 19:55:11.463+01	CO1	AWS
1493	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-16 02:00:00+02	0.1254	2023-10-30 19:55:11.464+01	2023-10-30 19:55:11.464+01	2023-10-30 19:55:11.464+01	CO1	AWS
1494	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-15 02:00:00+02	0.1250	2023-10-30 19:55:11.465+01	2023-10-30 19:55:11.465+01	2023-10-30 19:55:11.465+01	CO1	AWS
1495	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-14 02:00:00+02	0.1253	2023-10-30 19:55:11.466+01	2023-10-30 19:55:11.466+01	2023-10-30 19:55:11.466+01	CO1	AWS
1496	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-13 02:00:00+02	0.1257	2023-10-30 19:55:11.467+01	2023-10-30 19:55:11.467+01	2023-10-30 19:55:11.467+01	CO1	AWS
1497	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-12 02:00:00+02	0.1256	2023-10-30 19:55:11.468+01	2023-10-30 19:55:11.468+01	2023-10-30 19:55:11.468+01	CO1	AWS
1498	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-11 02:00:00+02	0.1257	2023-10-30 19:55:11.468+01	2023-10-30 19:55:11.468+01	2023-10-30 19:55:11.468+01	CO1	AWS
1499	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-10 02:00:00+02	0.1257	2023-10-30 19:55:11.469+01	2023-10-30 19:55:11.469+01	2023-10-30 19:55:11.469+01	CO1	AWS
1500	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-09 02:00:00+02	0.1257	2023-10-30 19:55:11.47+01	2023-10-30 19:55:11.47+01	2023-10-30 19:55:11.47+01	CO1	AWS
1501	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-08 02:00:00+02	0.1260	2023-10-30 19:55:11.471+01	2023-10-30 19:55:11.471+01	2023-10-30 19:55:11.471+01	CO1	AWS
1502	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-07 02:00:00+02	0.1255	2023-10-30 19:55:11.473+01	2023-10-30 19:55:11.473+01	2023-10-30 19:55:11.473+01	CO1	AWS
1503	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-06 02:00:00+02	0.1259	2023-10-30 19:55:11.473+01	2023-10-30 19:55:11.473+01	2023-10-30 19:55:11.473+01	CO1	AWS
1504	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-05 02:00:00+02	0.1256	2023-10-30 19:55:11.474+01	2023-10-30 19:55:11.474+01	2023-10-30 19:55:11.474+01	CO1	AWS
1505	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-04 02:00:00+02	0.1259	2023-10-30 19:55:11.475+01	2023-10-30 19:55:11.475+01	2023-10-30 19:55:11.475+01	CO1	AWS
1506	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-03 02:00:00+02	0.1254	2023-10-30 19:55:11.476+01	2023-10-30 19:55:11.476+01	2023-10-30 19:55:11.476+01	CO1	AWS
1507	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-02 02:00:00+02	0.1264	2023-10-30 19:55:11.477+01	2023-10-30 19:55:11.477+01	2023-10-30 19:55:11.477+01	CO1	AWS
1508	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-09-01 02:00:00+02	0.1264	2023-10-30 19:55:11.478+01	2023-10-30 19:55:11.478+01	2023-10-30 19:55:11.478+01	CO1	AWS
1509	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-08-31 02:00:00+02	0.1265	2023-10-30 19:55:11.48+01	2023-10-30 19:55:11.48+01	2023-10-30 19:55:11.48+01	CO1	AWS
1510	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-30 01:00:00+01	0.0795	2023-10-30 19:55:11.517+01	2023-10-30 19:55:11.517+01	2023-10-30 19:55:11.517+01	GP1	AWS
1511	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-29 02:00:00+02	0.0782	2023-10-30 19:55:11.518+01	2023-10-30 19:55:11.518+01	2023-10-30 19:55:11.518+01	GP1	AWS
1512	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-28 02:00:00+02	0.0791	2023-10-30 19:55:11.52+01	2023-10-30 19:55:11.52+01	2023-10-30 19:55:11.52+01	GP1	AWS
1513	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-27 02:00:00+02	0.0808	2023-10-30 19:55:11.52+01	2023-10-30 19:55:11.52+01	2023-10-30 19:55:11.52+01	GP1	AWS
1514	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-26 02:00:00+02	0.0840	2023-10-30 19:55:11.521+01	2023-10-30 19:55:11.521+01	2023-10-30 19:55:11.521+01	GP1	AWS
1515	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-25 02:00:00+02	0.0804	2023-10-30 19:55:11.522+01	2023-10-30 19:55:11.522+01	2023-10-30 19:55:11.522+01	GP1	AWS
1516	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-24 02:00:00+02	0.0850	2023-10-30 19:55:11.523+01	2023-10-30 19:55:11.524+01	2023-10-30 19:55:11.524+01	GP1	AWS
1517	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-23 02:00:00+02	0.0880	2023-10-30 19:55:11.526+01	2023-10-30 19:55:11.526+01	2023-10-30 19:55:11.526+01	GP1	AWS
1518	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-22 02:00:00+02	0.0858	2023-10-30 19:55:11.53+01	2023-10-30 19:55:11.53+01	2023-10-30 19:55:11.53+01	GP1	AWS
1519	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-21 02:00:00+02	0.0879	2023-10-30 19:55:11.533+01	2023-10-30 19:55:11.533+01	2023-10-30 19:55:11.533+01	GP1	AWS
1520	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-20 02:00:00+02	0.0942	2023-10-30 19:55:11.535+01	2023-10-30 19:55:11.535+01	2023-10-30 19:55:11.535+01	GP1	AWS
1521	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-19 02:00:00+02	0.0928	2023-10-30 19:55:11.537+01	2023-10-30 19:55:11.537+01	2023-10-30 19:55:11.537+01	GP1	AWS
1522	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-18 02:00:00+02	0.0902	2023-10-30 19:55:11.539+01	2023-10-30 19:55:11.539+01	2023-10-30 19:55:11.539+01	GP1	AWS
1523	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-17 02:00:00+02	0.0895	2023-10-30 19:55:11.541+01	2023-10-30 19:55:11.541+01	2023-10-30 19:55:11.541+01	GP1	AWS
1524	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-16 02:00:00+02	0.0960	2023-10-30 19:55:11.543+01	2023-10-30 19:55:11.543+01	2023-10-30 19:55:11.543+01	GP1	AWS
1525	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-15 02:00:00+02	0.0943	2023-10-30 19:55:11.546+01	2023-10-30 19:55:11.546+01	2023-10-30 19:55:11.546+01	GP1	AWS
1526	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-14 02:00:00+02	0.0975	2023-10-30 19:55:11.548+01	2023-10-30 19:55:11.548+01	2023-10-30 19:55:11.548+01	GP1	AWS
1527	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-13 02:00:00+02	0.0993	2023-10-30 19:55:11.55+01	2023-10-30 19:55:11.55+01	2023-10-30 19:55:11.55+01	GP1	AWS
1528	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-12 02:00:00+02	0.1007	2023-10-30 19:55:11.551+01	2023-10-30 19:55:11.551+01	2023-10-30 19:55:11.551+01	GP1	AWS
1529	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-11 02:00:00+02	0.1062	2023-10-30 19:55:11.552+01	2023-10-30 19:55:11.552+01	2023-10-30 19:55:11.552+01	GP1	AWS
1530	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-10 02:00:00+02	0.1084	2023-10-30 19:55:11.552+01	2023-10-30 19:55:11.552+01	2023-10-30 19:55:11.552+01	GP1	AWS
1531	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-09 02:00:00+02	0.1113	2023-10-30 19:55:11.553+01	2023-10-30 19:55:11.553+01	2023-10-30 19:55:11.553+01	GP1	AWS
1532	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-08 02:00:00+02	0.1135	2023-10-30 19:55:11.554+01	2023-10-30 19:55:11.554+01	2023-10-30 19:55:11.554+01	GP1	AWS
1533	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-07 02:00:00+02	0.1152	2023-10-30 19:55:11.556+01	2023-10-30 19:55:11.556+01	2023-10-30 19:55:11.556+01	GP1	AWS
1534	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-06 02:00:00+02	0.1179	2023-10-30 19:55:11.558+01	2023-10-30 19:55:11.558+01	2023-10-30 19:55:11.558+01	GP1	AWS
1535	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-05 02:00:00+02	0.1206	2023-10-30 19:55:11.56+01	2023-10-30 19:55:11.56+01	2023-10-30 19:55:11.56+01	GP1	AWS
1536	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-04 02:00:00+02	0.1263	2023-10-30 19:55:11.562+01	2023-10-30 19:55:11.562+01	2023-10-30 19:55:11.562+01	GP1	AWS
1537	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-03 02:00:00+02	0.1298	2023-10-30 19:55:11.563+01	2023-10-30 19:55:11.563+01	2023-10-30 19:55:11.563+01	GP1	AWS
1538	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-02 02:00:00+02	0.1321	2023-10-30 19:55:11.565+01	2023-10-30 19:55:11.565+01	2023-10-30 19:55:11.565+01	GP1	AWS
1539	t4g.xlarge-general-purpose	AWS-us-east-1	2023-10-01 02:00:00+02	0.1317	2023-10-30 19:55:11.566+01	2023-10-30 19:55:11.566+01	2023-10-30 19:55:11.566+01	GP1	AWS
1540	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-30 02:00:00+02	0.1314	2023-10-30 19:55:11.566+01	2023-10-30 19:55:11.566+01	2023-10-30 19:55:11.566+01	GP1	AWS
1541	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-29 02:00:00+02	0.1313	2023-10-30 19:55:11.567+01	2023-10-30 19:55:11.567+01	2023-10-30 19:55:11.567+01	GP1	AWS
1542	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-28 02:00:00+02	0.1313	2023-10-30 19:55:11.568+01	2023-10-30 19:55:11.568+01	2023-10-30 19:55:11.568+01	GP1	AWS
1543	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-27 02:00:00+02	0.1310	2023-10-30 19:55:11.569+01	2023-10-30 19:55:11.569+01	2023-10-30 19:55:11.569+01	GP1	AWS
1544	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-26 02:00:00+02	0.1306	2023-10-30 19:55:11.569+01	2023-10-30 19:55:11.569+01	2023-10-30 19:55:11.569+01	GP1	AWS
1545	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-25 02:00:00+02	0.1303	2023-10-30 19:55:11.57+01	2023-10-30 19:55:11.57+01	2023-10-30 19:55:11.57+01	GP1	AWS
1546	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-24 02:00:00+02	0.1297	2023-10-30 19:55:11.571+01	2023-10-30 19:55:11.571+01	2023-10-30 19:55:11.571+01	GP1	AWS
1547	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-23 02:00:00+02	0.1296	2023-10-30 19:55:11.571+01	2023-10-30 19:55:11.571+01	2023-10-30 19:55:11.571+01	GP1	AWS
1548	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-22 02:00:00+02	0.1296	2023-10-30 19:55:11.572+01	2023-10-30 19:55:11.572+01	2023-10-30 19:55:11.572+01	GP1	AWS
1549	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-21 02:00:00+02	0.1300	2023-10-30 19:55:11.573+01	2023-10-30 19:55:11.573+01	2023-10-30 19:55:11.573+01	GP1	AWS
1550	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-20 02:00:00+02	0.1301	2023-10-30 19:55:11.573+01	2023-10-30 19:55:11.573+01	2023-10-30 19:55:11.573+01	GP1	AWS
1551	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-19 02:00:00+02	0.1304	2023-10-30 19:55:11.574+01	2023-10-30 19:55:11.574+01	2023-10-30 19:55:11.574+01	GP1	AWS
1552	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-18 02:00:00+02	0.1306	2023-10-30 19:55:11.575+01	2023-10-30 19:55:11.575+01	2023-10-30 19:55:11.575+01	GP1	AWS
1553	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-17 02:00:00+02	0.1304	2023-10-30 19:55:11.576+01	2023-10-30 19:55:11.576+01	2023-10-30 19:55:11.576+01	GP1	AWS
1554	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-16 02:00:00+02	0.1305	2023-10-30 19:55:11.577+01	2023-10-30 19:55:11.577+01	2023-10-30 19:55:11.577+01	GP1	AWS
1555	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-15 02:00:00+02	0.1311	2023-10-30 19:55:11.578+01	2023-10-30 19:55:11.578+01	2023-10-30 19:55:11.578+01	GP1	AWS
1556	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-14 02:00:00+02	0.1315	2023-10-30 19:55:11.579+01	2023-10-30 19:55:11.579+01	2023-10-30 19:55:11.579+01	GP1	AWS
1557	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-13 02:00:00+02	0.1318	2023-10-30 19:55:11.58+01	2023-10-30 19:55:11.58+01	2023-10-30 19:55:11.58+01	GP1	AWS
1558	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-12 02:00:00+02	0.1319	2023-10-30 19:55:11.58+01	2023-10-30 19:55:11.58+01	2023-10-30 19:55:11.58+01	GP1	AWS
1559	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-11 02:00:00+02	0.1323	2023-10-30 19:55:11.581+01	2023-10-30 19:55:11.581+01	2023-10-30 19:55:11.581+01	GP1	AWS
1560	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-10 02:00:00+02	0.1328	2023-10-30 19:55:11.582+01	2023-10-30 19:55:11.582+01	2023-10-30 19:55:11.582+01	GP1	AWS
1561	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-09 02:00:00+02	0.1331	2023-10-30 19:55:11.582+01	2023-10-30 19:55:11.582+01	2023-10-30 19:55:11.582+01	GP1	AWS
1562	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-08 02:00:00+02	0.1340	2023-10-30 19:55:11.583+01	2023-10-30 19:55:11.583+01	2023-10-30 19:55:11.583+01	GP1	AWS
1563	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-07 02:00:00+02	0.1344	2023-10-30 19:55:11.584+01	2023-10-30 19:55:11.584+01	2023-10-30 19:55:11.584+01	GP1	AWS
1564	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-06 02:00:00+02	0.1344	2023-10-30 19:55:11.585+01	2023-10-30 19:55:11.585+01	2023-10-30 19:55:11.585+01	GP1	AWS
1565	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-05 02:00:00+02	0.1342	2023-10-30 19:55:11.585+01	2023-10-30 19:55:11.585+01	2023-10-30 19:55:11.585+01	GP1	AWS
1566	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-04 02:00:00+02	0.1343	2023-10-30 19:55:11.586+01	2023-10-30 19:55:11.586+01	2023-10-30 19:55:11.586+01	GP1	AWS
1567	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-03 02:00:00+02	0.1342	2023-10-30 19:55:11.587+01	2023-10-30 19:55:11.587+01	2023-10-30 19:55:11.587+01	GP1	AWS
1568	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-02 02:00:00+02	0.1344	2023-10-30 19:55:11.587+01	2023-10-30 19:55:11.587+01	2023-10-30 19:55:11.587+01	GP1	AWS
1569	t4g.xlarge-general-purpose	AWS-us-east-1	2023-09-01 02:00:00+02	0.1344	2023-10-30 19:55:11.588+01	2023-10-30 19:55:11.588+01	2023-10-30 19:55:11.588+01	GP1	AWS
1570	t4g.xlarge-general-purpose	AWS-us-east-1	2023-08-31 02:00:00+02	0.1344	2023-10-30 19:55:11.588+01	2023-10-30 19:55:11.588+01	2023-10-30 19:55:11.588+01	GP1	AWS
1571	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-30 01:00:00+01	0.0542	2023-10-30 19:55:11.997+01	2023-10-30 19:55:11.997+01	2023-10-30 19:55:11.997+01	GP1	AWS
1572	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-29 02:00:00+02	0.0563	2023-10-30 19:55:11.999+01	2023-10-30 19:55:11.999+01	2023-10-30 19:55:11.999+01	GP1	AWS
1573	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-28 02:00:00+02	0.0562	2023-10-30 19:55:12+01	2023-10-30 19:55:12+01	2023-10-30 19:55:12+01	GP1	AWS
1574	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-27 02:00:00+02	0.0553	2023-10-30 19:55:12.001+01	2023-10-30 19:55:12.001+01	2023-10-30 19:55:12.001+01	GP1	AWS
1575	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-26 02:00:00+02	0.0568	2023-10-30 19:55:12.002+01	2023-10-30 19:55:12.002+01	2023-10-30 19:55:12.002+01	GP1	AWS
1576	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-25 02:00:00+02	0.0568	2023-10-30 19:55:12.003+01	2023-10-30 19:55:12.003+01	2023-10-30 19:55:12.003+01	GP1	AWS
1577	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-30 01:00:00+01	0.0587	2023-10-30 19:55:12.005+01	2023-10-30 19:55:12.005+01	2023-10-30 19:55:12.005+01	CO1	AWS
1578	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-24 02:00:00+02	0.0582	2023-10-30 19:55:12.005+01	2023-10-30 19:55:12.005+01	2023-10-30 19:55:12.005+01	GP1	AWS
1579	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-29 02:00:00+02	0.0601	2023-10-30 19:55:12.009+01	2023-10-30 19:55:12.009+01	2023-10-30 19:55:12.009+01	CO1	AWS
1580	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-23 02:00:00+02	0.0581	2023-10-30 19:55:12.011+01	2023-10-30 19:55:12.011+01	2023-10-30 19:55:12.011+01	GP1	AWS
1581	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-22 02:00:00+02	0.0593	2023-10-30 19:55:12.014+01	2023-10-30 19:55:12.014+01	2023-10-30 19:55:12.014+01	GP1	AWS
1582	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-28 02:00:00+02	0.0602	2023-10-30 19:55:12.014+01	2023-10-30 19:55:12.014+01	2023-10-30 19:55:12.014+01	CO1	AWS
1583	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-21 02:00:00+02	0.0601	2023-10-30 19:55:12.015+01	2023-10-30 19:55:12.015+01	2023-10-30 19:55:12.015+01	GP1	AWS
1584	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-27 02:00:00+02	0.0587	2023-10-30 19:55:12.015+01	2023-10-30 19:55:12.015+01	2023-10-30 19:55:12.015+01	CO1	AWS
1585	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-20 02:00:00+02	0.0603	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	GP1	AWS
1586	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-26 02:00:00+02	0.0597	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	CO1	AWS
1587	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-19 02:00:00+02	0.0616	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	2023-10-30 19:55:12.016+01	GP1	AWS
1588	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-25 02:00:00+02	0.0590	2023-10-30 19:55:12.019+01	2023-10-30 19:55:12.019+01	2023-10-30 19:55:12.019+01	CO1	AWS
1589	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-18 02:00:00+02	0.0623	2023-10-30 19:55:12.019+01	2023-10-30 19:55:12.019+01	2023-10-30 19:55:12.019+01	GP1	AWS
1590	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-24 02:00:00+02	0.0587	2023-10-30 19:55:12.02+01	2023-10-30 19:55:12.02+01	2023-10-30 19:55:12.02+01	CO1	AWS
1592	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-23 02:00:00+02	0.0595	2023-10-30 19:55:12.021+01	2023-10-30 19:55:12.021+01	2023-10-30 19:55:12.021+01	CO1	AWS
1594	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-22 02:00:00+02	0.0601	2023-10-30 19:55:12.022+01	2023-10-30 19:55:12.022+01	2023-10-30 19:55:12.022+01	CO1	AWS
1596	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-21 02:00:00+02	0.0611	2023-10-30 19:55:12.024+01	2023-10-30 19:55:12.024+01	2023-10-30 19:55:12.024+01	CO1	AWS
1599	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-20 02:00:00+02	0.0628	2023-10-30 19:55:12.026+01	2023-10-30 19:55:12.026+01	2023-10-30 19:55:12.026+01	CO1	AWS
1601	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-19 02:00:00+02	0.0642	2023-10-30 19:55:12.027+01	2023-10-30 19:55:12.027+01	2023-10-30 19:55:12.027+01	CO1	AWS
1603	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-18 02:00:00+02	0.0667	2023-10-30 19:55:12.028+01	2023-10-30 19:55:12.028+01	2023-10-30 19:55:12.028+01	CO1	AWS
1605	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-17 02:00:00+02	0.0686	2023-10-30 19:55:12.029+01	2023-10-30 19:55:12.029+01	2023-10-30 19:55:12.029+01	CO1	AWS
1607	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-16 02:00:00+02	0.0701	2023-10-30 19:55:12.03+01	2023-10-30 19:55:12.03+01	2023-10-30 19:55:12.03+01	CO1	AWS
1609	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-15 02:00:00+02	0.0727	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	CO1	AWS
1611	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-14 02:00:00+02	0.0724	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	CO1	AWS
1613	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-13 02:00:00+02	0.0770	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	CO1	AWS
1615	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-12 02:00:00+02	0.0810	2023-10-30 19:55:12.034+01	2023-10-30 19:55:12.034+01	2023-10-30 19:55:12.034+01	CO1	AWS
1617	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-11 02:00:00+02	0.0838	2023-10-30 19:55:12.035+01	2023-10-30 19:55:12.035+01	2023-10-30 19:55:12.035+01	CO1	AWS
1619	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-10 02:00:00+02	0.0863	2023-10-30 19:55:12.036+01	2023-10-30 19:55:12.036+01	2023-10-30 19:55:12.036+01	CO1	AWS
1621	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-09 02:00:00+02	0.0924	2023-10-30 19:55:12.037+01	2023-10-30 19:55:12.037+01	2023-10-30 19:55:12.037+01	CO1	AWS
1623	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-08 02:00:00+02	0.0901	2023-10-30 19:55:12.039+01	2023-10-30 19:55:12.039+01	2023-10-30 19:55:12.039+01	CO1	AWS
1626	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-07 02:00:00+02	0.0945	2023-10-30 19:55:12.04+01	2023-10-30 19:55:12.04+01	2023-10-30 19:55:12.04+01	CO1	AWS
1628	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-06 02:00:00+02	0.0955	2023-10-30 19:55:12.041+01	2023-10-30 19:55:12.041+01	2023-10-30 19:55:12.041+01	CO1	AWS
1630	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-05 02:00:00+02	0.0995	2023-10-30 19:55:12.042+01	2023-10-30 19:55:12.042+01	2023-10-30 19:55:12.042+01	CO1	AWS
1632	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-04 02:00:00+02	0.1024	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	CO1	AWS
1634	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-03 02:00:00+02	0.1058	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	CO1	AWS
1636	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-02 02:00:00+02	0.1038	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	CO1	AWS
1638	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-10-01 02:00:00+02	0.1092	2023-10-30 19:55:12.045+01	2023-10-30 19:55:12.045+01	2023-10-30 19:55:12.045+01	CO1	AWS
1640	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-30 02:00:00+02	0.1129	2023-10-30 19:55:12.046+01	2023-10-30 19:55:12.046+01	2023-10-30 19:55:12.046+01	CO1	AWS
1642	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-29 02:00:00+02	0.1174	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	CO1	AWS
1644	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-28 02:00:00+02	0.1204	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	CO1	AWS
1646	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-27 02:00:00+02	0.1238	2023-10-30 19:55:12.048+01	2023-10-30 19:55:12.048+01	2023-10-30 19:55:12.048+01	CO1	AWS
1648	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-26 02:00:00+02	0.1242	2023-10-30 19:55:12.049+01	2023-10-30 19:55:12.049+01	2023-10-30 19:55:12.049+01	CO1	AWS
1650	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-25 02:00:00+02	0.1240	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	CO1	AWS
1652	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-24 02:00:00+02	0.1243	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	CO1	AWS
1654	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-23 02:00:00+02	0.1240	2023-10-30 19:55:12.051+01	2023-10-30 19:55:12.051+01	2023-10-30 19:55:12.051+01	CO1	AWS
1656	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-22 02:00:00+02	0.1241	2023-10-30 19:55:12.052+01	2023-10-30 19:55:12.052+01	2023-10-30 19:55:12.052+01	CO1	AWS
1658	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-21 02:00:00+02	0.1234	2023-10-30 19:55:12.053+01	2023-10-30 19:55:12.053+01	2023-10-30 19:55:12.053+01	CO1	AWS
1660	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-20 02:00:00+02	0.1232	2023-10-30 19:55:12.054+01	2023-10-30 19:55:12.054+01	2023-10-30 19:55:12.054+01	CO1	AWS
1662	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-19 02:00:00+02	0.1239	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	CO1	AWS
1664	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-18 02:00:00+02	0.1241	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	CO1	AWS
1666	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-17 02:00:00+02	0.1233	2023-10-30 19:55:12.056+01	2023-10-30 19:55:12.056+01	2023-10-30 19:55:12.056+01	CO1	AWS
1668	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-16 02:00:00+02	0.1234	2023-10-30 19:55:12.057+01	2023-10-30 19:55:12.057+01	2023-10-30 19:55:12.057+01	CO1	AWS
1670	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-15 02:00:00+02	0.1235	2023-10-30 19:55:12.058+01	2023-10-30 19:55:12.058+01	2023-10-30 19:55:12.058+01	CO1	AWS
1672	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-14 02:00:00+02	0.1233	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	CO1	AWS
1674	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-13 02:00:00+02	0.1239	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	CO1	AWS
1676	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-12 02:00:00+02	0.1232	2023-10-30 19:55:12.062+01	2023-10-30 19:55:12.062+01	2023-10-30 19:55:12.062+01	CO1	AWS
1678	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-11 02:00:00+02	0.1235	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	CO1	AWS
1680	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-10 02:00:00+02	0.1237	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	CO1	AWS
1682	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-09 02:00:00+02	0.1227	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	CO1	AWS
1684	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-08 02:00:00+02	0.1227	2023-10-30 19:55:12.065+01	2023-10-30 19:55:12.065+01	2023-10-30 19:55:12.065+01	CO1	AWS
1685	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-07 02:00:00+02	0.1227	2023-10-30 19:55:12.066+01	2023-10-30 19:55:12.066+01	2023-10-30 19:55:12.066+01	CO1	AWS
1686	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-06 02:00:00+02	0.1228	2023-10-30 19:55:12.066+01	2023-10-30 19:55:12.066+01	2023-10-30 19:55:12.066+01	CO1	AWS
1687	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-05 02:00:00+02	0.1227	2023-10-30 19:55:12.067+01	2023-10-30 19:55:12.067+01	2023-10-30 19:55:12.067+01	CO1	AWS
1688	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-04 02:00:00+02	0.1233	2023-10-30 19:55:12.068+01	2023-10-30 19:55:12.068+01	2023-10-30 19:55:12.068+01	CO1	AWS
1689	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-03 02:00:00+02	0.1237	2023-10-30 19:55:12.068+01	2023-10-30 19:55:12.068+01	2023-10-30 19:55:12.068+01	CO1	AWS
1690	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-02 02:00:00+02	0.1242	2023-10-30 19:55:12.069+01	2023-10-30 19:55:12.069+01	2023-10-30 19:55:12.069+01	CO1	AWS
1691	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-09-01 02:00:00+02	0.1250	2023-10-30 19:55:12.07+01	2023-10-30 19:55:12.07+01	2023-10-30 19:55:12.07+01	CO1	AWS
1692	c6a.xlarge-compute-optimized	AWS-us-west-2	2023-08-31 02:00:00+02	0.1251	2023-10-30 19:55:12.071+01	2023-10-30 19:55:12.071+01	2023-10-30 19:55:12.071+01	CO1	AWS
1990	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-02 01:00:00+01	0.0315	2023-11-02 09:17:09.441+01	2023-11-02 09:17:09.441+01	2023-11-02 09:17:09.441+01	GP1	AWS
1991	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-02 01:00:00+01	0.0783	2023-11-02 09:17:09.656+01	2023-11-02 09:17:09.656+01	2023-11-02 09:17:09.656+01	CO1	AWS
1992	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-02 01:00:00+01	0.0491	2023-11-02 09:17:09.755+01	2023-11-02 09:17:09.755+01	2023-11-02 09:17:09.755+01	GP1	AWS
1993	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-02 01:00:00+01	0.0862	2023-11-02 09:17:10.364+01	2023-11-02 09:17:10.364+01	2023-11-02 09:17:10.364+01	CO1	AWS
2151	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-04 02:00:00+02	0.0460	2023-11-03 10:42:18.237+01	2023-11-03 10:42:18.238+01	2023-11-03 10:42:18.238+01	CO1	ALB
2152	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-05 02:00:00+02	0.0460	2023-11-03 10:42:18.242+01	2023-11-03 10:42:18.242+01	2023-11-03 10:42:18.242+01	CO1	ALB
2153	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-06 02:00:00+02	0.0460	2023-11-03 10:42:18.243+01	2023-11-03 10:42:18.243+01	2023-11-03 10:42:18.243+01	CO1	ALB
2154	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-07 02:00:00+02	0.0460	2023-11-03 10:42:18.244+01	2023-11-03 10:42:18.244+01	2023-11-03 10:42:18.244+01	CO1	ALB
2155	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-08 02:00:00+02	0.0460	2023-11-03 10:42:18.245+01	2023-11-03 10:42:18.245+01	2023-11-03 10:42:18.245+01	CO1	ALB
2156	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-09 02:00:00+02	0.0460	2023-11-03 10:42:18.246+01	2023-11-03 10:42:18.246+01	2023-11-03 10:42:18.246+01	CO1	ALB
1591	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-17 02:00:00+02	0.0644	2023-10-30 19:55:12.02+01	2023-10-30 19:55:12.02+01	2023-10-30 19:55:12.02+01	GP1	AWS
1593	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-16 02:00:00+02	0.0680	2023-10-30 19:55:12.021+01	2023-10-30 19:55:12.021+01	2023-10-30 19:55:12.021+01	GP1	AWS
1595	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-15 02:00:00+02	0.0681	2023-10-30 19:55:12.023+01	2023-10-30 19:55:12.023+01	2023-10-30 19:55:12.023+01	GP1	AWS
1597	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-14 02:00:00+02	0.0698	2023-10-30 19:55:12.024+01	2023-10-30 19:55:12.024+01	2023-10-30 19:55:12.024+01	GP1	AWS
1598	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-13 02:00:00+02	0.0729	2023-10-30 19:55:12.026+01	2023-10-30 19:55:12.026+01	2023-10-30 19:55:12.026+01	GP1	AWS
1600	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-12 02:00:00+02	0.0736	2023-10-30 19:55:12.027+01	2023-10-30 19:55:12.027+01	2023-10-30 19:55:12.027+01	GP1	AWS
1602	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-11 02:00:00+02	0.0818	2023-10-30 19:55:12.028+01	2023-10-30 19:55:12.028+01	2023-10-30 19:55:12.028+01	GP1	AWS
1604	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-10 02:00:00+02	0.0802	2023-10-30 19:55:12.029+01	2023-10-30 19:55:12.029+01	2023-10-30 19:55:12.029+01	GP1	AWS
1606	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-09 02:00:00+02	0.0866	2023-10-30 19:55:12.03+01	2023-10-30 19:55:12.03+01	2023-10-30 19:55:12.03+01	GP1	AWS
1608	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-08 02:00:00+02	0.0831	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	GP1	AWS
1610	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-07 02:00:00+02	0.0889	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	2023-10-30 19:55:12.031+01	GP1	AWS
1612	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-06 02:00:00+02	0.0947	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	2023-10-30 19:55:12.032+01	GP1	AWS
1614	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-05 02:00:00+02	0.0952	2023-10-30 19:55:12.033+01	2023-10-30 19:55:12.033+01	2023-10-30 19:55:12.033+01	GP1	AWS
1616	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-04 02:00:00+02	0.0988	2023-10-30 19:55:12.034+01	2023-10-30 19:55:12.034+01	2023-10-30 19:55:12.034+01	GP1	AWS
1618	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-03 02:00:00+02	0.1054	2023-10-30 19:55:12.036+01	2023-10-30 19:55:12.036+01	2023-10-30 19:55:12.036+01	GP1	AWS
1620	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-02 02:00:00+02	0.1073	2023-10-30 19:55:12.037+01	2023-10-30 19:55:12.037+01	2023-10-30 19:55:12.037+01	GP1	AWS
1622	t4g.xlarge-general-purpose	AWS-us-west-2	2023-10-01 02:00:00+02	0.1084	2023-10-30 19:55:12.038+01	2023-10-30 19:55:12.038+01	2023-10-30 19:55:12.038+01	GP1	AWS
1624	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-30 02:00:00+02	0.1138	2023-10-30 19:55:12.039+01	2023-10-30 19:55:12.039+01	2023-10-30 19:55:12.039+01	GP1	AWS
1625	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-29 02:00:00+02	0.1165	2023-10-30 19:55:12.04+01	2023-10-30 19:55:12.04+01	2023-10-30 19:55:12.04+01	GP1	AWS
1627	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-28 02:00:00+02	0.1207	2023-10-30 19:55:12.041+01	2023-10-30 19:55:12.041+01	2023-10-30 19:55:12.041+01	GP1	AWS
1629	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-27 02:00:00+02	0.1221	2023-10-30 19:55:12.041+01	2023-10-30 19:55:12.042+01	2023-10-30 19:55:12.042+01	GP1	AWS
1631	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-26 02:00:00+02	0.1228	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	GP1	AWS
1633	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-25 02:00:00+02	0.1225	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	2023-10-30 19:55:12.043+01	GP1	AWS
1635	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-24 02:00:00+02	0.1224	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	2023-10-30 19:55:12.044+01	GP1	AWS
1637	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-23 02:00:00+02	0.1220	2023-10-30 19:55:12.045+01	2023-10-30 19:55:12.045+01	2023-10-30 19:55:12.045+01	GP1	AWS
1639	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-22 02:00:00+02	0.1218	2023-10-30 19:55:12.046+01	2023-10-30 19:55:12.046+01	2023-10-30 19:55:12.046+01	GP1	AWS
1641	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-21 02:00:00+02	0.1218	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	GP1	AWS
1643	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-20 02:00:00+02	0.1214	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	2023-10-30 19:55:12.047+01	GP1	AWS
1645	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-19 02:00:00+02	0.1211	2023-10-30 19:55:12.048+01	2023-10-30 19:55:12.048+01	2023-10-30 19:55:12.048+01	GP1	AWS
1647	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-18 02:00:00+02	0.1207	2023-10-30 19:55:12.049+01	2023-10-30 19:55:12.049+01	2023-10-30 19:55:12.049+01	GP1	AWS
1649	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-17 02:00:00+02	0.1208	2023-10-30 19:55:12.049+01	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	GP1	AWS
1651	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-16 02:00:00+02	0.1203	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	2023-10-30 19:55:12.05+01	GP1	AWS
1653	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-15 02:00:00+02	0.1212	2023-10-30 19:55:12.051+01	2023-10-30 19:55:12.051+01	2023-10-30 19:55:12.051+01	GP1	AWS
1655	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-14 02:00:00+02	0.1212	2023-10-30 19:55:12.052+01	2023-10-30 19:55:12.052+01	2023-10-30 19:55:12.052+01	GP1	AWS
1657	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-13 02:00:00+02	0.1217	2023-10-30 19:55:12.053+01	2023-10-30 19:55:12.053+01	2023-10-30 19:55:12.053+01	GP1	AWS
1659	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-12 02:00:00+02	0.1212	2023-10-30 19:55:12.054+01	2023-10-30 19:55:12.054+01	2023-10-30 19:55:12.054+01	GP1	AWS
1661	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-11 02:00:00+02	0.1213	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	GP1	AWS
1663	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-10 02:00:00+02	0.1216	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	2023-10-30 19:55:12.055+01	GP1	AWS
1665	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-09 02:00:00+02	0.1206	2023-10-30 19:55:12.056+01	2023-10-30 19:55:12.056+01	2023-10-30 19:55:12.056+01	GP1	AWS
1667	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-08 02:00:00+02	0.1203	2023-10-30 19:55:12.057+01	2023-10-30 19:55:12.057+01	2023-10-30 19:55:12.057+01	GP1	AWS
1669	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-07 02:00:00+02	0.1201	2023-10-30 19:55:12.058+01	2023-10-30 19:55:12.058+01	2023-10-30 19:55:12.058+01	GP1	AWS
1671	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-06 02:00:00+02	0.1203	2023-10-30 19:55:12.059+01	2023-10-30 19:55:12.059+01	2023-10-30 19:55:12.059+01	GP1	AWS
1673	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-05 02:00:00+02	0.1197	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	2023-10-30 19:55:12.06+01	GP1	AWS
1675	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-04 02:00:00+02	0.1198	2023-10-30 19:55:12.062+01	2023-10-30 19:55:12.062+01	2023-10-30 19:55:12.062+01	GP1	AWS
1677	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-03 02:00:00+02	0.1193	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	GP1	AWS
1679	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-02 02:00:00+02	0.1192	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	2023-10-30 19:55:12.063+01	GP1	AWS
1681	t4g.xlarge-general-purpose	AWS-us-west-2	2023-09-01 02:00:00+02	0.1191	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	2023-10-30 19:55:12.064+01	GP1	AWS
1683	t4g.xlarge-general-purpose	AWS-us-west-2	2023-08-31 02:00:00+02	0.1189	2023-10-30 19:55:12.065+01	2023-10-30 19:55:12.065+01	2023-10-30 19:55:12.065+01	GP1	AWS
1994	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-10-28 02:00:00+02	0.0460	2023-11-02 09:17:27.56+01	2023-11-02 09:17:27.561+01	2023-11-02 09:17:27.561+01	GP1	ALB
1995	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-10-28 02:00:00+02	0.0370	2023-11-02 09:17:29.06+01	2023-11-02 09:17:29.061+01	2023-11-02 09:17:29.061+01	GP1	ALB
1996	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-10-28 02:00:00+02	0.0250	2023-11-02 09:17:29.426+01	2023-11-02 09:17:29.427+01	2023-11-02 09:17:29.427+01	GP1	ALB
2157	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-10 02:00:00+02	0.0460	2023-11-03 10:42:18.247+01	2023-11-03 10:42:18.247+01	2023-11-03 10:42:18.247+01	CO1	ALB
2158	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-11 02:00:00+02	0.0460	2023-11-03 10:42:18.249+01	2023-11-03 10:42:18.249+01	2023-11-03 10:42:18.249+01	CO1	ALB
2159	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-12 02:00:00+02	0.0460	2023-11-03 10:42:18.25+01	2023-11-03 10:42:18.25+01	2023-11-03 10:42:18.25+01	CO1	ALB
2160	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-13 02:00:00+02	0.0460	2023-11-03 10:42:18.251+01	2023-11-03 10:42:18.251+01	2023-11-03 10:42:18.251+01	CO1	ALB
2161	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-14 02:00:00+02	0.0460	2023-11-03 10:42:18.253+01	2023-11-03 10:42:18.253+01	2023-11-03 10:42:18.253+01	CO1	ALB
2162	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-15 02:00:00+02	0.0460	2023-11-03 10:42:18.254+01	2023-11-03 10:42:18.254+01	2023-11-03 10:42:18.254+01	CO1	ALB
2163	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-16 02:00:00+02	0.0460	2023-11-03 10:42:18.256+01	2023-11-03 10:42:18.256+01	2023-11-03 10:42:18.256+01	CO1	ALB
2164	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-17 02:00:00+02	0.0460	2023-11-03 10:42:18.257+01	2023-11-03 10:42:18.257+01	2023-11-03 10:42:18.257+01	CO1	ALB
2165	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-18 02:00:00+02	0.0460	2023-11-03 10:42:18.258+01	2023-11-03 10:42:18.258+01	2023-11-03 10:42:18.258+01	CO1	ALB
2166	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-19 02:00:00+02	0.0460	2023-11-03 10:42:18.259+01	2023-11-03 10:42:18.259+01	2023-11-03 10:42:18.259+01	CO1	ALB
2167	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-20 02:00:00+02	0.0460	2023-11-03 10:42:18.26+01	2023-11-03 10:42:18.26+01	2023-11-03 10:42:18.26+01	CO1	ALB
2168	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-21 02:00:00+02	0.0460	2023-11-03 10:42:18.261+01	2023-11-03 10:42:18.261+01	2023-11-03 10:42:18.261+01	CO1	ALB
2169	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-10-22 02:00:00+02	0.0460	2023-11-03 10:42:18.262+01	2023-11-03 10:42:18.262+01	2023-11-03 10:42:18.262+01	CO1	ALB
3588	D4s_v3-compute-optimized	AZR-eastus	2023-11-13 22:00:00+01	0.1231	2023-11-13 22:00:00+01	2023-11-13 22:00:00+01	2023-11-14 07:25:01.503+01	CO1	AZR
3608	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-12 22:00:00+01	0.0666	2023-11-14 07:25:02.702+01	2023-11-14 07:25:02.705+01	2023-11-14 07:25:02.705+01	GP1	AWS
3610	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-12 22:00:00+01	0.0713	2023-11-14 07:25:02.821+01	2023-11-14 07:25:02.824+01	2023-11-14 07:25:02.824+01	CO1	AWS
3612	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-12 22:00:00+01	0.0825	2023-11-14 07:25:03.121+01	2023-11-14 07:25:03.13+01	2023-11-14 07:25:03.13+01	CO1	AWS
3609	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-13 22:00:00+01	0.0718	2023-11-15 16:07:46.682+01	2023-11-14 07:25:02.822+01	2023-11-15 16:07:46.687+01	CO1	AWS
3607	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-13 22:00:00+01	0.0668	2023-11-15 16:07:46.682+01	2023-11-14 07:25:02.704+01	2023-11-15 16:07:46.687+01	GP1	AWS
3611	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-13 22:00:00+01	0.0823	2023-11-15 16:07:46.782+01	2023-11-14 07:25:03.123+01	2023-11-15 16:07:46.785+01	CO1	AWS
3728	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-16 22:00:00+01	0.0671	2023-11-17 21:25:43.492+01	2023-11-17 10:37:34.078+01	2023-11-17 21:25:43.495+01	GP1	AWS
3208	E2 Instance Core running in Los Angeles	GCP-AWS-us-west	2023-11-06 00:00:00+01	0.0260	2023-11-06 11:32:24.558+01	2023-11-06 11:32:24.559+01	2023-11-06 11:32:24.559+01	GP1	GCP
3747	D4s_v3-compute-optimized	AZR-westus	2023-11-21 00:00:00+01	0.1381	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:48.015+01	CO1	AZR
3388	c2-standard-4-compute-optimized	GCP-us-west	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:29.258+01	2023-11-08 10:57:29.258+01	2023-11-08 13:46:39.922+01	CO1	GCP
3614	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-12 22:00:00+01	0.0741	2023-11-14 07:25:03.129+01	2023-11-14 07:25:03.136+01	2023-11-14 07:25:03.136+01	GP1	AWS
3209	C2D AMD Instance Core running in Los Angeles	GCP-AWS-us-west	2023-11-06 00:00:00+01	0.0350	2023-11-06 11:32:24.568+01	2023-11-06 11:32:24.568+01	2023-11-06 11:32:24.568+01	CO1	GCP
3615	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-11 22:00:00+01	0.0753	2023-11-14 07:25:03.129+01	2023-11-14 07:25:03.14+01	2023-11-14 07:25:03.14+01	GP1	AWS
3617	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-12 22:00:00+01	0.0320	2023-11-14 07:25:03.267+01	2023-11-14 07:25:03.272+01	2023-11-14 07:25:03.272+01	GP1	AWS
3619	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-12 22:00:00+01	0.0643	2023-11-14 07:25:03.275+01	2023-11-14 07:25:03.278+01	2023-11-14 07:25:03.278+01	CO1	AWS
3621	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-12 22:00:00+01	0.0811	2023-11-14 07:25:03.366+01	2023-11-14 07:25:03.37+01	2023-11-14 07:25:03.37+01	CO1	AWS
3623	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-12 22:00:00+01	0.0529	2023-11-14 07:25:03.379+01	2023-11-14 07:25:03.382+01	2023-11-14 07:25:03.382+01	GP1	AWS
3624	e2-standard-4-general-purpose	GCP-us-west2	2023-11-13 22:00:00+01	0.2620	2023-11-14 07:25:11.409+01	2023-11-14 07:25:11.409+01	2023-11-14 07:25:11.409+01	GP1	GCP
3625	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-13 22:00:00+01	0.3554	2023-11-14 07:25:11.411+01	2023-11-14 07:25:11.411+01	2023-11-14 07:25:11.411+01	CO1	GCP
3626	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-13 22:00:00+01	0.1951	2023-11-14 07:25:11.413+01	2023-11-14 07:25:11.413+01	2023-11-14 07:25:11.413+01	CO1	GCP
3627	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-13 22:00:00+01	0.2399	2023-11-14 07:25:11.416+01	2023-11-14 07:25:11.416+01	2023-11-14 07:25:11.416+01	GP1	GCP
3628	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-13 22:00:00+01	0.2810	2023-11-14 07:25:11.418+01	2023-11-14 07:25:11.418+01	2023-11-14 07:25:11.418+01	GP1	GCP
3629	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-13 22:00:00+01	0.3809	2023-11-14 07:25:11.42+01	2023-11-14 07:25:11.42+01	2023-11-14 07:25:11.42+01	CO1	GCP
3630	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-13 22:00:00+01	0.3330	2023-11-14 07:25:11.422+01	2023-11-14 07:25:11.422+01	2023-11-14 07:25:11.422+01	CO1	GCP
3379	e2-standard-4-general-purpose	GCP-near-east	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:07.862+01	2023-11-08 10:57:07.863+01	2023-11-08 13:46:18.304+01	GP1	GCP
3631	e2-standard-4-general-purpose	GCP-us-east4	2023-11-13 22:00:00+01	0.2457	2023-11-14 07:25:11.423+01	2023-11-14 07:25:11.423+01	2023-11-14 07:25:11.423+01	GP1	GCP
3632	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-13 22:00:00+01	0.3252	2023-11-14 07:25:11.425+01	2023-11-14 07:25:11.425+01	2023-11-14 07:25:11.425+01	CO1	GCP
3380	e2-standard-4-general-purpose	GCP-us-east	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:10.147+01	2023-11-08 10:57:10.147+01	2023-11-08 13:46:20.782+01	GP1	GCP
3633	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-13 22:00:00+01	0.2620	2023-11-14 07:25:11.427+01	2023-11-14 07:25:11.428+01	2023-11-14 07:25:11.428+01	GP1	GCP
3613	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-13 22:00:00+01	0.0713	2023-11-15 16:07:46.747+01	2023-11-14 07:25:03.132+01	2023-11-15 16:07:46.751+01	GP1	AWS
3381	e2-standard-4-general-purpose	GCP-europe-central	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:12.657+01	2023-11-08 10:57:12.657+01	2023-11-08 13:46:23.749+01	GP1	GCP
3618	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-13 22:00:00+01	0.0640	2023-11-15 16:07:47.016+01	2023-11-14 07:25:03.276+01	2023-11-15 16:07:47.022+01	CO1	AWS
3382	e2-standard-4-general-purpose	GCP-asia-india	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:15.527+01	2023-11-08 10:57:15.527+01	2023-11-08 13:46:26.079+01	GP1	GCP
3620	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-13 22:00:00+01	0.0788	2023-11-15 16:07:47.082+01	2023-11-14 07:25:03.368+01	2023-11-15 16:07:47.085+01	CO1	AWS
3622	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-13 22:00:00+01	0.0530	2023-11-15 16:07:47.086+01	2023-11-14 07:25:03.38+01	2023-11-15 16:07:47.088+01	GP1	AWS
3383	e2-standard-4-general-purpose	GCP-us-west	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:17.379+01	2023-11-08 10:57:17.379+01	2023-11-08 13:46:27.801+01	GP1	GCP
3616	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-13 22:00:00+01	0.0305	2023-11-16 18:59:21.92+01	2023-11-14 07:25:03.269+01	2023-11-16 18:59:21.926+01	GP1	AWS
3384	c2-standard-4-compute-optimized	GCP-near-east	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:19.833+01	2023-11-08 10:57:19.833+01	2023-11-08 13:46:29.407+01	CO1	GCP
3385	c2-standard-4-compute-optimized	GCP-us-east	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:21.696+01	2023-11-08 10:57:21.696+01	2023-11-08 13:46:31.939+01	CO1	GCP
3386	c2-standard-4-compute-optimized	GCP-europe-central	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:24.208+01	2023-11-08 10:57:24.208+01	2023-11-08 13:46:34.581+01	CO1	GCP
3745	B4ms-general-purpose	AZR-polandcentral	2023-11-21 00:00:00+01	0.2498	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.905+01	GP1	AZR
3752	B4ms-general-purpose	AZR-israelcentral	2023-11-21 00:00:00+01	0.2423	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.907+01	GP1	AZR
3387	c2-standard-4-compute-optimized	GCP-asia-india	2023-11-08 09:00:00+01	0.2399	2023-11-08 10:57:26.764+01	2023-11-08 10:57:26.764+01	2023-11-08 13:46:37.51+01	CO1	GCP
3749	B4ms-general-purpose	AZR-southindia	2023-11-21 00:00:00+01	0.2335	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.915+01	GP1	AZR
3750	D4s_v3-compute-optimized	AZR-southindia	2023-11-21 00:00:00+01	0.1571	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.994+01	CO1	AZR
3751	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-21 00:00:00+01	0.1530	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.995+01	CO1	AZR
3392	e2-standard-4	GCP-asia-south1	2023-11-08 00:00:00+01	0.2620	2023-11-08 11:32:39.727+01	2023-11-08 11:05:50.713+01	2023-11-08 11:32:39.728+01	GP1	GCP
3634	B4ms-general-purpose	AZR-israelcentral	2023-11-14 22:00:00+01	0.2423	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:43.76+01	GP1	AZR
3755	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-20 01:00:00+01	0.0250	2023-11-21 17:14:30.66+01	2023-11-21 17:14:30.662+01	2023-11-21 17:14:30.662+01	GP1	ALB
3756	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-21 01:00:00+01	0.0250	2023-11-21 17:14:30.66+01	2023-11-21 17:14:30.664+01	2023-11-21 17:14:30.664+01	GP1	ALB
3757	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-20 01:00:00+01	0.0380	2023-11-21 17:14:32.883+01	2023-11-21 17:14:32.885+01	2023-11-21 17:14:32.885+01	GP1	ALB
3758	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-21 01:00:00+01	0.0380	2023-11-21 17:14:32.883+01	2023-11-21 17:14:32.888+01	2023-11-21 17:14:32.888+01	GP1	ALB
3759	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-20 01:00:00+01	0.0390	2023-11-21 17:14:35.823+01	2023-11-21 17:14:35.825+01	2023-11-21 17:14:35.825+01	GP1	ALB
3760	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-21 01:00:00+01	0.0390	2023-11-21 17:14:35.823+01	2023-11-21 17:14:35.828+01	2023-11-21 17:14:35.828+01	GP1	ALB
3761	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-20 01:00:00+01	0.0410	2023-11-21 17:14:42.066+01	2023-11-21 17:14:42.068+01	2023-11-21 17:14:42.068+01	GP1	ALB
3762	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-21 01:00:00+01	0.0410	2023-11-21 17:14:42.066+01	2023-11-21 17:14:42.072+01	2023-11-21 17:14:42.072+01	GP1	ALB
3763	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-20 01:00:00+01	0.0250	2023-11-21 17:14:42.635+01	2023-11-21 17:14:42.637+01	2023-11-21 17:14:42.637+01	CO1	ALB
3764	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-21 01:00:00+01	0.0250	2023-11-21 17:14:42.635+01	2023-11-21 17:14:42.639+01	2023-11-21 17:14:42.639+01	CO1	ALB
3765	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-20 01:00:00+01	0.0360	2023-11-21 17:14:43.149+01	2023-11-21 17:14:43.151+01	2023-11-21 17:14:43.151+01	CO1	ALB
3766	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-21 01:00:00+01	0.0360	2023-11-21 17:14:43.149+01	2023-11-21 17:14:43.154+01	2023-11-21 17:14:43.154+01	CO1	ALB
3767	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-20 01:00:00+01	0.0345	2023-11-21 17:14:44.909+01	2023-11-21 17:14:44.911+01	2023-11-21 17:14:44.911+01	CO1	ALB
3768	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-21 01:00:00+01	0.0345	2023-11-21 17:14:44.909+01	2023-11-21 17:14:44.913+01	2023-11-21 17:14:44.913+01	CO1	ALB
3769	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-20 01:00:00+01	0.0420	2023-11-21 17:14:45.848+01	2023-11-21 17:14:45.849+01	2023-11-21 17:14:45.849+01	CO1	ALB
3770	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-21 01:00:00+01	0.0420	2023-11-21 17:14:45.848+01	2023-11-21 17:14:45.851+01	2023-11-21 17:14:45.851+01	CO1	ALB
3771	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-20 01:00:00+01	0.0250	2023-11-21 17:14:47.55+01	2023-11-21 17:14:47.552+01	2023-11-21 17:14:47.552+01	CO1	ALB
3772	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-21 01:00:00+01	0.0250	2023-11-21 17:14:47.55+01	2023-11-21 17:14:47.555+01	2023-11-21 17:14:47.555+01	CO1	ALB
3746	B4ms-general-purpose	AZR-westus	2023-11-21 00:00:00+01	0.2405	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.914+01	GP1	AZR
3748	B4ms-general-purpose	AZR-eastus	2023-11-21 00:00:00+01	0.1965	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:47.948+01	GP1	AZR
3754	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-21 00:00:00+01	0.1585	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:48.002+01	CO1	AZR
3753	D4s_v3-compute-optimized	AZR-eastus	2023-11-21 00:00:00+01	0.1231	2023-11-21 00:00:00+01	2023-11-21 00:00:00+01	2023-11-21 17:14:48.078+01	CO1	AZR
3397	c2-standard-4	GCP-us-west1	2023-11-08 00:00:00+01	0.3554	2023-11-08 11:32:39.724+01	2023-11-08 11:18:05.218+01	2023-11-08 11:32:39.724+01	CO1	GCP
3635	B4ms-general-purpose	AZR-westus	2023-11-14 22:00:00+01	0.2405	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:43.653+01	GP1	AZR
3636	B4ms-general-purpose	AZR-polandcentral	2023-11-14 22:00:00+01	0.2498	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:43.678+01	GP1	AZR
3773	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-21 00:00:00+01	0.0725	2023-11-21 17:14:50.875+01	2023-11-21 17:14:50.877+01	2023-11-21 17:14:50.877+01	CO1	AWS
3774	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-20 00:00:00+01	0.0698	2023-11-21 17:14:50.875+01	2023-11-21 17:14:50.879+01	2023-11-21 17:14:50.879+01	CO1	AWS
3775	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-21 00:00:00+01	0.0664	2023-11-21 17:14:50.883+01	2023-11-21 17:14:50.885+01	2023-11-21 17:14:50.885+01	GP1	AWS
3776	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-20 00:00:00+01	0.0648	2023-11-21 17:14:50.883+01	2023-11-21 17:14:50.887+01	2023-11-21 17:14:50.887+01	GP1	AWS
3777	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-21 00:00:00+01	0.0697	2023-11-21 17:14:51.173+01	2023-11-21 17:14:51.175+01	2023-11-21 17:14:51.175+01	GP1	AWS
3778	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-20 00:00:00+01	0.0677	2023-11-21 17:14:51.173+01	2023-11-21 17:14:51.178+01	2023-11-21 17:14:51.178+01	GP1	AWS
3779	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-21 00:00:00+01	0.0798	2023-11-21 17:14:51.201+01	2023-11-21 17:14:51.203+01	2023-11-21 17:14:51.203+01	CO1	AWS
3780	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-20 00:00:00+01	0.0805	2023-11-21 17:14:51.201+01	2023-11-21 17:14:51.207+01	2023-11-21 17:14:51.207+01	CO1	AWS
3781	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-21 00:00:00+01	0.0767	2023-11-21 17:14:51.458+01	2023-11-21 17:14:51.461+01	2023-11-21 17:14:51.461+01	CO1	AWS
3782	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-20 00:00:00+01	0.0773	2023-11-21 17:14:51.458+01	2023-11-21 17:14:51.465+01	2023-11-21 17:14:51.465+01	CO1	AWS
3783	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-21 00:00:00+01	0.0583	2023-11-21 17:14:51.502+01	2023-11-21 17:14:51.504+01	2023-11-21 17:14:51.504+01	GP1	AWS
3784	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-20 00:00:00+01	0.0577	2023-11-21 17:14:51.502+01	2023-11-21 17:14:51.507+01	2023-11-21 17:14:51.507+01	GP1	AWS
3785	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-21 00:00:00+01	0.0319	2023-11-21 17:14:51.547+01	2023-11-21 17:14:51.548+01	2023-11-21 17:14:51.548+01	GP1	AWS
3786	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-20 00:00:00+01	0.0329	2023-11-21 17:14:51.547+01	2023-11-21 17:14:51.549+01	2023-11-21 17:14:51.549+01	GP1	AWS
3400	e2-standard-4	GCP-us-west1	2023-11-08 00:00:00+01	0.2620	2023-11-08 11:32:39.713+01	2023-11-08 11:32:39.714+01	2023-11-08 11:32:39.714+01	GP1	GCP
3401	c2-standard-4	GCP-middleeast-north1	2023-11-08 00:00:00+01	0.3592	2023-11-08 11:32:39.721+01	2023-11-08 11:32:39.721+01	2023-11-08 11:32:39.721+01	CO1	GCP
3643	B4ms-general-purpose	AZR-eastus	2023-11-14 22:00:00+01	0.1965	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:43.776+01	GP1	AZR
3637	B4ms-general-purpose	AZR-southindia	2023-11-14 22:00:00+01	0.2335	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:43.814+01	GP1	AZR
3640	D4s_v3-compute-optimized	AZR-southindia	2023-11-14 22:00:00+01	0.1571	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:44.724+01	CO1	AZR
3644	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-14 22:00:00+01	0.1585	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:44.765+01	CO1	AZR
3638	D4s_v3-compute-optimized	AZR-westus	2023-11-14 22:00:00+01	0.1381	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:44.788+01	CO1	AZR
3642	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-14 22:00:00+01	0.1530	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:45.174+01	CO1	AZR
3639	D4s_v3-compute-optimized	AZR-eastus	2023-11-14 22:00:00+01	0.1231	2023-11-14 22:00:00+01	2023-11-14 22:00:00+01	2023-11-15 16:07:45.175+01	CO1	AZR
3641	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-15 01:00:00+01	0.0250	2023-11-16 18:59:02.439+01	2023-11-15 16:07:29.573+01	2023-11-16 18:59:02.441+01	GP1	ALB
3645	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-15 01:00:00+01	0.0380	2023-11-16 18:59:04.519+01	2023-11-15 16:07:31.471+01	2023-11-16 18:59:04.523+01	GP1	ALB
3646	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-15 01:00:00+01	0.0390	2023-11-16 18:59:07.16+01	2023-11-15 16:07:33.343+01	2023-11-16 18:59:07.163+01	GP1	ALB
3647	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-15 01:00:00+01	0.0370	2023-11-16 18:59:12.756+01	2023-11-15 16:07:38.134+01	2023-11-16 18:59:12.76+01	GP1	ALB
3648	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-15 01:00:00+01	0.0250	2023-11-16 18:59:13.371+01	2023-11-15 16:07:38.719+01	2023-11-16 18:59:13.374+01	CO1	ALB
3649	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-15 01:00:00+01	0.0350	2023-11-16 18:59:13.795+01	2023-11-15 16:07:39.896+01	2023-11-16 18:59:13.798+01	CO1	ALB
3650	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-15 01:00:00+01	0.0325	2023-11-16 18:59:14.901+01	2023-11-15 16:07:41.069+01	2023-11-16 18:59:14.904+01	CO1	ALB
3651	ecs.c6.xlarge-compute-optimized	ALB-me-central-1	2023-11-15 01:00:00+01	0.0420	2023-11-16 18:59:15.755+01	2023-11-15 16:07:42.472+01	2023-11-16 18:59:15.757+01	CO1	ALB
3652	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-15 01:00:00+01	0.0250	2023-11-16 18:59:17.303+01	2023-11-15 16:07:43.324+01	2023-11-16 18:59:17.305+01	CO1	ALB
3787	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-21 00:00:00+01	0.0462	2023-11-21 17:14:51.55+01	2023-11-21 17:14:51.551+01	2023-11-21 17:14:51.551+01	CO1	AWS
3788	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-20 00:00:00+01	0.0489	2023-11-21 17:14:51.55+01	2023-11-21 17:14:51.554+01	2023-11-21 17:14:51.554+01	CO1	AWS
3789	e2-standard-4-general-purpose	GCP-us-west2	2023-11-21 00:00:00+01	0.2620	2023-11-21 17:14:57.022+01	2023-11-21 17:14:57.022+01	2023-11-21 17:14:57.022+01	GP1	GCP
3790	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-21 00:00:00+01	0.3554	2023-11-21 17:14:57.024+01	2023-11-21 17:14:57.025+01	2023-11-21 17:14:57.025+01	CO1	GCP
3791	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-21 00:00:00+01	0.1951	2023-11-21 17:14:57.026+01	2023-11-21 17:14:57.026+01	2023-11-21 17:14:57.026+01	CO1	GCP
3792	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-21 00:00:00+01	0.2399	2023-11-21 17:14:57.028+01	2023-11-21 17:14:57.028+01	2023-11-21 17:14:57.028+01	GP1	GCP
3793	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-21 00:00:00+01	0.2810	2023-11-21 17:14:57.032+01	2023-11-21 17:14:57.032+01	2023-11-21 17:14:57.032+01	GP1	GCP
3794	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-21 00:00:00+01	0.3809	2023-11-21 17:14:57.034+01	2023-11-21 17:14:57.034+01	2023-11-21 17:14:57.034+01	CO1	GCP
3795	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-21 00:00:00+01	0.3330	2023-11-21 17:14:57.036+01	2023-11-21 17:14:57.036+01	2023-11-21 17:14:57.036+01	CO1	GCP
3796	e2-standard-4-general-purpose	GCP-us-east4	2023-11-21 00:00:00+01	0.2457	2023-11-21 17:14:57.037+01	2023-11-21 17:14:57.037+01	2023-11-21 17:14:57.037+01	GP1	GCP
3797	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-21 00:00:00+01	0.3252	2023-11-21 17:14:57.038+01	2023-11-21 17:14:57.038+01	2023-11-21 17:14:57.038+01	CO1	GCP
3798	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-21 00:00:00+01	0.2620	2023-11-21 17:14:57.039+01	2023-11-21 17:14:57.039+01	2023-11-21 17:14:57.039+01	GP1	GCP
2807	B4ms-general-purpose	AZR-westus	2023-11-03 18:09:09.499+01	0.2405	2023-11-03 18:09:09.499+01	2023-11-03 18:09:09.499+01	2023-11-03 18:09:09.499+01	GP1	AZR
2809	B4ms-general-purpose	AZR-southindia	2023-11-03 18:09:09.507+01	0.2335	2023-11-03 18:09:09.507+01	2023-11-03 18:09:09.507+01	2023-11-03 18:09:09.507+01	GP1	AZR
3653	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-14 22:00:00+01	0.0731	2023-11-16 18:59:21.786+01	2023-11-15 16:07:46.684+01	2023-11-16 18:59:21.829+01	CO1	AWS
3407	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-08 00:00:00+01	0.2620	2023-11-08 13:39:48.42+01	2023-11-08 11:35:12.074+01	2023-11-08 13:39:48.42+01	GP1	GCP
3260	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-06 09:00:00+01	0.0848	2023-11-06 13:55:50+01	2023-11-06 13:55:50+01	2023-11-06 13:55:50+01	CO1	AWS
3261	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-05 09:00:00+01	0.0851	2023-11-06 13:55:50.003+01	2023-11-06 13:55:50.003+01	2023-11-06 13:55:50.003+01	CO1	AWS
3271	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-06 09:00:00+01	0.0504	2023-11-06 13:55:50.559+01	2023-11-06 13:55:50.559+01	2023-11-06 13:55:50.559+01	GP1	AWS
3273	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-05 09:00:00+01	0.0507	2023-11-06 13:55:50.56+01	2023-11-06 13:55:50.56+01	2023-11-06 13:55:50.56+01	GP1	AWS
3404	e2-standard-4-general-purpose	GCP-us-west1	2023-11-08 00:00:00+01	0.2620	2023-11-08 15:04:03.237+01	2023-11-08 11:35:12.062+01	2023-11-08 15:04:03.238+01	GP1	GCP
3405	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-08 00:00:00+01	0.3592	2023-11-08 15:04:03.243+01	2023-11-08 11:35:12.068+01	2023-11-08 15:04:03.243+01	CO1	GCP
3406	c2-standard-4-compute-optimized	GCP-us-west1	2023-11-08 00:00:00+01	0.3554	2023-11-08 15:04:03.246+01	2023-11-08 11:35:12.071+01	2023-11-08 15:04:03.246+01	CO1	GCP
3408	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-08 00:00:00+01	0.1951	2023-11-08 15:04:03.25+01	2023-11-08 11:35:12.076+01	2023-11-08 15:04:03.25+01	CO1	GCP
3409	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-08 00:00:00+01	0.5100	2023-11-08 15:04:03.254+01	2023-11-08 11:35:12.078+01	2023-11-08 15:04:03.254+01	CO1	GCP
3410	B4ms-general-purpose	AZR-polandcentral	2023-11-09 00:00:00+01	0.2498	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.023+01	GP1	AZR
3416	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-09 00:00:00+01	0.1585	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.127+01	CO1	AZR
2247	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-03 01:00:00+01	0.0380	2023-11-04 13:26:18.445+01	2023-11-03 11:36:41.953+01	2023-11-04 13:26:18.447+01	GP1	ALB
3661	e2-standard-4-general-purpose	GCP-us-west2	2023-11-14 22:00:00+01	0.2620	2023-11-15 16:07:53.221+01	2023-11-15 16:07:53.221+01	2023-11-15 16:07:53.221+01	GP1	GCP
3662	c2-standard-4-compute-optimized	GCP-us-west2	2023-11-14 22:00:00+01	0.3554	2023-11-15 16:07:53.224+01	2023-11-15 16:07:53.224+01	2023-11-15 16:07:53.224+01	CO1	GCP
3663	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-14 22:00:00+01	0.1951	2023-11-15 16:07:53.226+01	2023-11-15 16:07:53.226+01	2023-11-15 16:07:53.226+01	CO1	GCP
3664	e2-standard-4-general-purpose	GCP-middleeast-north1	2023-11-14 22:00:00+01	0.2399	2023-11-15 16:07:53.228+01	2023-11-15 16:07:53.228+01	2023-11-15 16:07:53.228+01	GP1	GCP
3665	e2-standard-4-general-purpose	GCP-europe-central1	2023-11-14 22:00:00+01	0.2810	2023-11-15 16:07:53.229+01	2023-11-15 16:07:53.229+01	2023-11-15 16:07:53.229+01	GP1	GCP
3666	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-14 22:00:00+01	0.3809	2023-11-15 16:07:53.232+01	2023-11-15 16:07:53.232+01	2023-11-15 16:07:53.232+01	CO1	GCP
3667	c2-standard-4-compute-optimized	GCP-us-east4	2023-11-14 22:00:00+01	0.3330	2023-11-15 16:07:53.233+01	2023-11-15 16:07:53.233+01	2023-11-15 16:07:53.233+01	CO1	GCP
3668	e2-standard-4-general-purpose	GCP-us-east4	2023-11-14 22:00:00+01	0.2457	2023-11-15 16:07:53.235+01	2023-11-15 16:07:53.235+01	2023-11-15 16:07:53.235+01	GP1	GCP
3669	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-14 22:00:00+01	0.3252	2023-11-15 16:07:53.237+01	2023-11-15 16:07:53.237+01	2023-11-15 16:07:53.237+01	CO1	GCP
3670	e2-standard-4-general-purpose	GCP-asia-south1	2023-11-14 22:00:00+01	0.2620	2023-11-15 16:07:53.239+01	2023-11-15 16:07:53.239+01	2023-11-15 16:07:53.239+01	GP1	GCP
3654	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-14 22:00:00+01	0.0665	2023-11-16 18:59:21.786+01	2023-11-15 16:07:46.685+01	2023-11-16 18:59:21.822+01	GP1	AWS
3656	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-14 22:00:00+01	0.0820	2023-11-16 18:59:21.904+01	2023-11-15 16:07:46.784+01	2023-11-16 18:59:21.911+01	CO1	AWS
3657	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-14 22:00:00+01	0.0579	2023-11-16 18:59:21.913+01	2023-11-15 16:07:47.018+01	2023-11-16 18:59:21.918+01	CO1	AWS
3658	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-14 22:00:00+01	0.0327	2023-11-16 18:59:21.92+01	2023-11-15 16:07:47.031+01	2023-11-16 18:59:21.924+01	GP1	AWS
3655	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-14 22:00:00+01	0.0723	2023-11-16 18:59:21.935+01	2023-11-15 16:07:46.749+01	2023-11-16 18:59:21.939+01	GP1	AWS
3660	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-14 22:00:00+01	0.0534	2023-11-16 18:59:21.968+01	2023-11-15 16:07:47.087+01	2023-11-16 18:59:21.972+01	GP1	AWS
3659	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-14 22:00:00+01	0.0749	2023-11-16 18:59:21.971+01	2023-11-15 16:07:47.083+01	2023-11-16 18:59:21.974+01	CO1	AWS
3268	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-05 09:00:00+01	0.0316	2023-11-06 13:55:50.308+01	2023-11-06 13:55:50.309+01	2023-11-06 13:55:50.309+01	GP1	AWS
3270	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-06 09:00:00+01	0.0746	2023-11-06 13:55:50.558+01	2023-11-06 13:55:50.558+01	2023-11-06 13:55:50.558+01	CO1	AWS
3272	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-05 09:00:00+01	0.0782	2023-11-06 13:55:50.56+01	2023-11-06 13:55:50.56+01	2023-11-06 13:55:50.56+01	CO1	AWS
3276	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-06 09:00:00+01	0.0842	2023-11-06 13:55:51.237+01	2023-11-06 13:55:51.237+01	2023-11-06 13:55:51.237+01	CO1	AWS
3277	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-05 09:00:00+01	0.0853	2023-11-06 13:55:51.239+01	2023-11-06 13:55:51.239+01	2023-11-06 13:55:51.239+01	CO1	AWS
3411	B4ms-general-purpose	AZR-westus	2023-11-09 00:00:00+01	0.2405	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.005+01	GP1	AZR
3415	D4s_v3-compute-optimized	AZR-westus	2023-11-09 00:00:00+01	0.1381	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.098+01	CO1	AZR
3671	B4ms-general-purpose	AZR-eastus	2023-11-15 22:00:00+01	0.1965	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:18.039+01	GP1	AZR
3673	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-15 22:00:00+01	0.1585	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:19.034+01	CO1	AZR
2266	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-03 01:00:00+01	0.0460	2023-11-04 13:26:22.113+01	2023-11-03 11:36:42.367+01	2023-11-04 13:26:22.117+01	CO1	ALB
3216	e2-standard-4-general-purpose	GCP-near-east	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:20.987+01	2023-11-06 12:51:20.989+01	2023-11-06 13:01:16.528+01	GP1	GCP
3217	e2-standard-4-general-purpose	GCP-us-east	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:23.226+01	2023-11-06 12:51:23.226+01	2023-11-06 13:01:19.174+01	GP1	GCP
3218	e2-standard-4-general-purpose	GCP-europe-central	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:26.099+01	2023-11-06 12:51:26.099+01	2023-11-06 13:01:22.053+01	GP1	GCP
3219	e2-standard-4-general-purpose	GCP-asia-india	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:29.29+01	2023-11-06 12:51:29.29+01	2023-11-06 13:01:24.548+01	GP1	GCP
3220	e2-standard-4-general-purpose	GCP-us-west	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:31.644+01	2023-11-06 12:51:31.644+01	2023-11-06 13:01:27.12+01	GP1	GCP
3221	c2-standard-4-compute-optimized	GCP-near-east	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:34.144+01	2023-11-06 12:51:34.144+01	2023-11-06 13:01:29.036+01	CO1	GCP
3222	c2-standard-4-compute-optimized	GCP-us-east	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:36.977+01	2023-11-06 12:51:36.977+01	2023-11-06 13:01:31.416+01	CO1	GCP
3223	c2-standard-4-compute-optimized	GCP-europe-central	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:39.565+01	2023-11-06 12:51:39.565+01	2023-11-06 13:01:34.033+01	CO1	GCP
3224	c2-standard-4-compute-optimized	GCP-asia-india	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:42.016+01	2023-11-06 12:51:42.016+01	2023-11-06 13:01:36.635+01	CO1	GCP
3225	c2-standard-4-compute-optimized	GCP-us-west	2023-11-06 01:00:00+01	0.3076	2023-11-06 12:51:44.383+01	2023-11-06 12:51:44.383+01	2023-11-06 13:01:39.418+01	CO1	GCP
3420	e2-standard-4-general-purpose	GCP-us-west1	2023-11-09 00:00:00+01	0.2620	2023-11-09 18:13:16.443+01	2023-11-09 18:13:16.443+01	2023-11-09 18:13:16.443+01	GP1	GCP
3421	c2-standard-4-compute-optimized	GCP-middleeast-north1	2023-11-09 00:00:00+01	0.3592	2023-11-09 18:13:16.445+01	2023-11-09 18:13:16.445+01	2023-11-09 18:13:16.445+01	CO1	GCP
3422	c2-standard-4-compute-optimized	GCP-us-west1	2023-11-09 00:00:00+01	0.3554	2023-11-09 18:13:16.446+01	2023-11-09 18:13:16.446+01	2023-11-09 18:13:16.446+01	CO1	GCP
3423	c2-standard-4-compute-optimized	GCP-asia-south1	2023-11-09 00:00:00+01	0.1951	2023-11-09 18:13:16.447+01	2023-11-09 18:13:16.448+01	2023-11-09 18:13:16.448+01	CO1	GCP
3424	c2-standard-4-compute-optimized	GCP-europe-central1	2023-11-09 00:00:00+01	0.5100	2023-11-09 18:13:16.449+01	2023-11-09 18:13:16.449+01	2023-11-09 18:13:16.449+01	CO1	GCP
3425	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-08 01:00:00+01	0.0250	2023-11-09 18:13:17.19+01	2023-11-09 18:13:17.192+01	2023-11-09 18:13:17.192+01	GP1	ALB
3427	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-08 01:00:00+01	0.0380	2023-11-09 18:13:18.517+01	2023-11-09 18:13:18.52+01	2023-11-09 18:13:18.52+01	GP1	ALB
3429	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-08 01:00:00+01	0.0390	2023-11-09 18:13:22.922+01	2023-11-09 18:13:22.925+01	2023-11-09 18:13:22.925+01	GP1	ALB
3431	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-08 01:00:00+01	0.0370	2023-11-09 18:13:25.118+01	2023-11-09 18:13:25.121+01	2023-11-09 18:13:25.121+01	GP1	ALB
3433	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-08 01:00:00+01	0.0250	2023-11-09 18:13:25.547+01	2023-11-09 18:13:25.549+01	2023-11-09 18:13:25.549+01	CO1	ALB
3435	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-08 01:00:00+01	0.0352	2023-11-09 18:13:25.746+01	2023-11-09 18:13:25.748+01	2023-11-09 18:13:25.748+01	CO1	ALB
3437	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-08 01:00:00+01	0.0460	2023-11-09 18:13:27.003+01	2023-11-09 18:13:27.006+01	2023-11-09 18:13:27.006+01	CO1	ALB
3439	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-08 01:00:00+01	0.0325	2023-11-09 18:13:28.494+01	2023-11-09 18:13:28.496+01	2023-11-09 18:13:28.496+01	CO1	ALB
3441	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-08 01:00:00+01	0.0250	2023-11-09 18:13:29.736+01	2023-11-09 18:13:29.738+01	2023-11-09 18:13:29.738+01	CO1	ALB
3419	D4s_v3-compute-optimized	AZR-southindia	2023-11-09 00:00:00+01	0.1571	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.051+01	CO1	AZR
3412	B4ms-general-purpose	AZR-israelcentral	2023-11-09 00:00:00+01	0.2423	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.103+01	GP1	AZR
3418	D4s_v3-compute-optimized	AZR-eastus	2023-11-09 00:00:00+01	0.1231	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.106+01	CO1	AZR
3672	B4ms-general-purpose	AZR-israelcentral	2023-11-15 22:00:00+01	0.2423	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:17.962+01	GP1	AZR
3438	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-09 01:00:00+01	0.0460	2023-11-10 14:13:21.833+01	2023-11-09 18:13:27.012+01	2023-11-10 14:13:21.837+01	CO1	ALB
3426	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-09 01:00:00+01	0.0250	2023-11-10 14:28:46.207+01	2023-11-09 18:13:17.201+01	2023-11-10 14:28:46.21+01	GP1	ALB
3428	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-09 01:00:00+01	0.0380	2023-11-10 14:28:46.917+01	2023-11-09 18:13:18.522+01	2023-11-10 14:28:46.921+01	GP1	ALB
3430	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-09 01:00:00+01	0.0390	2023-11-10 14:28:48.347+01	2023-11-09 18:13:22.929+01	2023-11-10 14:28:48.351+01	GP1	ALB
3432	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-09 01:00:00+01	0.0370	2023-11-10 14:28:51.523+01	2023-11-09 18:13:25.126+01	2023-11-10 14:28:51.526+01	GP1	ALB
3434	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-09 01:00:00+01	0.0250	2023-11-10 14:28:51.957+01	2023-11-09 18:13:25.552+01	2023-11-10 14:28:51.959+01	CO1	ALB
3436	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-09 01:00:00+01	0.0360	2023-11-10 14:28:52.164+01	2023-11-09 18:13:25.751+01	2023-11-10 14:28:52.166+01	CO1	ALB
3440	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-09 01:00:00+01	0.0325	2023-11-10 14:28:52.93+01	2023-11-09 18:13:28.499+01	2023-11-10 14:28:52.933+01	CO1	ALB
3442	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-09 01:00:00+01	0.0250	2023-11-10 14:28:55.926+01	2023-11-09 18:13:29.741+01	2023-11-10 14:28:55.932+01	CO1	ALB
3228	B4ms-general-purpose	AZR-polandcentral	2023-11-06 00:00:00+01	0.2498	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.336+01	GP1	AZR
3226	B4ms-general-purpose	AZR-westus	2023-11-06 00:00:00+01	0.2405	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.372+01	GP1	AZR
3417	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-09 00:00:00+01	0.1530	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.03+01	CO1	AZR
3413	B4ms-general-purpose	AZR-eastus	2023-11-09 00:00:00+01	0.1965	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.05+01	GP1	AZR
3674	B4ms-general-purpose	AZR-westus	2023-11-15 22:00:00+01	0.2405	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:17.817+01	GP1	AZR
3678	B4ms-general-purpose	AZR-southindia	2023-11-15 22:00:00+01	0.2335	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:17.971+01	GP1	AZR
3170	ecs.g5.xlarge-general-purpose	ALB-eu-central-1	2023-11-04 01:00:00+01	0.0380	2023-11-04 13:26:18.445+01	2023-11-04 13:14:51.652+01	2023-11-04 13:26:18.451+01	GP1	ALB
3171	ecs.g5.xlarge-general-purpose	ALB-ap-south-1	2023-11-04 01:00:00+01	0.0390	2023-11-04 13:26:20.235+01	2023-11-04 13:14:52.695+01	2023-11-04 13:26:20.243+01	GP1	ALB
3172	ecs.g5.xlarge-general-purpose	ALB-us-west-1	2023-11-04 01:00:00+01	0.0399	2023-11-04 13:26:20.999+01	2023-11-04 13:14:53.346+01	2023-11-04 13:26:21.005+01	GP1	ALB
3173	ecs.c6.xlarge-compute-optimized	ALB-us-east-1	2023-11-04 01:00:00+01	0.0250	2023-11-04 13:26:21.422+01	2023-11-04 13:14:53.763+01	2023-11-04 13:26:21.426+01	CO1	ALB
3174	ecs.c6.xlarge-compute-optimized	ALB-eu-central-1	2023-11-04 01:00:00+01	0.0350	2023-11-04 13:26:21.631+01	2023-11-04 13:14:54.005+01	2023-11-04 13:26:21.635+01	CO1	ALB
3175	ecs.c6.xlarge-compute-optimized	ALB-me-east-1	2023-11-04 01:00:00+01	0.0460	2023-11-04 13:26:22.113+01	2023-11-04 13:14:54.468+01	2023-11-04 13:26:22.122+01	CO1	ALB
3176	ecs.c6.xlarge-compute-optimized	ALB-ap-south-1	2023-11-04 01:00:00+01	0.0325	2023-11-04 13:26:22.615+01	2023-11-04 13:14:54.945+01	2023-11-04 13:26:22.622+01	CO1	ALB
3231	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-06 00:00:00+01	0.1585	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.346+01	CO1	AZR
3177	ecs.c6.xlarge-compute-optimized	ALB-us-west-1	2023-11-04 01:00:00+01	0.0250	2023-11-04 13:26:23.262+01	2023-11-04 13:14:55.583+01	2023-11-04 13:26:23.267+01	CO1	ALB
3163	B4ms-general-purpose	AZR-eastus	2023-11-04 00:00:00+01	0.1965	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.525+01	GP1	AZR
3164	D4s_v3-compute-optimized	AZR-westus	2023-11-04 00:00:00+01	0.1381	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.551+01	CO1	AZR
3165	D4s_v3-compute-optimized	AZR-polandcentral	2023-11-04 00:00:00+01	0.1585	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.553+01	CO1	AZR
3159	B4ms-general-purpose	AZR-israelcentral	2023-11-04 00:00:00+01	0.2423	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.576+01	GP1	AZR
3227	B4ms-general-purpose	AZR-southindia	2023-11-06 00:00:00+01	0.2335	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.35+01	GP1	AZR
3161	B4ms-general-purpose	AZR-polandcentral	2023-11-04 00:00:00+01	0.2498	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.578+01	GP1	AZR
3160	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-04 00:00:00+01	0.1530	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.583+01	CO1	AZR
3233	D4s_v3-compute-optimized	AZR-southindia	2023-11-06 00:00:00+01	0.1571	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.356+01	CO1	AZR
3168	B4ms-general-purpose	AZR-southindia	2023-11-04 00:00:00+01	0.2335	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.583+01	GP1	AZR
3230	B4ms-general-purpose	AZR-israelcentral	2023-11-06 00:00:00+01	0.2423	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.37+01	GP1	AZR
3162	B4ms-general-purpose	AZR-westus	2023-11-04 00:00:00+01	0.2405	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.589+01	GP1	AZR
3167	D4s_v3-compute-optimized	AZR-eastus	2023-11-04 00:00:00+01	0.1231	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.59+01	CO1	AZR
3166	D4s_v3-compute-optimized	AZR-southindia	2023-11-04 00:00:00+01	0.1571	2023-11-04 00:00:00+01	2023-11-04 00:00:00+01	2023-11-04 13:26:23.596+01	CO1	AZR
3229	B4ms-general-purpose	AZR-eastus	2023-11-06 00:00:00+01	0.1965	2023-11-06 00:00:00+01	2023-11-06 00:00:00+01	2023-11-06 14:38:48.371+01	GP1	AZR
3414	B4ms-general-purpose	AZR-southindia	2023-11-09 00:00:00+01	0.2335	2023-11-09 00:00:00+01	2023-11-09 00:00:00+01	2023-11-09 18:13:30.076+01	GP1	AZR
3675	B4ms-general-purpose	AZR-polandcentral	2023-11-15 22:00:00+01	0.2498	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:17.982+01	GP1	AZR
3676	D4s_v3-compute-optimized	AZR-westus	2023-11-15 22:00:00+01	0.1381	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:19.042+01	CO1	AZR
3677	D4s_v3-compute-optimized	AZR-israelcentral	2023-11-15 22:00:00+01	0.1530	2023-11-15 22:00:00+01	2023-11-15 22:00:00+01	2023-11-16 18:59:19.262+01	CO1	AZR
3179	c6a.xlarge-compute-optimized	AWS-eu-central-1	2023-11-04 00:00:00+01	0.0831	2023-11-04 13:17:16.961+01	2023-11-04 13:14:57.659+01	2023-11-04 13:17:16.964+01	CO1	AWS
3178	t4g.xlarge-general-purpose	AWS-eu-central-1	2023-11-04 00:00:00+01	0.0633	2023-11-04 13:17:16.962+01	2023-11-04 13:14:57.659+01	2023-11-04 13:17:16.965+01	GP1	AWS
3181	t4g.xlarge-general-purpose	AWS-us-east-1	2023-11-04 00:00:00+01	0.0745	2023-11-04 13:17:17.135+01	2023-11-04 13:14:58.05+01	2023-11-04 13:17:17.136+01	GP1	AWS
3180	c6a.xlarge-compute-optimized	AWS-us-east-1	2023-11-04 00:00:00+01	0.0837	2023-11-04 13:17:17.232+01	2023-11-04 13:14:58.041+01	2023-11-04 13:17:17.234+01	CO1	AWS
3184	t4g.xlarge-general-purpose	AWS-us-west-1	2023-11-04 00:00:00+01	0.0507	2023-11-04 13:17:17.375+01	2023-11-04 13:14:58.379+01	2023-11-04 13:17:17.377+01	GP1	AWS
3182	t4g.xlarge-general-purpose	AWS-ap-south-1	2023-11-04 00:00:00+01	0.0305	2023-11-04 13:17:17.467+01	2023-11-04 13:14:58.345+01	2023-11-04 13:17:17.468+01	GP1	AWS
3185	c6a.xlarge-compute-optimized	AWS-us-west-1	2023-11-04 00:00:00+01	0.0859	2023-11-04 13:17:17.509+01	2023-11-04 13:14:58.392+01	2023-11-04 13:17:17.51+01	CO1	AWS
3183	c6a.xlarge-compute-optimized	AWS-ap-south-1	2023-11-04 00:00:00+01	0.0775	2023-11-04 13:17:17.531+01	2023-11-04 13:14:58.371+01	2023-11-04 13:17:17.533+01	CO1	AWS
3169	ecs.g5.xlarge-general-purpose	ALB-us-east-1	2023-11-04 01:00:00+01	0.0250	2023-11-04 13:26:17.63+01	2023-11-04 13:14:51.337+01	2023-11-04 13:26:17.635+01	GP1	ALB
\.


--
-- Name: CloudProviders_providerID_seq; Type: SEQUENCE SET; Schema: public; Owner: kacper
--

SELECT pg_catalog.setval('public."CloudProviders_providerID_seq"', 4, true);


--
-- Name: InstanceTypes_instanceID_seq; Type: SEQUENCE SET; Schema: public; Owner: kacper
--

SELECT pg_catalog.setval('public."InstanceTypes_instanceID_seq"', 8, true);


--
-- Name: Regions_regionID_seq; Type: SEQUENCE SET; Schema: public; Owner: kacper
--

SELECT pg_catalog.setval('public."Regions_regionID_seq"', 9, true);


--
-- Name: SpotPricings_pricingID_seq; Type: SEQUENCE SET; Schema: public; Owner: kacper
--

SELECT pg_catalog.setval('public."SpotPricings_pricingID_seq"', 3798, true);


--
-- Name: CloudProviders CloudProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."CloudProviders"
    ADD CONSTRAINT "CloudProviders_pkey" PRIMARY KEY ("providerID");


--
-- Name: InstanceTypes InstanceTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."InstanceTypes"
    ADD CONSTRAINT "InstanceTypes_pkey" PRIMARY KEY ("instanceID");


--
-- Name: Regions Regions_pkey; Type: CONSTRAINT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."Regions"
    ADD CONSTRAINT "Regions_pkey" PRIMARY KEY ("regionID");


--
-- Name: SpotPricings SpotPricings_pkey; Type: CONSTRAINT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."SpotPricings"
    ADD CONSTRAINT "SpotPricings_pkey" PRIMARY KEY ("pricingID");


--
-- Name: InstanceTypes InstanceTypes_providerID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kacper
--

ALTER TABLE ONLY public."InstanceTypes"
    ADD CONSTRAINT "InstanceTypes_providerID_fkey" FOREIGN KEY ("providerID") REFERENCES public."CloudProviders"("providerID");


--
-- PostgreSQL database dump complete
--

