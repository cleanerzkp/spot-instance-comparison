require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');
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

            const result = JSON.parse(stdout);
            return resolve(result);
        });
    });
}

async function saveSpotPriceToDB(region, instanceType, date, price, timestamp) {
    try {
        await db.SpotPricing.create({
            region,
            instance_type: instanceType,
            date,
            price,
            timestamp
        });
    } catch (err) {
        console.error('Error inserting spot price to DB:', err.message);
    }
}

async function fetchAndSaveAWSSpotPrices(region, instanceType) {
    try {
        const result = await fetchAWSSpotPrices(instanceType, region);
        const spotPriceHistory = result.SpotPriceHistory;

        const pricesByDay = {};
        spotPriceHistory.forEach(spotPrice => {
            const date = new Date(spotPrice.Timestamp).toISOString().split('T')[0];
            if (!pricesByDay[date]) {
                pricesByDay[date] = [];
            }
            pricesByDay[date].push(parseFloat(spotPrice.SpotPrice));
        });

        for (const date in pricesByDay) {
            const prices = pricesByDay[date];
            const sum = prices.reduce((acc, price) => acc + price, 0);
            const average = sum / prices.length;
            await saveSpotPriceToDB(region, instanceType, date, average, new Date(date));
        }

        console.log(`Saved daily average spot prices for ${instanceType} in ${region} to the database.`);
    } catch (error) {
        console.error('Error fetching and saving spot prices:', error.message);
    }
}

const instanceMap = ['t4g.xlarge', 'c6a.xlarge'];
const regionMap = ['us-east-1', 'eu-west-1'];

for (const instanceType of instanceMap) {
    for (const region of regionMap) {
        fetchAndSaveAWSSpotPrices(region, instanceType);
    }
}