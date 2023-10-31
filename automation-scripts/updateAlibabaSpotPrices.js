require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { RPCClient } = require('@alicloud/pop-core');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const regionEndpoints = {
  'us-west-1': 'https://ecs.us-west-1.aliyuncs.com',
  'eu-central-1': 'https://ecs.eu-central-1.aliyuncs.com'
};

async function fetchData() {
    const instanceTypes = await InstanceType.findAll({ where: { providerID: 'ALB' } });
    const regions = await Region.findAll({ where: { providerID: 'ALB' } });
  
    return {
      instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
      regions: regions.map(r => ({ name: r.name, endpoint: regionEndpoints[r.name] || 'missing endpoint' }))
    };  
  }

  async function fetchAlibabaSpotPrices(instanceType, region) {
    if (!region.endpoint || !region.endpoint.startsWith('https://')) {
      console.error(`Invalid or missing endpoint for region ${region.name}`);
      return;
    }
  
    const client = new RPCClient({
      accessKeyId: ALIBABA_ACCESS_KEY_ID,
      accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
      endpoint: region.endpoint,
      apiVersion: '2014-05-26'
    });
  
  try {
    const params = {
      RegionId: region.name,
      NetworkType: 'vpc',
      InstanceType: instanceType.name,
      MaxResults: 5,
    };
    const result = await client.request('DescribeSpotPriceHistory', params);
    return result.SpotPrices.SpotPriceType;
  } catch (error) {
    console.error(`Error fetching Alibaba Spot Prices for ${region.name} ${instanceType.name}:`, error.message);
  }
}

async function insertIntoDB(data, instanceTypeObj, region) {
  const mappedData = data.map(spot => ({
    name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        regionCategory: `ALB-${region}`,
        date: new Date(date),
        price: price,
        timestamp: new Date(),
        grouping: instanceTypeObj.grouping,
        providerID: 'ALB'
  }));
  
  for (const entry of mappedData) {
    await SpotPricing.create(entry);
  }
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  
  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      const data = await fetchAlibabaSpotPrices(instanceTypeObj, region);
      if (data && data.length > 0) {
        await insertIntoDB(data, instanceTypeObj, region);
      }
    }
  }
  
  console.log('Alibaba data saved successfully');
}

main();