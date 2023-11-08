const axios = require('axios');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');


const skuToInstanceRegionMap = {
    // c2-standard-4 SKUs mapping
 
    '0CB5-FB1A-2C2A': { instanceType: 'c2-standard-4', region: 'us-west1' },
  

    /*
    // e2-standard-4 SKUs mapping
    'D5C5-E209-22D3': { instanceType: 'e2-standard-4', region: 'us-east4' },
    '00FD-B743-831B': { instanceType: 'e2-standard-4', region: 'us-west1' },
    '5D70-7762-2DE7': { instanceType: 'e2-standard-4', region: 'europe-central1' },
    '9876-7A20-67F0': { instanceType: 'e2-standard-4', region: 'middleeast-north1' },
    '90AB-A7A8-F873': { instanceType: 'e2-standard-4', region: 'asia-south1' },
    */
    //https://cloud.google.com/skus/sku-groups/compute-engine-flexible-cud-eligible-skus  for sku codes

};
// Mapping for alternative SKUs
const alternativeSkusMap = {
    // ... Add your alternative SKUs mapping here
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

async function checkPriceHistory(authClient, skuId) {
    const projectId = 'getspot-402212';
    const url = `https://cloudbilling.googleapis.com/v1/projects/${projectId}/skus/${skuId}:listPriceHistory`;

    try {
        const accessToken = await authClient.getAccessToken();
        const response = await axios.get(url, {
            headers: {
                Authorization: `Bearer ${accessToken.token}`,
            },
        });

        const priceHistory = response.data.priceHistory;
        if (priceHistory && priceHistory.length > 0) {
            return priceHistory; // Return the price history data
        }
        return null; // No price history
    } catch (error) {
        console.error(`Error fetching price history for SKU: ${skuId}`, error);
        return null;
    }
}

async function main() {
    const authClient = await authenticate();

    for (const [skuId, { instanceType, region }] of Object.entries(skuToInstanceRegionMap)) {
        const priceHistory = await checkPriceHistory(authClient, skuId);
        if (priceHistory) {
            console.log(`Region: ${region}, Instance: ${instanceType} - has a price history:`, priceHistory);
        } else {
            const alternativeSku = alternativeSkusMap[skuId] || 'No alternative SKU available';
            console.log(`Region: ${region}, Instance: ${instanceType} - does not have a price history. Alternative SKU: ${alternativeSku}`);
        }
    }
}

main();