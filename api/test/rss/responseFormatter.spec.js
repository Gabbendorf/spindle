const {expect} = require('chai');
const responseFormatter = require('../../src/rss/responseFormatter.js');
const sampleMediumResponse = require('../testData/mediumResponse.js');
const sampleJekyllResponse = require('../testData/jekyllResponse.js');

describe('responseFormatter', () => {
  describe('formatFeeds', () => {
    it('formats feed into common post structure', () => {
      const feedResponses = [
        {source: 'medium', author: 'Gabi', feed: sampleMediumResponse},
        {source: 'medium', author: 'Andrew', feed: sampleMediumResponse},
        {source: 'jekyll', author: 'Laurent', feed: sampleJekyllResponse},
      ];

      const formattedFeeds = responseFormatter.convertFeedsToPosts(
        feedResponses,
      );

      expect(formattedFeeds.length).to.eq(9);
      expect(formattedFeeds).to.deep.equal([
        {
          author: 'Gabi',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Spreading the Word!',
        },
        {
          author: 'Gabi',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Setting up a project in MIX',
        },
        {
          author: 'Gabi',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Elixir Data Structures',
        },
        {
          author: 'Andrew',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Spreading the Word!',
        },
        {
          author: 'Andrew',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Setting up a project in MIX',
        },
        {
          author: 'Andrew',
          content: 'some blog post content',
          date: 'Mon, 09 Jul 2018 15:19:30 GMT',
          link:
            'https://medium.com/@gabriellamedas/spreading-the-word-79e270d6897d?source=rss-df01eaafb108------2',
          title: 'Elixir Data Structures',
        },
        {
          author: 'Laurent',
          content: 'some blog content',
          date: 'Wed, 13 Jun 2018 09:51:42 +0000',
          link: 'laurentcurau.com/whats-new-javascript',
          title: "What's new (for me) in Javascript",
        },
        {
          author: 'Laurent',
          content: 'some blog content',
          date: 'Wed, 13 Jun 2018 09:51:42 +0000',
          link: 'laurentcurau.com/whats-new-javascript',
          title: 'Testing multi-threaded asynchronous code in Java',
        },
        {
          author: 'Laurent',
          content: 'some blog content',
          date: 'Wed, 13 Jun 2018 09:51:42 +0000',
          link: 'laurentcurau.com/whats-new-javascript',
          title: 'Building trust, managing expectations and delivering value',
        },
      ]);
    });
  });
});
