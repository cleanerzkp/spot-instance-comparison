const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');

async function authenticate() {
    const credentialsPath = path.resolve(__dirname, '../GetSpot-Service-Account.json');

    const auth = new GoogleAuth({
        keyFilename: credentialsPath,
        scopes: ['https://www.googleapis.com/auth/cloud-platform'],
    });

    try {
        const authClient = await auth.getClient();
        const accessToken = await authClient.getAccessToken();
        console.log('Authentication successful. Access Token:', accessToken);
        return authClient;
    } catch (error) {
        console.error('Error during authentication:', error.message);
        return null;
    }
}
async function getGCPSpotPrices(authClient) {
  const projectId = 'getspot-402212'; 
  const serviceId = '6F81-5844-456A';

  const url = `https://cloudbilling.googleapis.com/v1/services/${serviceId}/skus`;

  try {
      const accessToken = await authClient.getAccessToken();
      const response = await axios.get(url, {
          headers: {
              Authorization: `Bearer ${accessToken.token}`,
          },
      });

      const items = response.data.skus;
      const specificSkus = ['4111-7FF1-D50A', '41F4-F6BE-4AF2', /* ...other SKU IDs */];
      items.forEach(item => {
          if (specificSkus.includes(item.skuId)) {
              const description = item.description;
              const pricingInfo = item.pricingInfo;
              pricingInfo.forEach(price => {
                  const pricingExpression = price.pricingExpression;
                  const baseUnit = pricingExpression.baseUnitDescription;
                  const tieredRates = pricingExpression.tieredRates;
                  tieredRates.forEach(rate => {
                      const unitPrice = rate.unitPrice;
                      const currencyCode = unitPrice.currencyCode;
                      const units = unitPrice.units;
                      const nanos = unitPrice.nanos;
                      console.log(`${description}: ${currencyCode} ${units}.${nanos}`);
                  });
              });
          }
      });

  } catch (error) {
      console.error('Error during API request:', error.message);
      if (error.response) {
          console.error('Response data:', error.response.data);
          console.error('Response status:', error.response.status);
          console.error('Response headers:', error.response.headers);
      } else if (error.request) {
          console.error('Request data:', error.request);
      }
  }
}

async function main() {
    const authClient = await authenticate();
    if (authClient) {
        await getGCPSpotPrices(authClient);
    }
}

main();