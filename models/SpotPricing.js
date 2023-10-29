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
    providerID: DataTypes.STRING,
    grouping: DataTypes.STRING,
  }, {
    sequelize,
    modelName: 'SpotPricing',
    uniqueKeys: {
      unique_tag: {
        customIndex: true,
        fields: ['name', 'regionCategory', 'date']
      }
    }
  });

  return SpotPricing;
};