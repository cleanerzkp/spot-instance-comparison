const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class SpotPricing extends Model {}

  SpotPricing.init({
    pricingID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    instanceID: DataTypes.INTEGER,
    regionID: DataTypes.INTEGER,
    date: DataTypes.DATE,
    price: DataTypes.DECIMAL(10, 4),
    timestamp: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'SpotPricing'
  });

  return SpotPricing;
};
