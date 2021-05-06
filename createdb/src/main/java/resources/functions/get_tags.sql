CREATE FUNCTION get_tags() RETURNS TABLE("like" tags)
    LANGUAGE plpgsql
    AS $$
begin
return query select * from tags;
end
$$;