// Load environment variables from the .env file
require('dotenv').config({ path: '../.env' });

const axios = require('axios');

// Get the Google Cloud API key from the environment variables
const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;

// Function to fetch GCP Spot Instance SKUs
async function fetchGCPSpotInstances() {
  const endpoint = `https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus`;
  const params = {
    key: GOOGLE_API_KEY,
  };

  try {
    const response = await axios.get(endpoint, { params });
    const skus = response.data.skus || [];
    
    const preemptibleSkus = skus.filter(sku => sku.description && sku.description.includes('Preemptible'));
    
    if (preemptibleSkus.length > 0) {
      const formattedSkus = preemptibleSkus.map(sku => {
        const price = parseFloat(`${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.units}.${sku.pricingInfo[0].pricingExpression.tieredRates[0].unitPrice.nanos / 1e6}`).toFixed(5);
        return {
          Description: sku.description,
          Price: `$${price}`,
          Region: sku.serviceRegions[0],
          Timestamp: sku.pricingInfo[0].effectiveTime,
        };
      }).filter(sku => parseFloat(sku.Price.slice(1)) > 0);  // Filter out instances with a price of $0.00
      
      console.log('GCP Spot Instances:', formattedSkus);
    } else {
      console.error('No preemptible SKUs found.');
    }
  } catch (error) {
    console.error('Error fetching GCP Spot Instances:', error.message);
    if (error.response) {
      console.error('Error response data:', error.response.data);
    }
  }
}

// Call the function to start fetching data
fetchGCPSpotInstances();