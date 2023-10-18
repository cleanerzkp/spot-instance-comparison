require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const { exec } = require('child_process');

async function fetchAWSSpotPrices() {
    return new Promise((resolve, reject) => {
        exec('aws ec2 describe-spot-price-history --region us-east-1 --max-items 20', (error, stdout, stderr) => {
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

// Function to filter spot prices for Linux/UNIX instances
function filterLinuxUnixPrices(spotPrices) {
    return spotPrices.filter(spotPrice => spotPrice.ProductDescription === 'Linux/UNIX');
}

// Call the function to start fetching data
fetchAWSSpotPrices()
    .then(result => {
        const linuxUnixPrices = filterLinuxUnixPrices(result.SpotPriceHistory);
        console.log('Linux/UNIX Spot Prices:', linuxUnixPrices);
    })
    .catch(error => {
        console.error('Error fetching AWS Spot Prices:', error.message);
    });
