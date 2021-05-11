CREATE FUNCTION del_pub(p_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from publishers where id=p_id returning name into msg;
return 'Succesfully deleted '|| msg||'.';
end;
$$;;