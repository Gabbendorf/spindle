const { expect } = require("chai");
const responseFormatter = require("../src/authors/responseFormatter.js");
const sampleMediumResponse = require("./testData/mediumResponse.js");
const sampleJekyllResponse = require("./testData/jekyllResponse.js");

describe("responseFormatter", () => {
  describe("formatMediumItem", () => {
    it("converts medium json into the correct format", () => {
      const expectedJson = {
        title: "blog post",
        link: "www.medium.com",
        date: "Mon, 09 Jul 2018 15:19:30 GMT",
        content: "blog post content"
      };

      const rawJson = {
        title: "blog post",
        link: "www.medium.com",
        pubDate: "Mon, 09 Jul 2018 15:19:30 GMT",
        "content:encoded": "blog post content"
      };

      const actualJson = responseFormatter.formatMediumItem(rawJson);
      expect(expectedJson).to.deep.equal(actualJson);
    });
  });

  describe("formatJekyllItem", () => {
    it("converts Jekyll json into the correct format", () => {
      const expectedJson = {
        title: "blog post",
        link: "www.jekyll.com",
        date: "Mon, 09 Jul 2018 15:19:30 GMT",
        content: "blog post content"
      };

      const rawJson = {
        title: "blog post",
        link: "www.jekyll.com",
        pubDate: "Mon, 09 Jul 2018 15:19:30 GMT",
        content: "blog post content"
      };

      const actualJson = responseFormatter.formatJekyllItem(rawJson);
      expect(expectedJson).to.deep.equal(actualJson);
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
    it("formats an array of feed responses with config, to correct api response format", () => {
      const feedResponses = [
        { source: "medium", author: "Gabi", feed: sampleMediumResponse },
        { source: "medium", author: "Andrew", feed: sampleMediumResponse },
        { source: "jekyll", author: "Laurent", feed: sampleJekyllResponse }
      ];

      const formattedFeeds = responseFormatter.formatFeeds(feedResponses);

      formattedFeeds.forEach((response, i) => {
        expect(response.author).to.eq(feedResponses[i].author);
        response.posts.forEach(post => {
          expect(post).to.have.keys("title", "link", "date", "content");
        });
      });
    });
  });
});
