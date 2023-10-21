require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');

async function fetchAWSSpotPrices(instanceType, region) {
    return new Promise((resolve, reject) => {
        exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 10 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
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

// Define the instances and regions to fetch pricing for
const instances = ['t4g.xlarge', 'c6a.xlarge'];
const regions = ['us-east-1', 'eu-west-1'];

// Fetch pricing data for each combination of instance type and region
instances.forEach(instanceType => {
    regions.forEach(region => {
        fetchAWSSpotPrices(instanceType, region)
            .then(result => {
                console.log(`Spot Prices for ${instanceType} in ${region}:`, result);
            })
            .catch(error => {
                console.error('Error fetching AWS Spot Prices:', error.message);
            });
    });
});