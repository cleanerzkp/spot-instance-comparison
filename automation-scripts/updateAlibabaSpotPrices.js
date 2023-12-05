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
    regions: regions.map(r => ({ name: r.name, standardizedRegion: r.standardizedRegion }))
  };
}

async function fetchAlibabaSpotPrices(instanceType, region) {
    const regionData = await Region.findOne({ where: { providerID: 'ALB', name: region.name } });
    if (!regionData) {
      console.error(`No region data found for ${region.name}`);
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

    const currentTime = new Date();
    const startTime = new Date(currentTime);
    startTime.setMinutes(0, 0, 0);

    try {
      const params = {
        RegionId: regionData.name,
        NetworkType: 'vpc',
        InstanceType: instanceType.name,
        StartTime: formatDate(startTime),
        EndTime: formatDate(currentTime),
        MaxResults: 1, // Fetch only the most recent entry
      };
      const result = await client.request('DescribeSpotPriceHistory', params);
      return result.SpotPrices.SpotPriceType.slice(0, 1) || [];
    } catch (error) {
      console.error(`Error fetching Alibaba Spot Prices for ${region.name} ${instanceType.name}:`, error.message);
      return [];
    }
}

async function insertIntoDB(spotPriceHistory, instanceTypeObj, region) {
  const currentTime = new Date();

  if (spotPriceHistory.length > 0) {
    const spotPrice = spotPriceHistory[0];
    await SpotPricing.create({
      name: instanceTypeObj.name,
      regionName: region.standardizedRegion,
      date: currentTime,
      price: parseFloat(spotPrice.SpotPrice),
      timestamp: currentTime,
      createdAt: currentTime,
      updatedAt: currentTime,
      grouping: instanceTypeObj.grouping,
      providerID: 'ALB'
    });
  }
}

async function processSpotPrices(instanceTypeObj, region) {
  const spotPriceHistory = await fetchAlibabaSpotPrices(instanceTypeObj, region);
  if (spotPriceHistory.length === 0) {
    console.log(`No prices available for ${instanceTypeObj.name} in ${region.name}`);
    return;
  }

  await insertIntoDB(spotPriceHistory, instanceTypeObj, region);
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      await processSpotPrices(instanceTypeObj, region);
    }
  }
}

main();