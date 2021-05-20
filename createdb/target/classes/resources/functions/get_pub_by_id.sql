CREATE FUNCTION get_pub_by_id(pub_id INTEGER) RETURNS  SETOF publishers
    LANGUAGE plpgsql
    AS
$$
begin 
	return query select * from publishers where id=pub_id;
end
$$;;