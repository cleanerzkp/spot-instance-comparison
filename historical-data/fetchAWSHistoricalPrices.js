require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');
const db = require('../models');

async function fetchAWSSpotPrices(instanceType, region) {
    return new Promise((resolve, reject) => {
        exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
            if (error || stderr) {
                return reject(new Error(error?.message || stderr));
            }
            const result = JSON.parse(stdout);
            return resolve(result);
        });
    });
}

async function saveOrUpdateSpotPrice(region, instanceType, date, price, timestamp, grouping, providerID) {
    try {
        const existingRecord = await db.SpotPricing.findOne({
            where: {
                region,
                instance_type: instanceType,
                date
            }
        });

        const dataToInsertOrUpdate = {
            name: `${instanceType}-general-purpose`,
            regionCategory: `AWS-${region}`,
            date,
            price,
            timestamp,
            createdAt: new Date(),
            updatedAt: new Date(),
            grouping,
            providerID
        };

        if (existingRecord) {
            await existingRecord.update(dataToInsertOrUpdate);
        } else {
            await db.SpotPricing.create(dataToInsertOrUpdate);
        }
    } catch (err) {
        console.error('Error inserting or updating spot price to DB:', err.message);
    }
}

async function fetchAndSaveAWSSpotPrices(region, instanceType, grouping, providerID) {
    try {
        const result = await fetchAWSSpotPrices(instanceType, region);
        const spotPriceHistory = result.SpotPriceHistory;

        if (!spotPriceHistory || spotPriceHistory.length === 0) {
            console.log(`No data available for ${instanceType} in ${region}.`);
            return;
        }

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
            const timestamp = new Date().toISOString();
            await saveOrUpdateSpotPrice(region, instanceType, date, average, timestamp, grouping, providerID);
        }

        console.log(`Saved or updated daily average spot prices for ${instanceType} in ${region} to the database.`);
    } catch (error) {
        console.log(`Error or no data for ${instanceType} in ${region}: ${error.message}`);
    }
}

async function main() {
    try {
        const { regions, instances } = await fetchRegionsAndInstanceTypes();

        const grouping = "YourGrouping";  // Replace with actual grouping
        const providerID = "AWS";  // Replace with actual providerID

        for (const instanceType of instances) {
            for (const region of regions) {
                await fetchAndSaveAWSSpotPrices(region, instanceType, grouping, providerID);
            }
        }
    } catch (error) {
        console.error(`Global error: ${error.message}`);
    }
}

async function fetchRegionsAndInstanceTypes() {
    const awsRegions = await db.Region.findAll({ where: { providerID: 'AWS' } });
    const awsInstanceTypes = await db.InstanceType.findAll({ where: { providerID: 'AWS' } });

    return {
        regions: awsRegions.map(r => r.name),
        instances: awsInstanceTypes.map(i => i.name)
    };
}

main();