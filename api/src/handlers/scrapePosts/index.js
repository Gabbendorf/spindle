const scrapePosts = require('./scrapePosts.js');
const Db = require('../../db/db.js')
const connectionConfig = require('../../db/connectionConfig.js')
const FeedManager = require('../../rss/feedManager.js')
const Parser = require('rss-parser');

module.exports.handler = (event, context, callback) => {
  const db = new Db(connectionConfig);
  const rssParser = new Parser();
  const feedManager = new FeedManager(rssParser);

  scrapePosts(db, feedManager)
    .then(() => callback(null, 'posts added'))
    .catch(err => callback(err, null));
};
