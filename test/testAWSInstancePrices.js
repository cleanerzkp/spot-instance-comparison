require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');
const db = require('../models');

// List of AWS available regions (update this list as needed)
const availableAwsRegions = ['us-east-1', 'us-west-2', 'eu-central-1', 'ap-south-1']; // ... Add more

async function fetchAWSSpotPrices(instanceType, region) {
    return new Promise((resolve, reject) => {
        if (!availableAwsRegions.includes(region)) {
            return reject(new Error(`Invalid AWS region: ${region}`));
        }
        const cmd = `aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`.trim();
        

        exec(cmd, (error, stdout, stderr) => {
            if (error || stderr) {
                return reject(new Error(`Error checking price history for ${instanceType} in ${region}: ${error?.message || stderr}`));
            }
            const result = JSON.parse(stdout);
            return resolve(result);
        });
    });
}

async function checkPriceHistory(instanceType, region) {
    try {
        const result = await fetchAWSSpotPrices(instanceType, region);
        const spotPriceHistory = result.SpotPriceHistory;
        if (spotPriceHistory.length > 0) {
            console.log(`Price history is available for ${instanceType} in ${region}.`);
        } else {
            console.log(`No price history found for ${instanceType} in ${region}.`);
        }
    } catch (error) {
        console.error(`Error for ${instanceType} in ${region}: ${error.message}`);
    }
}

async function fetchRegionsAndInstanceTypes() {
    const awsRegions = await db.Region.findAll({
        attributes: ['name'],
        where: { providerID: 'AWS' }
    });
    const awsInstanceTypes = await db.InstanceType.findAll({
        attributes: ['name'],
        where: { providerID: 'AWS' }
    });

    return {
        regions: awsRegions.map(r => r.name),
        instances: awsInstanceTypes.map(i => i.name)
    };
}

async function main() {
    try {
        const { regions, instances } = await fetchRegionsAndInstanceTypes();

        for (const instanceType of instances) {
            for (const region of regions) {
                await checkPriceHistory(instanceType, region);
            }
        }
    } catch (error) {
        console.error(`Global error: ${error.message}`);
    }
}

main();