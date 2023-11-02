const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');

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
    const specificSkus = [
      'D276-7CD3-D61E', // US East (Virginia)
        '0CB5-FB1A-2C2A'
        // ... your SKUs
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
                        currency: currencyCode,
                        sku: item.skuId  // include SKU in the output
                    });
                });
            });
        }
    });
    return prices;
}

async function main() {
    const authClient = await authenticate();
    const data = await fetchGCPSpotPrices(authClient);
    
    if (data && data.length > 0) {
        data.forEach(priceInfo => {
            console.log(`SKU: ${priceInfo.sku}, Description: ${priceInfo.description}, Price: ${priceInfo.price} ${priceInfo.currency}`);
        });
    } else {
        console.log('No matching SKUs found or no price data available for the specified SKUs.');
    }
}

main();