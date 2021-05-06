create table comments(
    id serial PRIMARY KEY,
    author VARCHAR(50),
    book_id smallint,
    text VARCHAR(250),
    posted_time timestamp without time zone
);