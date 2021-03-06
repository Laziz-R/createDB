CREATE FUNCTION public.add_comment(au character varying, b_id integer, txt character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
msg VARCHAR;
BEGIN
INSERT INTO comments(author, text, book_id, posted_time) VALUES(au, txt, b_id, now())
RETURNING author INTO msg;
return 'Succesfully posted by '||msg||'.';
END;
$$;;