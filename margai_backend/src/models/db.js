const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASS,
  {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: 'mysql',
    logging: false,
    dialectOptions: { 
        useUTC: false,
        timezone: '+05:30' // for reading the data
    },
    timezone: '+05:30' 
  },
  
);

module.exports = { sequelize }; 