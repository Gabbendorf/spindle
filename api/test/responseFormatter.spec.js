const { expect } = require("chai");
const responseFormatter = require("../src/authors/responseFormatter.js");
const sampleMediumResponse = require("./testData/mediumResponse.js");
const sampleJekyllResponse = require("./testData/jekyllResponse.js");

const formattedMediumPost = {
  title: "blog post",
  link: "www.medium.com",
  date: "Mon, 09 Jul 2018 15:19:30 GMT",
  content: "blog post content"
};

const unformattedMediumPost = {
  title: "blog post",
  link: "www.medium.com",
  pubDate: "Mon, 09 Jul 2018 15:19:30 GMT",
  "content:encoded": "blog post content"
};

const formattedJekyllPost = {
  title: "blog post",
  link: "www.jekyll.com",
  date: "Mon, 09 Jul 2018 15:19:30 GMT",
  content: "blog post content"
};

const unformattedJekyllPost = {
  title: "blog post",
  link: "www.jekyll.com",
  pubDate: "Mon, 09 Jul 2018 15:19:30 GMT",
  content: "blog post content"
};

describe("responseFormatter", () => {
  describe("formatMediumItem", () => {
    it("converts medium json into the correct format", () => {
      const actualJson = responseFormatter.formatMediumItem(unformattedMediumPost);
      
      expect(actualJson).to.deep.equal(formattedMediumPost);
    });
  });

  describe("formatJekyllItem", () => {
    it("converts Jekyll json into the correct format", () => {
      const actualJson = responseFormatter.formatJekyllItem(unformattedJekyllPost);
      
      expect(actualJson).to.deep.equal(formattedJekyllPost);
    });
  });

  describe("formatFeed", () => {
    it("given medium, converts feed items using the medium formatter", () => {
      const sampleFeedItems = sampleMediumResponse.items;
      const actualFeed = responseFormatter.formatFeed(
        "medium",
        sampleFeedItems
      );

      actualFeed.forEach((feedItem, i) => {
        const expectedFeedItem = responseFormatter.formatMediumItem(
          sampleFeedItems[i]
        );
        expect(feedItem).to.deep.equal(expectedFeedItem);
      });
    });

    it("given jekyll, converts feed items using the jekyll formatter", () => {
      const sampleFeedItems = sampleJekyllResponse.items;
      const actualFeed = responseFormatter.formatFeed(
        "jekyll",
        sampleFeedItems
      );

      actualFeed.forEach((feedItem, i) => {
        const expectedFeedItem = responseFormatter.formatJekyllItem(
          sampleFeedItems[i]
        );
        expect(feedItem).to.deep.equal(expectedFeedItem);
      });
    });
  });

  describe("formatFeeds", () => {
    it("formatted feeds keep original author of feed responses", () => {
      const feedResponses = [
        { source: "medium", author: "Gabi", feed: sampleMediumResponse },
        { source: "medium", author: "Andrew", feed: sampleMediumResponse },
        { source: "jekyll", author: "Laurent", feed: sampleJekyllResponse }
      ];

      const formattedFeeds = responseFormatter.formatFeeds(feedResponses);

      formattedFeeds.forEach((response, i) => {
        expect(response.author).to.eq(feedResponses[i].author);
      });
    });

    it("all posts from different sources should have the same keys", () => {
      const feedResponses = [
        { source: "medium", author: "Gabi", feed: sampleMediumResponse },
        { source: "medium", author: "Andrew", feed: sampleMediumResponse },
        { source: "jekyll", author: "Laurent", feed: sampleJekyllResponse }
      ];

      const formattedFeeds = responseFormatter.formatFeeds(feedResponses);

      formattedFeeds.forEach(({ posts }) => {
        posts.forEach(post => {
          expect(post).to.have.keys("title", "link", "date", "content");
        });
      });
    });
  });
});
