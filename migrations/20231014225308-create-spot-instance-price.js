'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('SpotInstancePrices', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      provider_name: {
        type: Sequelize.STRING
      },
      instance_type: {
        type: Sequelize.STRING
      },
      region: {
        type: Sequelize.STRING
      },
      availability_zone: {
        type: Sequelize.STRING
      },
      operating_system: {
        type: Sequelize.STRING
      },
      ram: {
        type: Sequelize.STRING
      },
      cpu: {
        type: Sequelize.STRING
      },
      storage: {
        type: Sequelize.STRING
      },
      network: {
        type: Sequelize.STRING
      },
      price: {
        type: Sequelize.DECIMAL
      },
      timestamp: {
        type: Sequelize.DATE
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
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('SpotInstancePrices');
  }
};