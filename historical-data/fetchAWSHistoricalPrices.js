
require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');
const path = require('path');
const db = require('../models');

async function fetchAWSSpotPrices(instanceType, region) {
    return new Promise((resolve, reject) => {
        exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
            if (error) {
                console.error(`Error: ${error.message}`);
                return reject(error);
            }
            if (stderr) {
                console.error(`Stderr: ${stderr}`);
                return reject(new Error(stderr));
            }

            // Parse the CLI output to JSON
            const result = JSON.parse(stdout);
            return resolve(result);
        });
    });
}

async function saveSpotPriceToDB(instanceID, regionID, date, price, timestamp) {
    try {
        await db.SpotPricing.create({
            instanceID,
            regionID,
            date,
            price,
            timestamp
        });
    } catch (err) {
        console.error('Error inserting spot price to DB:', err.message);
    }
}

async function fetchAndSaveAWSSpotPrices(instanceID, regionID, instanceType, region) {
    try {
        const result = await fetchAWSSpotPrices(instanceType, region);
        const spotPriceHistory = result.SpotPriceHistory;

        // Group the spot prices by day
        const pricesByDay = {};
        spotPriceHistory.forEach(spotPrice => {
            const date = new Date(spotPrice.Timestamp).toISOString().split('T')[0];
            if (!pricesByDay[date]) {
                pricesByDay[date] = [];
            }
            pricesByDay[date].push(parseFloat(spotPrice.SpotPrice));
        });

        // Calculate the average price for each day and save to DB
        for (const date in pricesByDay) {
            const prices = pricesByDay[date];
            const sum = prices.reduce((acc, price) => acc + price, 0);
            const average = sum / prices.length;
            await saveSpotPriceToDB(instanceID, regionID, date, average, new Date(date));
        }

        console.log(`Saved daily average spot prices for ${instanceType} in ${region} to the database.`);
    } catch (error) {
        console.error('Error fetching and saving spot prices:', error.message);
    }
}

const instanceMap = {
    't4g.xlarge': 3,
    'c6a.xlarge': 4
};

const regionMap = {
    'us-east-1': 2,
    'eu-west-1': 6
};

for (const instanceType in instanceMap) {
    for (const region in regionMap) {
        fetchAndSaveAWSSpotPrices(instanceMap[instanceType], regionMap[region], instanceType, region);
    }
}