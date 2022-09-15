const express = require("express");
const sequelize = require("./config/connection");

const app = express();
const PORT = process.env.PORT || 3001;

const apiRoutes = require("./routes/apiRoutes");
const htmlRoutes = require("./routes/htmlRoutes");

// necessary middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static("public"));

// Use apiRoutes
// app.use('/api', apiRoutes);
// app.use('/', htmlRoutes);

// sync all the models with the database
sequelize.sync({ force: true }).then(() => {
  app.listen(PORT, () => {
    console.log(`API server now listening on port ${PORT}!`);
    console.log("*****************************************");
  });
});
