// Load environment variables from .env file
require('dotenv').config({ path: '../.env' });
const axios = require('axios');

// Get Google API key and Project ID from environment variables
const GOOGLE_API_KEY = process.env.GOOGLE_API_KEY;
const GOOGLE_CLOUD_PROJECT = process.env.GOOGLE_CLOUD_PROJECT;
const YOUR_ZONE = 'us-central1-a';  // Change to your specific zone

// Define the URL for the Compute Engine API
const url = `https://compute.googleapis.com/compute/v1/projects/${GOOGLE_CLOUD_PROJECT}/zones/${YOUR_ZONE}/machineTypes?key=${GOOGLE_API_KEY}`;

// Send a GET request to the API
axios.get(url)
  .then(response => {
    const machineTypes = response.data.items.filter(item =>
      item.name === 'e2-standard-4' ||
      item.name === 'c2-standard-4'
    );
    console.log(machineTypes);
  })
  .catch(error => {
    console.error('Error: ', error);
  });