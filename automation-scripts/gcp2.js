const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const specificSkus = [
    // c2-standard-4 SKUs
    'D276-7CD3-D61E', // US East (Virginia)
    '0CB5-FB1A-2C2A', // US West (Los Angeles)
    '955B-B00E-ED15', // EU Central (Warsaw)
    '41F4-F6BE-4AF2', // Near East (Israel)
    '210D-FDFA-448C', // East India (Delhi)

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
        // Enhanced logging to check if the SKUs are being fetched
        console.log(`Fetched SKU: ${item.skuId}`);

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
                    const priceEntry = {
                        description: item.description,
                        price: parseFloat(`${units}.${nanos}`),
                        currency: currencyCode,
                        sku: item.skuId,
                        region: item.serviceRegions[0]
                    };
                    // Log the price entry to be added
                    console.log(`Adding Price Entry:`, priceEntry);
                    prices.push(priceEntry);
                });
            });
        }
    });
    return prices;
}

async function insertIntoDB(data) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);  // Set time to midnight for consistent comparison

    for (const entry of data) {
        // Log the data being processed for insertion
        console.log(`Processing for DB insertion:`, entry);

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: entry.description,
                regionCategory: `GCP-${entry.region}`,
                date: today
            }
        });

        if (existingRecord) {
            console.log(`Updating existing record for ${entry.description} in ${entry.region}`);
            await existingRecord.update({ price: entry.price, timestamp: new Date() });
        } else {
            console.log(`Inserting new record for ${entry.description} in ${entry.region}`);
            await SpotPricing.create({
                name: entry.description,
                regionCategory: `GCP-${entry.region}`,
                date: today,
                price: entry.price,
                timestamp: new Date(),
                grouping: entry.sku,
                providerID: 'GCP'
            });
        }
    }
}

async function main() {
    try {
        const authClient = await authenticate();
        const data = await fetchGCPSpotPrices(authClient);
        if (data && data.length > 0) {
            await insertIntoDB(data);
        }
        console.log('GCP data saved successfully');
    } catch (error) {
        // Log any errors that occur during the execution
        console.error('Error during script execution', error);
    }
}

main();