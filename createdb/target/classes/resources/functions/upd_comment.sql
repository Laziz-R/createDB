CREATE FUNCTION upd_comment(c_id integer, au character varying, txt character varying, b_id integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update comments set author = au, text = txt, book_id = b_id where id=c_id returning author into msg;
return 'Succesfully updated (by '||msg||')';
end;
$$;