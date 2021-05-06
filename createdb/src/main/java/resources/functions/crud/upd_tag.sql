CREATE FUNCTION upd_tag(t_id integer, na character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update tags set name = na where id=t_id returning name into msg;
return 'Succesfully updated '||msg||'.';
end;
$$;;