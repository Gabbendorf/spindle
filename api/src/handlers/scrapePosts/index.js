const scrapePosts = require('./scrapePosts.js');
const Db = require('../../db/db.js')
const FeedManager = require('../../rss/feedManager.js')
const Parser = require('rss-parser');

module.exports.handler = (event, context, callback) => {
  const connectionConfig = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD
  };

  const db = new Db(connectionConfig);
  const rssParser = new Parser();
  const feedManager = new FeedManager(rssParser);
  scrapePosts(db, feedManager)
    .then(() => callback(null, 'posts added'))
    .catch(err => callback(err, null));
};
