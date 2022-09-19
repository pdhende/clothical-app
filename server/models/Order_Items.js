// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Order_Items extends Model {}

Order_Items.init(
  {
    // model attributes are defined here
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    order_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Order_Details",
        key: "id",
      },
    },
    product_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Product",
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
    modelName: "Order_Items",
  }
);

module.exports = Order_Items;
