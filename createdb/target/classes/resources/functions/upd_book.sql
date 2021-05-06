CREATE FUNCTION upd_book(b_id integer, na character varying, au character varying, p_id integer, p_year integer, i character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update books set name = na, author = au, pub_id = p_id, pub_year = p_year, isbn = i 
			where id=b_id returning name into msg;
return 'Succesfully updated '||msg||'.';
end;
$$;