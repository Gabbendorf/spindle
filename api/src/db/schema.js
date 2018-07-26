const addTables = `
  CREATE TABLE IF NOT EXISTS authors(
    id SERIAL PRIMARY KEY,
    first_name text NOT NULL,
    second_name text NOT NULL,
    blog_url text NOT NULL,
    blog_source text NOT NULL
  );

  CREATE TABLE IF NOT EXISTS posts(
    id SERIAL PRIMARY KEY,
    author_id integer REFERENCES authors (id) NOT NULL,
    title text NOT NULL,
    link text NOT NULL,
    content text NOT NULL,
    date date NOT NULL,
    UNIQUE (author_id, title)
  );
`;

module.exports = {addTables};
