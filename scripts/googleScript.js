require('dotenv').config({ path: '../.env' }); 
const axios = require('axios');
const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;

async function fetchGCPSpotPrices() {
    try {
        const response = await axios.get(`https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus?key=${GOOGLE_API_KEY}`);

        if (response.status === 200) {
            console.log('GCP Spot Prices:', response.data);
        } else {
            console.error(`Request failed with status ${response.status}`);
        }
    } catch (error) {
        console.error('Error fetching GCP Spot Prices:', error.message);
    }
}

// Call the function to start fetching data
fetchGCPSpotPrices();