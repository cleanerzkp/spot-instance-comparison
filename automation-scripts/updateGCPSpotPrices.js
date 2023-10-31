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
      'AB94-9F50-2B3C', 'D276-7CD3-D61E', '929E-B2DA-110A',
      '9787-23D2-3EA1', '7D01-D6C8-232D', '210D-FDFA-448C',
      '41F4-F6BE-4AF2', '4111-7FF1-D50A', 'D5C5-E209-22D3',
      '955B-B00E-ED15'
        // ... your specific SKUs
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

async function insertIntoDB(data, instanceTypeObj, region) {
    const mappedData = data.map(spot => ({
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        regionCategory: `GCP-${region}`,
        date: new Date(),
        price: spot.price,
        timestamp: new Date(),
        grouping: instanceTypeObj.grouping,
        providerID: 'GCP'
    }));

    for (const entry of mappedData) {
        await SpotPricing.create(entry);
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