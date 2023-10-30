require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const db = require('../models');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;
const { exec } = require('child_process');

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AWS' } });
  const regions = await Region.findAll({ where: { providerID: 'AWS' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category })),
    regions: regions.map(r => r.name)
  };
}

async function fetchAWSSpotPrices(instanceType, region) {
  return new Promise((resolve, reject) => {
    exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType.name} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
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

async function insertIntoDB(dailyAverages, instanceTypeObj, region) {
  for (const date in dailyAverages) {
    const existingRecord = await SpotPricing.findOne({
      where: {
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
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
        name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
        regionCategory: `AWS-${region}`,
        date: new Date(date),
        price: price,
        timestamp: new Date(),
        grouping: instanceTypeObj.grouping,
        providerID: 'AWS'
      });
    }
  }
}

async function calculateDailyAverage(instanceTypeObj, region) {
  try {
    const result = await fetchAWSSpotPrices(instanceTypeObj, region);
    const spotPriceHistory = result.SpotPriceHistory;

    if (spotPriceHistory.length === 0) {
      console.log(`No prices available for ${instanceTypeObj.name} in ${region}`);
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

    await insertIntoDB(dailyAverages, instanceTypeObj, region);
  } catch (error) {
    console.error('Error calculating daily average:', error.message);
  }
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  instanceTypes.forEach(instanceTypeObj => {
    regions.forEach(region => {
      calculateDailyAverage(instanceTypeObj, region);
    });
  });
}

main();