CREATE FUNCTION get_comments() RETURNS TABLE("like" comments)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from comments;
end
$$;