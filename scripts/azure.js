const axios = require('axios');
const moment = require('moment');

const instancesAzure = ['Standard_B4ms', 'Standard_F4s_v2'];
const regionsAzure = ['eastus', 'westeurope'];

async function fetchAzureSpotPrices(instanceType, region) {
    try {
        const params = {
            "$filter": `serviceName eq 'Virtual Machines' and armSkuName eq '${instanceType}' and armRegionName eq '${region}'`,
            "$top": 100,  // Set to a high number to ensure we fetch enough data to filter client-side
            "api-version": "2023-01-01-preview"
        };

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200) {
            let standardizedData = response.data.Items.map(item => {
                return {
                    SpotPrice: item.retailPrice,
                    Timestamp: item.effectiveStartDate,
                    AvailabilityZone: item.armRegionName,
                    InstanceType: item.armSkuName,
                    ProductDescription: item.serviceName
                };
            });

            // Filter for only the prices from October 2023
            standardizedData = standardizedData.filter(item => {
                const date = moment(item.Timestamp);
                return date.isBetween('2023-10-01', '2023-10-31', undefined, '[]');
            });

            // Limit to 10 results
            standardizedData = standardizedData.slice(0, 10);

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