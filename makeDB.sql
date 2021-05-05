--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 12.6

-- Started on 2021-05-05 13:25:18

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

DROP DATABASE "Library";
--
-- TOC entry 2879 (class 1262 OID 16423)
-- Name: Library; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Library" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE "Library" OWNER TO postgres;

\connect "Library"

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
-- TOC entry 214 (class 1255 OID 16543)
-- Name: add_book(character varying, character varying, integer, integer, character varying, integer[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_book(na character varying, au character varying, p_id integer, p_year integer, i character varying, tags integer[]) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
id_book INTEGER;
msg VARCHAR;
BEGIN
INSERT INTO books(name, author, pub_id, pub_year, isbn) 
VALUES(na, au, p_id, p_year, i) RETURNING id, name INTO id_book, msg;

IF array_upper(tags, 1)>0 THEN 
FOR i IN 1..array_upper(tags, 1) LOOP
	INSERT INTO book_tags(book_id, tag_id) VALUES(id_book, tags[i]);
END LOOP;
END IF;
return 'Succesfully added: '||msg||'.';
END;
$$;


ALTER FUNCTION public.add_book(na character varying, au character varying, p_id integer, p_year integer, i character varying, tags integer[]) OWNER TO postgres;

--
-- TOC entry 212 (class 1255 OID 16641)
-- Name: add_comment(character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_comment(au character varying, txt character varying, b_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
msg VARCHAR;
BEGIN
INSERT INTO comments(author, text, book_id, posted_time) VALUES(au, txt, b_id, now())
RETURNING author INTO msg;
return 'Succesfully posted by '||msg||'.';
END;
$$;


ALTER FUNCTION public.add_comment(au character varying, txt character varying, b_id integer) OWNER TO postgres;

--
-- TOC entry 211 (class 1255 OID 16528)
-- Name: add_pub(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_pub(na character varying, ad character varying, ph character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
msg VARCHAR;
BEGIN

INSERT INTO publishers(name, address, phone) VALUES(na, ad, ph) 
RETURNING name INTO msg;

return 'Succesfully added: '||msg||'.';
END;
$$;


ALTER FUNCTION public.add_pub(na character varying, ad character varying, ph character varying) OWNER TO postgres;

--
-- TOC entry 213 (class 1255 OID 16540)
-- Name: add_tag(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.add_tag(na character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
msg VARCHAR;
BEGIN
INSERT INTO tags(name) VALUES(na) RETURNING name INTO msg;
return 'Succesfully added: '||msg||'.';
END;
$$;


ALTER FUNCTION public.add_tag(na character varying) OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16622)
-- Name: del_book(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_book(b_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from books where id=b_id returning name into msg;
return 'Succesfully deleted: ' || msg;
end;
$$;


ALTER FUNCTION public.del_book(b_id integer) OWNER TO postgres;

--
-- TOC entry 232 (class 1255 OID 16630)
-- Name: del_comment(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_comment(c_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from comments where id=c_id returning author into msg;
return 'Succesfully deleted: by '||msg;
end;
$$;


ALTER FUNCTION public.del_comment(c_id integer) OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 16623)
-- Name: del_pub(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_pub(p_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from publishers where id=p_id returning name into msg;
return 'Succesfully deleted: ' || msg;
end;
$$;


ALTER FUNCTION public.del_pub(p_id integer) OWNER TO postgres;

--
-- TOC entry 235 (class 1255 OID 16629)
-- Name: del_tag(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.del_tag(t_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from tags where id=t_id returning name into msg;
return 'Succesfully deleted: ' || msg;
end;
$$;


ALTER FUNCTION public.del_tag(t_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 16426)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id smallint NOT NULL,
    name character varying(255) NOT NULL,
    author character varying(255),
    pub_id smallint,
    pub_year smallint,
    isbn character varying(20)
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 218 (class 1255 OID 16621)
-- Name: get_books(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_books() RETURNS SETOF public.books
    LANGUAGE plpgsql
    AS $$
begin 
	return query select * from books;
end;
$$;


ALTER FUNCTION public.get_books() OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16592)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id smallint NOT NULL,
    author character varying(100),
    book_id smallint NOT NULL,
    text character varying(255) NOT NULL,
    posted_time timestamp without time zone
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 215 (class 1255 OID 16617)
-- Name: get_comments(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_comments() RETURNS TABLE("like" public.comments)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from comments;
end
$$;


ALTER FUNCTION public.get_comments() OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16475)
-- Name: publishers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publishers (
    id smallint NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255),
    phone character varying(20)
);


ALTER TABLE public.publishers OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16619)
-- Name: get_pubs(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_pubs() RETURNS TABLE("like" public.publishers)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from publishers;
end
$$;


ALTER FUNCTION public.get_pubs() OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16531)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 216 (class 1255 OID 16618)
-- Name: get_tags(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_tags() RETURNS TABLE("like" public.tags)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from tags;
end
$$;


ALTER FUNCTION public.get_tags() OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 16632)
-- Name: upd_book(integer, character varying, character varying, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.upd_book(b_id integer, na character varying, au character varying, p_id integer, p_year integer, i character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update books set name = na, author = au, pub_id = p_id, pub_year = p_year, isbn = i 
			where id=b_id returning name into msg;
return 'Succesfully updated: '||msg;
end;
$$;


ALTER FUNCTION public.upd_book(b_id integer, na character varying, au character varying, p_id integer, p_year integer, i character varying) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 16643)
-- Name: upd_comment(integer, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.upd_comment(c_id integer, au character varying, txt character varying, b_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update comments set author = au, text = txt, book_id = b_id where id=c_id returning author into msg;
return 'Succesfully updated: by '||msg;
end;
$$;


ALTER FUNCTION public.upd_comment(c_id integer, au character varying, txt character varying, b_id integer) OWNER TO postgres;

--
-- TOC entry 238 (class 1255 OID 16634)
-- Name: upd_pub(integer, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.upd_pub(p_id integer, na character varying, ad character varying, ph character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update publishers set name = na, address = ad, phone = ph where id=p_id returning name into msg;
return 'Succesfully updated: '||msg;
end;
$$;


ALTER FUNCTION public.upd_pub(p_id integer, na character varying, ad character varying, ph character varying) OWNER TO postgres;

--
-- TOC entry 237 (class 1255 OID 16633)
-- Name: upd_tag(integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.upd_tag(t_id integer, na character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update tags set name = na where id=t_id returning name into msg;
return 'Succesfully updated: '||msg;
end;
$$;


ALTER FUNCTION public.upd_tag(t_id integer, na character varying) OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16424)
-- Name: Books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Books_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Books_id_seq" OWNER TO postgres;

--
-- TOC entry 2880 (class 0 OID 0)
-- Dependencies: 202
-- Name: Books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Books_id_seq" OWNED BY public.books.id;


--
-- TOC entry 204 (class 1259 OID 16473)
-- Name: Publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Publishers_id_seq"
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Publishers_id_seq" OWNER TO postgres;

--
-- TOC entry 2881 (class 0 OID 0)
-- Dependencies: 204
-- Name: Publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Publishers_id_seq" OWNED BY public.publishers.id;


--
-- TOC entry 206 (class 1259 OID 16515)
-- Name: book_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_tags (
    book_id smallint NOT NULL,
    tag_id smallint NOT NULL
);


ALTER TABLE public.book_tags OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16590)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO postgres;

--
-- TOC entry 2882 (class 0 OID 0)
-- Dependencies: 209
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.comments.id;


--
-- TOC entry 207 (class 1259 OID 16529)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- TOC entry 2883 (class 0 OID 0)
-- Dependencies: 207
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- TOC entry 2728 (class 2604 OID 16429)
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public."Books_id_seq"'::regclass);


--
-- TOC entry 2731 (class 2604 OID 16595)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 2729 (class 2604 OID 16478)
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public."Publishers_id_seq"'::regclass);


--
-- TOC entry 2730 (class 2604 OID 16534)
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- TOC entry 2733 (class 2606 OID 16434)
-- Name: books Books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT "Books_pkey" PRIMARY KEY (id);


--
-- TOC entry 2737 (class 2606 OID 16480)
-- Name: publishers Publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT "Publishers_pkey" PRIMARY KEY (id);


--
-- TOC entry 2735 (class 2606 OID 16579)
-- Name: books book; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT book UNIQUE (name, author, pub_id, pub_year);


--
-- TOC entry 2739 (class 2606 OID 16526)
-- Name: book_tags book_tag; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_tags
    ADD CONSTRAINT book_tag PRIMARY KEY (book_id, tag_id);


--
-- TOC entry 2741 (class 2606 OID 16555)
-- Name: tags id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT id_pk PRIMARY KEY (id);


--
-- TOC entry 2743 (class 2606 OID 16600)
-- Name: comments posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 2745 (class 2606 OID 16568)
-- Name: book_tags book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_tags
    ADD CONSTRAINT book_fk FOREIGN KEY (book_id) REFERENCES public.books(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2747 (class 2606 OID 16601)
-- Name: comments book_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT book_fk FOREIGN KEY (book_id) REFERENCES public.books(id);


--
-- TOC entry 2744 (class 2606 OID 16624)
-- Name: books pub_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT pub_fk FOREIGN KEY (pub_id) REFERENCES public.publishers(id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;


--
-- TOC entry 2746 (class 2606 OID 16573)
-- Name: book_tags tag_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_tags
    ADD CONSTRAINT tag_fk FOREIGN KEY (tag_id) REFERENCES public.tags(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


-- Completed on 2021-05-05 13:25:18

--
-- PostgreSQL database dump complete
--

