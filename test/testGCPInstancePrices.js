require('dotenv').config({ path: '../.env' });

const axios = require('axios');

const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;

const regionsToCheck = ['us-central1', 'us-west1'];
const instanceTypesToCheck = ['n1-standard-4'];


async function fetchGCPSpotInstances() {
  const endpoint = `https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus?key=${GOOGLE_API_KEY}`;

  try {
    const response = await axios.get(endpoint);
    const skus = response.data.skus || [];

    const preemptibleSkus = skus.filter(sku => sku.description && sku.description.includes('Preemptible'));
    
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
      }).filter(sku => parseFloat(sku.Price.slice(1)) > 0);
      
      console.log('GCP Spot Instances:', formattedSkus);
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