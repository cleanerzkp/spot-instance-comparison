const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class InstanceType extends Model {
    static associate(models) {
      this.belongsTo(models.CloudProvider, { foreignKey: 'providerID' });
    }
  }

  InstanceType.init({
    instanceID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    providerID: DataTypes.STRING,
    name: DataTypes.STRING,
    vCPU: DataTypes.INTEGER,
    RAM_GB: DataTypes.INTEGER,
    category: DataTypes.STRING,
    comparisonGroup: DataTypes.STRING,
    grouping: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'InstanceType'
  });

  return InstanceType;
};
