const {parseFeeds} = require('../../rss/xmlParser.js');
const feedManager = require('../../rss/feedManager.js');

module.exports = function scrapePosts(db, feedManager) {
  return db
    .getAuthors()
    .then(authors => feedManager.parseFeeds(authors))
    .then(feeds => feedManager.convertFeedsToPosts(feeds))
    .then(posts => db.addPosts(posts));
};
