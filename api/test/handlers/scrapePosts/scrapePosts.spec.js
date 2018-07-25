const {expect} = require('chai');
const scrapePosts = require('../../../src/handlers/scrapePosts/scrapePosts.js');

describe('scrapePosts', () => {
  let dbSpy;
  let feedManagerSpy;
  let authorsStub;
  let feedsStub;
  let postsStub;

  beforeEach(() => {
    authorsStub = {};
    feedsStub = {};
    postsStub = {};

    dbSpy = {
      getAuthorsCalled: false,
      getAuthors: function() {
        this.getAuthorsCalled = true;
        return Promise.resolve(authorsStub);
      },
      addPostsCalledWith: undefined,
      addPosts: function(arg) {
        this.addPostsCalledWith = arg;
      },
    };

    feedManagerSpy = {
      parseFeedsCalledWith: undefined,
      convertFeedsToPostsCalledWith: undefined,
      parseFeeds: function(arg) {
        this.parseFeedsCalledWith = arg;
        return Promise.resolve(feedsStub);
      },
      convertFeedsToPosts: function(arg) {
        this.convertFeedsToPostsCalledWith = arg;
        return Promise.resolve(postsStub);
      },
    };
  });

  it('gets authors via the db', async () => {
    await scrapePosts(dbSpy, feedManagerSpy);

    expect(dbSpy.getAuthorsCalled).to.be.true;
  });

  it('parses the feeds via the feed manager', async () => {
    await scrapePosts(dbSpy, feedManagerSpy);

    expect(feedManagerSpy.parseFeedsCalledWith).to.eq(authorsStub);
  });

  it('converts the feeds to posts via the feedManager', async () => {
    await scrapePosts(dbSpy, feedManagerSpy);

    expect(feedManagerSpy.convertFeedsToPostsCalledWith).to.eq(
      feedsStub,
    );
  });

  it('adds posts via the db', async () => {
    await scrapePosts(dbSpy, feedManagerSpy);

    expect(dbSpy.addPostsCalledWith).to.eq(postsStub)
  })
});
