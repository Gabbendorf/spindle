const {expect} = require('chai');
const getPostsResponse = require('../../../src/handlers/getPosts/getPostsResponse.js');

describe('getPostsResponse', () => {
  it('if successful, responds with a 200, cors header and stringified body', async () => {
    const dbStub = {
      getAuthorPosts: () => {
        return Promise.resolve(dbResponse());
      },
    };

    const response = await getPostsResponse(dbStub);

    expect(response).to.deep.equal({
      statusCode: 200,
      headers: {'Access-Control-Allow-Origin': '*'},
      body: JSON.stringify(dbResponse()),
    });
  });

  it('if database errors, responds with a 404, cors headers and error message', async () => {
    const erroringDbStub = {
      getAuthorPosts: () => {
        throw Error('SQL error')
      },
    }

    const response = await getPostsResponse(erroringDbStub);

    expect(response).to.deep.equal({
      statusCode: 404,
      headers: {'Access-Control-Allow-Origin': '*'},
      body: JSON.stringify({message: 'Couldn\'t get posts from database.'}),
    });
  });

  function dbResponse() {
    return [
      {
        author: 'gabi',
        posts: [
          {
            title: 'Spreading the word',
            content: 'some content',
            date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
            link: 'gabis_posts.com',
          },
        ],
      },
      {
        author: 'andrew',
        posts: [
          {
            title: 'Earth to Mercury',
            content: 'some content',
            date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
            link: 'andrews_posts.com',
          },
          {
            title: 'Gradle stuff',
            content: 'some content',
            date: 'Fri Jun 29 2018 00:00:00 GMT+0100 (BST)',
            link: 'andrews_posts.com',
          },
        ],
      },
    ];
  }
});
