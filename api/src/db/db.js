const {Client} = require('pg');

module.exports = class Db {
  constructor(config) {
    this.config = config;
  }

  async getAuthors() {
    const records = await this.executeQuery('SELECT * FROM authors;');
    return records.map(row => {
      return {
        id: row.id,
        source: row.blog_source,
        url: row.blog_url,
      };
    });
  }

  async addPostsForAuthor(firstName, secondName, posts) {
    const author = await this.executeQuery(
      `SELECT id FROM authors WHERE first_name = '${firstName}' AND second_name = '${secondName}';`,
    );

    const queryValues = posts
      .map(
        post =>
          `('${author[0].id}', '${post.title}', '${post.link}', '${
            post.content
          }', '${post.date}')`,
      )
      .join(', ');
    const query = `INSERT INTO posts (author_id, title, link, content, date) VALUES ${queryValues};`;
    await this.executeQuery(query);
  }

  async executeQuery(query) {
    try {
      const client = new Client(this.config);
      await client.connect();
      const result = await client.query(query);
      await client.end();
      return result.rows;
    } catch (err) {
      await client.end();
      console.log(err);
    }
  }
};
