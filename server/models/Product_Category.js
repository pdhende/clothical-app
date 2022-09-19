// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Product_Category extends Model {}

Product_Category.init(
  {
    // model attributes are defined here
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    name: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
    description: {
      type: DataTypes.STRING(100),
      allowNull: false,
    }
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Product_Category",
  }
);

module.exports = Product_Category;
