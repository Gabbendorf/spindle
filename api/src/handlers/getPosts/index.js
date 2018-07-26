const Db = require('../../db/db.js');
const connectionConfig = require('../../db/connectionConfig.js');
const getPostsResponse = require('./getPostsResponse.js');

module.exports.handler = (event, context, callback) => {
  const db = new Db(connectionConfig);
  getPostsResponse(db).then(response => {
    if (response.statusCode === 200) {
      callback(null, response);
    } else {
      callback(response, null);
    }
  });
};
