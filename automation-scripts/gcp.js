require('dotenv').config();
const axios = require('axios');

const apiKey = process.env.GOOGLE_API_KEY; // Ensure your .env file contains the correct API key

const query = {
  query: `{
    products(filter: {
      vendorName: "gcp",
      service: "Compute Engine",
      region: "europe-central2",
      sku: "6F81-5844-456A"
    }) {
      prices {
        USD
      }
    }
  }`
};

axios.post('https://pricing.api.infracost.io/graphql', query, {
  headers: {
    'Content-Type': 'application/json',
    'X-Api-Key': apiKey
  }
})
.then(response => {
  console.log(JSON.stringify(response.data, null, 2));
})
.catch(error => {
  console.error('Error:', error);
});
