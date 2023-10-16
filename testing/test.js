const db = require('../models/index');
const SpotInstancePricing = db.SpotInstancePricing;
const axios = require('axios');

async function main() {
  // Step 1: Test Database Connection
  try {
    await db.sequelize.authenticate();
    console.log('Connection has been established successfully.');
  } catch (error) {
    console.error('Unable to connect to the database:', error);
    return;
  }

  // Step 2: Fetch Data from API
  let response;
  try {
    const params = {
      "$filter": "serviceName eq 'Virtual Machines' and contains(meterName, 'Spot')",
      "$top": 2,
      "api-version": "2023-01-01-preview"
    };
    console.log('Fetching data from API...');
    response = await axios.get('https://prices.azure.com/api/retail/prices', { params });
    console.log('API response received successfully.');
    console.log(`Number of items fetched: ${response.data.Items.length}`);
  } catch (error) {
    console.error('API request failed:', error);
    return;
  }

  // Step 3: Insert Data into Database
try {
    console.log('Inserting data into database...');
    for (const item of response.data.Items) {
      const createdRecord = await SpotInstancePricing.create({
        CloudProvider: 'Azure',
        InstanceType: item.armSkuName,
        Region: item.armRegionName,
        PricePerHour_USD: item.retailPrice,
        EffectiveStartDate: item.effectiveStartDate,
        OriginalAPIResponse: JSON.stringify(item),
        Location: item.location,
        MeterName: item.meterName,
        ProductName: item.productName,
        SkuName: item.skuName,
        ServiceName: item.serviceName,
        ServiceFamily: item.serviceFamily,
        UnitOfMeasure: item.unitOfMeasure,
      }).catch(error => console.error(`Database operation failed: ${error}`));
  
      console.log('Created record:', createdRecord.dataValues);
    }
    console.log('Data insertion completed successfully.');
  } catch (error) {
    console.error('Data insertion failed:', error);
  }
  

  // Step 4: Check Data in Database
  try {
    console.log('Checking data in database...');
    const data = await SpotInstancePricing.findAll();
    console.log(`Number of records in database: ${data.length}`);
  } catch (error) {
    console.error('Data fetch from database failed:', error);
  }
}

main();