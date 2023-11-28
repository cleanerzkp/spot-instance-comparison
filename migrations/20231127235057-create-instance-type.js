'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('InstanceTypes', {
      instanceID: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      providerID: {
        type: Sequelize.STRING,
        references: {
          model: 'CloudProviders',
          key: 'providerID'
        }
      },
      name: Sequelize.STRING,
      vCPU: Sequelize.INTEGER,
      RAM_GB: Sequelize.INTEGER,
      category: Sequelize.STRING,
      comparisonGroup: Sequelize.STRING,
      grouping: Sequelize.STRING,
      createdAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      }
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('InstanceTypes');
  }
};
