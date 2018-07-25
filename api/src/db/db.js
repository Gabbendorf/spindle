const {Client} = require('pg');

module.exports = class Db {
  constructor(connectionConfig) {
    this.connection = new Connection(connectionConfig);
  }

  async getAuthors() {
    const getAuthorsQuery = 'SELECT * FROM authors;';
    const records = await this._executeQuery(getAuthorsQuery);
    return records.map(record => {
      return {
        author: record.first_name,
        source: record.blog_source,
        url: record.blog_url,
      };
    });
  }

  async addPosts(posts) {
    const queries = posts.map(post => this._insertPostQuery(post));
    const query = queries.join(' ') + ';';
    await this._executeQuery(query);
  }

  async getAuthorPosts() {
    const authors = await this.getAuthors();
    const posts = await this.getPosts();
    return authors.map(author => {
      return {
        author: author.author,
        posts: posts
        .filter(post => post.first_name === author.author)
        .map(({title, link, content, date }) => {
          return { title, link, content, date: date.toString() };
        }),
      };
    });
  }

  async getPosts() {
    const query = `SELECT
      posts.title, posts.content, posts.date, posts.link, authors.first_name
      FROM posts
      INNER JOIN authors
      ON posts.author_id = authors.id;`;

    return this._executeQuery(query);
  }

  _insertPostQuery({author, title, link, content, date}) {
    const getAuthorId = `SELECT id FROM authors WHERE first_name = '${author}'`;
    const fields = `(author_id, title, link, content, date)`;
    const values = `(
      (${getAuthorId}),
      '${title}',
      '${link}',
      '${content}',
      '${date}'
    )`;
    return `INSERT INTO posts ${fields} VALUES ${values} ON CONFLICT DO NOTHING;`;
  }

  async _executeQuery(query) {
    return this.connection.query(query);
  }
};

class Connection {
  constructor(connectionConfig) {
    this.connectionConfig = connectionConfig;
  }

  async query(query) {
    const client = this._createClient();
    try {
      return this._executeQuery(client, query);
    } catch (err) {
      return this._onErrorDisconnect(client, err);
    }
  }

  async _executeQuery(client, query) {
    await client.connect();
    const result = await client.query(query);
    await client.end();
    return result.rows;
  }

  async _onErrorDisconnect(client, err) {
    console.log(err);
    await client.end();
  }

  _createClient() {
    return new Client(this.connectionConfig);
  }
}
