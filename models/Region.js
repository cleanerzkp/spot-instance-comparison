const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class Region extends Model {}

  Region.init({
    regionID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Region'
  });

  return Region;
};
