const { DataTypes } = require('sequelize');
const { sequelize } = require('./db');
const User = require('./userModel');

const LoginHistory = sequelize.define('LoginHistory', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true
  },
  loginTime: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW
  },
  ipAddress: {
    type: DataTypes.STRING,
    allowNull: true
  },
  deviceInfo: {
    type: DataTypes.STRING,
    allowNull: true
  },
  status: {
    type: DataTypes.ENUM('success', 'failed'),
    defaultValue: 'success'
  }
});

// Create association with proper foreign key naming
User.hasMany(LoginHistory, {
  foreignKey: {
    name: 'userId',
    allowNull: false
  }
});
LoginHistory.belongsTo(User, {
  foreignKey: {
    name: 'userId',
    allowNull: false
  }
});

module.exports = LoginHistory; 