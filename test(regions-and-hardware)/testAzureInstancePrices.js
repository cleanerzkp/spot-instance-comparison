const axios = require('axios');

// Define the instance types and regions you are interested in
const instanceTypes = ['B4ms', 'D4sv3'];
const regions = ['eastus2', 'westus3', 'polandcentral', 'qatarcentral', 'centralindia'];

async function fetchRecentPrices(instanceType, region) {
  const apiUrl = 'https://prices.azure.com/api/retail/prices';
  const params = {
    '$filter': `armRegionName eq '${region}' and armSkuName eq 'Standard_${instanceType}'`,
    '$top': 100
  };

  try {
    const response = await axios.get(apiUrl, { params: params });
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
    // Filter the items to only include those from the last 30 days
    return response.data.Items.filter(item => new Date(item.effectiveStartDate) >= thirtyDaysAgo);
  } catch (error) {
    console.error(`Error fetching prices for ${instanceType} in ${region}:`, error.message);
    return [];
  }
}
async function checkPopularInstancesAndRegions() {
  const instancePopularity = {};
  const regionPopularity = {};

  for (const instanceType of instanceTypes) {
    for (const region of regions) {
      const recentPrices = await fetchRecentPrices(instanceType, region);
      if (recentPrices.length > 0) {
        instancePopularity[instanceType] = (instancePopularity[instanceType] || 0) + recentPrices.length;

        // Check if the region already exists in regionPopularity, and initialize if not
        if (!regionPopularity[region]) {
          regionPopularity[region] = {
            totalInstances: 0,
            supportedInstanceTypes: [],
          };
        }

        regionPopularity[region].totalInstances += recentPrices.length;
        regionPopularity[region].supportedInstanceTypes.push(instanceType);
      }
    }
  }

  console.log('Instance Popularity:', instancePopularity);
  console.log('Region Popularity:', regionPopularity);
}



checkPopularInstancesAndRegions();