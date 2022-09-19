// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Order_Details extends Model {}

Order_Details.init(
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
    payment_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Payment_Details",
        key: "id",
      },
    }
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Order_Details",
  }
);

module.exports = Order_Details;
