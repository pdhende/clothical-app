// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Shopping_Session extends Model {}

Shopping_Session.init(
  {
    // model attributes are defined here
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    customer_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Customer",
        key: "id",
      },
    },
    total: {
      type: DataTypes.DECIMAL(7,2),
      allowNull: false
    }
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Shopping_Session",
  }
);

module.exports = Shopping_Session;
