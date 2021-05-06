create table comments(
    id serial PRIMARY KEY,
    author VARCHAR(50),
    book_id smallint,
    text text,
    posted_time timestamp without time zone
);