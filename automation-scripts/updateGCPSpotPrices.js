const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const skuToInstanceRegionMap = {
    // c2-standard-4 SKUs mapping
    '9BD1-9DF4-DEBB': { instanceType: 'c2-standard-4', region: 'us-east1' },
    '0CB5-FB1A-2C2A': { instanceType: 'c2-standard-4', region: 'us-west1' },
    '40DE-6073-970E': { instanceType: 'c2-standard-4', region: 'europe-central1' },
    '08F8-0A90-720E': { instanceType: 'c2-standard-4', region: 'middleeast-north1' },
    '406A-AA4B-1013': { instanceType: 'c2-standard-4', region: 'asia-south1' },
    
    // e2-standard-4 SKUs mapping
    'D5C5-E209-22D3': { instanceType: 'e2-standard-4', region: 'us-east1' },
    '00FD-B743-831B': { instanceType: 'e2-standard-4', region: 'us-west1' },
    'C921-088E-792A': { instanceType: 'e2-standard-4', region: 'europe-central1' },
    '9876-7A20-67F0': { instanceType: 'e2-standard-4', region: 'middleeast-north1' },
    '210D-FDFA-448C': { instanceType: 'e2-standard-4', region: 'asia-south1' },
};

async function authenticate() {
    const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');
    const auth = new GoogleAuth({
        keyFilename: credentialsPath,
        scopes: ['https://www.googleapis.com/auth/cloud-platform'],
    });
    const authClient = await auth.getClient();
    return authClient;
}

async function fetchGCPSpotPrices(authClient) {
    const projectId = 'getspot-402212';
    const serviceId = '6F81-5844-456A';
    const url = `https://cloudbilling.googleapis.com/v1/services/${serviceId}/skus`;

    const accessToken = await authClient.getAccessToken();
    const response = await axios.get(url, {
        headers: {
            Authorization: `Bearer ${accessToken.token}`,
        },
    });

    const items = response.data.skus.filter(item => Object.keys(skuToInstanceRegionMap).includes(item.skuId));
    const prices = items.map(item => {
        const mappedData = skuToInstanceRegionMap[item.skuId];
        const pricingInfo = item.pricingInfo[0]; // Assume one pricingInfo per SKU
        const unitPrice = pricingInfo.pricingExpression.tieredRates[0].unitPrice;
        return {
            instanceType: mappedData.instanceType,
            region: mappedData.region,
            price: parseFloat(`${unitPrice.units}.${unitPrice.nanos}`),
            currency: unitPrice.currencyCode
        };
    });

    return prices;
}

async function insertIntoDB(data) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // Fetch all instance types and regions from the database
    const instanceTypes = await InstanceType.findAll({
        where: { providerID: 'GCP' }
    });
    const regions = await Region.findAll({
        where: { providerID: 'GCP' }
    });

    for (const entry of data) {
        // Find the matching instance type and region for the GCP entry
        const instanceTypeObj = instanceTypes.find(it => it.name === entry.instanceType);
        const regionObj = regions.find(r => r.name === entry.region);

        // If instance type or region is not found, use 'unknown-grouping'
        const grouping = instanceTypeObj && regionObj ? `${instanceTypeObj.grouping}-${regionObj.grouping}` : 'unknown-grouping';

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: entry.instanceType,
                regionCategory: `GCP-${entry.region}`,
                date: today
            }
        });

        if (existingRecord) {
            await existingRecord.update({ price: entry.price, timestamp:

 new Date() });
        } else {
            await SpotPricing.create({
                name: entry.instanceType,
                regionCategory: `GCP-${entry.region}`,
                date: today,
                price: entry.price,
                timestamp: new Date(),
                grouping: grouping,
                providerID: 'GCP'
            });
        }
    }
}

async function main() {
    const authClient = await authenticate();
    const data = await fetchGCPSpotPrices(authClient);
    if (data && data.length > 0) {
        await insertIntoDB(data);
    }
    console.log('GCP data saved successfully');
}

main();