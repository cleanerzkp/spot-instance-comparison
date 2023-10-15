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
    EquivalentStandardSKU: DataTypes.STRING,
    RAM_GB: DataTypes.INTEGER,
    CPU_Cores: DataTypes.INTEGER,
    NetworkPerformance: DataTypes.STRING,
    DiskIO: DataTypes.STRING,
    GPU: DataTypes.STRING,
    PricePerHour_USD: DataTypes.DECIMAL(10, 2),
    Region: DataTypes.STRING,
    Timestamp: DataTypes.DATE,
    OriginalAPIResponse: DataTypes.JSONB,
    TransformedAPIResponse: DataTypes.JSONB,
    AdditionalInfo: DataTypes.JSONB
  }, {
    sequelize,
    modelName: 'SpotInstancePricing',
    tableName: 'spot_instance_pricing',
  });
  return SpotInstancePricing;
};