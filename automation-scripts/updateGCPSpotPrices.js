const path = require('path');
const { google } = require('googleapis');
const compute = google.compute('v1');

// Set the path to the JSON service account credentials file.
const credentialsPath = process.env.GOOGLE_APPLICATION_CREDENTIALS || path.resolve(__dirname, '..', 'GetSpot-Service-Account.json');

// Create a new Google Auth client.
const authClient = new google.auth.GoogleAuth({
  keyFilename: credentialsPath,
  scopes: ['https://www.googleapis.com/auth/cloud-platform'],
});

// Get the price history of spot instances for the e2-standard-4 instance type in the us-east1-a zone.
compute.spotPriceHistory.list({
  instanceType: 'e2-standard-4',
  zone: 'us-east1-a',
  startTime: '2023-10-20',
  endTime: '2023-10-22',
  auth: authClient,
}, (err, result) => {
  if (err) {
    console.log('Error getting spot instance price history:', err);
    return;
  }

  // The result object contains the price history of spot instances.
  console.log(result);
});
