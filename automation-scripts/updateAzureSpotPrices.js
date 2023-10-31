const db = require('../models');
const axios = require('axios');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AZR' } });
  const regions = await Region.findAll({ where: { providerID: 'AZR' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };
}

async function fetchAzurePrices(instanceType, region, nextPageUrl) {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const params = {
    '$filter': `armRegionName eq '${region}' and armSkuName eq 'Standard_${instanceType}'`,  // Adjusted the armSkuName value
    '$top': 100
  };

  try {
    let response;
    if (nextPageUrl) {
      response = await axios.get(nextPageUrl);
    } else {
      response = await axios.get(apiUrl, { params: params });
    }

    let prices = response.data.Items;
    if (response.data.NextPageLink) {
      prices = prices.concat(await fetchAzurePrices(instanceType, region, response.data.NextPageLink));
    }
    return prices;

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