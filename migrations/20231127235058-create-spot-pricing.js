'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('SpotPricings', {
      pricingID: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: Sequelize.STRING,
      regionCategory: Sequelize.STRING,
      date: Sequelize.DATE,
      price: Sequelize.DECIMAL(10, 4),
      timestamp: Sequelize.DATE,
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE,
      providerID: Sequelize.STRING,
      grouping: Sequelize.STRING
    });

    // If needed, create additional indices
    await queryInterface.addIndex('SpotPricings', ['name', 'regionCategory', 'date']);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('SpotPricings');
  }
};
