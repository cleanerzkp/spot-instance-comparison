const db = require('../testDbConnection');
const SpotPricing = db.SpotPricing;
const { exec } = require('child_process');
const cron = require('node-cron');

// Function to fetch AWS spot prices
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

// Function to insert data into the database
async function insertIntoDB(dailyAverages, instanceType, region) {
  const groupingMap = {
    't4g.xlarge': 'GP1',
    'c6a.xlarge': 'CO1'
  };

  for (const date in dailyAverages) {
    const existingRecord = await SpotPricing.findOne({
      where: {
        name: `${instanceType}-general-purpose`,
        date: new Date(date),
        regionCategory: `AWS-${region}`
      }
    });

    const today = new Date().toISOString().split('T')[0];
    if (existingRecord && date !== today) {
      continue;
    }

    const price = dailyAverages[date];

    if (existingRecord && date === today) {
      await existingRecord.update({ price: price });
    } else {
      await SpotPricing.create({
        name: `${instanceType}-general-purpose`,
        regionCategory: `AWS-${region}`,
        date: new Date(date),
        price: price,
        timestamp: new Date(),
        grouping: groupingMap[instanceType],
        providerID: 'AWS'
      });
    }
  }
}

// Function to calculate daily average of spot prices
async function calculateDailyAverage(instanceType, region) {
  try {
    const result = await fetchAWSSpotPrices(instanceType, region);
    const spotPriceHistory = result.SpotPriceHistory;
    
    if (spotPriceHistory.length === 0) {
      console.log(`No prices available for ${instanceType} in ${region}`);
      return;
    }

    const pricesByDay = {};
    const dailyAverages = {};

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
      dailyAverages[date] = average;
    }

    await insertIntoDB(dailyAverages, instanceType, region);

  } catch (error) {
    console.error('Error calculating daily average:', error.message);
  }
}

// Scheduled task to run every day at 12:00 AM
cron.schedule('0 0 * * *', function() {
  const instances = ['t4g.xlarge', 'c6a.xlarge'];
  const regions = ['us-east-1', 'eu-west-1'];

  instances.forEach(instanceType => {
    regions.forEach(region => {
      calculateDailyAverage(instanceType, region);
    });
  });
});
