'use strict';
const fs = require('fs');
const path = require('path');

module.exports = {
  async up(queryInterface, Sequelize) {
    try {
      const sql = fs.readFileSync(path.join(__dirname, '../work.sql'), 'utf8');
      const queries = sql.split(/;\s*\n/); // Adjusted for new line after semicolon

      for (const query of queries) {
        if (query.trim().length > 0) {
          console.log('Executing query:', query.substring(0, 100)); // Log first 100 characters of query
          await queryInterface.sequelize.query(query).catch(err => {
            console.error('Error executing query:', query, err);
            throw err; // Stop further execution on error
          });
        }
      }
    } catch (error) {
      console.error('Migration failed:', error);
      throw error; // Propagate error for visibility
    }
  },

  async down(queryInterface, Sequelize) {
    // Logic for reverting the changes, if needed
  }
};