CREATE FUNCTION upd_pub(p_id integer, na character varying, ad character varying, ph character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update publishers set name = na, address = ad, phone = ph where id=p_id returning name into msg;
return 'Succesfully updated '||msg||'.';
end;
$$;;