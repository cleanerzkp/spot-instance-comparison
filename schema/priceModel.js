const { Sequelize, DataTypes } = require('sequelize');
const sequelize = new Sequelize('spot_instance_comparison', 'kacper', 'QWERTYUIOP', {
  host: '127.0.0.1',
  dialect: 'postgres'
});

const SpotInstancePrice = sequelize.define('SpotInstancePrice', {
  provider: {
    type: DataTypes.STRING,
    allowNull: false
  },
  instanceType: {
    type: DataTypes.STRING,
    allowNull: false
  },
  ram: {
    type: DataTypes.FLOAT,
    allowNull: false
  },
  cpu: {
    type: DataTypes.FLOAT,
    allowNull: false
  },
  pricePerHour: {
    type: DataTypes.FLOAT,
    allowNull: false
  },
  originalApiResponse: {
    type: DataTypes.JSONB,
    allowNull: false
  },
  transformedApiResponse: {
    type: DataTypes.JSONB,
    allowNull: false
  }
}, {
  tableName: 'spot_instance_prices',  // Explicitly specify table name to match your existing table
});

module.exports = SpotInstancePrice;  // Export the model for use in other files
