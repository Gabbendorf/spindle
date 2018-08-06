const {parseFeeds} = require('./xmlParser.js');
const formatResponse = require('./formatResponse.js');

module.exports = class FeedManager {
  constructor(rssParser) {
    this._rssParser = rssParser;
  }

  parseFeeds(authors) {
    return parseFeeds(this._rssParser, authors);
  }

  formatResponse(feeds) {
    return formatResponse(feeds);
  }
};
