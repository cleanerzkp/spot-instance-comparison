const axios = require('axios');
const moment = require('moment');

const instancesAzure = ['Standard_B4ms', 'Standard_F4s_v2'];
const regionsAzure = ['eastus', 'westeurope'];

async function fetchAzureSpotPrices(instanceType, region) {
    try {
        const params = {
            "$filter": `serviceName eq 'Virtual Machines' and armSkuName eq '${instanceType}' and armRegionName eq '${region}'`,
            "$top": 10,
            "api-version": "2023-01-01-preview"
        };

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200) {
            const standardizedData = response.data.Items.map(item => {
                return {
                    SpotPrice: item.retailPrice,
                    Timestamp: item.effectiveStartDate,
                    AvailabilityZone: item.armRegionName,
                    InstanceType: item.armSkuName,
                    ProductDescription: item.serviceName
                };
            });
            console.log(`Standardized Data for ${instanceType} in ${region}:`, standardizedData);
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error(`Request failed with error: ${error.message}`);
    }
}

instancesAzure.forEach(instanceType => {
    regionsAzure.forEach(region => {
        fetchAzureSpotPrices(instanceType, region);
    });
});