const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class CloudProvider extends Model {}

  CloudProvider.init({
    providerID: {
      type: DataTypes.STRING,
      primaryKey: true
    },
    name: DataTypes.STRING,
    API_endpoint: DataTypes.STRING,
    data_frequency: DataTypes.STRING,
    createdAt: DataTypes.DATE,
    updatedAt: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'CloudProvider'
  });

  return CloudProvider;
};
