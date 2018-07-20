const { expect } = require("chai");
const xmlParser = require("../src/authors/xmlParser.js");
const sampleMediumResponse = require("./testData/mediumResponse.js");

const parserStub = {
  parseURL: () => Promise.resolve(sampleMediumResponse)
};

describe("xmlParser", () => {
  describe("parseFeed", () => {
    it("parses an xml feed url into JSON", async () => {
      const feedConfig = {
        source: "medium",
        author: "Gabi",
        url: "https://medium.com/feed/@gabriellamedas"
      };

      const response = await xmlParser.parseFeed(parserStub, feedConfig)

      expect(response.source).to.eq("medium");
      expect(response.author).to.eq("Gabi");
      expect(response.feed).to.deep.equal(sampleMediumResponse);
    });
  });

  describe("parseFeeds", () => {
    it("given an array of feed urls parses all into JSON", async () => {
      const feedConfigs = [
        {
          source: "medium",
          author: "Gabi",
          url: "https://medium.com/feed/@gabriellamedas"
        },
        {
          source: "jekyll",
          author: "Laurent",
          url: "https://laurentcurau.com/feed.xml"
        }
      ];

      const responses = await xmlParser.parseFeeds(parserStub, feedConfigs);

      responses.forEach(response => {
        expect(response.feed).to.deep.equal(sampleMediumResponse);
      });
    });
  });
});
