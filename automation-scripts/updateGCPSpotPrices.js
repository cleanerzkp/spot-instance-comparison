const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const specificSkus = [
    // c2-standard-4 SKUs
    '9BD1-9DF4-DEBB', // US East (Montreal)
    '0CB5-FB1A-2C2A', // US West (Los Angeles)
    '40DE-6073-970E', // EU Central (Frankfurt)
    '08F8-0A90-720E', // Near East (Doha  -- Qatar)
    '406A-AA4B-1013', // East India (Mumbai)
   //https://gcloud-compute.com/c2-standard-4.html to see avaialiblity of regions/skus 

    // e2-standard-4 SKUs
    'D5C5-E209-22D3', // US East (Virginia)
    '00FD-B743-831B', // US West (Los Angeles)
    'C921-088E-792A', // EU Central (Frankfurt)
    '9876-7A20-67F0', // Near East (Israel)
    '210D-FDFA-448C	'  // East India (Delhi)

    //https://cloud.google.com/skus/sku-groups/compute-engine-flexible-cud-eligible-skus  for sku codes
    //
];

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
    
    const items = response.data.skus;
    const prices = [];
    items.forEach(item => {
        if (specificSkus.includes(item.skuId)) {
            const pricingInfo = item.pricingInfo;
            pricingInfo.forEach(price => {
                const pricingExpression = price.pricingExpression;
                const tieredRates = pricingExpression.tieredRates;
                tieredRates.forEach(rate => {
                    const unitPrice = rate.unitPrice;
                    const currencyCode = unitPrice.currencyCode;
                    const units = unitPrice.units;
                    const nanos = unitPrice.nanos;
                    prices.push({
                        description: item.description,
                        price: parseFloat(`${units}.${nanos}`),
                        currency: currencyCode,
                        sku: item.skuId,
                        region: item.serviceRegions[0]  // Assumes each SKU is associated with a single region
                    });
                });
            });
        }
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
        const instanceTypeObj = instanceTypes.find(it => it.name === entry.description);
        const regionObj = regions.find(r => r.name === entry.region);

        // Use instance type and region to create a grouping identifier
        const grouping = instanceTypeObj ? `${instanceTypeObj.grouping}-${regionObj.grouping}` : 'unknown-grouping';

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: entry.description,
                regionCategory: `GCP-${entry.region}`,
                date: today
            }
        });

        if (existingRecord) {
            await existingRecord.update({ price: entry.price, timestamp: new Date() });
        } else {
            await SpotPricing.create({
                name: entry.description,
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