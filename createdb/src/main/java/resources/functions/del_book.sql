CREATE FUNCTION del_book(b_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
delete from books where id=b_id returning name into msg;
return 'Succesfully deleted ' || msg ||'.';
end;
$$;;