require('dotenv').config({ path: '../.env' });
const ALIBABA_ACCESS_KEY_ID = process.env.ALIBABA_ACCESS_KEY_ID;
const ALIBABA_ACCESS_KEY_SECRET = process.env.ALIBABA_ACCESS_KEY_SECRET;

const { RPCClient } = require('@alicloud/pop-core');

async function fetchAlibabaSpotPrices() {
    const client = new RPCClient({
        accessKeyId: ALIBABA_ACCESS_KEY_ID,
        accessKeySecret: ALIBABA_ACCESS_KEY_SECRET,
        endpoint: 'https://ecs.aliyuncs.com',
        apiVersion: '2014-05-26'
    });

    try {
        const params = {
            RegionId: 'cn-hangzhou',
            NetworkType: 'vpc',
            InstanceType: 'ecs.g5.large',  // specify the instance type here
            MaxResults: 10 ,
            // other necessary parameters...
        };
        const result = await client.request('DescribeSpotPriceHistory', params);
        console.log('Alibaba Spot Prices:', result);
        console.log('Alibaba Spot Prices:', JSON.stringify(result, null, 2));

    } catch (error) {
        console.error('Error fetching Alibaba Spot Prices:', error.message);
    }
}


// Call the function to start fetching data
fetchAlibabaSpotPrices();