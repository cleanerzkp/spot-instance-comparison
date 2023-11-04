require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;

const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;
const { exec } = require('child_process');

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AWS' } });
  const regions = await Region.findAll({ where: { providerID: 'AWS' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => r.name)
  };  
}

async function fetchAWSSpotPrices(instanceType, region) {
  return new Promise((resolve, reject) => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(today.getDate() + 1);  

    exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType.name} --region ${region} --start-time ${today.toISOString()} --end-time ${tomorrow.toISOString()} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
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
  const currentTime = new Date();

  for (const date in dailyAverages) {
    const formattedDate = new Date(date);
    formattedDate.setHours(0, 0, 0, 0);  
    const existingRecord = await SpotPricing.findOne({
        where: {
            name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
            regionCategory: `AWS-${region}`,
            date: formattedDate
        }
    });

    if (existingRecord) {
        await existingRecord.update({ price: dailyAverages[date], timestamp: currentTime });
    } else {
        await SpotPricing.create({
            name: `${instanceTypeObj.name}-${instanceTypeObj.category}`,
            regionCategory: `AWS-${region}`,
            date: formattedDate,
            price: dailyAverages[date],
            timestamp: currentTime,
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

async function runAWSScript() {
  await main();
}

module.exports = runAWSScript;