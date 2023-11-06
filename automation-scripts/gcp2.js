const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

// Authentication with Google Cloud
async function authenticate() {
  const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');
  const auth = new GoogleAuth({
    keyFilename: credentialsPath,
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  });
  const authClient = await auth.getClient();
  return authClient;
}

// Fetch instance types and regions from the database
async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'GCP' } });
  const regions = await Region.findAll({ where: { providerID: 'GCP' } });
  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.standardizedRegion)
  };
}

async function fetchGCPSpotPrices(authClient, instanceTypes, regions) {
    const projectId = 'getspot-402212';
    const serviceId = '6F81-5844-456A';
    const url = `https://cloudbilling.googleapis.com/v1/services/${serviceId}/skus`;
    const accessToken = await authClient.getAccessToken();

    // Map each SKU to its region and instance type
    const skuToRegionAndType = {
        'D276-7CD3-D61E': { region: 'us-east1', type: 'c2-standard-4' },
        '0CB5-FB1A-2C2A': { region: 'us-west1', type: 'c2-standard-4' },
        '955B-B00E-ED15': { region: 'europe-central1', type: 'c2-standard-4' },
        '41F4-F6BE-4AF2': { region: 'middleeast-north1', type: 'c2-standard-4' },
        '210D-FDFA-448C': { region: 'asia-south1', type: 'c2-standard-4' },
        'D5C5-E209-22D3': { region: 'us-east1', type: 'e2-standard-4' },
        '00FD-B743-831B': { region: 'us-west1', type: 'e2-standard-4' },
        '9787-23D2-3EA1': { region: 'europe-central1', type: 'e2-standard-4' },
        '9876-7A20-67F0': { region: 'middleeast-north1', type: 'e2-standard-4' },
        '0B33-C7D0-C5A9': { region: 'asia-south1', type: 'e2-standard-4' }
        // ... Add any additional SKUs here
    };

    const response = await axios.get(url, {
        headers: {
            Authorization: `Bearer ${accessToken.token}`,
        }
    });

    const items = response.data.skus;
// Fetch prices for each SKU
const prices = [];
for (const specificSku of Object.keys(skuToRegionAndType)) {
    const skuDetails = skuToRegionAndType[specificSku];
    const response = await axios.get(`${url}?key=${specificSku}`, {
        headers: {
            Authorization: `Bearer ${accessToken.token}`,
        }
    });
    const item = response.data.skus[0]; // Assuming each SKU ID returns a single SKU item
    if (item && skuDetails && item.serviceRegions.includes(skuDetails.region)) {
        const pricingInfo = item.pricingInfo[0]; // Assuming we take the first pricing info
        const pricingExpression = pricingInfo.pricingExpression;
        const tieredRates = pricingExpression.tieredRates[0]; // Assuming we take the first tiered rate
        const unitPrice = tieredRates.unitPrice;
        const pricePerUnit = `${unitPrice.units}.${unitPrice.nanos}`;
        prices.push({
            instanceType: skuDetails.type,
            region: skuDetails.region,
            price: parseFloat(pricePerUnit),
            currency: unitPrice.currencyCode,
            timestamp: new Date().toISOString()
        });
    }
}
return prices;
}
async function insertIntoDB(dailyAverages, instanceTypeObj, region) {
    for (const date in dailyAverages) {
        const standardizedDate = new Date(date);
        standardizedDate.setUTCHours(0, 0, 0, 0); // Set time to midnight UTC

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

async function calculateDailyAverage(instanceTypeObj, region, authClient) {
    const spotPriceHistory = await fetchGCPSpotPrices(authClient, instanceTypeObj.name, region);

    if (spotPriceHistory.length === 0) {
        console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
        return;
    }

    const pricesByDay = {};
    const dailyAverages = {};

    spotPriceHistory.forEach(spotPrice => {
        // Check if the timestamp is defined and is a valid date
        if (!spotPrice.timestamp || isNaN(Date.parse(spotPrice.timestamp))) {
            console.log(`Invalid or missing timestamp for price entry: ${spotPrice.description}`);
            return;
        }

        const date = new Date(spotPrice.timestamp);
        date.setUTCHours(0, 0, 0, 0); // Standardize to midnight UTC
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

async function main() {
    const authClient = await authenticate();
    const data = await fetchData();

    for (const instanceTypeObj of data.instanceTypes) {
        for (const region of data.regions) {
            await calculateDailyAverage(instanceTypeObj, region, authClient);
        }
    }
    console.log('Data processing complete.');
}

main();