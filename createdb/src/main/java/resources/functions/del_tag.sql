CREATE FUNCTION del_tag(t_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from tags where id=t_id returning name into msg;
return 'Succesfully deleted '|| msg ||'.';
end;
$$;
