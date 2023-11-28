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
        .pipe(csv())
        .on('data', (row) => {
          spotPricings.push(row);
        })
        .on('end', () => {
          queryInterface.bulkInsert('SpotPricings', spotPricings)
            .then(resolve)
            .catch(reject);
        });
    });
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('SpotPricings', null, {});
  }
};