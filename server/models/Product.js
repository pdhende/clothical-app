// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Product extends Model {}

Product.init(
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
      type: DataTypes.STRING(200),
      allowNull: false,
    },
    cart_description: {
      type: DataTypes.STRING(100),
      allowNull: false,
    },
    sku: {
      type: DataTypes.UUID,
      defaultValue: DataTypes.UUIDV4,
      allowNull: false,
    },
    price: {
      type: DataTypes.DECIMAL(7, 2),
      allowNull: false,
    },
    category_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Product_Category",
        key: "id",
      },
    },
    inventory_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Product_Inventory",
        key: "id",
      },
    },
    discount_id: {
      type: DataTypes.INTEGER,
      references: {
        model: "Product_Discount",
        key: "id",
      },
    },
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Product",
  }
);

module.exports = Product;
