const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class CloudProvider extends Model {}

  CloudProvider.init({
    providerID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: DataTypes.STRING,
    API_endpoint: DataTypes.STRING,
    data_frequency: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'CloudProvider'
  });

  return CloudProvider;
};