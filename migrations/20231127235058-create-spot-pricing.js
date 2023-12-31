module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('SpotPricings', {
      pricingID: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },
      name: Sequelize.STRING,
      regionName: Sequelize.STRING,
      date: Sequelize.DATE,
      price: Sequelize.DECIMAL(10, 4),
      timestamp: Sequelize.DATE,
      createdAt: Sequelize.DATE,
      updatedAt: Sequelize.DATE,
      providerID: Sequelize.STRING,
      grouping: Sequelize.STRING
    });

    await queryInterface.addIndex('SpotPricings', ['name', 'regionName', 'date']);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('SpotPricings');
  }
};
