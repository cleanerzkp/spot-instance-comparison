const axios = require('axios');
const db = require('../models');
const Pricing = db.Pricing;
const InstanceType = db.InstanceType;
const Region = db.Region;

async function fetchData() {
  // Fetching instance and region data from your database
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AZR' } });
  const regions = await Region.findAll({ where: { providerID: 'AZR' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };  
}

async function fetchAzurePrices(instanceType, region) {
  // Define the API endpoint and query parameters
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const params = {
    '$filter': `armRegionName eq '${region}' and (armSkuName eq 'Standard_${instanceType}' or armSkuName eq '${instanceType}')`,
    '$top': 100
  };

  try {
    // Sending the API request
    const response = await axios.get(apiUrl, { params: params });
    return response.data.Items;
  } catch (error) {
    console.error(`Error fetching prices for ${instanceType} in ${region}:`, error.message);
    return [];
  }
}


async function insertIntoDB(prices, instanceTypeObj, region) {
    for (const price of prices) {
      try {
        // Formatting date to match your database setup
        const date = new Date(price.effectiveStartDate).toISOString().split('T')[0];
  
        // Checking if a record already exists for the given date
        const existingRecord = await Pricing.findOne({
          where: {
            name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
            date: new Date(date),
            regionCategory: `AZR-${region}`
          }
        });
  
        const priceValue = parseFloat(price.retailPrice);
  
        if (existingRecord) {
          // Updating the existing record if it exists
          await existingRecord.update({ price: priceValue });
        } else {
          // Creating a new record if it doesn't exist
          await Pricing.create({
            name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
            regionCategory: `AZR-${region}`,
            date: new Date(date),
            price: priceValue,
            timestamp: new Date(),
            grouping: instanceTypeObj.grouping,
            providerID: 'AZR'
          });
        }
      } catch (error) {
        console.error('Error inserting into DB:', error.message);
      }
    }
  }
  

async function main() {
  const { instanceTypes, regions } = await fetchData();
  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      const prices = await fetchAzurePrices(instanceTypeObj.name, region);
      if (prices.length > 0) {
        await insertIntoDB(prices, instanceTypeObj, region);
      } else {
        console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
      }
    }
  }
}

main();