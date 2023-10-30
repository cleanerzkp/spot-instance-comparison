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
      // Debug logs to confirm environment variables
      console.log(`Using AWS_ACCESS_KEY_ID: ${process.env.AWS_ACCESS_KEY_ID}`);
      console.log(`Using AWS_SECRET_ACCESS_KEY: ${process.env.AWS_SECRET_ACCESS_KEY}`);
      
      // The AWS CLI command to fetch spot prices
      const cmd = `aws ec2 describe-spot-price-history --instance-types ${instanceType} --region ${region} --max-items 10 --product-descriptions "Linux/UNIX" --output json`;
      
      // Debug log to show the command being executed
      console.log(`Executing command: ${cmd}`);
  
      exec(cmd, (error, stdout, stderr) => {
        if (error) {
          console.error(`Error for ${instanceType} in ${region}: ${error.message}`);
          return reject(error);
        }
        if (stderr) {
          console.error(`Stderr for ${instanceType} in ${region}: ${stderr}`);
          return reject(new Error(stderr));
        }
        try {
          const result = JSON.parse(stdout);
          return resolve(result);
        } catch (parseError) {
          console.error(`JSON parse error for ${instanceType} in ${region}: ${parseError.message}`);
          return reject(parseError);
        }
      });
    });
  }

async function saveOrUpdateSpotPrice(pricingID, name, regionCategory, date, price, timestamp, grouping, providerID) {
  const existingRecord = await SpotPricing.findOne({
    where: {
      pricingID,
      name,
      regionCategory,
      date
    }
  });

  const dataToInsertOrUpdate = {
    pricingID,
    name,
    regionCategory,
    date,
    price,
    timestamp: new Date(),
    createdAt: new Date(),
    updatedAt: new Date(),
    grouping,
    providerID
  };

  if (existingRecord) {
    await existingRecord.update(dataToInsertOrUpdate);
  } else {
    await SpotPricing.create(dataToInsertOrUpdate);
  }
}

async function fetchAndSaveAWSSpotPrices(region, instanceTypeObj) {
  const { id: pricingID, name: instanceType, category, grouping, providerID } = instanceTypeObj;
  const regionCategory = `AWS-${region}`;
  const name = `${instanceType}-${category}`;

  const result = await fetchAWSSpotPrices(instanceType, region);
  const spotPriceHistory = result.SpotPriceHistory;

  if (!spotPriceHistory || spotPriceHistory.length === 0) {
    console.log(`No data available for ${name} in ${region}.`);
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
    const timestamp = new Date();
    await saveOrUpdateSpotPrice(pricingID, name, regionCategory, date, average, timestamp, grouping, providerID);
  }

  console.log(`Price history is available for ${name} in ${region}.`);
}

async function main() {
  const awsRegions = await Region.findAll({ where: { providerID: 'AWS' } });
  const awsInstanceTypes = await InstanceType.findAll({ where: { providerID: 'AWS' } });
  const regions = awsRegions.map(r => r.name);

  for (const instanceTypeObj of awsInstanceTypes) {
    for (const region of regions) {
      await fetchAndSaveAWSSpotPrices(region, instanceTypeObj);
    }
  }
}

main();
