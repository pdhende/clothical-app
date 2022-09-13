const db = require('./config/connection');
// console.log('db is', db);

// Just testing connection to database and the ability
// to execute an SQL command here...
db.query(`SELECT * FROM customer`, function(err, results) {
    console.log('Results from database are', results);
})

const express = require('express');

const PORT = process.env.PORT || 3001;
const app = express();
const apiRoutes = require('./routes/apiRoutes');
const htmlRoutes = require('./routes/htmlRoutes');

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static('public'));

// Use apiRoutes
// app.use('/api', apiRoutes);
// app.use('/', htmlRoutes);

app.listen(PORT, () => {
  console.log(`API server now listening on port ${PORT}!`);
  console.log('*****************************************');
});