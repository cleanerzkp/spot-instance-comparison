'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const cloudProviders = [
      { providerID: 'ALB', name: 'Alibaba', API_endpoint: 'https://ecs.aliyuncs.com', data_frequency: '1hour', createdAt: new Date('2023-10-22 12:51:33.996807+02'), updatedAt: new Date('2023-10-22 12:51:33.996807+02') },
      { providerID: 'AWS', name: 'AWS', API_endpoint: 'https://ec2.amazonaws.com', data_frequency: '24hrs', createdAt: new Date('2023-10-22 12:51:33.996807+02'), updatedAt: new Date('2023-10-22 12:51:33.996807+02') },
      { providerID: 'AZR', name: 'Azure', API_endpoint: 'https://management.azure.com', data_frequency: 'few hours', createdAt: new Date('2023-10-22 12:51:33.996807+02'), updatedAt: new Date('2023-10-22 12:51:33.996807+02') },
      { providerID: 'GCP', name: 'Google Cloud Platform', API_endpoint: 'https://compute.googleapis.com', data_frequency: 'few hours', createdAt: new Date('2023-10-22 12:51:33.996807+02'), updatedAt: new Date('2023-10-22 12:51:33.996807+02') }
    ];

    await queryInterface.bulkInsert('CloudProviders', cloudProviders);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('CloudProviders', null, {});
  }
};
