create table book_tags(
    book_id smallint,
    tag_id smallint,
    UNIQUE (book_id, tag_id)
);