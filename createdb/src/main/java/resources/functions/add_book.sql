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
return 'Succesfully added '||msg||'.';
END;
$$;