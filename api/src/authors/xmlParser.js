function parseFeeds(parser, feedConfigs) {
  return Promise.all(feedConfigs.map(config => parseFeed(parser, config)));
}

function parseFeed(parser, { source, author, url }) {
  return parser.parseURL(url).then(response => ({
    source: source,
    author: author,
    feed: response
  }));
}

module.exports = {
  parseFeeds,
  parseFeed
};
