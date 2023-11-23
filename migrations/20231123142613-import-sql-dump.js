'use strict';
const fs = require('fs');
const path = require('path');

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      // Read SQL file
      const sql = fs.readFileSync(path.join(__dirname, '../work.sql'), 'utf8');

      // Split SQL commands
      const queries = sql.split(/;\s*$/m);

      for (const query of queries) {
        if (query.length > 1) {
          console.log('Executing query:', query);
          await queryInterface.sequelize.query(query);
        }
      }
    } catch (error) {
      console.error('Migration failed:', error);
    }
  },

  async down(queryInterface, Sequelize) {
    // Logic for reverting the changes (if applicable)
  }
};