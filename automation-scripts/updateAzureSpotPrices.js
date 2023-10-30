const db = require('../models');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;
const axios = require('axios');
const moment = require('moment');

async function fetchData() {
  try {
    const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AZR' } });
    const regions = await Region.findAll({ where: { providerID: 'AZR' } });
    console.log('Fetched data:', { instanceTypes, regions });  
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
    console.log('Azure API Response:', response.data);

    if (response.status === 200) {
      let standardizedData = response.data.Items.map(item => ({
        SpotPrice: item.retailPrice,
        Timestamp: item.effectiveStartDate,
        AvailabilityZone: item.armRegionName,
        InstanceType: item.armSkuName,
        ProductDescription: item.serviceName
      }));

      // Filter for only the prices from October 2023
      standardizedData = standardizedData.filter(item => {
        const date = moment(item.Timestamp);
        return date.isBetween('2023-10-01', '2023-10-31', undefined, '[]');
      });

      // Limit to 10 results
      standardizedData = standardizedData.slice(0, 10);

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
    console.log('Main function started');
    const { instanceTypes, regions } = await fetchData();
    console.log('Starting to fetch Azure spot prices');
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