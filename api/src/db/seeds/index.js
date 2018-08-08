const connectionConfig = require('../connectionConfig.js');
const {Client} = require('pg');
const {addTables} = require('../schema.js');
const {deleteExistingAuthorsQuery, addAuthorsQuery} = require('./authors.js');

const client = new Client(connectionConfig);

async function runSeeds() {
  try {
    await client.connect();
    await client.query(addTables);
    await client.query(deleteExistingAuthorsQuery);
    await client.query(addAuthorsQuery);
    await client.end();
    console.log('seeded database');
  } catch (err) {
    console.log(err);
    await client.end();
  }
}

runSeeds();
