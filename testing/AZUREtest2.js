'use strict';

const axios = require('axios');
const db = require('../models/index');
const SpotInstancePricing = db.SpotInstancePricing;

async function testDatabaseConnection() {
    try {
        await db.sequelize.authenticate();
        console.log('Connection has been established successfully.');
        return true;
    } catch (error) {
        console.error('Unable to connect to the database:', error);
        return false;
    }
}

async function fetchDataFromAPI() {
    const params = {
        "$filter": "serviceName eq 'Virtual Machines' and contains(meterName, 'Spot')",
        "$top": 5,
        "api-version": "2023-01-01-preview"
    };
    return await axios.get('https://prices.azure.com/api/retail/prices', { params });
}


async function insertDataAndLog(response) {
    let newRecords = 0;
    let duplicateRecords = 0;
    let insertedCount = 0; // Counter for new inserts

    for (const item of response.data.Items) {
        if (insertedCount >= 5) break; // Stop if 5 new records have been inserted

        const existingRecord = await SpotInstancePricing.findOne({
            where: {
                CloudProvider: 'Azure',
                InstanceType: item.armSkuName,
                Region: item.armRegionName,
                PricePerHour_USD: item.retailPrice,
                EffectiveStartDate: item.effectiveStartDate,
            }
        });

        if (!existingRecord) {
            newRecords++;
            insertedCount++;
            await SpotInstancePricing.create({
                // your object here
            });
        } else {
            duplicateRecords++;
        }
    }

    console.log(`Data insertion completed. New Records: ${newRecords}, Duplicates: ${duplicateRecords}`);
}


async function checkDatabaseStats() {
    const totalRecords = await SpotInstancePricing.count();
    console.log(`Total records in database: ${totalRecords}`);
}

async function main() {
    if (!await testDatabaseConnection()) return;

    let response;
    try {
        response = await fetchDataFromAPI();
    } catch (error) {
        console.error('API request failed:', error);
        return;
    }

    await insertDataAndLog(response);
    await checkDatabaseStats();
}

main();
