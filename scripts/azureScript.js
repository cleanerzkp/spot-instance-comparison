'use strict';

const axios = require('axios');
const db = require('../models/index');
const SpotInstancePricing = db.SpotInstancePricing;

async function fetchAzureSpotPrices() {
    try {
        const params = {
            "$filter": "serviceName eq 'Virtual Machines' and contains(meterName, 'Spot')",
            "$limit": 2, // Limit the result to 100 rows
            "api-version": "2023-01-01-preview"
        };
        

        const response = await axios.get('https://prices.azure.com/api/retail/prices', { params });

        if (response.status === 200) {
            for (const item of response.data.Items) {
                await SpotInstancePricing.create({
                    CloudProvider: 'Azure',
                    InstanceType: item.armSkuName,
                    Region: item.armRegionName,
                    PricePerHour_USD: item.retailPrice,
                    EffectiveStartDate: item.effectiveStartDate,
                    OriginalAPIResponse: JSON.stringify(item),
                    Location: item.location,
                    MeterName: item.meterName,
                    ProductName: item.productName,
                    SkuName: item.skuName,
                    ServiceName: item.serviceName,
                    ServiceFamily: item.serviceFamily,
                    UnitOfMeasure: item.unitOfMeasure,
                });
            }
            console.log('Data insertion completed successfully.');
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error(`Request failed with error: ${error.message}`);
    }
}

// Call the function to start inserting data
fetchAzureSpotPrices();