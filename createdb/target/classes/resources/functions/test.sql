create function test() RETURNS VARCHAR AS 
'
BEGIN
    return 'Salom';
END; 
'
LANGUAGE plpgsql;