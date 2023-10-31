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
    '$filter': `armRegionName eq '${region}' and armSkuName eq 'Standard_${instanceType}'`,
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
    const priceValue = parseFloat(price.retailPrice);
    
    // Ignoring outlier prices
    if (priceValue > 10) {
      console.log(`Ignoring outlier price: ${priceValue} for ${instanceTypeObj.name} in ${region}`);
      continue;
    }

    const existingRecord = await SpotPricing.findOne({
      where: {
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        date: new Date(date),
        regionCategory: `AZR-${region}`
      }
    });

    if (existingRecord) {
      // Updating with new price value if it's different
      if (existingRecord.price !== priceValue) {
        await existingRecord.update({ price: priceValue });
      }
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
  const promises = [];

  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      promises.push((async () => {
        const prices = await fetchAzurePrices(instanceTypeObj.name, region);
        const filteredPrices = prices.filter(price => {
          const date = new Date(price.effectiveStartDate);
          return date >= new Date('2023-10-01T00:00:00Z') && date <= new Date('2023-10-31T23:59:59Z');
        });
        if (filteredPrices.length > 0) {
          await insertIntoDB(filteredPrices, instanceTypeObj, region);
        } else {
          console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
        }
      })());
    }
  }

  await Promise.all(promises);
}

main();