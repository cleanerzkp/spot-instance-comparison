require('dotenv').config({ path: '../.env' });
const axios = require('axios');

const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;
const regionsToCheck = ['us-central1', 'asia-east1'];
const instanceTypesToCheck = ['e2-standard-4', 'c2-standard-4'];

async function fetchGCPSpotInstances() {
  const endpoint = `https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus?key=${GOOGLE_API_KEY}`;

  try {
    const response = await axios.get(endpoint);
    console.log('Raw Response:', response.data);

    if (!response.data || !response.data.skus) {
      console.log('Unexpected response structure.');
      return;
    }

    const skus = response.data.skus;
    console.log('All SKUs:', skus);

    const filteredSkus = skus.filter(sku =>
      regionsToCheck.includes(sku.serviceRegions[0]) &&
      instanceTypesToCheck.some(type => sku.description.includes(type)) &&
      sku.category.usageType === 'Preemptible'
    );

    if (filteredSkus.length > 0) {
      const formattedSkus = filteredSkus.map(sku => {
        const price = parseFloat(`${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.units}.${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.nanos / 1e9}`).toFixed(5);
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
    console.log('Error:', error.message);
    if (error.response) {
      console.log('Error response data:', error.response.data);
    }
  }
}

fetchGCPSpotInstances();