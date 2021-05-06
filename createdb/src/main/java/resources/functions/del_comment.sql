CREATE FUNCTION del_comment(c_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from comments where id=c_id returning author into msg;
return 'Succesfully deleted (by '||msg||')';
end;
$$;