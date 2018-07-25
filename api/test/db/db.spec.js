const {expect} = require('chai');
const {Client} = require('pg');
const Db = require('../../src/db/db.js');
const {addTables} = require('../../src/db/schema.js');

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
    await addAuthor('gabi', 'medas', 'medium');
    await addAuthor('andrew', 'macmurray', 'jekyll');

    db = new Db(dbConfig);
  });

  afterEach(async () => {
    await executeQuery(deleteTables);
  });

  it('gets list of authors from database', async () => {
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
      date: 'Fri, 29 Jun 2018 11:21:29 GMT',
      link: 'gabis_posts.com',
    };

    const post2 = {
      author: 'andrew',
      title: 'Earth to Mercury',
      content: 'some content',
      date: 'Fri, 29 Jun 2018 11:21:29 GMT',
      link: 'andrews_posts.com',
    };

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

  describe('getAuthorPosts', () => {
    it('gets an array of authors with their posts', async () => {
      const post1 = {
        author: 'gabi',
        title: 'Spreading the word',
        content: 'some content',
        date: 'Fri, 29 Jun 2018 11:21:29 GMT',
        link: 'gabis_posts.com',
      };

      const post2 = {
        author: 'andrew',
        title: 'Earth to Mercury',
        content: 'some content',
        date: 'Fri, 29 Jun 2018 11:21:29 GMT',
        link: 'andrews_posts.com',
      };

      const post3 = {
        author: 'andrew',
        title: 'Gradle stuff',
        content: 'some content',
        date: 'Fri, 29 Jun 2018 11:21:29 GMT',
        link: 'andrews_posts.com',
      };
      await db.addPosts([post1, post2, post3]);

      const posts = await db.getAuthorPosts();

      expect(posts).to.deep.equal([
        {
          author: 'gabi',
          posts: [
            {
              title: 'Spreading the word',
              content: 'some content',
              date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
              link: 'gabis_posts.com',
            },
          ],
        },
        {
          author: 'andrew',
          posts: [
            {
              title: 'Earth to Mercury',
              content: 'some content',
              date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
              link: 'andrews_posts.com',
            },
            {
              title: 'Gradle stuff',
              content: 'some content',
              date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
              link: 'andrews_posts.com',
            },
          ],
        },
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
