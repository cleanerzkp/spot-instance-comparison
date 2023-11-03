const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

async function authenticate() {
    const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');
    const auth = new GoogleAuth({
        keyFilename: credentialsPath,
        scopes: ['https://www.googleapis.com/auth/cloud-platform'],
    });
    const authClient = await auth.getClient();
    return authClient;
}

async function fetchData() {
    const instanceTypes = await InstanceType.findAll({ where: { providerID: 'GCP' } });
    const regions = await Region.findAll({ where: { providerID: 'GCP' } });
    return {
        instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
        regions: regions.map(r => r.standardizedRegion)
    };  
}

async function fetchGCPSpotPrices(authClient, instanceType, region) {
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
    const specificSkus = [
        // c2-standard-4 SKUs
        'D276-7CD3-D61E', // US East (Virginia)
        '0CB5-FB1A-2C2A', // US West (Los Angeles)
        '955B-B00E-ED15', // EU Central (Warsaw)
        '41F4-F6BE-4AF2', // Near East (Israel)
        '210D-FDFA-448C', // East India (Delhi)
    ];

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
                        currency: currencyCode
                    });
                });
            });
        }
    });
    return prices;
}

async function insertIntoDB(prices, instanceTypeObj, region) {
    const today = new Date();
    today.setHours(9, 0, 0, 0);  // Set time to 9 AM
    const todayStr = today.toISOString().split('T')[0];

    for (const priceObj of prices) {
        const existingRecord = await SpotPricing.findOne({
            where: {
                name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
                date: today,
                regionCategory: `GCP-${region}`
            }
        });

        if (existingRecord) {
            await existingRecord.update({ price: priceObj.price });
        } else {
            await SpotPricing.create({
                name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
                regionCategory: `GCP-${region}`,
                date: today,
                price: priceObj.price,
                timestamp: new Date(),
                grouping: instanceTypeObj.grouping,
                providerID: 'GCP'
            });
        }
    }
}

async function main() {
    const authClient = await authenticate();
    const { instanceTypes, regions } = await fetchData();
    
    for (const instanceTypeObj of instanceTypes) {
        for (const region of regions) {
            const data = await fetchGCPSpotPrices(authClient, instanceTypeObj, region);
            if (data && data.length > 0) {
                await insertIntoDB(data, instanceTypeObj, region);
            }
        }
    }
    
    console.log('GCP data saved successfully');
}

main();