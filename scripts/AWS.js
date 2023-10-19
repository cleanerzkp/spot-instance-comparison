require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');

async function fetchAWSSpotPrices() {
    return new Promise((resolve, reject) => {
        exec('aws ec2 describe-spot-price-history --region us-east-1 --max-items 10 --product-descriptions "Linux/UNIX" --query "SpotPriceHistory[*].{InstanceType:InstanceType, SpotPrice:SpotPrice, Timestamp:Timestamp}"', (error, stdout, stderr) => {
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

// Call the function to start fetching data
fetchAWSSpotPrices()
    .then(result => {
        console.log('Linux/UNIX Spot Prices:', result);
    })
    .catch(error => {
        console.error('Error fetching AWS Spot Prices:', error.message);
    });