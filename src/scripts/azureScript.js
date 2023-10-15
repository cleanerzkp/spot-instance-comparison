const axios = require('axios');
const SpotInstancePricing = require('../../models/spotinstanceprice.js');

async function fetchAzureSpotPrices() {
    try {
        const params = {
            "$filter": "serviceName eq 'Virtual Machines' and contains(meterName, 'Spot')",
            "api-version": "2023-01-01-preview"
        };

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200) {
            console.log(response.data);
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error(`Request failed with error: ${error.message}`);
    }
}

fetchAzureSpotPrices();