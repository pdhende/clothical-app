// Import and configure dotenv
require('dotenv').config();
// Import and require mysql2
const mysql = require('mysql2');
// Connect to database; the location of the .env file
// must be in the same parent folder as the execution
// of the server/index.js file
const db = mysql.createConnection(
  {
    host: 'localhost',
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
  },
  console.log(`Connected to the ${process.env.DB_NAME} database.
*************************************************`)
);

module.exports = db;