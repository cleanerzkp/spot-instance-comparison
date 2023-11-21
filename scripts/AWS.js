require('dotenv').config({ path: '../.env' });

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

async function calculateDailyAverage(instanceType, region) {
    try {
        const result = await fetchAWSSpotPrices(instanceType, region);
        const spotPriceHistory = result.SpotPriceHistory;

        // Group the spot prices by day
        const pricesByDay = {};
        spotPriceHistory.forEach(spotPrice => {
            const date = new Date(spotPrice.Timestamp).toISOString().split('T')[0];  // Extract the date part of the timestamp
            if (!pricesByDay[date]) {
                pricesByDay[date] = [];
            }
            pricesByDay[date].push(parseFloat(spotPrice.SpotPrice));
        });

        // Calculate the average price for each day
        const dailyAverages = {};
        for (const date in pricesByDay) {
            const prices = pricesByDay[date];
            const sum = prices.reduce((acc, price) => acc + price, 0);
            const average = sum / prices.length;
            dailyAverages[date] = average;
        }

        console.log(`Daily Average Prices for ${instanceType} in ${region}:`, dailyAverages);
    } catch (error) {
        console.error('Error calculating daily average:', error.message);
    }
}

// Define the instances and regions to fetch pricing for
const instances = ['t4g.xlarge', 'c6a.xlarge'];
const regions = ['us-east-1', 'eu-west-1'];

// Calculate daily average price for each combination of instance type and region
instances.forEach(instanceType => {
    regions.forEach(region => {
        calculateDailyAverage(instanceType, region);
    });
});