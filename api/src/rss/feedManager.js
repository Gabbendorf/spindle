const {parseFeeds} = require('./xmlParser.js') 
const {convertFeedsToPosts} = require('./xmlParser.js') 

module.exports = class FeedManager {
  constructor(rssParser) {
    this._rssParser = rssParser;
  }

  parseFeeds (authors) {
    return parseFeeds(this._rssParser, authors);
  }

  convertFeedsToPosts (feeds) {
    return convertFeedsToPosts(feeds);
  }
};
