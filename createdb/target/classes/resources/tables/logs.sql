DROP TABLE  IF EXISTS logs;
CREATE TABLE logs
   (id SERIAL PRIMARY KEY NOT NULL,
    dated   timestamp without time zone NOT NULL,
    logger  VARCHAR(50)    NOT NULL,
    level   VARCHAR(10)    NOT NULL,
    message VARCHAR(1000)  NOT NULL
   );