const db = require('../models');
const axios = require('axios');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;

if (!SpotPricing) {
    console.error('SpotPricing model is not defined');
    process.exit(1);
}

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AZR' } });
  const regions = await Region.findAll({ where: { providerID: 'AZR' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };
}

async function fetchAzurePrices(instanceType, region) {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const params = {
    '$filter': `armRegionName eq '${region}' and armSkuName eq '${instanceType}'`,
    '$top': 100
  };

  try {
    const response = await axios.get(apiUrl, { params: params });
    return response.data.Items;
  } catch (error) {
    console.error(`Error fetching prices for ${instanceType} in ${region}:`, error.message);
    return [];
  }
}

async function insertIntoDB(prices, instanceTypeObj, region) {
  for (const price of prices) {
    const date = new Date(price.effectiveStartDate).toISOString().split('T')[0];
    const existingRecord = await SpotPricing.findOne({
      where: {
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        date: new Date(date),
        regionCategory: `AZR-${region}`
      }
    });

    // Adjusted to handle retailPrice from the Azure API response
    const priceValue = parseFloat(price.retailPrice);

    if (existingRecord) {
      await existingRecord.update({ price: priceValue });
    } else {
      await SpotPricing.create({
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        regionCategory: `AZR-${region}`,
        date: new Date(date),
        price: priceValue,
        timestamp: new Date(),
        grouping: instanceTypeObj.grouping,
        providerID: 'AZR'
      });
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