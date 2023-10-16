'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class SpotInstancePricing extends Model {
    static associate(models) {
      // define association here
    }
  }
  SpotInstancePricing.init({
    CloudProvider: DataTypes.STRING,
    InstanceType: DataTypes.STRING,
    Region: DataTypes.STRING,
    PricePerHour_USD: DataTypes.DECIMAL(10, 2),
    EffectiveStartDate: DataTypes.DATE,
    OriginalAPIResponse: DataTypes.JSONB,
    AdditionalInfo: DataTypes.JSONB,
    // other atriubutes?
    Location: DataTypes.STRING,
    MeterName: DataTypes.STRING,
    ProductName: DataTypes.STRING,
    SkuName: DataTypes.STRING,
    ServiceName: DataTypes.STRING,
    ServiceFamily: DataTypes.STRING,
    UnitOfMeasure: DataTypes.STRING,
    // ... 
  }, {
    sequelize,
    modelName: 'SpotInstancePricing',
    tableName: 'spot_instance_pricing',
  });
  return SpotInstancePricing
};