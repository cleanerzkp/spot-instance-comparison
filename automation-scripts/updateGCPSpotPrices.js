const { google } = require('googleapis');
const path = require('path');

// Set the GOOGLE_APPLICATION_CREDENTIALS environment variable to the path of the JSON file.
process.env.GOOGLE_APPLICATION_CREDENTIALS = path.resolve(__dirname, '..', 'GetSpot-Service-Account.json');

// Create a new Google Cloud Auth Library object.
const auth = new google.auth.GoogleAuth();

// Create a new Google Cloud Compute Engine API client.
const compute = new google.compute({
  version: 'v1',
  auth: auth,
});
