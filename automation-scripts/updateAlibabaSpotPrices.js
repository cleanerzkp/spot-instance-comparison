require('dotenv').config({ path: '../.env' });
const { RPCClient } = require('@alicloud/pop-core');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const formatDate = date => date.toISOString().split('.')[0] + 'Z';

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'ALB' } });
  const regions = await Region.findAll({ where: { providerID: 'ALB' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };
}

async function fetchAlibabaSpotPrices(instanceType, region) {
    const regionData = await Region.findOne({ where: { providerID: 'ALB', name: region } });
    if (!regionData) {
      console.error(`No region data found for ${region}`);
      return [];
    }
    const endpoint = `https://ecs.${regionData.name}.aliyuncs.com`;
    const client = new RPCClient({
        accessKeyId: process.env.ALIBABA_ACCESS_KEY_ID,
        accessKeySecret: process.env.ALIBABA_ACCESS_KEY_SECRET,
        endpoint: endpoint,
        apiVersion: '2014-05-26',
        opts: { timeout: 10000 }
    });
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    try {
      const params = {
        RegionId: regionData.name,
        NetworkType: 'vpc',
        InstanceType: instanceType.name,
        StartTime: formatDate(thirtyDaysAgo),
        EndTime: formatDate(new Date()),
        MaxResults: 500,
      };
      const result = await client.request('DescribeSpotPriceHistory', params);
      return result.SpotPrices.SpotPriceType || [];
    } catch (error) {
      console.error(`Error fetching Alibaba Spot Prices for ${region} ${instanceType.name}:`, error.message);
      return [];
    }
}

async function insertIntoDB(dailyAverages, instanceTypeObj, region) {
    for (const date in dailyAverages) {
      const existingRecord = await SpotPricing.findOne({
        where: {
          name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
          date: new Date(date),
          regionCategory: `ALB-${region}`
        }
      });
  
      const today = new Date().toISOString().split('T')[0];
      if (existingRecord && date !== today) {
        continue;
      }
  
      const price = dailyAverages[date];
  
      if (existingRecord && date === today) {
        await existingRecord.update({ price: price });
      } else {
        await SpotPricing.create({
          name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
          regionCategory: `ALB-${region}`,
          date: new Date(date),
          price: price,
          timestamp: new Date(),
          grouping: instanceTypeObj.grouping,
          providerID: 'ALB'
        });
      }
    }
}

async function calculateDailyAverage(instanceTypeObj, region) {
  const spotPriceHistory = await fetchAlibabaSpotPrices(instanceTypeObj, region);
  if (spotPriceHistory.length === 0) {
    console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
    return;
  }
  const pricesByDay = {};
  const dailyAverages = {};
  spotPriceHistory.forEach(spotPrice => {
    const date = new Date(spotPrice.Timestamp);
    date.setUTCHours(9, 0, 0, 0);  // Standardize to 9 AM UTC
    const standardizedDate = date.toISOString().split('T')[0];
    if (!pricesByDay[standardizedDate]) pricesByDay[standardizedDate] = [];
    pricesByDay[standardizedDate].push(parseFloat(spotPrice.SpotPrice));
  });
  for (const date in pricesByDay) {
    const prices = pricesByDay[date];
    const sum = prices.reduce((acc, price) => acc + price, 0);
    const average = sum / prices.length;
    dailyAverages[date] = average;
  }
  await insertIntoDB(dailyAverages, instanceTypeObj, region);
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      await calculateDailyAverage(instanceTypeObj, region);
    }
  }
}

module.exports = async function runAlibabaScript() {
    await main();
}