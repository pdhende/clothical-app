// Import and configure dotenv
require('dotenv').config();

// Main class and entry point to Sequelize
const Sequelize = require('sequelize');

// Call Sequelize constructor and instantiate new sequelize object
// with name of database, username, and password; the location of 
// the .env file  must be in the same parent folder as the execution
// of the server/index.js file
const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: 'localhost',
  dialect: 'mysql',
  port: 3306
});

// test if the Sequelize connection to database is OK
sequelize.authenticate()
  .then(() => console.log('Sequelize connection to database is successfully established.'))
  .catch(err => console.error('Sequelize connection to database failed:', err));

module.exports = sequelize;