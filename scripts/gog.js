require('dotenv').config();
const { google } = require('googleapis');
const { GoogleAuth } = require('google-auth-library');

async function main() {
  const auth = new GoogleAuth({
    keyFile: '../GetSpot-Service-Account.json',
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  });

  const authClient = await auth.getClient();
  const cloudbilling = google.cloudbilling('v1');
  const request = {
    auth: authClient,
    parent: 'services/6F81-5844-456A',
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

  console.log(JSON.stringify(spotSkus, null, 2));
}

main().catch(console.error);