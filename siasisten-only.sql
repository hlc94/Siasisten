--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: siasisten; Type: SCHEMA; Schema: -; Owner: henry.louis
--

CREATE SCHEMA siasisten;


ALTER SCHEMA siasisten OWNER TO "henry.louis";

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: dungeon_access(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: henry.louis
--

CREATE FUNCTION dungeon_access(p1 character varying, p2 character varying, p3 character varying, d character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
    DECLARE
enter VARCHAR;
 temp1 INT;
 temp2 INT;
 temp3 INT;
 min INT;
 BEGIN
SELECT PlayerLevel INTO temp1 FROM PLAYER WHERE PlayerName=p1;
SELECT PlayerLevel INTO temp2 FROM PLAYER WHERE PlayerName=p2;
SELECT PlayerLevel INTO temp3 FROM PLAYER WHERE PlayerName=p3;
SELECT MinimumLevel INTO min FROM DUNGEON WHERE DungeonName=d;
 
 IF(temp1>=min AND temp2>=min AND temp3>=min) THEN enter='Ketiga pemain dapat memasuki '||d;END IF;
 IF(temp1>=min AND temp2>=min AND temp3<min) THEN enter='Semua pemain dapat memasuki '||d||' kecuali '||p3;END IF;
 IF(temp1>=min AND temp2<min AND temp3>=min) THEN enter='Semua pemain dapat memasuki '||d||' kecuali '||p2;END IF;
 IF(temp1<min AND temp2>=min AND temp3>=min) THEN enter='Semua pemain dapat memasuki '||d||' kecuali '||p1;END IF;
 IF(temp1<min AND temp2<min AND temp3>=min) THEN enter='Hanya '||p3||' yang dapat memasuki '||d;END IF;
 IF(temp1>=min AND temp2<min AND temp3<min) THEN enter='Hanya '||p1||' yang dapat memasuki '||d;END IF;
 IF(temp1<min AND temp2>=min AND temp3<min) THEN enter='Hanya '||p2||' yang dapat memasuki '||d;END IF;
 IF(temp1<min AND temp2<min AND temp3<min) THEN enter='semua pemain tidak dapat memasuki '||d;END IF;
 RETURN enter;
 END
$$;


ALTER FUNCTION public.dungeon_access(p1 character varying, p2 character varying, p3 character varying, d character varying) OWNER TO "henry.louis";

SET search_path = siasisten, pg_catalog;

--
-- Name: tambah_lowongan(); Type: FUNCTION; Schema: siasisten; Owner: henry.louis
--

CREATE FUNCTION tambah_lowongan() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
UPDATE lowongan set jumlah_pelamar = jumlah_pelamar + 1
WHERE idlowongan = NEW.idlowongan;
RETURN NEW;
END;
$$;


ALTER FUNCTION siasisten.tambah_lowongan() OWNER TO "henry.louis";

--
-- Name: tambah_pelamar_diterima(); Type: FUNCTION; Schema: siasisten; Owner: henry.louis
--

CREATE FUNCTION tambah_pelamar_diterima() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
begin
if new.id_st_lamaran=3 then
update lowongan set jumlah_pelamar_diterima=jumlah_pelamar_diterima+1
where idlowongan=new.idlowongan;
return new;
else
return null;
end if;
end;
$$;


ALTER FUNCTION siasisten.tambah_pelamar_diterima() OWNER TO "henry.louis";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: dosen; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE dosen (
    nip character varying(20) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    universitas character varying(100) NOT NULL,
    fakultas character varying(100) NOT NULL
);


ALTER TABLE dosen OWNER TO "henry.louis";

--
-- Name: dosen_kelas_mk; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE dosen_kelas_mk (
    nip character varying(20) NOT NULL,
    idkelasmk integer NOT NULL
);


ALTER TABLE dosen_kelas_mk OWNER TO "henry.louis";

--
-- Name: kategori_log; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE kategori_log (
    id integer NOT NULL,
    kategori character varying(50) NOT NULL
);


ALTER TABLE kategori_log OWNER TO "henry.louis";

--
-- Name: kelas_mk; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE kelas_mk (
    idkelasmk integer NOT NULL,
    tahun integer NOT NULL,
    semester integer NOT NULL,
    kode_mk character(10)
);


ALTER TABLE kelas_mk OWNER TO "henry.louis";

--
-- Name: lamaran; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE lamaran (
    idlamaran integer NOT NULL,
    npm character(10) NOT NULL,
    idlowongan integer NOT NULL,
    id_st_lamaran integer NOT NULL,
    ipk numeric(5,2) NOT NULL,
    jumlahsks integer NOT NULL,
    nip character varying(20)
);


ALTER TABLE lamaran OWNER TO "henry.louis";

--
-- Name: log; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE log (
    idlog integer NOT NULL,
    idlamaran integer NOT NULL,
    npm character(10) NOT NULL,
    id_kat_log integer NOT NULL,
    id_st_log integer NOT NULL,
    tanggal timestamp without time zone NOT NULL,
    jam_mulai timestamp without time zone NOT NULL,
    jam_selesai timestamp without time zone NOT NULL,
    deskripsi_kerja character varying(100) NOT NULL
);


ALTER TABLE log OWNER TO "henry.louis";

--
-- Name: lowongan; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE lowongan (
    idlowongan integer NOT NULL,
    idkelasmk integer NOT NULL,
    status boolean DEFAULT false NOT NULL,
    jumlah_asisten integer DEFAULT 0 NOT NULL,
    syarat_tambahan character varying(100),
    nipdosenpembuka character varying(20) NOT NULL,
    jumlah_pelamar integer DEFAULT 0,
    jumlah_pelamar_diterima integer DEFAULT 0,
    dosen character varying(50)
);


ALTER TABLE lowongan OWNER TO "henry.louis";

--
-- Name: lowonganklsmk; Type: VIEW; Schema: siasisten; Owner: henry.louis
--

CREATE VIEW lowonganklsmk AS
 SELECT lowongan.idkelasmk,
    lowongan.idlowongan,
    lowongan.status,
    lowongan.jumlah_asisten,
    lowongan.syarat_tambahan,
    lowongan.nipdosenpembuka,
    lowongan.jumlah_pelamar,
    lowongan.jumlah_pelamar_diterima,
    lowongan.dosen,
    kelas_mk.tahun,
    kelas_mk.semester,
    kelas_mk.kode_mk
   FROM (lowongan
     JOIN kelas_mk USING (idkelasmk));


ALTER TABLE lowonganklsmk OWNER TO "henry.louis";

--
-- Name: mata_kuliah; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE mata_kuliah (
    kode character(10) NOT NULL,
    nama character varying(100) NOT NULL,
    prasyarat_dari character(10)
);


ALTER TABLE mata_kuliah OWNER TO "henry.louis";

--
-- Name: lowonganklsmk2; Type: VIEW; Schema: siasisten; Owner: henry.louis
--

CREATE VIEW lowonganklsmk2 AS
 SELECT lowonganklsmk.idkelasmk,
    lowonganklsmk.idlowongan,
    lowonganklsmk.status,
    lowonganklsmk.jumlah_asisten,
    lowonganklsmk.syarat_tambahan,
    lowonganklsmk.nipdosenpembuka,
    lowonganklsmk.jumlah_pelamar,
    lowonganklsmk.jumlah_pelamar_diterima,
    lowonganklsmk.dosen,
    lowonganklsmk.tahun,
    lowonganklsmk.semester,
    lowonganklsmk.kode_mk,
    mata_kuliah.kode,
    mata_kuliah.nama,
    mata_kuliah.prasyarat_dari
   FROM (lowonganklsmk
     JOIN mata_kuliah ON ((lowonganklsmk.kode_mk = mata_kuliah.kode)));


ALTER TABLE lowonganklsmk2 OWNER TO "henry.louis";

--
-- Name: mahasiswa; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE mahasiswa (
    npm character(10) NOT NULL,
    nama character varying(100) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    email_aktif character varying(100),
    waktu_kosong character varying(100),
    bank character varying(100),
    norekening character varying(100),
    url_mukatab character varying(100),
    url_foto character varying(100)
);


ALTER TABLE mahasiswa OWNER TO "henry.louis";

--
-- Name: mhs_mengambil_kelas_mk; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE mhs_mengambil_kelas_mk (
    npm character(10) NOT NULL,
    idkelasmk integer NOT NULL,
    nilai numeric(5,2)
);


ALTER TABLE mhs_mengambil_kelas_mk OWNER TO "henry.louis";

--
-- Name: status_lamaran; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE status_lamaran (
    id integer NOT NULL,
    status character varying(10) NOT NULL
);


ALTER TABLE status_lamaran OWNER TO "henry.louis";

--
-- Name: status_log; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE status_log (
    id integer NOT NULL,
    status character varying(10) NOT NULL
);


ALTER TABLE status_log OWNER TO "henry.louis";

--
-- Name: telepon_mahasiswa; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE telepon_mahasiswa (
    npm character(10) NOT NULL,
    nomortelepon character varying(20) NOT NULL
);


ALTER TABLE telepon_mahasiswa OWNER TO "henry.louis";

--
-- Name: term; Type: TABLE; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

CREATE TABLE term (
    tahun integer NOT NULL,
    semester integer NOT NULL
);


ALTER TABLE term OWNER TO "henry.louis";

--
-- Data for Name: dosen; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY dosen (nip, nama, username, password, email, universitas, fakultas) FROM stdin;
198503072010121003	Wahyu Agung	wahyuagung2	wahyuagun6	wahyuangung@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
199012052016032201	Rini Sagita Ayu	rini.s	rinisagitaayu12	rs.ayu@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197707072001061300	Ahmad Luthfi	a.luthfi	luthfi1977	a.luthfi@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198708242004042333	Dian Ayu Nisa	d.ayu	dianayu24	d.ayu@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
196009301990091124	Rama Maulana Ibrahim	r.maulana	fortress99	r.maulana@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197505282000061231	Imam Faroek	imam.faroek	matdassaja4	imam.faroek@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198009162005112433	Indah Permata	indah.permata	berlianindah1	indah.permata@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
196707141992062342	Anisa Lusiana	anisa.lusiana	greatwall7	anisa.lusiana@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197202181998031120	Choresa Ananta	choresa.ananta	12rainydevil	choresa.ananta@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
196508281995091533	Agung Julian	agung.julian12	juli1965	agung.julian@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197708252005061122	Juanda Ibrahim	juanda.ibrahim	sayasukamakan8	juanda.ibrahim@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197709222007052332	Inastra Sugiartha	inastra.s	bowling80	inastra.s@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198403262011052212	Lori Maranata	l.maranata	bigfammaranata4	l.maranata@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198307292012081099	Khoirul Ermes	khoirul.eremes	eremes69	khoirul.eremes@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197322092000092087	Endah Paulina	endah.p	withhonor73	endah@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198502232012121095	Dandi Guna	dandi.guna33	digunaguna22	dandi.guna33@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198804272013092009	Olina Ono	olina12	singerwannabe0	olina@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
197011122005032001	Lisa Fatimah	lisa.fatimah	lisasaja4	lisa.fatimah@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198204232012101045	Junadi Ahmad Alwan	junadi	alwan39	junadi@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
198509092014112078	Randa Cinta	r.cinta	cintasatu23	r.cinta@cs.ui.ac.id	Universitas Indonesia	Fakultas Ilmu Komputer
25275100909649825	Martin Hunter	mhunter0	hmLFhgp	mhunter0@noaa.gov	King Saud bin Abdulaziz University for Health Sciences 	Computer Science
24295855221732416	Rachel Johnston	rjohnston1	PIgyES4gt	rjohnston1@vistaprint.com	University of Electronic Science and Technology of China	Phsycology
27262211867510388	Terry Burton	tburton2	xWcrsWzSKDDG	tburton2@barnesandnoble.com	The Tulane University of New Orleans	Engineering
23138552154372694	Gerald Evans	gevans3	d6pru1zKhY	gevans3@theatlantic.com	University of Houston	Chemistry
21422742894580479	Jacqueline Riley	jriley4	NSMA7IIZjFds	jriley4@weebly.com	Université Abou Bekr Belkaid, Tlemcen	Chemistry
20008240044793484	Ashley Thomas	athomas5	kE29iac	athomas5@freewebs.com	Case Western Reserve University	Nursing
25700597158468814	Phyllis Fernandez	pfernandez6	wQVuSwkmg	pfernandez6@ycombinator.com	Swansea Metropolitan University	Computer Science
20860032671949502	Virginia Anderson	vanderson7	tWZGaLznCP	vanderson7@furl.net	Fisher College	Chemistry
23323398502483968	Mark Ray	mray8	19OoHV	mray8@so-net.ne.jp	California State University, San Marcos	Nursing
28599059692094613	Christine Myers	cmyers9	w9OBXWJ	cmyers9@usnews.com	University of Mississippi Medical Center	Medical Faculty
24043192601730988	Laura Carpenter	lcarpentera	lTLng4MnU4	lcarpentera@exblog.jp	Rensselaer Polytechnic Institute	Computer Science
29931837456124680	Joan Payne	jpayneb	a9060V	jpayneb@google.fr	Technological University (Sittwe)	Sports
23515806946143525	Carlos Smith	csmithc	Nf2Hw3	csmithc@reuters.com	King Khaled University	Faculty of Law
23419495800092416	Kenneth Ryan	kryand	fp4joy1UxrDS	kryand@dropbox.com	Enugu State University of Science and Technology	Computer Science
26903454173080204	Samuel Carter	scartere	k0iJps4	scartere@yellowpages.com	North West Frontier Province Agricultural University	Agriculture
28382524532092387	Anna Berry	aberryf	uPfbjoR	aberryf@reuters.com	Fujian Agricultural University	Agriculture
24931610966097778	Anne Welch	awelchg	p3tgmLQyHCto	awelchg@un.org	University of SV Cyril and Methodius in Trnava	Faculty of Law
27687196835301456	Philip Davis	pdavish	NDw06WbidUO	pdavish@jalbum.net	Baghyatoolah Medical Sciences University	Applied Science
28199785781098102	Rose Owens	rowensi	uIaQlcN	rowensi@mediafire.com	Boise State University	Faculty of Law
21649286935360729	Rose Stephens	rstephensj	GYIW4VY9	rstephensj@ibm.com	Université de Mostaganem	Engineering
28952029117983509	Kathryn Spencer	kspencerk	2uMNn5ent	kspencerk@ibm.com	Kyoto Pharmaceutical University	Chemistry
25164853631791519	Lillian Holmes	lholmesl	ul3K9WXYaV	lholmesl@netlog.com	Hemchandracharay North Gujarat University	Engineering
20706729594122428	Laura Ellis	lellism	8QqhHy0s	lellism@php.net	Knowledge College for Science and Technology	Engineering
26034692028167245	Matthew Daniels	mdanielsn	oNnhesP	mdanielsn@usatoday.com	Brest State University	Engineering
25664043900787120	Joyce Allen	jalleno	uEsIQSLv1k	jalleno@slate.com	New World University	Computer Science
26823116443905698	Justin Stephens	jstephensp	iOZHpsXRf7	jstephensp@simplemachines.org	Ecole Supérieure Internationale d'Administration des Entreprises	Administration
26552298848655484	Roy Ruiz	rruizq	CXquoBfXq	rruizq@moonfruit.com	Eastern Conservatory of Music	Classic Music
20534205028113519	Antonio Ford	afordr	HDdM4p	afordr@buzzfeed.com	Hampden-Sydney College	Engineering
26461070244480429	Jerry Wallace	jwallaces	kRMCErQjcdPk	jwallaces@columbia.edu	Kazan State Pedagogical University	Junior High School
20520372033955056	Heather Smith	hsmitht	HEMUOvj6yl	hsmitht@alibaba.com	University of Craiova	Engineering
\.


--
-- Data for Name: dosen_kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY dosen_kelas_mk (nip, idkelasmk) FROM stdin;
24043192601730988	234
24043192601730988	2
26903454173080204	16
20706729594122428	12
24295855221732416	17
27687196835301456	222
29931837456124680	6
20008240044793484	222
27687196835301456	6
29931837456124680	700
27687196835301456	13
26903454173080204	8
27262211867510388	222
27687196835301456	100
20008240044793484	543
26903454173080204	17
27687196835301456	239
20520372033955056	8
23419495800092416	777
26903454173080204	654
23419495800092416	99
27262211867510388	10
29931837456124680	100
20706729594122428	455
26903454173080204	6
\.


--
-- Data for Name: kategori_log; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY kategori_log (id, kategori) FROM stdin;
1456732009	Tutorial
1456732563	Persiapan asistensi
1456734535	Membuat soal/tugas
1458363937	Rapat
1432892921	Sit in kelas
1468373839	Mengkoreksi
1562527627	Mengawas
\.


--
-- Data for Name: kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY kelas_mk (idkelasmk, tahun, semester, kode_mk) FROM stdin;
1	2012	1	IKS0000001
2	2012	1	IKS0000002
3	2013	2	IKS0000002
4	2014	3	IKS0000003
5	2014	3	IKS0000003
6	2016	2	IKS0000004
7	2016	2	IKS0000004
8	2013	2	IKS0000005
9	2014	3	IKS0000005
10	2015	1	IKS0000006
11	2015	1	IKS0000006
12	2015	1	IKS0000007
13	2014	3	IKS0000007
14	2016	2	IKS0000007
15	2016	2	IKS0000007
16	2012	1	IKS0000008
17	2015	1	IKS0000008
18	2016	2	IKS0000009
19	2016	2	IKS0000009
20	2012	1	IKS0000010
111	2012	1	IKS3702935
222	2012	1	IKS3702935
333	2013	2	IKS3702935
444	2014	3	IKS4517260
555	2014	3	IKS4517260
666	2016	2	IKS4517260
777	2016	2	IKS4267807
888	2013	2	IKS4267807
999	2014	3	IKS4267807
133	2015	1	IKS9351721
345	2015	1	IKS9351721
981	2015	1	IKS0236264
234	2014	3	IKS0236264
455	2016	2	IKS0236264
958	2016	2	IKS8821360
543	2012	1	IKS8821360
667	2015	1	IKS5977935
654	2016	2	IKS8821360
700	2016	2	IKS5977935
324	2012	1	IKS5977935
347	2015	1	IKS5977935
983	2015	1	IKS0236264
239	2014	3	IKS0236264
98	2016	2	IKS5977935
99	2016	2	IKS9351721
100	2012	1	IKS9351721
210	2015	1	IKS9351721
643	2016	2	IKS6525393
157	2016	2	IKS6525393
279	2012	1	IKS6525393
\.


--
-- Data for Name: lamaran; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY lamaran (idlamaran, npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) FROM stdin;
1	1282454908	1	3	4.00	3	198503072010121003
2	1291596353	2	3	4.00	4	198503072010121003
3	1361336967	3	3	4.00	3	197707072001061300
4	1291596353	4	3	4.00	2	198708242004042333
5	1361336967	5	3	4.00	2	198009162005112433
6	1245435990	6	3	4.00	3	196707141992062342
7	1245435990	7	3	4.00	2	196508281995091533
8	1291596353	8	3	4.00	4	197708252005061122
9	1282454908	9	3	4.00	4	197708252005061122
10	1245435990	10	3	4.00	4	197709222007052332
11	1245435990	11	3	4.00	4	198403262011052212
12	1293576624	12	3	4.00	3	198307292012081099
13	1293576624	13	3	4.00	2	198502232012121095
14	1208453676	14	3	4.00	6	198502232012121095
15	1298112579	15	3	4.00	6	198804272013092009
16	1282454908	16	3	4.00	6	198804272013092009
17	1298112579	17	3	4.00	3	197011122005032001
18	1247290045	18	3	4.00	4	198204232012101045
19	1364713623	19	3	4.00	4	198204232012101045
20	1293576624	20	3	4.00	2	198204232012101045
21	1298112579	21	3	4.00	2	198509092014112078
22	1247290045	22	3	4.00	2	198509092014112078
23	1364713623	23	3	4.00	2	198509092014112078
24	1305498698	24	3	4.00	2	25275100909649825
25	1341503627	25	3	4.00	2	25275100909649825
26	1364713623	26	3	4.00	2	25275100909649825
27	1307383054	27	3	4.00	3	24295855221732416
28	1341503627	28	3	4.00	4	24295855221732416
29	1305498698	29	3	4.00	4	24295855221732416
30	1276762997	30	3	4.00	4	197708252005061122
31	1307383054	31	3	4.00	3	197708252005061122
32	1277439953	32	3	4.00	3	197708252005061122
33	1254015212	33	3	4.00	4	197709222007052332
34	1306357606	34	3	4.00	3	197709222007052332
35	1282454908	35	3	4.00	3	197709222007052332
36	1242094311	36	3	4.00	4	197202181998031120
37	1254278433	37	3	4.00	3	197202181998031120
38	1399894458	38	3	4.00	2	197202181998031120
39	1221614512	39	3	4.00	6	196707141992062342
40	1242094311	40	3	4.00	3	196707141992062342
41	1282454908	41	3	4.00	3	196707141992062342
42	1306357606	42	3	4.00	6	196009301990091124
43	1254663212	43	3	4.00	3	196009301990091124
44	1211948516	44	3	4.00	6	196009301990091124
45	1282454908	45	3	4.00	3	198708242004042333
46	1355684168	46	3	4.00	2	198708242004042333
47	1211948516	47	3	4.00	3	198708242004042333
48	1254663212	48	3	4.00	2	199012052016032201
49	1254015212	49	3	4.00	6	199012052016032201
50	1277439953	50	3	4.00	3	199012052016032201
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY log (idlog, idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) FROM stdin;
4	4	1291596353	1456732563	3	2016-11-19 13:01:00	2016-11-19 13:01:00	2016-11-19 15:01:00	Persiapan Asistensi Aljabar Linear
5	5	1361336967	1456732563	3	2016-09-11 15:00:00	2016-09-11 15:00:00	2016-09-11 17:00:00	Persiapan Asistensi Matematika Dasar 2
6	6	1245435990	1456732563	3	2016-10-22 14:00:00	2016-10-22 14:00:00	2016-10-22 16:00:00	Persiapan Asistensi Sistem Operasi
7	7	1245435990	1456732009	4	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Tutorial Pengolahan Citra
8	8	1291596353	1468373839	4	2016-10-30 09:00:00	2016-10-30 09:00:00	2016-10-30 11:00:00	Mengoreksi Tugas 1 Aljabar Linear
9	9	1282454908	1562527627	4	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Mengawas Kuis 2 Aljabar Linear
13	13	1293576624	1562527627	4	2016-10-07 08:00:00	2016-10-07 08:00:00	2016-10-07 10:00:00	Mengawas Kuis 3 Basis Data
14	14	1208453676	1456732009	4	2016-09-19 16:00:00	2016-09-19 16:00:00	2016-09-19 18:00:00	Tutorial Aljabar Linear
18	18	1247290045	1456732563	4	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Persiapan Asistensi Sistem Operasi
21	21	1298112579	1456732563	2	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Persiapan Asistensi Basis Data
24	24	1305498698	1468373839	2	2016-11-19 13:01:00	2016-11-19 13:01:00	2016-11-19 15:01:00	Mengoreksi Tugas 3 Basis Data
25	25	1341503627	1458363937	2	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Sistem Operasi
26	26	1364713623	1458363937	2	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Sistem Operasi
27	27	1307383054	1458363937	2	2016-11-19 13:01:00	2016-11-19 13:01:00	2016-11-19 15:01:00	Rapat Asistensi Sistem Operasi
28	28	1341503627	1458363937	3	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Sistem Operasi
29	29	1305498698	1458363937	3	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Sistem Operasi
30	30	1276762997	1456734535	3	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Membuat Soal Tugas 2 Basis Data
31	31	1307383054	1468373839	3	2016-10-22 14:00:00	2016-10-22 14:00:00	2016-10-22 16:00:00	Mengoreksi Tugas 2 Basis Data
32	32	1277439953	1468373839	3	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Mengoreksi Tugas 1 Aljabar Linear
33	33	1254015212	1456734535	2	2016-10-22 14:00:00	2016-10-22 14:00:00	2016-10-22 16:00:00	Membuat Soal Tugas Aljabar Linear
36	36	1242094311	1432892921	3	2016-10-22 14:00:00	2016-10-22 14:00:00	2016-10-22 16:00:00	Sit in kelas Basis Data
37	37	1254278433	1432892921	3	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Sit in kelas Matematika Dasar
38	38	1399894458	1458363937	3	2016-10-22 14:00:00	2016-10-22 14:00:00	2016-10-22 16:00:00	Rapat Asistensi Mingguan Aljabar Linear
39	39	1221614512	1458363937	3	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Mingguan Aljabar Linear
40	40	1242094311	1458363937	4	2016-10-23 10:00:00	2016-10-23 10:00:00	2016-10-23 12:00:00	Rapat Asistensi Mingguan Aljabar Linear
41	41	1282454908	1458363937	4	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Rapat Asistensi Mingguan Aljabar Linear
42	42	1306357606	1458363937	2	2016-10-30 09:00:00	2016-10-30 09:00:00	2016-10-30 11:00:00	Rapat Asistensi Mingguan Aljabar Linear
43	43	1254663212	1432892921	4	2016-10-30 09:00:00	2016-10-30 09:00:00	2016-10-30 11:00:00	Sit in kelas Sistem Operasi
44	44	1211948516	1432892921	4	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Sit in kelas Basis Data
45	45	1282454908	1432892921	4	2016-09-09 19:00:00	2016-09-09 19:00:00	2016-09-09 21:00:00	Sit in kelas Sistem Operasi
46	45	1355684168	1432892921	4	2016-10-25 16:00:00	2016-10-25 16:00:00	2016-10-25 18:00:00	Sit in kelas Aljabar Linear
47	47	1211948516	1432892921	4	2016-10-25 16:00:00	2016-10-25 16:00:00	2016-10-25 18:00:00	Sit in kelas Aljabar Linear
48	48	1254663212	1458363937	4	2016-10-30 09:00:00	2016-10-30 09:00:00	2016-10-30 11:00:00	Rapat Asistensi Mingguan Aljabar Linear
49	49	1254015212	1458363937	2	2016-10-30 09:00:00	2016-10-30 09:00:00	2016-10-30 11:00:00	Rapat Asistensi Mingguan Aljabar Linear
50	50	1277439953	1432892921	2	2016-10-25 16:00:00	2016-10-25 16:00:00	2016-10-25 18:00:00	Sit in kelas Basis Data
\.


--
-- Data for Name: lowongan; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY lowongan (idlowongan, idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka, jumlah_pelamar, jumlah_pelamar_diterima, dosen) FROM stdin;
51	3	f	0	\N	198009162005112433	0	0	\N
52	4	f	0	Belajar teknologi baru yang lebih sulit	198009162005112433	0	0	\N
53	5	t	24	Mau oprek dan belajar lebih dalam	197709222007052332	0	0	\N
54	5	f	0	\N	197709222007052332	0	0	\N
55	6	t	7	Pernah mengambil matakuliah matdas lanjut	197709222007052332	0	0	\N
56	6	f	0	\N	197709222007052332	0	0	\N
57	7	t	8	Dapat A- minimal	197505282000061231	0	0	\N
58	8	f	0	Minimal dapat B-	197505282000061231	0	0	\N
59	9	f	0	Minimal dapat A	197505282000061231	0	0	\N
60	10	t	10	Kerjasama baik dengan orang lain	197322092000092087	0	0	\N
61	10	f	0	Kerjasama baik dengan orang lain	197322092000092087	0	0	\N
62	7	t	80	Dapat A- minimal	197322092000092087	0	0	\N
63	8	f	0	Minimal dapat B	197322092000092087	0	0	\N
64	9	f	0	Minimal dapat A dan B di basis data	20860032671949502	0	0	\N
65	10	t	104	Kerjasama baik dengan orang lain	20860032671949502	0	0	\N
5	3	f	0	\N	197505282000061231	1	0	\N
6	4	f	0	Belajar teknologi baru yang lebih sulit	197505282000061231	1	0	\N
7	5	t	4	Mau oprek dan belajar lebih dalam	197505282000061231	1	0	\N
1	1	f	0	Nilai minimal dapat B+	198503072010121003	3	2	\N
2	1	t	2	Nilai minimal dapat B+	199012052016032201	2	0	\N
3	2	f	6	Mau oprek dan belajar lebih dalam lagi	199012052016032201	1	0	\N
4	2	t	2	Mau oprek dan belajar lebih dalam lagi	199012052016032201	1	0	\N
8	5	f	0	\N	197505282000061231	1	0	\N
9	6	t	7	Pernah mengambil matakuliah matdas lanjut	197505282000061231	1	0	\N
10	6	f	0	\N	196707141992062342	1	0	\N
11	7	t	8	Dapat A- minimal	196707141992062342	1	0	\N
12	8	f	50	Minimal dapat A	196707141992062342	1	0	\N
13	9	f	0	Minimal dapat A	196707141992062342	1	0	\N
14	10	t	10	Kerjasama dengan dosen dan pihak luar	196707141992062342	1	0	\N
15	10	f	0	Kerjasama baik dengan orang lain	198509092014112078	1	0	\N
16	1	f	0	Nilai minimal dapat B+	198509092014112078	1	0	\N
20	3	f	0	\N	23323398502483968	1	0	\N
17	1	t	2	Nilai minimal dapat B+	198509092014112078	1	0	\N
18	2	f	0	Mau oprek dan belajar lebih dalam lagi	23323398502483968	1	0	\N
19	2	t	2	Mau oprek dan belajar lebih dalam lagi	23323398502483968	1	0	\N
21	4	f	0	Belajar teknologi baru yang lebih sulit	23515806946143525	1	0	\N
22	5	t	4	Mau oprek dan belajar lebih dalam	23515806946143525	1	0	\N
23	5	f	0	\N	23515806946143525	1	0	\N
24	6	t	7	Pernah mengambil matakuliah matdas lanjut	23515806946143525	1	0	\N
25	6	f	0	\N	26034692028167245	1	0	\N
26	7	t	8	Dapat A- minimal	26034692028167245	1	0	\N
27	8	f	0	Minimal dapat A	26034692028167245	1	0	\N
28	9	f	0	Minimal dapat A	26034692028167245	1	0	\N
29	10	t	10	Kerjasama baik dengan orang lain	20520372033955056	1	0	\N
30	10	f	0	Kerjasama baik dengan orang lain	26823116443905698	1	0	\N
31	1	f	0	Nilai minimal dapat B+	27687196835301456	1	0	\N
32	1	t	2	Nilai minimal dapat B+	27687196835301456	1	0	\N
33	2	f	0	Mau oprek dan belajar lebih dalam lagi	27687196835301456	1	0	\N
34	2	t	2	Mau oprek dan belajar lebih dalam lagi	27687196835301456	1	0	\N
35	3	f	0	\N	27687196835301456	1	0	\N
36	4	f	0	Belajar teknologi baru yang lebih sulit	25700597158468814	1	0	\N
37	5	t	4	Mau oprek dan belajar lebih dalam	25700597158468814	1	0	\N
38	5	f	0	\N	25700597158468814	1	0	\N
39	6	t	7	Pernah mengambil matakuliah matdas lanjut	25700597158468814	1	0	\N
40	6	f	0	\N	25700597158468814	1	0	\N
41	7	t	85	Dapat A- minimal	198502232012121095	1	0	\N
42	8	f	0	Minimal dapat A	198502232012121095	1	0	\N
43	9	f	0	Minimal dapat A	198502232012121095	1	0	\N
44	10	t	104	Kerjasama baik dengan orang lain	198502232012121095	1	0	\N
45	10	f	0	Kerjasama baik dengan orang lain	198502232012121095	1	0	\N
46	7	t	28	Dapat A- minimal	198502232012121095	1	0	\N
47	8	f	0	Minimal dapat A	198502232012121095	1	0	\N
48	9	f	0	Minimal dapat A	198502232012121095	1	0	\N
49	10	t	10	Kerjasama baik dengan orang lain	198009162005112433	1	0	\N
50	10	f	0	Kerjasama baik dengan orang lain	198009162005112433	1	0	\N
\.


--
-- Data for Name: mahasiswa; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY mahasiswa (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) FROM stdin;
1282454908	Pamela Ferguson	pferguson0	TTYnV5kV	pferguson0@slashdot.org	pferguson0@1und1.de	136	Domainer	172459618	/nulla/nunc.png	/at/dolor/quis.jsp
1291596353	Dorothy Hughes	dhughes1	f3LcQvv	dhughes1@cbc.ca	\N	110	Home Ing	195315730	/euismod/scelerisque/quam/turpis/adipiscing.js	/justo/in/blandit/ultrices.json
1361336967	Joan Medina	jmedina2	tBtuVlJz	jmedina2@dyndns.org	jmedina2@unc.edu	109	Alphazap	221890114	/lectus/pellentesque/eget.jpg	/elementum/nullam/varius/nulla/facilisi/cras/non.png
1245435990	Philip Ramos	pramos3	E4eNsTm3Q5I	pramos3@mashable.com	pramos3@delicious.com	117	Rank	205557212	/neque/libero/convallis.aspx	/erat/tortor/sollicitudin/mi/sit/amet/lobortis.aspx
1242908088	Jeremy Harper	jharper4	6Y24KZwpsgP	jharper4@uol.com.br	jharper4@state.gov	113	Stronghold	198498054	/viverra/diam/vitae.png	/ipsum/aliquam/non/mauris.aspx
1293576624	Bobby West	bwest5	xHDFfumOzHeb	bwest5@csmonitor.com	bwest5@sciencedirect.com	123	Viva	152985784	/vulputate/elementum/nullam/varius/nulla/facilisi/cras.json	/in/sapien/iaculis/congue/vivamus.png
1208453676	Jacqueline Foster	jfoster6	KztAcOWqXHp	jfoster6@constantcontact.com	jfoster6@cocolog-nifty.com	128	Flexidy	198219056	/a/suscipit/nulla/elit/ac/nulla.jpg	/pellentesque/volutpat/dui/maecenas/tristique.xml
1298112579	Bruce Hansen	bhansen7	fyMe4LCOhz	bhansen7@hubpages.com	bhansen7@blogger.com	113	Voyatouch	165102985	/potenti/in/eleifend/quam.json	/felis/eu/sapien/cursus.js
1247290045	Jeremy Ramos	jramos8	hqq7IKH	jramos8@msu.edu	jramos8@creativecommons.org	101	Prodder	134692361	/tortor/duis/mattis/egestas/metus.xml	/consectetuer/adipiscing.jsp
1364713623	Alice Gilbert	agilbert9	t1xlzJB	agilbert9@nytimes.com	agilbert9@live.com	114	Bitchip	202299111	/id/pretium/iaculis/diam/erat/fermentum.html	/donec/semper/sapien/a/libero.xml
1305498698	Karen Bishop	kbishopa	Xzk0A4	kbishopa@hostgator.com	kbishopa@i2i.jp	114	Prodder	162548417	/donec/dapibus/duis/at/velit.xml	/quam/pharetra.json
1341503627	Gary Peterson	gpetersonb	brmMctt4alJ8	gpetersonb@netscape.com	gpetersonb@xinhuanet.com	112	Tampflex	185838347	/montes/nascetur/ridiculus/mus/vivamus/vestibulum/sagittis.jsp	/dapibus/nulla.json
1276762997	Richard Lawson	rlawsonc	Z4ZfPG	rlawsonc@weibo.com	rlawsonc@dyndns.org	135	Quo Lux	172729755	/pede/posuere.js	/turpis.html
1307383054	Mildred Oliver	moliverd	eMp8N7LMW5t	moliverd@slashdot.org	moliverd@github.com	120	Otcom	193040808	/varius/ut/blandit/non.json	/purus/aliquet/at/feugiat/non/pretium/quis.jsp
1254663212	Jerry Barnes	jbarnese	m43kYqDW	jbarnese@dmoz.org	jbarnese@shop-pro.jp	101	Daltfresh	176620254	/in/leo/maecenas/pulvinar/lobortis.json	/vestibulum/sed/magna/at/nunc/commodo.js
1277439953	Rachel Perkins	rperkinsf	8iGOqaD	rperkinsf@soundcloud.com	rperkinsf@mapquest.com	134	Andalax	133675476	/cras/mi/pede/malesuada/in/imperdiet.png	/in.jsp
1254015212	Jeffrey Parker	jparkerg	r2csN2jJo	jparkerg@gizmodo.com	jparkerg@blogspot.com	125	Job	223658686	/sem/fusce/consequat/nulla/nisl/nunc.jpg	/duis/faucibus/accumsan/odio/curabitur/convallis.js
1306357606	Adam Howell	ahowellh	IBOclpewR	ahowellh@booking.com	ahowellh@ucla.edu	126	Trippledex	162159557	/at/dolor/quis/odio/consequat.aspx	/dictumst/maecenas/ut.xml
1242094311	James West	jwesti	AzBGfG	jwesti@ustream.tv	jwesti@examiner.com	127	Tempsoft	132687945	/dolor/quis/odio/consequat.png	/pulvinar/sed/nisl/nunc/rhoncus.png
1351184029	Lois Fuller	lfullerj	R01APsT8	lfullerj@arizona.edu	lfullerj@hexun.com	144	Kanlam	128086130	/sapien/varius/ut/blandit/non/interdum.jpg	/lectus/in/est.jpg
1254278433	Margaret Jackson	mjacksonk	CUT0pq6wOV	mjacksonk@w3.org	\N	105	Latlux	200509974	/erat/fermentum/justo/nec.js	/duis/consequat/dui/nec.json
1399894458	Craig Harris	charrisl	sbmq93	charrisl@state.gov	charrisl@exblog.jp	145	Transcof	141408246	/phasellus/in/felis/donec.json	/faucibus/orci/luctus.xml
1221614512	Stephanie Carr	scarrm	HO0AJ5GYOC	scarrm@about.me	scarrm@edublogs.org	139	Fintone	178906516	/maecenas/tristique.png	/pede/ac/diam/cras/pellentesque/volutpat.xml
1355684168	Patrick Lynch	plynchn	yqtzcOZyA	plynchn@dedecms.com	plynchn@sitemeter.com	148	Toughjoyfax	140401272	/eget/nunc/donec/quis/orci/eget.html	/lacinia/aenean/sit/amet.png
1211948516	Daniel Wright	dwrighto	QXZt2efOm5s	dwrighto@liveinternet.ru	dwrighto@wikimedia.org	104	Domainer	166141081	/nunc/proin/at/turpis.aspx	/donec/vitae/nisi.js
1390559743	William Banks	wbanksp	712msXl	wbanksp@spiegel.de	\N	135	Quo Lux	152895389	/mauris/enim/leo/rhoncus/sed/vestibulum.html	/in/quam/fringilla/rhoncus/mauris/enim/leo.aspx
1346049363	Harold Bennett	hbennettq	q9Ygd6QvNsO	hbennettq@stumbleupon.com	hbennettq@nydailynews.com	147	Holdlamis	126351686	/a/odio/in/hac/habitasse/platea.png	/sociis/natoque/penatibus.aspx
1255949123	Cynthia Cook	ccookr	nDyrhCo82C	ccookr@com.com	ccookr@europa.eu	114	Zaam-Dox	175450604	/suscipit/nulla/elit.js	/molestie/hendrerit/at/vulputate/vitae.aspx
1284746559	Joyce Dunn	jdunns	3yr1F9nBdt	jdunns@ed.gov	jdunns@so-net.ne.jp	133	Wrapsafe	202921698	/ipsum.aspx	/morbi.html
1345620124	Ronald George	rgeorget	PTD1YD	rgeorget@hud.gov	rgeorget@tripadvisor.com	106	Veribet	216458630	/hac/habitasse.png	/nulla/eget/eros/elementum/pellentesque.js
1349356437	Laura Torres	ltorresu	bSwIw2SS	ltorresu@digg.com	ltorresu@china.com.cn	114	Stringtough	152778726	/duis/mattis/egestas.js	/amet.xml
1367929410	Donna Henry	dhenryv	18qAayY8XDC	dhenryv@miitbeian.gov.cn	dhenryv@wp.com	113	Viva	127229952	/ac/diam/cras/pellentesque.js	/ipsum/ac/tellus/semper/interdum/mauris/ullamcorper.aspx
1238698135	Jane Morales	jmoralesw	InXcqKN76	jmoralesw@flickr.com	jmoralesw@xinhuanet.com	140	Sonair	138212363	/vitae/quam/suspendisse/potenti/nullam/porttitor/lacus.aspx	/in/faucibus/orci/luctus/et/ultrices.html
1233833073	Janice Davis	jdavisx	4qVqKpgWmNj	jdavisx@who.int	jdavisx@hao123.com	128	Domainer	131771094	/nisl/nunc/rhoncus/dui.jpg	/nulla/facilisi/cras/non/velit/nec.jpg
1376984254	Bobby Kennedy	bkennedyy	zG3efNs	bkennedyy@zimbio.com	bkennedyy@sogou.com	100	Zathin	174694473	/duis/faucibus/accumsan/odio/curabitur.xml	/eget/massa/tempor/convallis/nulla/neque.json
1291288787	Susan Montgomery	smontgomeryz	fqMt4deUB87m	smontgomeryz@cmu.edu	smontgomeryz@indiatimes.com	147	Home Ing	179506483	/morbi/a.jsp	/ac/tellus/semper/interdum/mauris.png
1303584753	Wayne Butler	wbutler10	8W5arlAvomC	wbutler10@comcast.net	wbutler10@usda.gov	103	Ronstring	168148525	/orci/pede/venenatis/non/sodales/sed/tincidunt.aspx	/vitae/nisl/aenean/lectus/pellentesque/eget.jsp
1255458451	Christine Robertson	crobertson11	EvfxBR	crobertson11@cam.ac.uk	crobertson11@github.io	126	Keylex	228967388	/magna.html	/erat/vestibulum/sed/magna/at/nunc.jsp
1335182600	Joseph Gonzales	jgonzales12	Cwm0iL	jgonzales12@xrea.com	jgonzales12@lycos.com	107	Alpha	175121689	/tristique/est/et/tempus/semper/est/quam.png	/eleifend/donec/ut/dolor/morbi/vel/lectus.aspx
1316327471	Sean Armstrong	sarmstrong13	gxxtPm4l	sarmstrong13@nps.gov	sarmstrong13@dell.com	105	Daltfresh	157588390	/dui/nec/nisi/volutpat/eleifend/donec.xml	/platea/dictumst/etiam/faucibus/cursus/urna.html
1288803276	Justin Romero	jromero14	Qo5VKan1V2	jromero14@google.cn	\N	128	Subin	222741749	/habitasse/platea/dictumst.aspx	/tortor.js
1288787029	Louise Simpson	lsimpson15	vJWAimE8jmg	lsimpson15@scribd.com	\N	111	Job	170230594	/diam.png	/eget/vulputate.json
1317311698	Diana Roberts	droberts16	T5MEmJG7	droberts16@theguardian.com	droberts16@sbwire.com	148	Zontrax	180775843	/libero/quis/orci.jsp	/iaculis/congue/vivamus/metus/arcu.jsp
1343439971	Dorothy Welch	dwelch17	mkyRJrk4UNW2	dwelch17@blogtalkradio.com	dwelch17@disqus.com	137	Y-Solowarm	131161321	/nunc/commodo/placerat/praesent/blandit/nam.js	/dictumst/maecenas/ut/massa.xml
1288010980	Keith Owens	kowens18	QUoDkY	kowens18@census.gov	kowens18@rambler.ru	109	Regrant	224049886	/ornare.html	/sem/praesent/id.js
1232524494	Douglas Watson	dwatson19	4FfEna8	dwatson19@toplist.cz	dwatson19@bbc.co.uk	139	Job	180262124	/dictumst/aliquam/augue.jsp	/nullam/molestie/nibh/in/lectus/pellentesque/at.jpg
1380599266	Anna Burke	aburke1a	2YPMXP3ypTa5	aburke1a@usda.gov	aburke1a@yandex.ru	109	Zathin	192685639	/amet/sem/fusce.aspx	/quam.png
1233432444	Howard Wallace	hwallace1b	7G2zMKzI	hwallace1b@stanford.edu	hwallace1b@quantcast.com	135	Fintone	234365435	/id/sapien/in/sapien/iaculis/congue/vivamus.html	/sit/amet/sapien/dignissim/vestibulum/vestibulum/ante.aspx
1245406618	Jeremy Hernandez	jhernandez1c	PqAE0J9eK	jhernandez1c@earthlink.net	jhernandez1c@desdev.cn	100	Solarbreeze	225520287	/id/nulla/ultrices/aliquet/maecenas.png	/ut/at/dolor/quis/odio/consequat.html
1208431848	Dennis Murphy	dmurphy1d	6TLOW2bw	dmurphy1d@github.io	dmurphy1d@gov.uk	129	Stringtough	154237758	/suscipit/a/feugiat/et/eros.jpg	/convallis.js
1320630781	Irene Parker	iparker1e	YqX3Y3vPy3Wj	iparker1e@cnbc.com	iparker1e@psu.edu	105	Y-Solowarm	229554352	/tincidunt/lacus/at/velit/vivamus/vel.jpg	/nisl.jpg
1283182413	Carol Howard	choward1f	Z02zVnfmt	choward1f@fc2.com	choward1f@alexa.com	117	Zamit	167293440	/ante/ipsum/primis/in/faucibus/orci/luctus.jpg	/elementum/eu/interdum/eu/tincidunt.jpg
1359028263	Stephen Rivera	srivera1g	4PREmN7rZp9	srivera1g@tiny.cc	\N	105	Viva	178522574	/nisl/ut/volutpat/sapien/arcu/sed.jsp	/eget.xml
1310762586	Walter Hill	whill1h	turhWzkbwc4	whill1h@utexas.edu	whill1h@sciencedirect.com	120	Alphazap	213995521	/ut/massa/quis/augue/luctus.json	/vitae/quam/suspendisse/potenti/nullam/porttitor.js
1281754386	Harry Torres	htorres1i	YRmwLcUMeY93	htorres1i@mozilla.org	htorres1i@arstechnica.com	122	Keylex	145095149	/id/consequat/in.jsp	/elementum/pellentesque/quisque/porta.js
1273815703	Katherine Fuller	kfuller1j	ObZHfFDu	kfuller1j@biglobe.ne.jp	kfuller1j@blogger.com	104	Hatity	140304374	/vel/ipsum.jsp	/rhoncus/dui/vel.png
1251172761	Theresa Webb	twebb1k	NJa4JVH	twebb1k@sourceforge.net	twebb1k@un.org	119	It	231054739	/vivamus/vestibulum.html	/condimentum/curabitur/in/libero/ut.html
1319723705	Richard Bowman	rbowman1l	eI7ZdCqcMEc	rbowman1l@nydailynews.com	rbowman1l@furl.net	118	Hatity	196667381	/erat/eros/viverra/eget/congue.jpg	/vivamus/vel/nulla/eget/eros/elementum/pellentesque.jsp
1382872889	Billy Burton	bburton1m	UgVelI2Ml	bburton1m@yale.edu	bburton1m@delicious.com	109	Temp	224859190	/faucibus/orci/luctus/et/ultrices/posuere.jpg	/risus/dapibus/augue.xml
1298085957	Pamela Thompson	pthompson1n	zbQDQI	pthompson1n@dot.gov	pthompson1n@archive.org	145	Konklux	187217439	/lobortis/ligula/sit/amet/eleifend.png	/potenti/nullam/porttitor/lacus/at/turpis.xml
1280589309	Lois Kim	lkim1o	EZOgKY	lkim1o@desdev.cn	lkim1o@wikimedia.org	103	Overhold	187652574	/nunc.jsp	/justo.jsp
1359909949	Kathy Brooks	kbrooks1p	CdvRkF	kbrooks1p@sciencedaily.com	kbrooks1p@opensource.org	150	Span	212287460	/urna.jsp	/enim/lorem/ipsum.jpg
1268479082	Marilyn Watkins	mwatkins1q	zf4kGF2W	mwatkins1q@gov.uk	mwatkins1q@photobucket.com	131	Opela	186130263	/consectetuer.js	/condimentum/id/luctus/nec/molestie/sed.png
1340431151	Victor Fisher	vfisher1r	6i2JfDSQq4mI	vfisher1r@lulu.com	vfisher1r@vistaprint.com	115	Prodder	135873333	/aliquam/erat/volutpat.xml	/lacinia/sapien/quis/libero/nullam/sit/amet.jsp
1317793236	Stephen Fisher	sfisher1s	L9aEwZj	sfisher1s@irs.gov	sfisher1s@nasa.gov	129	Alphazap	161682836	/dui/vel/sem/sed.js	/sed/tincidunt.xml
1351199752	Matthew Dixon	mdixon1t	0wslO6prS96F	mdixon1t@sfgate.com	mdixon1t@tamu.edu	148	Lotstring	230581417	/nam/congue/risus.json	/phasellus.xml
1402609223	Jonathan Owens	jowens1u	rRCHZsVyoh	jowens1u@chron.com	\N	104	Trippledex	151857331	/fermentum/justo/nec.js	/est/donec/odio/justo.png
1244790120	Rose Sanders	rsanders1v	uJprJo13	rsanders1v@360.cn	rsanders1v@live.com	125	Biodex	208150813	/sed/sagittis/nam/congue/risus/semper/porta.jsp	/sed/augue.jpg
1219487756	Theresa Ryan	tryan1w	4fJ508h	tryan1w@posterous.com	\N	121	Zamit	210729103	/bibendum/morbi.html	/ultrices/phasellus/id/sapien/in/sapien.jsp
1393091638	Lillian Jackson	ljackson1x	yGeaJkLPT2OA	ljackson1x@netscape.com	ljackson1x@huffingtonpost.com	126	Overhold	153786917	/sit/amet/nulla/quisque/arcu/libero/rutrum.jsp	/nisl/venenatis/lacinia/aenean/sit.aspx
1315344519	Gerald Rivera	grivera1y	plEmwFh0dOG	grivera1y@1688.com	grivera1y@npr.org	150	Cardguard	210153267	/consequat/in/consequat/ut.html	/vel/sem/sed/sagittis/nam/congue.js
1227775443	Sharon Richards	srichards1z	B0l4UGeszyS6	srichards1z@marriott.com	srichards1z@last.fm	147	Opela	154951848	/mattis/nibh/ligula/nec/sem.js	/sollicitudin.js
1395847115	Philip Myers	pmyers20	L1SANr2GC	pmyers20@microsoft.com	pmyers20@google.de	123	Cookley	162436318	/sapien/non/mi/integer/ac/neque.jpg	/congue.html
1358904740	Phyllis Cruz	pcruz21	SeR4JTOpYM	pcruz21@psu.edu	pcruz21@newsvine.com	112	Quo Lux	127877085	/etiam/faucibus/cursus.jsp	/nulla/sed/vel/enim/sit/amet/nunc.jpg
1293195029	Juan Garza	jgarza22	4HdFxQFAwat	jgarza22@csmonitor.com	jgarza22@amazon.co.uk	141	Konklux	180201092	/in/hac/habitasse/platea/dictumst/morbi/vestibulum.json	/ut/mauris/eget.json
1398011910	Lori Phillips	lphillips23	fSliaWH	lphillips23@java.com	lphillips23@chron.com	126	Rank	127678646	/cursus/id/turpis/integer.xml	/vitae/mattis/nibh.aspx
1247253832	Sarah Crawford	scrawford24	gTHb8JfIn8a	scrawford24@wordpress.com	scrawford24@tiny.cc	119	Quo Lux	233474122	/quis.png	/ligula/nec/sem.aspx
1238850236	Alan Thompson	athompson25	KWJGrBtwC35Z	athompson25@cocolog-nifty.com	\N	131	Voltsillam	137666734	/justo/eu/massa/donec/dapibus/duis/at.aspx	/ultricies/eu/nibh.html
1389578448	Henry Butler	hbutler26	HkE92t5p	hbutler26@photobucket.com	hbutler26@wikipedia.org	104	Tres-Zap	125330456	/vestibulum/rutrum/rutrum/neque.jsp	/cursus/urna/ut/tellus/nulla/ut/erat.js
1211941962	Rachel Burke	rburke27	Ht4xigWlH	rburke27@fotki.com	\N	136	Keylex	127347162	/nisi/venenatis/tristique/fusce.html	/suspendisse/accumsan/tortor/quis/turpis/sed/ante.html
1287712464	Peter Shaw	pshaw28	Y7PshO1SRbF	pshaw28@cnet.com	\N	137	Lotlux	212340368	/augue/quam/sollicitudin/vitae/consectetuer.json	/eget/rutrum/at/lorem/integer/tincidunt/ante.json
1292292416	Linda Rodriguez	lrodriguez29	lGSXsSiW	lrodriguez29@usa.gov	lrodriguez29@jigsy.com	134	Stringtough	174742028	/praesent/lectus/vestibulum/quam.aspx	/a/ipsum/integer.html
1335870845	Randy Peterson	rpeterson2a	DWDM756Zm8ou	rpeterson2a@a8.net	rpeterson2a@bbc.co.uk	124	Daltfresh	159738175	/tortor/eu/pede.html	/mauris.html
1257160881	William Carroll	wcarroll2b	zOVPF3JvSLO	wcarroll2b@jugem.jp	\N	137	Quo Lux	192031407	/elementum/ligula.jpg	/ut/tellus/nulla/ut.aspx
1364062187	Brandon Cooper	bcooper2c	dGCaaIV	bcooper2c@dedecms.com	bcooper2c@cornell.edu	149	Mat Lam Tam	165209963	/dictumst/morbi/vestibulum/velit/id.jpg	/odio.jpg
1270505362	Adam Brooks	abrooks2d	fCHbLDlEYTd	abrooks2d@google.co.uk	abrooks2d@sciencedirect.com	143	Span	171024035	/pellentesque/eget/nunc/donec/quis/orci.json	/nunc/vestibulum.html
1337455591	Scott Hill	shill2e	t6zpnPbEB	shill2e@bravesites.com	shill2e@discovery.com	129	Transcof	133868194	/posuere/cubilia/curae/nulla.html	/tortor/sollicitudin.jpg
1260310456	Linda Sanchez	lsanchez2f	vWFsSIXc	lsanchez2f@alibaba.com	lsanchez2f@bandcamp.com	117	Hatity	135020860	/amet/eros/suspendisse/accumsan/tortor/quis.aspx	/blandit/nam/nulla/integer/pede/justo.aspx
1365791162	Cynthia Cunningham	ccunningham2g	Qe9Bn6Y9G	ccunningham2g@princeton.edu	ccunningham2g@smh.com.au	139	Wrapsafe	190454985	/cum/sociis/natoque/penatibus/et/magnis/dis.jpg	/ultrices/posuere/cubilia/curae/mauris/viverra/diam.json
1292368144	Chris Cox	ccox2h	K7pFgUhJ	ccox2h@hugedomains.com	\N	118	Y-find	150925205	/erat/fermentum/justo/nec/condimentum/neque.aspx	/maecenas/tincidunt/lacus/at/velit/vivamus/vel.aspx
1276824378	Amanda Kim	akim2i	CTm6urqJh8	akim2i@google.cn	akim2i@vk.com	104	Matsoft	126411173	/a/odio/in/hac/habitasse/platea.jpg	/donec.jsp
1353307637	David Matthews	dmatthews2j	zlsF2Wwa	dmatthews2j@dell.com	dmatthews2j@twitpic.com	119	Voltsillam	148356363	/lorem/quisque/ut.aspx	/semper/est/quam/pharetra/magna/ac.png
1318686479	Daniel Hill	dhill2k	53Tl1K1g	dhill2k@cbsnews.com	dhill2k@zimbio.com	121	Stim	145089401	/nulla/pede/ullamcorper/augue.png	/lobortis/est/phasellus/sit/amet.json
1305093234	Todd Ryan	tryan2l	nnMZf8id	tryan2l@geocities.jp	tryan2l@mayoclinic.com	116	Ventosanzap	179837625	/velit/donec.png	/quis.jsp
1233069218	Henry Crawford	hcrawford2m	RrQzsuYL	hcrawford2m@linkedin.com	hcrawford2m@miibeian.gov.cn	100	Zontrax	233809341	/vel/pede/morbi/porttitor/lorem/id.jpg	/mauris/laoreet/ut/rhoncus/aliquet.xml
1208264955	Martin Jones	mjones2n	ZF9UjWbyc2SK	mjones2n@xrea.com	mjones2n@geocities.com	127	Stronghold	161858302	/bibendum/felis/sed/interdum/venenatis/turpis.xml	/vestibulum/sed/magna/at/nunc/commodo/placerat.aspx
1208954063	James George	jgeorge2o	CKRIxWlSJfPa	jgeorge2o@skyrock.com	jgeorge2o@tuttocitta.it	107	Y-Solowarm	195274933	/pede/morbi/porttitor/lorem/id.xml	/vestibulum/ante.jpg
1319951019	Howard Fisher	hfisher2p	AXChYWv	hfisher2p@histats.com	hfisher2p@china.com.cn	141	Stim	178890916	/donec/ut/dolor/morbi.jsp	/ultrices/posuere/cubilia/curae/mauris/viverra/diam.html
1369775789	Eric Palmer	epalmer2q	VeD8v5QkE2	epalmer2q@amazonaws.com	epalmer2q@patch.com	139	Tin	229491113	/integer/ac/neque/duis/bibendum/morbi.json	/volutpat/convallis/morbi/odio/odio/elementum/eu.js
1281428728	Kathryn Lynch	klynch2r	KDNPaNyRsbK	klynch2r@mtv.com	klynch2r@theatlantic.com	126	Mat Lam Tam	161376228	/nulla/nunc/purus/phasellus/in/felis/donec.aspx	/a/suscipit.json
\.


--
-- Data for Name: mata_kuliah; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY mata_kuliah (kode, nama, prasyarat_dari) FROM stdin;
IKS0000001	Basis data	\N
IKS0000002	Matematika Dasar 1	\N
IKS0000003	Struktur data dan algoritma	\N
IKS0000004	Sistem Informasi Geografis	\N
IKS0000005	Sistem terdistribusi	\N
IKS0000006	Matematika dasar 2	\N
IKS0000007	Pengolahan Citra	\N
IKS0000008	Game Development	\N
IKS0000009	Aljabar Linear	\N
IKS0000010	Sistem Operasi	\N
IKS9351721	Drip Irrigation	\N
IKS4517260	HDTV	\N
IKS8821360	AC/DC	\N
IKS5282256	DPM	\N
IKS5977935	Biodiversity	\N
IKS4168267	RS/6000	\N
IKS3748504	RFP Generation	\N
IKS0236264	HST	\N
IKS9554466	MS VC++	\N
IKS3702935	NLTK	\N
IKS4267807	Hardware Diagnostics	\N
IKS4965745	Aspen HYSYS	\N
IKS8191536	WGA	\N
IKS9083743	Oligonucleotides	\N
IKS5725285	SnagIt	\N
IKS0667937	Pharmacy	\N
IKS6248843	System Administration	\N
IKS0925433	HV	\N
IKS2223996	Smoking Cessation	\N
IKS0777986	EWSD	\N
IKS9726801	Aerial Cinematography	\N
IKS5121268	HD Camera Operation	\N
IKS2509519	Freight Forwarding	\N
IKS2389122	HSQLDB	\N
IKS1805866	MSC Patran	\N
IKS4133974	MCSD	\N
IKS0232546	QR	\N
IKS4090447	EEPROM	\N
IKS3156847	Java Enterprise Edition	\N
IKS5530269	Psychopharmacology	\N
IKS6525393	CNC Machine	\N
IKS5885066	EU Competition Law	\N
IKS9492351	Nielsen	\N
IKS1967913	People Skills	\N
IKS1174788	HSP	\N
IKS2067238	UV coating	\N
IKS5490895	Site Planning	\N
IKS8500661	Business Valuation	\N
IKS9178147	HSIA	\N
IKS9902645	Ultra Low Latency	\N
\.


--
-- Data for Name: mhs_mengambil_kelas_mk; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY mhs_mengambil_kelas_mk (npm, idkelasmk, nilai) FROM stdin;
1208954063	1	\N
1208954063	2	\N
1208954063	3	\N
1244790120	13	\N
1244790120	12	\N
1244790120	4	\N
1244790120	20	\N
1244790120	1	\N
1244790120	19	\N
1244790120	14	\N
\.


--
-- Data for Name: status_lamaran; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY status_lamaran (id, status) FROM stdin;
1	melamar
3	diterima
4	ditolak
2	rekomen
\.


--
-- Data for Name: status_log; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY status_log (id, status) FROM stdin;
2	disetujui
3	ditolak
4	diproses
\.


--
-- Data for Name: telepon_mahasiswa; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY telepon_mahasiswa (npm, nomortelepon) FROM stdin;
1206228544	085715333350
1206673470	085890908888
1206344630	081246549572
1206988989	087812904567
1206534342	081570892459
1206125547	081509882674
1206895678	085710923568
1206545476	089826457899
1206990022	085774536288
1206435435	085723552637
1206890872	081375638462
1306990234	085762303737
1306105573	089847773136
1306636820	081347561945
1306739466	081512938572
1306829621	081384315580
1306430664	081352241741
1306785917	081320551377
1306913457	085267685782
1306916326	087871345621
1306219534	085736839097
1406157976	085713791362
1406214653	085714948782
1406240675	087844804180
1406261997	081563814196
1406302495	081566917656
1406322560	085271059078
1406420858	085784652827
1406592017	081397714386
1406627338	089898128452
1406952108	081398755334
1506283733	085713319515
1506290889	087813624261
1506418583	081337129810
1506493053	081537345683
1506498675	081938822852
1506630842	081957343292
1506646058	085761604879
1506738641	089975397954
1506864051	085280934652
1506961536	085792919079
1606165472	085721354361
1606450512	085222207251
1606631213	087840039657
1606680259	081545926491
1606700816	085770846478
1606705189	081374401669
1606729975	089882579460
1606776381	085791183345
1606844544	089994339929
1347716722	33-(402)723-9417
1496125145	62-(225)553-3679
1490669956	86-(236)884-4148
1481339384	1-(970)309-2872
1444100256	55-(232)676-6635
1341611854	86-(905)223-1261
1253108266	251-(999)631-5513
1313664936	62-(347)926-7327
1228937947	86-(775)564-9727
1465351665	34-(572)592-3301
1493609728	1-(850)820-9918
1370953628	86-(632)728-2634
1468332610	386-(805)493-3408
1221955271	262-(485)518-2108
1347611672	507-(493)569-8148
1283607490	591-(449)733-3672
1298470548	385-(497)518-6555
1454198786	66-(643)635-6040
1257093553	351-(933)833-4202
1359574924	66-(909)447-9255
1330519919	48-(314)186-7753
1342525549	86-(362)599-9313
1352604501	372-(874)492-9114
1407555932	55-(475)132-7531
1474841294	52-(844)726-7038
1330298057	48-(754)951-5598
1284571403	46-(897)694-0105
1418228415	62-(631)995-9601
1435608565	62-(348)857-9933
1261639058	33-(941)343-3898
1397948843	7-(691)131-3159
1411619459	51-(521)332-5177
1351285793	687-(864)378-3642
1267442128	66-(829)139-8938
1252109061	7-(562)541-6765
1381000272	351-(160)579-6344
1461953967	55-(904)416-5851
1360525133	7-(870)714-0492
1316496967	86-(348)873-1975
1264885982	691-(622)231-7613
1362450448	66-(285)552-3919
1465892598	55-(639)340-9674
1363448798	7-(607)234-0260
1270784836	46-(119)467-8849
1442786316	351-(136)734-6115
1337766627	385-(947)604-2421
1461062168	86-(331)367-6818
1284722636	31-(134)342-6514
1498133916	86-(658)774-5168
1219791967	86-(223)261-8895
1336000051	81-(957)946-2092
1457138085	33-(128)635-2992
1368536250	48-(269)315-4093
1458620458	60-(236)588-2645
1336639864	86-(430)527-1638
1484148907	62-(340)944-1624
1488905763	351-(200)587-2150
1481688809	7-(580)438-7576
1354455479	1-(217)869-4605
1331181987	351-(979)300-6761
1472687745	381-(114)900-8780
1208673470	86-(808)982-2912
1231033129	86-(597)921-8854
1468473707	47-(703)184-2972
1464296189	34-(715)205-5329
1281303396	351-(428)877-6323
1473877887	351-(119)967-3921
1305524630	86-(288)914-0268
1406614097	967-(869)612-8569
1333304669	967-(461)651-5805
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: siasisten; Owner: henry.louis
--

COPY term (tahun, semester) FROM stdin;
2012	1
2013	2
2014	3
2015	1
2016	2
\.


--
-- Name: dosen_kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_pkey PRIMARY KEY (nip, idkelasmk);


--
-- Name: dosen_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY dosen
    ADD CONSTRAINT dosen_pkey PRIMARY KEY (nip);


--
-- Name: kategori_log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY kategori_log
    ADD CONSTRAINT kategori_log_pkey PRIMARY KEY (id);


--
-- Name: kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_pkey PRIMARY KEY (idkelasmk);


--
-- Name: lamaran_idlamaran_key; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_idlamaran_key UNIQUE (idlamaran);


--
-- Name: lamaran_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_pkey PRIMARY KEY (idlamaran, npm);


--
-- Name: log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_pkey PRIMARY KEY (idlog);


--
-- Name: lowongan_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_pkey PRIMARY KEY (idlowongan);


--
-- Name: mahasiswa_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY mahasiswa
    ADD CONSTRAINT mahasiswa_pkey PRIMARY KEY (npm);


--
-- Name: mata_kuliah_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY mata_kuliah
    ADD CONSTRAINT mata_kuliah_pkey PRIMARY KEY (kode);


--
-- Name: mhs_mengambil_kelas_mk_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_pkey PRIMARY KEY (npm, idkelasmk);


--
-- Name: status_lamaran_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY status_lamaran
    ADD CONSTRAINT status_lamaran_pkey PRIMARY KEY (id);


--
-- Name: status_log_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY status_log
    ADD CONSTRAINT status_log_pkey PRIMARY KEY (id);


--
-- Name: telepon_npm_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY telepon_mahasiswa
    ADD CONSTRAINT telepon_npm_pkey PRIMARY KEY (npm, nomortelepon);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: siasisten; Owner: henry.louis; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (tahun, semester);


--
-- Name: tambah_lowongan; Type: TRIGGER; Schema: siasisten; Owner: henry.louis
--

CREATE TRIGGER tambah_lowongan AFTER INSERT ON lamaran FOR EACH ROW EXECUTE PROCEDURE tambah_lowongan();


--
-- Name: tambah_pelamar_diterima; Type: TRIGGER; Schema: siasisten; Owner: henry.louis
--

CREATE TRIGGER tambah_pelamar_diterima AFTER UPDATE OF id_st_lamaran ON lamaran FOR EACH ROW EXECUTE PROCEDURE tambah_pelamar_diterima();


--
-- Name: dosen_kelas_mk_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: dosen_kelas_mk_nip_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY dosen_kelas_mk
    ADD CONSTRAINT dosen_kelas_mk_nip_fkey FOREIGN KEY (nip) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: kelas_mk_kode_mk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_kode_mk_fkey FOREIGN KEY (kode_mk) REFERENCES mata_kuliah(kode) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: kelas_mk_tahun_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY kelas_mk
    ADD CONSTRAINT kelas_mk_tahun_fkey FOREIGN KEY (tahun, semester) REFERENCES term(tahun, semester) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lamaran_id_st_lamaran_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_id_st_lamaran_fkey FOREIGN KEY (id_st_lamaran) REFERENCES status_lamaran(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lamaran_idlowongan_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_idlowongan_fkey FOREIGN KEY (idlowongan) REFERENCES lowongan(idlowongan) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lamaran_nip_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_nip_fkey FOREIGN KEY (nip) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lamaran_npm_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lamaran
    ADD CONSTRAINT lamaran_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: log_id_kat_log_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_id_kat_log_fkey FOREIGN KEY (id_kat_log) REFERENCES kategori_log(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: log_id_st_log_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_id_st_log_fkey FOREIGN KEY (id_st_log) REFERENCES status_log(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: log_idlamaran_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY log
    ADD CONSTRAINT log_idlamaran_fkey FOREIGN KEY (idlamaran) REFERENCES lamaran(idlamaran) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lowongan_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lowongan_nipdosenpembuka_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY lowongan
    ADD CONSTRAINT lowongan_nipdosenpembuka_fkey FOREIGN KEY (nipdosenpembuka) REFERENCES dosen(nip) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mata_kuliah_prasyarat_dari_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY mata_kuliah
    ADD CONSTRAINT mata_kuliah_prasyarat_dari_fkey FOREIGN KEY (prasyarat_dari) REFERENCES mata_kuliah(kode) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mhs_mengambil_kelas_mk_idkelasmk_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_idkelasmk_fkey FOREIGN KEY (idkelasmk) REFERENCES kelas_mk(idkelasmk) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: mhs_mengambil_kelas_mk_npm_fkey; Type: FK CONSTRAINT; Schema: siasisten; Owner: henry.louis
--

ALTER TABLE ONLY mhs_mengambil_kelas_mk
    ADD CONSTRAINT mhs_mengambil_kelas_mk_npm_fkey FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

