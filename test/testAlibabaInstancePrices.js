require('dotenv').config({ path: '../.env' });

const { RPCClient } = require('@alicloud/pop-core');

const regions = ['us-west-1', 'eu-central-1'];
const instanceTypes = ['ecs.g5.xlarge', 'ecs.c6.xlarge'];  

const regionEndpoints = {
    'us-west-1': 'https://ecs.us-west-1.aliyuncs.com',
    'eu-central-1': 'https://ecs.eu-central-1.aliyuncs.com'
};

async function checkAlibabaSpotPriceHistory() {
    for (const region of regions) {
        const endpoint = regionEndpoints[region];
        if (!endpoint) {
            console.error(`No endpoint specified for region ${region}`);
            continue;  // Skip to next region if endpoint is not specified
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