'use strict';

const fs = require('fs');
const path = require('path');
const parse = require('csv-parse/lib/sync');

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const csvFilePath = path.join(__dirname, '../SpotPricings.csv');
    const csvData = fs.readFileSync(csvFilePath);
    const records = parse(csvData, {
      columns: true,
      skip_empty_lines: true
    });

    // Transform and map data if necessary
    const transformed = records.map(record => {
      return {
        name: record.name,
        regionCategory: record.regionCategory,
        date: new Date(record.date),
        price: parseFloat(record.price),
        timestamp: new Date(record.timestamp),
        createdAt: new Date(record.createdAt),
        updatedAt: new Date(record.updatedAt),
        providerID: record.providerID,
        grouping: record.grouping
      };
    });

    await queryInterface.bulkInsert('SpotPricings', transformed);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.bulkDelete('SpotPricings', null, {});
  }
};