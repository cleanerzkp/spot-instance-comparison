'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('spot_instance_pricing', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      CloudProvider: {
        type: Sequelize.STRING
      },
      InstanceType: {
        type: Sequelize.STRING
      },
      Region: {
        type: Sequelize.STRING
      },
      PricePerHour_USD: {
        type: Sequelize.DECIMAL(10, 2)
      },
      EffectiveStartDate: {
        type: Sequelize.DATE
      },
      OriginalAPIResponse: {
        type: Sequelize.JSONB
      },
      AdditionalInfo: {
        type: Sequelize.JSONB
      },
      Location: {
        type: Sequelize.STRING
      },
      MeterName: {
        type: Sequelize.STRING
      },
      ProductName: {
        type: Sequelize.STRING
      },
      SkuName: {
        type: Sequelize.STRING
      },
      ServiceName: {
        type: Sequelize.STRING
      },
      ServiceFamily: {
        type: Sequelize.STRING
      },
      UnitOfMeasure: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  
  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('spot_instance_pricing');
  }
};