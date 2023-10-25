// Sample Alibaba fetched data
const alibabaData = [
    {
      Region: "us-west-1",
      InstanceType: "ecs.g6a.xlarge",
      SpotPrice: 0.025,
      OriginPrice: 0.186,
      ZoneId: "us-west-1a",
      Timestamp: "2023-10-25T05:26:10Z"
    },
    // ... add more items
  ];
  
  function mapAlibabaDataToTable(alibabaData) {
    return alibabaData.map((entry, index) => ({
      pricingID: index + 1, // You might have your own logic to generate this ID
      name: entry.InstanceType,
      regionCategory: `Alibaba-${entry.Region}`,
      date: entry.Timestamp, // Transform to your desired format
      price: entry.SpotPrice,
      timestamp: entry.Timestamp, // Transform to your desired format
      createdAt: new Date().toISOString(), // Current timestamp
      updatedAt: new Date().toISOString(), // Current timestamp
      grouping: entry.ZoneId,
      providerID: "Alibaba" // or your specific provider ID for Alibaba
    }));
  }
  
  const standardizedTableData = mapAlibabaDataToTable(alibabaData);
  console.log(standardizedTableData);
  