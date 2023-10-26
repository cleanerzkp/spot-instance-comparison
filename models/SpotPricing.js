const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class SpotPricing extends Model {}

  SpotPricing.init({
    pricingID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: DataTypes.STRING,
    regionCategory: DataTypes.STRING,
    date: DataTypes.DATE,
    price: DataTypes.DECIMAL(10, 4),
    timestamp: DataTypes.DATE,
    createdAt: DataTypes.DATE,
    updatedAt: DataTypes.DATE,
    grouping: DataTypes.STRING,
    providerID: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'SpotPricing'
  });

  return SpotPricing;
};
