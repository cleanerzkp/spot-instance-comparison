require('dotenv').config();
const axios = require('axios');
const moment = require('moment');

const regionsAzure = ['eastus', 'westeurope'];
const instancesAzure = ['Standard_B4ms', 'Standard_F4s_v2'];

async function fetchAzureSpotPrices(instanceType, region) {
    try {
        const params = {
            "$filter": `serviceName eq 'Virtual Machines' and armSkuName eq '${instanceType}' and armRegionName eq '${region}'`,
            "$top": 100,
            "api-version": "2023-01-01-preview"
        };

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200) {
            let dataFiltered = response.data.Items.filter(item => {
                const date = moment(item.effectiveStartDate);
                return date.isBetween('2023-10-01', '2023-10-31');
            }).slice(0, 10);

            const standardizedData = dataFiltered.map(item => ({
                SpotPrice: item.retailPrice,
                Timestamp: item.effectiveStartDate,
                AvailabilityZone: item.armRegionName,
                InstanceType: item.armSkuName,
                ProductDescription: item.serviceName,
            }));

            console.log(`Standardized Data for ${instanceType} in ${region}:`, standardizedData);
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error(`Request failed: ${error.message}`);
    }
}

instancesAzure.forEach(instanceType => {
    regionsAzure.forEach(region => {
        fetchAzureSpotPrices(instanceType, region);
    });
});
