require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { Sequelize } = require('sequelize');
const { RPCClient } = require('@alicloud/pop-core');
const { SpotPricing, InstanceType, Region, sequelize } = require('../models');

const regionEndpoints = {
  'us-west-1': 'https://ecs.us-west-1.aliyuncs.com',
  'eu-central-1': 'https://ecs.eu-central-1.aliyuncs.com'
};

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'ALB' } });
  const regions = await Region.findAll({ where: { providerID: 'ALB' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };
}

async function fetchAlibabaSpotPrices(instanceType, region) {
  const endpoint = regionEndpoints[region];
  const client = new RPCClient({
    accessKeyId: ALIBABA_ACCESS_KEY_ID,
    accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
    endpoint: endpoint,
    apiVersion: '2014-05-26'
  });

  const params = {
    RegionId: region,
    NetworkType: 'vpc',
    InstanceType: instanceType.name,
    MaxResults: 1000
  };

  const result = await client.request('DescribeSpotPriceHistory', params);
  return result.SpotPrices.SpotPriceType;
}

async function insertIntoDB(dailyAverages, instanceType, region) {
  for (const date in dailyAverages) {
    const existingRecord = await SpotPricing.findOne({
      where: {
        name: instanceType.name,
        date: new Date(date),
        regionCategory: `Alibaba-${region}`
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
        name: instanceType.name,
        regionCategory: `Alibaba-${region}`,
        date: new Date(date),
        price: price,
        timestamp: new Date(),
        grouping: instanceType.grouping,
        providerID: 'ALB'
      });
    }
  }
}

async function calculateDailyAverage(instanceType, region) {
  const spotPriceHistory = await fetchAlibabaSpotPrices(instanceType, region);
  if (spotPriceHistory.length === 0) {
    console.log(`No prices available for ${instanceType.name} in ${region}`);
    return;
  }

  const pricesByDay = {};
  const dailyAverages = {};

  spotPriceHistory.forEach(spotPrice => {
    const date = new Date(spotPrice.Timestamp).toISOString().split('T')[0];
    if (!pricesByDay[date]) {
      pricesByDay[date] = [];
    }
    pricesByDay[date].push(parseFloat(spotPrice.SpotPrice));
  });

  for (const date in pricesByDay) {
    const prices = pricesByDay[date];
    const sum = prices.reduce((acc, price) => acc + price, 0);
    const average = sum / prices.length;
    dailyAverages[date] = average;
  }

  await insertIntoDB(dailyAverages, instanceType, region);
}

async function runAlibabaScript() {
  const { instanceTypes, regions } = await fetchData();
  for (const instanceType of instanceTypes) {
    for (const region of regions) {
      await calculateDailyAverage(instanceType, region);
    }
  }
  console.log('Alibaba data saved successfully');
}

runAlibabaScript();