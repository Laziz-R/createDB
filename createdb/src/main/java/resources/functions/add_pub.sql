CREATE FUNCTION public.add_pub(na character varying, ad character varying, ph character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
msg VARCHAR;
BEGIN

INSERT INTO publishers(name, address, phone) VALUES(na, ad, ph) 
RETURNING name INTO msg;

return 'Succesfully added '||msg||'.';
END;
$$;;