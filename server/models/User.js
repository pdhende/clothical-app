module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('user', {
    customerId: {
      type: DataTypes.INTEGER,
      primarykey : true,
      unique: true
    },
    userName: DataTypes.STRING,
    email: {
      type: DataTypes.STRING,
      unique: true,
      required: true,
      allowNull: false
    },
    password: DataTypes.STRING,
    firstName: {
      type: DataTypes.STRING,
      allowNull: false
     },
     lastName: {
      type: DataTypes.STRING,
      allowNull: false
     },
    telephone: DataTypes.INTEGER,
    dateRegistered: DataTypes.DATE,
  });
  return User;
};
