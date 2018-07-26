const Db = require('../../db/db.js');
const connectionConfig = require('../../db/connectionConfig.js');
const getPostsResponse = require('./getPostsResponse.js');

module.exports.handler = async (event, context, callback) => {
  const db = new Db(connectionConfig);
  const postsResponse = await getPostsResponse(db);
  if (postsResponse.statusCode === 200) {
    callback(null, postsResponse);
  } else {
    callback(postsResponse, null);
  }
};
