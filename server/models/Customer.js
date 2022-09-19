// Access built-in data types from Sequelize, and Model
const { Model, DataTypes } = require("sequelize");
const sequelize = require("../config/connection");

class Customer extends Model {};

Customer.init(
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true,
      autoIncrement: true,
    },
    user_name: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
    user_email: {
      type: DataTypes.STRING(30),
      allowNull: false,
      unique: true, // A user's email must be unique among all others
      validate: {
        isEmail: true // checks for email format (foo@bar.com) 
      }
    },
    user_password: {
      type: DataTypes.STRING(20),
      allowNull: false,
      validate: {
        len: [6]
      }
    },
    first_name: {
      type: DataTypes.STRING(20),
      allowNull: false,
      validate: {
        isAlpha: true
      }
    },
    last_name: {
      type: DataTypes.STRING(20),
      allowNull: false,
      validate: {
        isAlpha: true
      }
    },
    telephone: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
    date_registered: {
      type: DataTypes.STRING(20),
      allowNull: false,
    },
  },
  {
    // model options are placed in this object
    sequelize, // pass the connection instance we imported from the top
    timestamps: false,
    freezeTableName: true,
    underscored: true,
    modelName: "Customer",
  }
);

module.exports = Customer;
