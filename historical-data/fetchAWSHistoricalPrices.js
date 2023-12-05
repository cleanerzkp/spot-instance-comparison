require('dotenv').config({ path: '../.env' });

const db = require('../models');
const { SpotPricing, InstanceType, Region } = db;
const { exec } = require('child_process');

async function fetchData() {
  const instanceTypes = await InstanceType.findAll({ where: { providerID: 'AWS' } });
  const regions = await Region.findAll({ where: { providerID: 'AWS' } });

  return {
    instanceTypes: instanceTypes.map(it => ({ name: it.name, category: it.category, grouping: it.grouping })),
    regions: regions.map(r => ({ name: r.name, standardizedRegion: r.standardizedRegion }))
  };
}

async function fetchAWSSpotPrices(instanceType, region) {
  return new Promise((resolve, reject) => {
    const endTime = new Date();
    const startTime = new Date();
    startTime.setDate(startTime.getDate() - 30);

    const startTimeFormatted = startTime.toISOString().split('.')[0] + 'Z';
    const endTimeFormatted = endTime.toISOString().split('.')[0] + 'Z';

    exec(`aws ec2 describe-spot-price-history --instance-types ${instanceType.name} --region ${region.name} --start-time "${startTimeFormatted}" --end-time "${endTimeFormatted}" --product-descriptions "Linux/UNIX" --output json`, (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        return reject(error);
      }
      if (stderr) {
        console.error(`Stderr: ${stderr}`);
        return reject(new Error(stderr));
      }
      const result = JSON.parse(stdout);
      return resolve(result.SpotPriceHistory);
    });
  });
}

async function insertIntoDB(spotPriceHistory, instanceTypeObj, region) {
  for (const spotPrice of spotPriceHistory) {
    const existing = await SpotPricing.findOne({
      where: {
        name: instanceTypeObj.name,
        regionName: region.standardizedRegion,
        date: new Date(spotPrice.Timestamp)
      }
    });

    if (!existing) {
      await SpotPricing.create({
        name: instanceTypeObj.name,
        regionName: region.standardizedRegion,
        date: new Date(spotPrice.Timestamp),
        price: parseFloat(spotPrice.SpotPrice),
        timestamp: new Date(),
        grouping: instanceTypeObj.grouping,
        providerID: 'AWS'
      });
    } else {
      console.log('Record already exists, skipping');
    }
  }
}

async function processSpotPrices(instanceTypeObj, region) {
  try {
    const spotPriceHistory = await fetchAWSSpotPrices(instanceTypeObj, region);
    if (spotPriceHistory.length === 0) {
      console.log(`No prices available for ${instanceTypeObj.name} in ${region.name}`);
      return;
    }

    await insertIntoDB(spotPriceHistory, instanceTypeObj, region);
  } catch (error) {
    console.error('Error processing spot prices:', error.message);
  }
}

async function main() {
  const { instanceTypes, regions } = await fetchData();
  for (const instanceTypeObj of instanceTypes) {
    for (const region of regions) {
      await processSpotPrices(instanceTypeObj, region);
    }
  }
}

main();