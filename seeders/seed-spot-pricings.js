'use strict';
const fs = require('fs');
const path = require('path');
const csv = require('csv-parser');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const spotPricings = [];
    const filePath = path.join(__dirname, '../SpotPricings.csv');

    return new Promise((resolve, reject) => {
      fs.createReadStream(filePath)
        .pipe(csv({ separator: ';' }))
        .on('data', (data) => {
          
          const transformedData = {
            name: data.name,
            regionCategory: data.regionCategory,
            date: new Date(data.date),
            price: parseFloat(data.price),
            timestamp: new Date(data.timestamp),
            createdAt: new Date(data.createdAt),
            updatedAt: new Date(data.updatedAt),
            grouping: data.grouping,
            providerID: data.providerID
          };
          spotPricings.push(transformedData);
        })
        .on('end', () => {
          queryInterface.bulkInsert('SpotPricings', spotPricings, {})
            .then(resolve)
            .catch(reject);
        });
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('SpotPricings', null, {});
  }
};
