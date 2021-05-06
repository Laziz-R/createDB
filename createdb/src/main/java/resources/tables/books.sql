create table books(
    id serial PRIMARY KEY,
    name VARCHAR(100),
    author VARCHAR(100),
    pub_id smallint,
    pub_year smallint,
    isbn VARCHAR(20),
    UNIQUE (name, author, pub_id, pub_year)
 );