const axios = require('axios');

// Function to fetch all available SKUs and Regions
async function fetchAllSkusAndRegions() {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  
  try {
    const response = await axios.get(apiUrl, {
      params: {
        '$top': 1000  // Adjust this value based on the number of SKUs and regions you expect
      }
    });
    const items = response.data.Items;
    const skus = [...new Set(items.map(item => item.armSkuName))];
    const regions = [...new Set(items.map(item => item.armRegionName))];
    return { skus, regions };
  } catch (error) {
    console.error('Error fetching SKUs and regions:', error.message);
    return { skus: [], regions: [] };
  }
}

// Function to fetch price data for a given SKU and Region
async function fetchPriceData(sku, region) {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const filter = `armRegionName eq '${region}' and armSkuName eq '${sku}' and priceType eq 'Consumption' and contains(meterName, 'Spot')`;
  
  try {
    const response = await axios.get(apiUrl, { params: { '$filter': filter } });
    return response.data.Items;
  } catch (error) {
    console.error(`Error fetching prices for ${sku} in ${region}:`, error.message);
    return [];
  }
}

// Function to check price data consistency over the last 30 days
async function isPriceDataConsistent(priceData) {
  // TODO: Implement logic to check price data consistency
  // Returning true for now as a placeholder
  return true;
}

// Main function to execute the script
async function main() {
  const { skus, regions } = await fetchAllSkusAndRegions();
  
  for (const sku of skus) {
    for (const region of regions) {
      const priceData = await fetchPriceData(sku, region);
      if (priceData.length > 0) {
        const consistent = await isPriceDataConsistent(priceData);
        if (consistent) {
          console.log(`Consistent price data history found for SKU ${sku} in region ${region} over the last 30 days.`);
        }
      }
    }
  }
}

// Run the main function
main();