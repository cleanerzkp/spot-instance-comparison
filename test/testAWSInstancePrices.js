require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');

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
        console.error('Error checking price history:', error.message);
    }
}

// Define the instances and regions to check pricing history for
const instances = ['t4g.xlarge', 'c6a.xlarge'];
const regions = ['us-east-1', 'eu-west-1'];

// Check price history for each combination of instance type and region
instances.forEach(instanceType => {
    regions.forEach(region => {
        checkPriceHistory(instanceType, region);
    });
});