function mediumJsonToPost(rawJson, author) {
  return {
    title: rawJson.title,
    link: rawJson.link,
    date: rawJson.pubDate,
    content: rawJson['content:encoded'],
    author,
  };
}

function jekyllJsonToPost(rawJson, author) {
  return {
    title: rawJson.title,
    link: rawJson.link,
    date: rawJson.pubDate,
    content: rawJson.content,
    author,
  };
}

function convertFeedToPosts(feedSource, feedItems, author) {
  if (feedSource === 'medium') {
    return feedItems.map(feedJson => mediumJsonToPost(feedJson, author));
  } else {
    return feedItems.map(feedJson => jekyllJsonToPost(feedJson, author));
  }
}

module.exports = function convertFeedsToPosts(feedResponses) {
  return feedResponses.reduce((acc, response) => {
    const posts = convertFeedToPosts(response.source, response.feed.items, response.author);
    return acc.concat(posts);
  }, []);
}

