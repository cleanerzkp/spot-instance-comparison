require('dotenv').config();
const { google } = require('googleapis');
const { GoogleAuth } = require('google-auth-library');
const path = require('path');
const fs = require('fs');

async function main() {
  // Load client secrets from a file, and setup the GoogleAuth client
  const credentialsPath = path.resolve(__dirname, '..', 'GetSpot-Service-Account.json');
  const credentials = JSON.parse(fs.readFileSync(credentialsPath, 'utf8'));
  const auth = new GoogleAuth({
    credentials,
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  });

  // Obtain client for making requests
  const authClient = await auth.getClient();
  const cloudbilling = google.cloudbilling('v1');
  const request = {
    auth: authClient,
    parent: `projects/${credentials.project_id}/services/compute.googleapis.com`,
    pageSize: 100,
  };

  let skus = [];
  let nextPageToken;
  const targetInstances = ['e2-standard-4', 'c2-standard-4'];

  do {
    if (nextPageToken) {
      request.pageToken = nextPageToken;
    }

    const result = await cloudbilling.services.skus.list(request);
    skus = skus.concat(result.data.skus || []);
    nextPageToken = result.data.nextPageToken;

  } while (nextPageToken);

  const spotSkus = skus.filter(sku => {
    return sku.category && sku.category.usageType === 'Preemptible' &&
           targetInstances.some(instance => sku.description.includes(instance));
  });

  // Format the output
  spotSkus.forEach(sku => {
    console.log(`Instance Type: ${sku.description}`);
    if (sku.pricingInfo && sku.pricingInfo.length > 0) {
      const pricingExpression = sku.pricingInfo[0].pricingExpression;
      if (pricingExpression && pricingExpression.tieredRates && pricingExpression.tieredRates.length > 0) {
        const unitPrice = pricingExpression.tieredRates[0].unitPrice;
        console.log(`Price: ${unitPrice.currencyCode} ${unitPrice.units}.${unitPrice.nanos / 1e6}`);
      }
    }
    console.log('---');
  });
}

main().catch(console.error);