const { DataTypes } = require('sequelize');
const { sequelize } = require('./db');
const User = require('./userModel');

const OTP = sequelize.define('OTP', {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true
  },
  otp: {
    type: DataTypes.STRING,
    allowNull: false
  },
  purpose: {
    type: DataTypes.ENUM('password_reset', 'email_verification'),
    allowNull: false
  },
  expiresAt: {
    type: DataTypes.DATE,
    allowNull: false
  },
  isUsed: {
    type: DataTypes.BOOLEAN,
    defaultValue: false
  }
});

// Create association with proper foreign key naming
User.hasMany(OTP, {
  foreignKey: {
    name: 'userId',
    allowNull: false
  }
});
OTP.belongsTo(User, {
  foreignKey: {
    name: 'userId',
    allowNull: false
  }
});

module.exports = OTP; 