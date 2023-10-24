require('dotenv').config({ path: '../.env' });
const axios = require('axios');

const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;

const regionsToCheck = ['us-central1', 'us-west3'];
const instanceTypesToCheck = ['e2-standard-4'];

async function fetchGCPSpotInstances() {
  const endpoint = `https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus?key=${GOOGLE_API_KEY}`;
  const regionCount = {};
  const typeCount = {};
  const topSKUs = {
    Compute: [],
    Network: [],
    Storage: []
  };

  try {
    const response = await axios.get(endpoint);
    const skus = response.data.skus || [];

    const preemptibleSkus = skus.filter(sku => sku.description && sku.description.includes('Preemptible'));

    preemptibleSkus.forEach(sku => {
      const region = sku.serviceRegions[0];
      const type = sku.category.resourceFamily;
      const description = sku.description;

      if (!regionCount[region]) regionCount[region] = 0;
      if (!typeCount[type]) typeCount[type] = 0;

      regionCount[region]++;
      typeCount[type]++;

      if (topSKUs[type]) {
        topSKUs[type].push(description);
      }
    });

    const sortedRegionCounts = Object.entries(regionCount).sort(([, a], [, b]) => b - a);
    const sortedTypeCounts = Object.entries(typeCount).sort(([, a], [, b]) => b - a);

    console.log('Preemptible SKU counts by Region (Descending):');
    sortedRegionCounts.forEach(([region, count]) => {
      console.log(`${region}: ${count}`);
    });

    console.log('\nPreemptible SKU counts by Instance Type (Descending):');
    sortedTypeCounts.forEach(([type, count]) => {
      console.log(`${type}: ${count}`);
    });

    console.log('\nTop 5 Preemptible SKUs of each Instance Type (Descending):');
    Object.keys(topSKUs).forEach(type => {
      const uniqueTopSKUs = [...new Set(topSKUs[type])];
      const top5 = uniqueTopSKUs.slice(0, 5);
      console.log(`${type}:`);
      top5.forEach((sku, index) => {
        console.log(`  ${index + 1}. ${sku}`);
      });
    });

    const filteredSkus = preemptibleSkus.filter(sku =>
      regionsToCheck.includes(sku.serviceRegions[0]) &&
      instanceTypesToCheck.some(type => sku.description.includes(type))
    );

    if (filteredSkus.length > 0) {
      const formattedSkus = filteredSkus.map(sku => {
        const price = parseFloat(`${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.units}.${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.nanos / 1e6}`).toFixed(5);
        return {
          Description: sku.description,
          Price: `$${price}`,
          Region: sku.serviceRegions[0],
          Timestamp: sku.pricingInfo[0].effectiveTime,
        };
      });

      console.log('\nGCP Spot Instances in Specified Regions and Types:', formattedSkus);
    } else {
      console.log('No matching preemptible SKUs found.');
    }

  } catch (error) {
    console.log('Error fetching GCP Spot Instances:', error.message);
    if (error.response) {
      console.log('Error response data:', error.response.data);
    }
  }
}

fetchGCPSpotInstances();