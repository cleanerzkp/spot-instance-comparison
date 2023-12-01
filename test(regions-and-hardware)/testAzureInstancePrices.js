const axios = require('axios');

const instancesAzure = ['Standard_B4ms', 'Standard_F4s_v2'];
const regionsAzure = ['eastus', 'westeurope'];

async function checkAzureSpotPriceHistory(instanceType, region) {
    try {
        const params = {
            "$filter": `serviceName eq 'Virtual Machines' and armSkuName eq '${instanceType}' and armRegionName eq '${region}'`,
            "$top": 5,  // Reduced the number to minimize data fetching
            "api-version": "2023-01-01-preview"
        };

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200 && response.data.Items.length > 0) {
            console.log(`Price history is available for ${instanceType} in ${region}.`);
        } else {
            console.log(`No price history found for ${instanceType} in ${region}.`);
        }
    } catch (error) {
        console.error(`Error checking price history for ${region} ${instanceType}: ${error.message}`);
    }
}

instancesAzure.forEach(instanceType => {
    regionsAzure.forEach(region => {
        checkAzureSpotPriceHistory(instanceType, region);
    });
});