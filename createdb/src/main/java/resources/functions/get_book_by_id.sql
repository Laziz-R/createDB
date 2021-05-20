CREATE FUNCTION get_book_by_id(book_id INTEGER) RETURNS  SETOF books
    LANGUAGE plpgsql
    AS
$$
begin 
	return query select * from books where id=book_id;
end
$$;;