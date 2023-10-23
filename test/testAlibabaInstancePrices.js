require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { RPCClient } = require('@alicloud/pop-core');

const regions = ['us-west-1', 'asia-southeast1'];
const instanceTypes = ['ecs.g6a.xlarge', 'ecs.g6.xlarge'];  

async function checkAlibabaSpotPriceHistory() {
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
                if (result.SpotPrices && result.SpotPrices.SpotPriceType.length > 0) {
                    console.log(`Price history is available for ${instanceType} in ${region}.`);
                } else {
                    console.log(`No price history found for ${instanceType} in ${region}.`);
                }
            } catch (error) {
                console.error(`Error checking price history for ${region} ${instanceType}:`, error.message);
            }
        }
    }
}

// Call the function to start checking data
checkAlibabaSpotPriceHistory();