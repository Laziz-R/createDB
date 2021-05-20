CREATE FUNCTION get_com_by_id(com_id INTEGER) RETURNS  SETOF comments
    LANGUAGE plpgsql
    AS
$$
begin 
	return query select * from comments where id=com_id;
end
$$;;