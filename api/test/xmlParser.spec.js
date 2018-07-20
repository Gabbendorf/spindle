const { expect } = require("chai");
const xmlParser = require("../src/authors/xmlParser.js");
const sampleMediumResponse = require("./testData/mediumResponse.js");

describe("xmlParser", () => {
  describe("parseFeed", () => {
    it("parses an xml feed url into JSON", () => {
      const parserStub = {
        parseURL: () => Promise.resolve(sampleMediumResponse)
      };

      const feedConfig = {
        source: "medium",
        author: "Gabi",
        url: "https://medium.com/feed/@gabriellamedas"
      };

      xmlParser
        .parseFeed(parserStub, feedConfig)
        .then(response => {
          expect(response.source).to.eq("medium");
          expect(response.author).to.eq("Gabi");
          expect(response.feed).to.deep.equal(sampleMediumResponse);
        })
        .catch(err => expect.fail(err));
    });
  });

  describe("parseFeeds", () => {
    it("given an array of feed urls parses all into JSON", async () => {
      const parserStub = {
        parseURL: () => Promise.resolve(sampleMediumResponse)
      };

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
      expect(responses.length).to.eq(2);
      responses.forEach(response => {
        expect(response.feed).to.deep.equal(sampleMediumResponse);
      });
    });
  });
});
