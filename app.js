const express = require('express');
const db = require('./models');

const app = express();

app.use(express.json());

// Root route
app.get('/', (req, res) => {
  res.send('Welcome to the Spot Instance Price Comparison API');
});

// Retrieve all CloudProviders
app.get('/providers', async (req, res) => {
  try {
    const providers = await db.CloudProvider.findAll();
    res.json(providers);
  } catch (error) {
    console.error('Error fetching CloudProviders:', error);
    res.status(500).send('Error fetching CloudProviders');
  }
});

// Retrieve all InstanceTypes
app.get('/instance-types', async (req, res) => {
  try {
    const instanceTypes = await db.InstanceType.findAll();
    res.json(instanceTypes);
  } catch (error) {
    console.error('Error fetching InstanceTypes:', error);
    res.status(500).send('Error fetching InstanceTypes');
  }
});

// Retrieve all Regions
app.get('/regions', async (req, res) => {
  try {
    const regions = await db.Region.findAll();
    res.json(regions);
  } catch (error) {
    console.error('Error fetching Regions:', error);
    res.status(500).send('Error fetching Regions');
  }
});

// Retrieve all SpotPricings
app.get('/spot-pricings', async (req, res) => {
  try {
    const spotPricings = await db.SpotPricing.findAll();
    res.json(spotPricings);
  } catch (error) {
    console.error('Error fetching SpotPricings:', error);
    res.status(500).send('Error fetching SpotPricings');
  }
});

// Database synchronization and server start
db.sequelize.sync().then(() => {
  const port = 3000;
  app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
    console.log('Database synced');
  });
}).catch((error) => {
  console.error('Error syncing database', error);
});
