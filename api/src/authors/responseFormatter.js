function formatMediumItem(rawJson) {
  return {
    title: rawJson.title,
    link: rawJson.link,
    date: rawJson.pubDate,
    content: rawJson["content:encoded"]
  };
}

function formatJekyllItem(rawJson) {
  return {
    title: rawJson.title,
    link: rawJson.link,
    date: rawJson.pubDate,
    content: rawJson.content
  };
}

function formatFeed(feedSource, feedItems) {
  if (feedSource === "medium") {
    return feedItems.map(formatMediumItem);
  } else {
    return feedItems.map(formatJekyllItem);
  }
}

function formatFeeds(feedResponses) {
  return feedResponses.map(response => {
    return {
      author: response.author,
      posts: formatFeed(response.source, response.feed.items)
    };
  });
}

module.exports = {
  formatMediumItem,
  formatJekyllItem,
  formatFeed,
  formatFeeds
};
