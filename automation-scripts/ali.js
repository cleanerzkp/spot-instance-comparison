require('dotenv').config({ path: '../.env' });
const { RPCClient } = require('@alicloud/pop-core');

const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;
const REGION_ID = 'us-east-1';  // Update this if necessary
const INSTANCE_TYPE = 'ecs.g5.xlarge';  // Update this if necessary

async function fetchAlibabaSpotPrices() {
  const client = new RPCClient({
    accessKeyId: ALIBABA_ACCESS_KEY_ID,
    accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
    endpoint: `https://ecs.${REGION_ID}.aliyuncs.com`,
    apiVersion: '2014-05-26',
  });

  const sevenDaysAgo = new Date();
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

  // Format dates to 'YYYY-MM-DDTHH:mm:ss' (ISO 8601 without milliseconds or timezone offset)
  const formatDate = date => date.toISOString().split('.')[0] + 'Z';

  try {
    const params = {
      RegionId: REGION_ID,
      NetworkType: 'vpc',
      InstanceType: INSTANCE_TYPE,
      StartTime: formatDate(sevenDaysAgo),
      EndTime: formatDate(new Date()),
      MaxResults: 50,  // Increase this value if necessary
    };
    const result = await client.request('DescribeSpotPriceHistory', params);
    console.log(JSON.stringify(result, null, 2));  // Log the results in JSON format
  } catch (error) {
    console.error(`Error fetching Alibaba Spot Prices for ${REGION_ID} ${INSTANCE_TYPE}:`, error.message);
  }
}

fetchAlibabaSpotPrices();