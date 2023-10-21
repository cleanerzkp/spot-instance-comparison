const axios = require('axios');
const moment = require('moment'); 

async function fetchAzureSpotPrices() {
    try {
        const params = {
            "$filter": "serviceName eq 'Virtual Machines' and armSkuName eq 'Standard_NP20s' and armRegionName eq 'southcentralus' and contains(meterName, 'Spot')",
            "$top": 10000,
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
            console.log('Standardized Data:', standardizedData);
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error(`Request failed with error: ${error.message}`);
    }
}

fetchAzureSpotPrices();