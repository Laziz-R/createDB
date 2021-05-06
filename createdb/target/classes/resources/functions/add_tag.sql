CREATE FUNCTION public.add_tag(na character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
msg VARCHAR;
BEGIN
INSERT INTO tags(name) VALUES(na) RETURNING name INTO msg;
return 'Succesfully added '||msg||'.';
END;
$$;