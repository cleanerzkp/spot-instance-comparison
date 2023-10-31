require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { Sequelize, DataTypes } = require('sequelize');
const { RPCClient } = require('@alicloud/pop-core');
const { SpotPricing, sequelize, InstanceType, Region } = require('../models');

const regionEndpoints = {
    'us-east-1': 'https://ecs.us-east-1.aliyuncs.com',
    'us-west-1': 'https://ecs.us-west-1.aliyuncs.com',
    'eu-central-1': 'https://ecs.eu-central-1.aliyuncs.com',
    'me-east-1': 'https://ecs.me-east-1.aliyuncs.com',
    'ap-south-1': 'https://ecs.ap-south-1.aliyuncs.com'
};
async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'ALB' } });
  const regions = await Region.findAll({ where: { providerID: 'ALB' } });

  console.log('Fetched instanceTypes and regions from DB:', instanceTypes, regions);

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };  
}

async function fetchAlibabaSpotPrices(instanceType, region) {
  const endpoint = regionEndpoints[region];
  if (!endpoint) {
    console.error(`No endpoint specified for region ${region}`);
    return [];
  }

  const client = new RPCClient({
    accessKeyId: ALIBABA_ACCESS_KEY_ID,
    accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
    endpoint: endpoint,
    apiVersion: '2014-05-26'
  });

  try {
    const params = {
      RegionId: region,
      NetworkType: 'vpc',
      InstanceType: instanceType.name,
      MaxResults: 5,
    };
    const result = await client.request('DescribeSpotPriceHistory', params);
    console.log(`Fetched spot prices for ${instanceType.name} in ${region}:`, result.SpotPrices.SpotPriceType);
    return result.SpotPrices.SpotPriceType;
  } catch (error) {
    console.error(`Error fetching Alibaba Spot Prices for ${region} ${instanceType.name}:`, error.message);
  }
}

const mapAlibabaDataToDbFormat = async (data, instanceType) => {
  return {
    name: instanceType.name,
    regionCategory: `ALB-${data.ZoneId}`,
    date: new Date(data.Timestamp).toISOString(),
    price: parseFloat(data.SpotPrice),
    timestamp: new Date().toISOString(),
    providerID: "ALB",
    grouping: instanceType.grouping
  };
};

const saveToDatabase = async (mappedData) => {
  console.log('Saving data to DB:', mappedData);
  await SpotPricing.create(mappedData);
};

const runAlibabaScript = async () => {
  const { instanceTypes, regions } = await fetchData();
  
  for (const instanceType of instanceTypes) {
    for (const region of regions) {
      const alibabaData = await fetchAlibabaSpotPrices(instanceType, region);
      for (const data of alibabaData) {
        const mappedData = await mapAlibabaDataToDbFormat(data, instanceType);
        await saveToDatabase(mappedData);
      }
    }
  }

  console.log('Alibaba data saved successfully');
};

runAlibabaScript()
  .then(() => console.log('All data saved successfully'))
  .catch(err => console.error('Error saving data:', err));