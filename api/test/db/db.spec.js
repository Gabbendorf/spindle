const {expect} = require('chai');
const {Client} = require('pg');
const Db = require('../../src/db/db.js');

const dbConfig = {
  host: 'localhost',
  user: 'postgres',
  database: 'spindle_test',
};

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
    date integer NOT NULL,
    UNIQUE (author_id, title)
  );
`;

const deleteTables = `
  DROP TABLE IF EXISTS posts;
  DROP TABLE IF EXISTS authors;
`;

describe('db class', () => {
  let db;

  beforeEach(async () => {
    await executeQuery(deleteTables);
    await executeQuery(addTables);
    db = new Db(dbConfig);
  });

  afterEach(async () => {
    await executeQuery(deleteTables);
  });

  it('gets list of authors from database', async () => {
    await addAuthor('gabi', 'medas', 'medium');
    await addAuthor('andrew', 'macmurray', 'jekyll');

    const authors = await db.getAuthors();

    expect(authors).to.deep.equal([
      {source: 'medium', id: 1, url: 'gabis-url'},
      {source: 'jekyll', id: 2, url: 'andrews-url'},
    ]);
  });

  describe('adding a post', () => {
    const post1 = {
      title: 'Spreading the word',
      content: 'some content',
      date: 38853974,
      link: 'gabis_posts.com',
    };

    const post2 = {
      title: 'First time with Elixir',
      content: 'some content',
      date: 47397935,
      link: 'gabis_posts.com',
    };

    beforeEach(async () => {
      await addAuthor('gabi', 'medas', 'medium');
    });

    it('inserts author posts in posts table', async () => {
      await db.addPostsForAuthor('gabi', 'medas', [post1, post2]);

      const posts = await executeQuery('SELECT * FROM posts;');
      expect(posts).to.deep.equal([
        {...post1, id: 1, author_id: 1},
        {...post2, id: 2, author_id: 1},
      ]);
    });

    it('doesnt insert a duplicate post', async () => {
      await db.addPostsForAuthor('gabi', 'medas', [post1, post1]);
      
      const posts = await executeQuery('SELECT * FROM posts;');
      expect(posts).to.deep.equal([
        {...post1, id: 1, author_id: 1},
      ]);
    });
  });

  async function addAuthor(firstName, lastName, source) {
    const query = `
      INSERT INTO authors (first_name, second_name, blog_url, blog_source)
      VALUES ('${firstName}', '${lastName}', '${firstName}s-url', '${source}');
    `;
    await executeQuery(query);
  }

  async function executeQuery(query) {
    let client;
    try {
      client = new Client(dbConfig);
      await client.connect();
      const result = await client.query(query);
      await client.end();
      return result.rows;
    } catch (err) {
      await client.end();
    }
  }
});
