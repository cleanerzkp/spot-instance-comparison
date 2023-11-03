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
    if (response.data && response.data.Items) {
      return response.data.Items;
    } else {
      console.log(`No price data found for ${instanceType} in ${region}`);
      return [];
    }
  } catch (error) {
    console.error(`Error fetching prices for ${instanceType} in ${region}:`, error.message);
    return [];
  }
}

async function insertIntoDB(avgPrices, instanceTypeObj, region) {
  const today = new Date();

  try {
    for (const [region, avgPrice] of Object.entries(avgPrices)) {
      await db.SpotPricing.create({
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        regionCategory: `AZR-${region}`,
        date: today,
        price: avgPrice,
        timestamp: today,
        createdAt: today,
        updatedAt: today,
        grouping: instanceTypeObj.grouping,
        providerID: 'AZR'
      });
    }
  } catch (error) {
    console.error('Error inserting data into database:', error.message);
  }
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  if (instanceTypes.length === 0 || regions.length === 0) {
    console.error('No instance types or regions available to fetch prices for.');
    return;
  }

  const promises = [];

  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      promises.push((async () => {
        const prices = await fetchAzurePrices(instanceTypeObj.name, region);
        if (prices.length > 0) {
          const avgPrices = prices.reduce((acc, price) => {
            const priceValue = parseFloat(price.retailPrice);
            if (!isNaN(priceValue) && priceValue <= 10) { // Assuming you want to filter out prices higher than 10
              acc[region] = (acc[region] || [0, 0]);
              acc[region][0] += priceValue;
              acc[region][1] += 1;
            }
            return acc;
          }, {});

          for (const region in avgPrices) {
            avgPrices[region] = avgPrices[region][0] / avgPrices[region][1];
          }

          await insertIntoDB(avgPrices, instanceTypeObj, region);
        } else {
          console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
        }
      })());
    }
  }

  await Promise.all(promises);
}

main().catch(error => console.error('Error in main function:', error.message));async function runAzureScript() {
  await main();
}

module.exports = runAzureScript;