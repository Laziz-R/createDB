CREATE FUNCTION upd_book(b_id integer, na character varying, au character varying, p_id integer, p_year integer, i character varying, tags integer[]) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
msg varchar;
old_tags integer[];
begin

update books set name = na, author = au, pub_id = p_id, pub_year = p_year, isbn = i 
			where id=b_id returning name into msg;

delete from book_tags where book_id=b_id;

IF array_upper(tags, 1)>0 THEN 
FOR i IN 1..array_upper(tags, 1) LOOP
	INSERT INTO book_tags(book_id, tag_id) VALUES(b_id, tags[i]);
END LOOP;
END IF;

return 'Succesfully updated '||msg||'.';
end;
$$;;