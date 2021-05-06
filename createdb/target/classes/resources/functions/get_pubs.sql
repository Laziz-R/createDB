CREATE FUNCTION get_pubs() RETURNS TABLE("like" publishers)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from publishers;
end
$$;;