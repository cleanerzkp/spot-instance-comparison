const axios = require('axios');

async function fetchAzureSpotPrices() {
  try {
    const response = await axios.get('https://prices.azure.com/api/retail/prices', {
      params: {
        "$filter": "armRegionName eq 'eastus' and productFamily eq 'Virtual Machines' and priceType eq 'Spot' and (armSkuName eq 'Standard_D2s_v3' or armSkuName eq 'Standard_E2s_v3' or armSkuName eq 'Standard_F2s_v2')"
      }
    });
    return response.data;
  } catch (error) {
    console.error(error);
  }
}

module.exports = fetchAzureSpotPrices;