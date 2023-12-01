const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');

const skuToInstanceRegionMap = {
    // c2-standard-4 SKUs mapping
    '0CB5-FB1A-2C2A': { instanceType: 'c2-standard-4', region: 'us-west2' }, // Los Angeles
    'AB94-9F50-2B3C': { instanceType: 'c2-standard-4', region: 'europe-central1' }, // Warsaw

    // e2-standard-4 SKUs mapping
    '00FD-B743-831B': { instanceType: 'e2-standard-4', region: 'us-west2' }, // Los Angeles
    '955B-B00E-ED15': { instanceType: 'e2-standard-4', region: 'europe-central1' }, // Warsaw
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

async function main() {
    try {
        const authClient = await authenticate();
        const data = await fetchGCPSpotPrices(authClient);
        if (data.length > 0) {
            data.forEach(priceInfo => {
                console.log(`Instance: ${priceInfo.instanceType}, Region: ${priceInfo.region}, Price: ${priceInfo.price} ${priceInfo.currency}`);
            });
        } else {
            console.log('No data found for specified SKUs.');
        }
    } catch (error) {
        console.error("Error in main function:", error);
    }
}

main();