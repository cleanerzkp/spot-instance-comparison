require('dotenv').config({ path: '../.env' });
const db = require('../models');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;
const axios = require('axios');

async function fetchData() {
  try {
    const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AZR' } });
    const regions = await Region.findAll({ where: { providerID: 'AZR' } });
    return {
      instanceTypes: instanceTypes.map(it => ({ name: it.name, grouping: it.grouping })),
      regions: regions.map(r => r.name)
    };
  } catch (error) {
    console.error("Fetch Data Error:", error);
    throw error;
  }
}

async function insertIntoDB(standardizedData, instanceTypeObj, region) {
  try {
    for (const data of standardizedData) {
      const existingRecord = await SpotPricing.findOne({
        where: {
          name: instanceTypeObj.name,
          date: new Date(data.Timestamp),
          regionCategory: `AZR-${region}`
        }
      });

      const today = new Date().toISOString().split('T')[0];
      const date = new Date(data.Timestamp).toISOString().split('T')[0];
  
      if (existingRecord && date !== today) {
        console.log('Skipping existing record that is not from today.');
        continue;
      }
  
      const price = data.SpotPrice;
  
      if (existingRecord && date === today) {
        console.log('Updating existing record for today.');
        await existingRecord.update({ price: price });
      } else {
        console.log('Inserting new record.');
        await SpotPricing.create({
          name: instanceTypeObj.name,
          regionCategory: `AZR-${region}`,
          date: new Date(date),
          price: price,
          timestamp: new Date(),
          grouping: instanceTypeObj.grouping,
          providerID: 'AZR'
        });
      }
    }
  } catch (error) {
    console.error('Insert Into DB Error:', error);
  }
}

async function fetchAzureSpotPrices(instanceTypeObj, region) {
  try {
    const params = {
      "$filter": `serviceName eq 'Virtual Machines' and armSkuName eq '${instanceTypeObj.name}' and armRegionName eq '${region}'`,
      "$top": 100,
      "api-version": "2023-01-01-preview" 
    };

    const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

    if (response.status === 200) {
      let standardizedData = response.data.Items.map(item => ({
        SpotPrice: item.retailPrice,
        Timestamp: item.effectiveStartDate,
        AvailabilityZone: item.armRegionName,
        InstanceType: item.armSkuName,
        ProductDescription: item.serviceName
      }));

      await insertIntoDB(standardizedData, instanceTypeObj, region);
    } else {
      console.error(`Request returned non-OK status: ${response.status}`);
    }
  } catch (error) {
    console.error(`Fetch Azure Spot Prices Error: ${error.message}`);
  }
}

async function main() {
  try {
    const { instanceTypes, regions } = await fetchData();
    instanceTypes.forEach(instanceTypeObj => {
      regions.forEach(region => {
        fetchAzureSpotPrices(instanceTypeObj, region);
      });
    });
  } catch (error) {
    console.error('Main Function Error:', error);
  }
}

main();