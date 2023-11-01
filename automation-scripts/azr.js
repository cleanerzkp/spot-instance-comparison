const axios = require('axios');

async function getB4msPrice() {
  try {
    const response = await axios.get("https://prices.azure.com/api/retail/prices", {
      params: {
        "api-version": "2023-01-01-preview",
        "$filter": "armSkuName eq 'Standard_B4ms'",
        "$top": 1000
      }
    });
    const data = response.data;
    if (data && data.Items) {
      data.Items.forEach(item => {
        console.log(`Region: ${item.armRegionName}, Price: $${item.retailPrice}/hr`);
      });
    } else {
      console.log('No data found');
    }
  } catch (error) {
    console.error(`Error: ${error.message}`);
  }
}

getB4msPrice();