'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const regions = [
        { name: 'us-east-1', standardizedRegion: 'us-east', providerID: 'ALB', regionCategory: 'ALB-us-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'us-east-1', standardizedRegion: 'us-east', providerID: 'AWS', regionCategory: 'AWS-us-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'eastus', standardizedRegion: 'us-east', providerID: 'AZR', regionCategory: 'AZR-us-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'northamerica-northeast1', standardizedRegion: 'us-east', providerID: 'GCP', regionCategory: 'GCP-us-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'us-west-1', standardizedRegion: 'us-west', providerID: 'ALB', regionCategory: 'ALB-us-west', createdAt: new Date(), updatedAt: new Date() },
        { name: 'us-west-1', standardizedRegion: 'us-west', providerID: 'AWS', regionCategory: 'AWS-us-west', createdAt: new Date(), updatedAt: new Date() },
        { name: 'westus', standardizedRegion: 'us-west', providerID: 'AZR', regionCategory: 'AZR-us-west', createdAt: new Date(), updatedAt: new Date() },
        { name: 'us-west1', standardizedRegion: 'us-west', providerID: 'GCP', regionCategory: 'GCP-us-west', createdAt: new Date(), updatedAt: new Date() },
        { name: 'eu-central-1', standardizedRegion: 'europe-central', providerID: 'ALB', regionCategory: 'ALB-europe-central', createdAt: new Date(), updatedAt: new Date() },
        { name: 'eu-central-1', standardizedRegion: 'europe-central', providerID: 'AWS', regionCategory: 'AWS-europe-central', createdAt: new Date(), updatedAt: new Date() },
        { name: 'polandcentral', standardizedRegion: 'europe-central', providerID: 'AZR', regionCategory: 'AZR-europe-central', createdAt: new Date(), updatedAt: new Date() },
        { name: 'europe-central1', standardizedRegion: 'europe-central', providerID: 'GCP', regionCategory: 'GCP-europe-central', createdAt: new Date(), updatedAt: new Date() },
        { name: 'me-central-1', standardizedRegion: 'near-east', providerID: 'ALB', regionCategory: 'ALB-near-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'me-south-1', standardizedRegion: 'near-east', providerID: 'AWS', regionCategory: 'AWS-near-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'israelcentral', standardizedRegion: 'near-east', providerID: 'AZR', regionCategory: 'AZR-near-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'middleeast-north1', standardizedRegion: 'near-east', providerID: 'GCP', regionCategory: 'GCP-near-east', createdAt: new Date(), updatedAt: new Date() },
        { name: 'ap-south-1', standardizedRegion: 'asia-india', providerID: 'ALB', regionCategory: 'ALB-asia', createdAt: new Date(), updatedAt: new Date() },
        { name: 'ap-south-1', standardizedRegion: 'asia-india', providerID: 'AWS', regionCategory: 'AWS-asia', createdAt: new Date(), updatedAt: new Date() },
        { name: 'southindia', standardizedRegion: 'asia-india', providerID: 'AZR', regionCategory: 'AZR-asia', createdAt: new Date(), updatedAt: new Date() },
        { name: 'asia-south1', standardizedRegion: 'asia-india', providerID: 'GCP', regionCategory: 'GCP-asia', createdAt: new Date(), updatedAt: new Date() }
      ];

    await queryInterface.bulkInsert('Regions', regions);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('Regions', null, {});
  }
};
