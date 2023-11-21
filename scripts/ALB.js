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

async function fetchInstanceGrouping(instanceType) {
  const query = `SELECT "grouping" FROM public."InstanceTypes" WHERE "name" = :instanceType`;
  const [results] = await sequelize.query(query, {
    replacements: { instanceType },
    type: Sequelize.QueryTypes.SELECT,
  });
  return results ? results.grouping : null;
}

async function fetchAlibabaSpotPrices() {
  let allData = [];

  for (const region of regions) {
    const endpoint = regionEndpoints[region];
    if (!endpoint) {
        console.error(`No endpoint specified for region ${region}`);
        continue;
    }

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
    const grouping = await fetchInstanceGrouping(spot.InstanceType);
    return {
      name: spot.InstanceType,
      regionCategory: `Alibaba-${spot.ZoneId}`,
      date: new Date(spot.Timestamp).toISOString(),
      price: parseFloat(spot.SpotPrice),
      timestamp: new Date().toISOString(),
      providerID: "Alibaba",
      grouping: grouping || "Unknown"
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
  const alibabaData = await fetchAlibabaSpotPrices();
  const mappedData = await mapAlibabaDataToDbFormat(alibabaData);
  await saveToDatabase(mappedData);
  console.log('Alibaba data saved successfully');
};

module.exports = { runAlibabaScript };

const { runAlibabaScript } = require('./ALB');

const runAllScripts = async () => {
  await runAlibabaScript();
};

runAllScripts()
  .then(() => console.log('All data saved successfully'))
  .catch(err => console.error('Error saving data:', err));