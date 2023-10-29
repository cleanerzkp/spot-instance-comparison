require('dotenv').config({ path: '../.env' });
process.env.AWS_ACCESS_KEY_ID = process.env.AWS_ACCESS_KEY;
process.env.AWS_SECRET_ACCESS_KEY = process.env.AWS_SECRET_KEY;


const { exec } = require('child_process');
const db = require('../models');
const SpotPricing = db.SpotPricing;
const InstanceType = db.InstanceType;
const Region = db.Region;

async function fetchAWSSpotPrices(instanceType, region) {
  return new Promise((resolve, reject) => {
    exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 1000 --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error for ${instanceType} in ${region}: ${error.message}`);
        return reject(error);
      }
      if (stderr) {
        console.error(`Stderr for ${instanceType} in ${region}: ${stderr}`);
        return reject(new Error(stderr));
      }
      const result = JSON.parse(stdout);
      return resolve(result);
    });
  });
}

async function saveOrUpdateSpotPrice(region, instanceType, date, price, grouping, providerID) {
  const dataToInsertOrUpdate = {
    name: `${instanceType}-general-purpose`,
    regionCategory: `AWS-${region}`,
    date,
    price,
    createdAt: new Date(),
    updatedAt: new Date(),
    grouping,
    providerID
  };
  
  const existingRecord = await SpotPricing.findOne({
    where: {
      region,
      instance_type: instanceType,
      date
    }
  });
  
  if (existingRecord) {
    await existingRecord.update(dataToInsertOrUpdate);
  } else {
    await SpotPricing.create(dataToInsertOrUpdate);
  }
}

async function fetchAndSaveAWSSpotPrices(region, instanceType, grouping, providerID) {
  try {
    const result = await fetchAWSSpotPrices(instanceType, region);
    const spotPriceHistory = result.SpotPriceHistory;

    if (!spotPriceHistory || spotPriceHistory.length === 0) {
      console.log(`No data available for ${instanceType} in ${region}.`);
      return;
    }

    const pricesByDay = {};
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
      await saveOrUpdateSpotPrice(region, instanceType, date, average, grouping, providerID);
    }
    
    console.log(`Price history is available for ${instanceType} in ${region}.`);
  } catch (error) {
    // Do nothing, this region-instance pair doesn't have history
  }
}

async function main() {
  try {
    const awsRegions = await Region.findAll({ where: { providerID: 'AWS' } });
    const awsInstanceTypes = await InstanceType.findAll({ where: { providerID: 'AWS' } });
    const regions = awsRegions.map(r => r.name);

    for (const instanceTypeObj of awsInstanceTypes) {
      const instanceType = instanceTypeObj.name;
      const grouping = instanceTypeObj.grouping;
      const providerID = "AWS"; // Replace with actual providerID if needed

      for (const region of regions) {
        await fetchAndSaveAWSSpotPrices(region, instanceType, grouping, providerID);
      }
    }
  } catch (error) {
    console.error(`Global error: ${error.message}`);
  }
}

main();