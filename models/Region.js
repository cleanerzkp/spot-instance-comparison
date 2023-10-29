const { Model, DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  class Region extends Model {}

  Region.init({
    regionID: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    name: DataTypes.STRING,
    standardizedRegion: DataTypes.STRING,
    providerID: DataTypes.STRING,
    regionCategory: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Region',
    timestamps: false
  });

  return Region;
};
