// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Customer_Payment extends Model {};

Customer_Payment.init(
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    customer_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'Customer',
        key: 'id',
      }
    },
    customer_address: {
      type: DataTypes.STRING(50),
      allowNull: false,
    },
    payment_type: {
      type: DataTypes.ENUM('Credit card', 'Debit card', 'Stripe', 'Paypal'),
      allowNull: false,
      validate: {
        isIn: [['Credit card', 'Debit card', 'Stripe', 'Paypal']],
      }
    },
    merchant: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
    account: {
      type: DataTypes.INTEGER,
      allowNull: false,
      validate: {
        isCreditCard: true // check for valid credit card numbers
      }
    },
    expiry: {
      type: DataTypes.DATE,
      allowNull: false,
      validate: {
        isDate: true // only allow date strings
      }
    }
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Customer_Payment",
  }
);

module.exports = Customer_Payment;
