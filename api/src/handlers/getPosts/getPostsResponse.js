const DATABASE_ERROR_MESSAGE = "Couldn't get posts from database.";
const CORS_HEADER = {'Access-Control-Allow-Origin': '*'};

module.exports = async function getPostsResponse(db) {
  try {
    const body = await db.getAuthorPosts();
    return {
      statusCode: 200,
      headers: CORS_HEADER,
      body: JSON.stringify(body),
    };
  } catch (err) {
    return {
      statusCode: 404,
      headers: CORS_HEADER,
      body: JSON.stringify({message: DATABASE_ERROR_MESSAGE}),
    };
  }
};
