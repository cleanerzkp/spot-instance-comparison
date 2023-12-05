const axios = require('axios');
const db = require('../models');

async function fetchData() {
  try {
    const instanceTypes = await db.InstanceType.findAll({ where: { providerID: 'AZR' } });
    const regions = await db.Region.findAll({ where: { providerID: 'AZR' } });

    return {
      instanceTypes: instanceTypes.map(it => ({ id: it.id, name: it.name, category: it.category, grouping: it.grouping })),
      regions: regions.map(r => r.name)
    };
  } catch (error) {
    console.error('Error fetching data from database:', error.message);
    return { instanceTypes: [], regions: [] };
  }
}

async function fetchAzurePrices(instanceType, region) {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const params = {
    'api-version': '2023-01-01-preview',
    '$filter': `armRegionName eq '${region}' and armSkuName eq 'Standard_${instanceType}'`,
    '$top': 1000
  };

  try {
    const response = await axios.get(apiUrl, { params });
    return response.data && response.data.Items ? response.data.Items : [];
  } catch (error) {
    console.error(`Error fetching prices for ${instanceType} in ${region}:`, error.message);
    return [];
  }
}

async function insertIntoDB(prices, instanceTypeObj, region) {
  const currentTime = new Date();

  for (const price of prices) {
    await db.SpotPricing.create({
      name: instanceTypeObj.name,
      regionName: region,
      price: parseFloat(price.retailPrice),
      date: currentTime,
      timestamp: currentTime,
      createdAt: currentTime,
      updatedAt: currentTime,
      grouping: instanceTypeObj.grouping,
      providerID: 'AZR'
    });
  }
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  if (instanceTypes.length === 0 || regions.length === 0) {
    console.error('No instance types or regions available to fetch prices for.');
    return;
  }

  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      const prices = await fetchAzurePrices(instanceTypeObj.name, region);
      if (prices.length > 0) {
        const lowestPrice = prices.reduce((min, p) => parseFloat(p.retailPrice) < parseFloat(min.retailPrice) ? p : min, prices[0]);
        await insertIntoDB([lowestPrice], instanceTypeObj, region);
      } else {
        console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
      }
    }
  }
}

main().catch(error => console.error('Error in main function:', error.message));async function runAzureScript() {
  await main();
}

module.exports = runAzureScript;