const {Client} = require('pg');

module.exports = class Db {
  constructor(config) {
    this.config = config;
  }

  async getAuthors() {
    const records = await this.executeQuery('SELECT * FROM authors;');
    return records.map(row => {
      return {
        author: row.first_name,
        source: row.blog_source,
        url: row.blog_url,
      };
    });
  }

  async addPosts(posts) {
    const queries = await Promise.all(posts.map(async (post) => {
      return this.insertPostQuery(post);
    }));
    const query = `${queries.join(' ')};`;

    await this.executeQuery(query);
  }

  async insertPostQuery(post) {
    const author = await this.executeQuery(
      `SELECT id FROM authors WHERE first_name = '${post.author}';`,
    );
    const authorId = author[0].id;
    const fields = `(author_id, title, link, content, date)`;
    const values = `('${authorId}', '${post.title}', '${post.link}', '${ post.content }', '${post.date}')`;
    return `INSERT INTO posts ${fields} VALUES ${values} ON CONFLICT DO NOTHING;`;
  }

  async executeQuery(query) {
    let client;
    try {
      client = new Client(this.config);
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
