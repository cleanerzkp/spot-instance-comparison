require('dotenv').config();
const axios = require('axios');

// Set up your Google Cloud credentials and SKU ID
const API_KEY = process.env.GOOGLE_API_KEY; // Ensure you have GOOGLE_API_KEY in your .env file
const SKU_ID = '4FA8-5F47-948C'; // Replace with your specific SKU ID

// Define the Google Cloud Billing API URL
const billingUrl = `https://cloudbilling.googleapis.com/v1/services/6F81-5844-456A/skus/${SKU_ID}?key=${API_KEY}`;

// Function to check SKU pricing
async function checkSKUPrice() {
  try {
    const response = await axios.get(billingUrl);
    if (response.data.pricingInfo && response.data.pricingInfo.length > 0) {
      // Pricing info exists, output the pricing data
      console.log('Pricing info:', response.data.pricingInfo);
    } else {
      // No pricing info available for this SKU
      console.log('No pricing information available for this SKU.');
    }
  } catch (error) {
    console.error('Error fetching SKU pricing:', error);
  }
}

// Run the check
checkSKUPrice();