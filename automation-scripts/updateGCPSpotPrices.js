const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;

const skuToInstanceRegionMap = {
    // c2-standard-4 SKUs mapping
    'D276-7CD3-D61E': { instanceType: 'c2-standard-4', region: 'us-east4' },
    '0CB5-FB1A-2C2A': { instanceType: 'c2-standard-4', region: 'us-west2' },
    'AB94-9F50-2B3C': { instanceType: 'c2-standard-4', region: 'europe-central1' },
    'DDBE-FFEB-7E00': { instanceType: 'c2-standard-4', region: 'middleeast-north1' },
    '406A-AA4B-1013': { instanceType: 'c2-standard-4', region: 'asia-south1' },
    //https://gcloud-compute.com/c2-standard-4.html to see avaialiblity of regions/skus 

    
    // e2-standard-4 SKUs mapping
    'D5C5-E209-22D3': { instanceType: 'e2-standard-4', region: 'us-east1' },
    '00FD-B743-831B': { instanceType: 'e2-standard-4', region: 'us-west1' },
    '955B-B00E-ED15': { instanceType: 'e2-standard-4', region: 'europe-central1' },
    '41F4-F6BE-4AF2': { instanceType: 'e2-standard-4', region: 'middleeast-north1' },
    'DFC1-04D4-B4A1': { instanceType: 'e2-standard-4', region: 'asia-south1' },
    //https://cloud.google.com/skus/sku-groups/compute-engine-flexible-cud-eligible-skus  for specific sku codes

};

async function authenticate() {
    try {
        const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');
        const auth = new GoogleAuth({
            keyFilename: credentialsPath,
            scopes: ['https://www.googleapis.com/auth/cloud-platform'],
        });
        const authClient = await auth.getClient();
        return authClient;
    } catch (error) {
        console.error("Error in authentication:", error);
        throw error;
    }
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
            headers: {
                Authorization: `Bearer ${accessToken.token}`,
            },
            params: params
        });

        items = items.concat(response.data.skus);
        nextPageToken = response.data.nextPageToken;
    } while (nextPageToken);

    const prices = items.filter(item => Object.keys(skuToInstanceRegionMap).includes(item.skuId))
                        .map(item => {
                            const mappedData = skuToInstanceRegionMap[item.skuId];
                            const pricingInfo = item.pricingInfo[0];
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

    const instanceTypes = await InstanceType.findAll({
        where: { providerID: 'GCP' }
    });
    const regions = await Region.findAll({
        where: { providerID: 'GCP' }
    });

    for (const entry of data) {
        const instanceTypeObj = instanceTypes.find(it => it.name.includes(entry.instanceType));
        const regionObj = regions.find(r => r.standardizedRegion.includes(entry.region));

        const name = instanceTypeObj ? `${instanceTypeObj.name}-${instanceTypeObj.category}` : entry.instanceType;
        const regionCategory = regionObj ? `GCP-${regionObj.standardizedRegion}` : `GCP-${entry.region}`;

        let grouping = '';
        if (instanceTypeObj && instanceTypeObj.grouping) {
            grouping += instanceTypeObj.grouping;
        }
        if (regionObj && regionObj.grouping) {
            grouping += `-${regionObj.grouping}`;
        }
        grouping = grouping || 'unknown-grouping'; // Fallback to 'unknown-grouping' if both are undefined

        const existingRecord = await SpotPricing.findOne({
            where: {
                name: name,
                regionCategory: regionCategory,
                date: today
            }
        });

        if (existingRecord) {
            await existingRecord.update({
                price: entry.price,
                timestamp: new Date(),
                grouping: grouping,
            });
        } else {
            await SpotPricing.create({
                name: name,
                regionCategory: regionCategory,
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