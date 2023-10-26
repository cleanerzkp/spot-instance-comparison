require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { Sequelize, DataTypes } = require('sequelize');
const { RPCClient } = require('@alicloud/pop-core');
const { SpotPricing, sequelize } = require('../models');

const regions = ['us-west-1', 'eu-central-1'];
const instanceTypes = ['ecs.g5.xlarge', 'ecs.g6.xlarge'];
const regionEndpoints = {
  'us-west-1': 'https://ecs.us-west-1.aliyuncs.com',
  'eu-central-1': 'https://ecs.eu-central-1.aliyuncs.com'
};

// Fetch all instance groupings at once and keep it in a map
const instanceGroupingMap = {};

async function fetchAllInstanceGroupings() {
  const query = `SELECT "name", "grouping" FROM public."InstanceTypes"`;
  const results = await sequelize.query(query, {
    type: Sequelize.QueryTypes.SELECT,
  });
  for (const res of results) {
    instanceGroupingMap[res.name] = res.grouping;
  }
}

async function fetchAlibabaSpotPrices() {
  let allData = [];
  for (const region of regions) {
    const endpoint = regionEndpoints[region];
    if (!endpoint) continue;

    const client = new RPCClient({
      accessKeyId: ALIBABA_ACCESS_KEY_ID,
      accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
      endpoint: endpoint,
      apiVersion: '2014-05-26'
    });

    for (const instanceType of instanceTypes) {
      try {
        const params = {
          RegionId: region,
          NetworkType: 'vpc',
          InstanceType: instanceType,
          MaxResults: 5,
        };
        const result = await client.request('DescribeSpotPriceHistory', params);
        allData = allData.concat(result.SpotPrices.SpotPriceType);
      } catch (error) {
        console.error(`Error fetching Alibaba Spot Prices for ${region} ${instanceType}:`, error.message);
      }
    }
  }
  return allData;
}

const mapAlibabaDataToDbFormat = async (data) => {
  const promises = data.map(async (spot) => {
    const grouping = instanceGroupingMap[spot.InstanceType] || "Unknown";
    return {
      name: spot.InstanceType,
      regionCategory: `Alibaba-${spot.ZoneId}`,
      date: new Date(spot.Timestamp).toISOString(),
      price: parseFloat(spot.SpotPrice),
      timestamp: new Date().toISOString(),
      providerID: "ALB",
      grouping: grouping
    };
  });
  return Promise.all(promises);
};

const saveToDatabase = async (mappedData) => {
  for (const entry of mappedData) {
    await SpotPricing.create(entry);
  }
};

const runAlibabaScript = async () => {
  await fetchAllInstanceGroupings();  // Fetch all groupings once
  const alibabaData = await fetchAlibabaSpotPrices();
  const mappedData = await mapAlibabaDataToDbFormat(alibabaData);
  await saveToDatabase(mappedData);
  console.log('Alibaba data saved successfully');
};

module.exports = { runAlibabaScript };