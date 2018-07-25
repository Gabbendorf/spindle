const {expect} = require('chai');
const {Client} = require('pg');
const Db = require('../../src/lib/db/db.js');
const {addTables} = require('../../src/lib/db/schema.js');

const dbConfig = {
  host: 'localhost',
  user: 'postgres',
  database: 'spindle_test',
};

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
      {source: 'medium', author: 'gabi', url: 'gabis-url'},
      {source: 'jekyll', author: 'andrew', url: 'andrews-url'},
    ]);
  });

  describe('adding a post', () => {
    const post1 = {
      author: 'gabi',
      title: 'Spreading the word',
      content: 'some content',
      date: 38853974,
      link: 'gabis_posts.com',
    };

    const post2 = {
      author: 'andrew',
      title: 'Earth to Mercury',
      content: 'some content',
      date: 47397935,
      link: 'andrews_posts.com',
    };

    beforeEach(async () => {
      await addAuthor('gabi', 'medas', 'medium');
      await addAuthor('andrew', 'macmurray', 'jekyll');
    });

    it('inserts author posts in posts table', async () => {
      await db.addPosts([post1, post2]);

      const posts = await executeQuery('SELECT * FROM posts;');
      expect(posts.length).to.eq(2);
      expect(posts[0].title).to.eq(post1.title);
      expect(posts[1].title).to.eq(post2.title);
    });

    it('doesnt insert a duplicate post', async () => {
      await db.addPosts([post1, post1]);

      const posts = await executeQuery('SELECT * FROM posts;');
      expect(posts.length).to.eq(1);
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
