CREATE FUNCTION get_books() RETURNS SETOF books
    LANGUAGE plpgsql
    AS
$$
begin 
	return query select * from books;
end
$$;;