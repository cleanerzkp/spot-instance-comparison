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
      grouping: Sequelize.STRING
    });

    const instanceTypes = [
      { providerID: 'ALB', name: 'ecs.g5.xlarge', vCPU: 4, RAM_GB: 16, category: 'general-purpose', comparisonGroup: 'ALB-ecs.g6a.xlarge-general-purpose-GP1', grouping: 'GP1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'ALB', name: 'ecs.c6.xlarge', vCPU: 4, RAM_GB: 8, category: 'compute-optimized', comparisonGroup: 'ALB-ecs.c6a.xlarge-compute-optimized-CO1', grouping: 'CO1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'AWS', name: 't4g.xlarge', vCPU: 4, RAM_GB: 16, category: 'general-purpose', comparisonGroup: 'AWS-t4g.xlarge-general-purpose-GP1', grouping: 'GP1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'AWS', name: 'c6a.xlarge', vCPU: 4, RAM_GB: 8, category: 'compute-optimized', comparisonGroup: 'AWS-c6a.xlarge-compute-optimized-CO1', grouping: 'CO1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'AZR', name: 'B4ms', vCPU: 4, RAM_GB: 16, category: 'general-purpose', comparisonGroup: 'AZR-B4ms-general-purpose-GP1', grouping: 'GP1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'AZR', name: 'D4s_v3', vCPU: 4, RAM_GB: 8, category: 'compute-optimized', comparisonGroup: 'AZR-F4s v2-compute-optimized-CO1', grouping: 'CO1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'GCP', name: 'e2-standard-4', vCPU: 4, RAM_GB: 16, category: 'general-purpose', comparisonGroup: 'GCP-e2-standard-4-general-purpose-GP1', grouping: 'GP1', createdAt: new Date(), updatedAt: new Date() },
      { providerID: 'GCP', name: 'c2-standard-4', vCPU: 4, RAM_GB: 16, category: 'compute-optimized', comparisonGroup: 'GCP-c2-standard-4-compute-optimized-CO1', grouping: 'CO1', createdAt: new Date(), updatedAt: new Date() }
    ];

    await queryInterface.bulkInsert('InstanceTypes', instanceTypes);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable('InstanceTypes');
  }
};
