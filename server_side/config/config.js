const promise = require('bluebird');
const options = {
  promiseLib: promise,
  query: (e) => {},
};

const pgp = require('pg-promise')(options);
const types = pgp.pg.types;
types.setTypeParser(1114, function (stringValue) {
  return stringValue;
});

const databaseConfig = {
  host: 'localhost',
  port: 5432,
  database: 'postgres',
  user: 'yuuki',
  password: 'yunikuro',
};

const db = pgp(databaseConfig);

module.exports = db;
