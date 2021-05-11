CREATE FUNCTION upd_comment(c_id integer, au character varying, txt character varying) 
RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
begin
update comments set author = au, text = txt where id=c_id returning author into msg;
return 'Succesfully updated (by '||msg||')';
end;
$$;;