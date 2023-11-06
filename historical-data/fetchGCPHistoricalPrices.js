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
async function insertIntoDB(dailyAverages, instanceTypeObj, region) {
    for (const date in dailyAverages) {
        const standardizedDate = new Date(date);
        standardizedDate.setHours(0, 0, 0, 0);  // Set time to 0 AM

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
                date: standardizedDate,
                regionCategory: `GCP-${region}`
            }
        });

        const price = dailyAverages[date];

        if (existingRecord) {
            await existingRecord.update({ price: price, date: standardizedDate });
        } else {
            await SpotPricing.create({
                name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
                regionCategory: `GCP-${region}`,
                date: standardizedDate, 
                price: price,
                timestamp: new Date(),
                grouping: instanceTypeObj.grouping,
                providerID: 'GCP'
            });
        }
    }
}

// Function to calculate daily average prices
// Function to calculate daily average prices
async function calculateDailyAverage(instanceTypeObj, region, authClient) {
    const spotPriceHistory = await fetchGCPSpotPrices(authClient, instanceTypeObj, region);

    if (spotPriceHistory.length === 0) {
        console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
        return;
    }

    const pricesByDay = {};
    const dailyAverages = {};

    spotPriceHistory.forEach(spotPrice => {
        // Validate the timestamp is a valid date
        const date = new Date(spotPrice.timestamp);
        if (isNaN(date)) {
            console.log('Invalid timestamp for spot price:', spotPrice);
            return;
        }
        date.setUTCHours(9, 0, 0, 0);  // Standardize to 9 AM UTC
        const standardizedDate = date.toISOString().split('T')[0];
        if (!pricesByDay[standardizedDate]) {
            pricesByDay[standardizedDate] = [];
        }
        pricesByDay[standardizedDate].push(parseFloat(spotPrice.price));
    });

    for (const date in pricesByDay) {
        const prices = pricesByDay[date];
        const sum = prices.reduce((acc, price) => acc + price, 0);
        const average = sum / prices.length;
        dailyAverages[date] = average;
    }

    await insertIntoDB(dailyAverages, instanceTypeObj, region);
}

// Main function to handle data fetching, calculation, and insertion into the database
async function main() {
    const authClient = await authenticate();
    const instanceTypes = await InstanceType.findAll({ where: { providerID: 'GCP' } });
    const regions = await Region.findAll({ where: { providerID: 'GCP' } });

    for (const instanceTypeObj of instanceTypes) {
        for (const region of regions) {
            await calculateDailyAverage(instanceTypeObj, region.name, authClient);
        }
    }
}

// Invoke the main function
main();