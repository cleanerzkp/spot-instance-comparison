const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const skuToInstanceRegionMap = {
    // c2-standard-4 SKUs mapping
    'D276-7CD3-D61E': { instanceType: 'c2-standard-4', region: 'us-east4' }, //Virginia
    '0CB5-FB1A-2C2A': { instanceType: 'c2-standard-4', region: 'us-west2' }, //Los Angeles
    'AB94-9F50-2B3C': { instanceType: 'c2-standard-4', region: 'europe-central1' }, //Warsaw
    'DDBE-FFEB-7E00': { instanceType: 'c2-standard-4', region: 'middleeast-north1' }, //Israel
    '406A-AA4B-1013': { instanceType: 'c2-standard-4', region: 'asia-south1' }, //Mumbai
    //https://gcloud-compute.com/c2-standard-4.html to see avaialiblity of regions/skus 

    
    // e2-standard-4 SKUs mapping
    'D5C5-E209-22D3': { instanceType: 'e2-standard-4', region: 'us-east4' }, //Virginia
    '00FD-B743-831B': { instanceType: 'e2-standard-4', region: 'us-west2' }, //Los Angeles
    '955B-B00E-ED15': { instanceType: 'e2-standard-4', region: 'europe-central1' }, //Warsaw
    '41F4-F6BE-4AF2': { instanceType: 'e2-standard-4', region: 'middleeast-north1' }, //Israel
    'DFC1-04D4-B4A1': { instanceType: 'e2-standard-4', region: 'asia-south1' }, //Mumbai
    //https://cloud.google.com/skus/sku-groups/compute-engine-flexible-cud-eligible-skus  for specific sku codes

};

async function authenticate() {
    const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');
    const auth = new GoogleAuth({
        keyFilename: credentialsPath,
        scopes: ['https://www.googleapis.com/auth/cloud-platform'],
    });
    return auth.getClient();
}

async function fetchGCPSpotPrices(authClient) {
    const serviceId = '6F81-5844-456A';
    const url = `https://cloudbilling.googleapis.com/v1/services/${serviceId}/skus`;
    const accessToken = await authClient.getAccessToken();

    let items = [];
    let nextPageToken;

    do {
        const params = nextPageToken ? { pageToken: nextPageToken } : {};
        const response = await axios.get(url, {
            headers: { Authorization: `Bearer ${accessToken.token}` },
            params: params
        });

        items = items.concat(response.data.skus);
        nextPageToken = response.data.nextPageToken;
    } while (nextPageToken);

    return items.filter(item => Object.keys(skuToInstanceRegionMap).includes(item.skuId))
                .map(item => {
                    const mappedData = skuToInstanceRegionMap[item.skuId];
                    const pricingInfo = item.pricingInfo[0];
                    const unitPrice = pricingInfo.pricingExpression.tieredRates[0].unitPrice;
                    return {
                        instanceType: mappedData.instanceType,
                        region: mappedData.region,
                        price: parseFloat(`${unitPrice.units}.${unitPrice.nanos}`),
                        timestamp: new Date() // Current time
                    };
                });
}

async function insertIntoDB(data) {
    for (const entry of data) {
        const instanceTypeObj = await InstanceType.findOne({ where: { name: entry.instanceType, providerID: 'GCP' } });
        const regionObj = await Region.findOne({ where: { standardizedRegion: entry.region, providerID: 'GCP' } });

        const name = instanceTypeObj ? instanceTypeObj.name : entry.instanceType;
        const regionName = regionObj ? regionObj.standardizedRegion : entry.region;
        const grouping = instanceTypeObj ? instanceTypeObj.grouping : 'unknown-grouping';

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: name,
                regionName: regionName,
                timestamp: entry.timestamp
            }
        });

        if (!existingRecord) {
            await SpotPricing.create({
                name: name,
                regionName: regionName,
                date: entry.timestamp,
                price: entry.price,
                timestamp: entry.timestamp,
                grouping: grouping,
                providerID: 'GCP'
            });
        } else {
            console.log(`Record for ${name} in ${regionName} already exists, skipping`);
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
        console.error("Error in main function:", error);
    }
}

main();