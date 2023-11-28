const { Sequelize } = require('sequelize');
const config = require('./config/config.json')['test'];
async function listTables() {
  const sequelize = new Sequelize(config.database, config.username, config.password, {
    host: config.host,
    dialect: config.dialect,
  });

  try {
    await sequelize.authenticate();
    console.log('Connection to the test database has been established successfully.');

    const results = await sequelize.query("SELECT table_name FROM information_schema.tables WHERE table_schema='public';", { type: Sequelize.QueryTypes.SELECT });
    
    console.log('Query results:', results);


console.log('Tables in the test database:');
results.forEach(row => {
  console.log(row[0]); 
});

  } catch (error) {
    console.error('Unable to connect to the test database:', error);
  } finally {
    await sequelize.close();
  }
}

listTables();