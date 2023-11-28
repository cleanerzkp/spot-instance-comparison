'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('CloudProviders', {
      providerID: {
        type: Sequelize.STRING,
        primaryKey: true
      },
      name: Sequelize.STRING,
      API_endpoint: Sequelize.STRING,
      data_frequency: Sequelize.STRING,
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('CloudProviders');
  }
};
