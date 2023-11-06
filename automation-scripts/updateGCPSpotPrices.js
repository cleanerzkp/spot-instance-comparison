const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

// Map SKUs to instance types
const specificSkus = {
    'D276-7CD3-D61E': 'c2-standard-4', // US East (Virginia)
    '0CB5-FB1A-2C2A': 'c2-standard-4', // US West (Los Angeles)
    '955B-B00E-ED15': 'c2-standard-4', // EU Central (Warsaw)
    '41F4-F6BE-4AF2': 'c2-standard-4', // Near East (Israel)
    '210D-FDFA-448C': 'c2-standard-4', // East India (Delhi)
    'D5C5-E209-22D3': 'e2-standard-4', // US East (Virginia)
    '00FD-B743-831B': 'e2-standard-4', // US West (Los Angeles)
    '9787-23D2-3EA1': 'e2-standard-4', // EU Central (Warsaw)
    '9876-7A20-67F0': 'e2-standard-4', // Near East (Israel)
    '0B33-C7D0-C5A9': 'e2-standard-4'  // East India (Delhi)
};

const regionMapping = {
    'us-east1': 'US East (Virginia)',
    'us-west2': 'US West (Los Angeles)',
    'europe-central2': 'EU Central (Warsaw)',
    'middleeast1': 'Near East (Israel)',
    'asia-south1': 'East India (Delhi)',
    // Add additional mappings as needed
};

// Add your existing regionDescriptionMapping if needed
const regionDescriptionMapping = {
    'US East (Virginia)': 'us-east',
    'US West (Los Angeles)': 'us-west',
    'EU Central (Warsaw)': 'europe-central',
    'Near East (Israel)': 'near-east',
    'East India (Delhi)': 'asia-india',
    // Additional mappings
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
    
    const items = response.data.skus;
    const prices = [];
    items.forEach(item => {
        const instanceType = specificSkus[item.skuId];
        if (instanceType) {
            const pricingInfo = item.pricingInfo;
            pricingInfo.forEach(price => {
                const pricingExpression = price.pricingExpression;
                const tieredRates = pricingExpression.tieredRates;
                tieredRates.forEach(rate => {
                    const unitPrice = rate.unitPrice;
                    const currencyCode = unitPrice.currencyCode;
                    const units = unitPrice.units;
                    // Convert nanos to ensure 9 digits for correct decimal placement
                    const nanos = String(unitPrice.nanos).padStart(9, '0');
                    const price = parseFloat(`${units}.${nanos.slice(0, -6)}`);
                    prices.push({
                        instanceType,
                        description: item.description,
                        price: price,
                        currency: currencyCode,
                        sku: item.skuId,
                        region: item.serviceRegions[0] // Assumes each SKU is associated with a single region
                    });
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
        // Translate GCP region description to your standardizedRegion
        const standardizedRegion = regionMapping[entry.region];

        // Find the corresponding InstanceType and Region from the database
        const instanceTypeObj = await InstanceType.findOne({
            where: { name: entry.instanceType }
        });

        const regionObj = await Region.findOne({
            where: { standardizedRegion: standardizedRegion }
        });

        // Proceed if both instance type and region are found
        if (instanceTypeObj && regionObj) {
            const existingRecord = await SpotPricing.findOne({
                where: {
                    name: entry.description,
                    regionCategory: `GCP-${regionObj.regionCategory}`,
                    date: today
                }
            });

            if (existingRecord) {
                await existingRecord.update({ price: entry.price, timestamp: new Date() });
            } else {
                await SpotPricing.create({
                    name: entry.description,
                    regionCategory: `GCP-${regionObj.regionCategory}`,
                    date: today,
                    price: entry.price,
                    timestamp: new Date(),
                    grouping: instanceTypeObj.grouping,
                    providerID: 'GCP'
                });
            }
        } else {
            // If the region or instance type is not found, log an error or handle accordingly
            console.log(`Region or instance type not found for SKU: ${entry.sku}`);
        }
    }
}

async function main() {
    try {
        const authClient = await authenticate();
        const data = await fetchGCPSpotPrices(authClient);
        if (data && data.length > 0) {
            await insertIntoDB(data);
            console.log('GCP data saved successfully');
        }
    } catch (error) {
        console.error('Error in main function:', error);
    }
}

main();