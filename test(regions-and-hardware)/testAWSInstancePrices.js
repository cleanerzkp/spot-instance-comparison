require('dotenv').config({ path: '../.env' });

const { exec } = require('child_process');

// Manually define the instances and regions
const instances = ['t4g.xlarge', 'c6a.xlarge'];
const regions = ['us-east-1', 'eu-west-1'];

async function fetchAWSSpotPrices(instanceType, region) {
    return new Promise((resolve, reject) => {
        exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
            if (error || stderr) {
                console.error(`Error: ${error?.message || stderr}`);
                return reject(new Error(error?.message || stderr));
            }

            // Parse the CLI output to JSON
            const result = JSON.parse(stdout);
            return resolve(result);
        });
    });
}

async function checkAWSSpotPriceHistory(instanceType, region) {
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

// Check price history for each instance type and region combination
instances.forEach(instanceType => {
    regions.forEach(region => {
        checkAWSSpotPriceHistory(instanceType, region);
    });
});