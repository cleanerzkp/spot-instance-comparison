'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class SpotInstancePrice extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  SpotInstancePrice.init({
    provider_name: DataTypes.STRING,
    instance_type: DataTypes.STRING,
    region: DataTypes.STRING,
    availability_zone: DataTypes.STRING,
    operating_system: DataTypes.STRING,
    ram: DataTypes.STRING,
    cpu: DataTypes.STRING,
    storage: DataTypes.STRING,
    network: DataTypes.STRING,
    price: DataTypes.DECIMAL,
    timestamp: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'SpotInstancePrice',
  });
  return SpotInstancePrice;
};