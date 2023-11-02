const axios = require('axios');

async function getInstancePrice(instanceType) {
  try {
    const response = await axios.get("https://prices.azure.com/api/retail/prices", {
      params: {
        "api-version": "2023-01-01-preview",
        "$filter": `armSkuName eq 'Standard_${instanceType}'`,
        "$top": 1000
      }
    });
    const data = response.data;
    if (data && data.Items && data.Items.length > 0) {
      data.Items.forEach(item => {
        console.log(`Instance Type: ${instanceType}, Region: ${item.armRegionName}, Price: $${item.retailPrice}/hr`);
      });
    } else {
      console.log(`No price data found for Standard_${instanceType}`);
    }
  } catch (error) {
    console.error(`Error fetching prices for Standard_${instanceType}: ${error.message}`);
  }
}
getInstancePrice();