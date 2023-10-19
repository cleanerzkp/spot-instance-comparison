require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { RPCClient } = require('@alicloud/pop-core');

const regions = ['cn-hangzhou', 'us-east-1', 'us-west-1', 'eu-west-1', 'ap-southeast-1'];
const instanceTypes = ['g8a', 'c8a', 'r8a', 'g6', 'c6'];

async function fetchAlibabaSpotPrices() {
    const client = new RPCClient({
        accessKeyId: ALIBABA_ACCESS_KEY_ID,
        accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
        endpoint: 'https://ecs.aliyuncs.com',
        apiVersion: '2014-05-26',
        timeout: 6000,
    });

    for (let region of regions) {
        for (let instanceType of instanceTypes) {
            try {
                const params = {
                    RegionId: region,
                    NetworkType: 'vpc',
                    InstanceType: instanceType,
                    MaxResults: 2,
                    StartTime: '2020-01-01T00:00:00Z',
                    EndTime: '2023-10-17T17:56:31Z',
                };
                const result = await client.request('DescribeSpotPriceHistory', params);
                console.log(`Alibaba Spot Prices for Region ${region} and InstanceType ${instanceType}:`, result);
                console.log(JSON.stringify(result, null, 2));

            } catch (error) {
                console.error(`Error fetching Alibaba Spot Prices for Region ${region} and InstanceType ${instanceType}:`, error.message);
            }
        }
    }
}

// Call the function to start fetching data
fetchAlibabaSpotPrices();