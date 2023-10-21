require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { RPCClient } = require('@alicloud/pop-core');

const regions = ['us-west-1', 'asia-southeast1'];
const instanceTypes = ['ecs.g6a.xlarge', 'ecs.g6.xlarge'];  
async function fetchAlibabaSpotPrices() {
    const client = new RPCClient({
        accessKeyId: ALIBABA_ACCESS_KEY_ID,
        accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
        endpoint: 'https://ecs.aliyuncs.com',
        apiVersion: '2014-05-26'
    });

    for (const region of regions) {
        for (const instanceType of instanceTypes) {
            try {
                const params = {
                    RegionId: region,
                    NetworkType: 'vpc',
                    InstanceType: instanceType,
                    MaxResults: 5,
                };
                const result = await client.request('DescribeSpotPriceHistory', params);
                console.log(`Alibaba Spot Prices for ${region} ${instanceType}:`, JSON.stringify(result, null, 2));
            } catch (error) {
                console.error(`Error fetching Alibaba Spot Prices for ${region} ${instanceType}:`, error.message);
            }
        }
    }
}

// Call the function to start fetching data
fetchAlibabaSpotPrices();