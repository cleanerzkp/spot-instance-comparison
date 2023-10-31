const { GoogleAuth } = require('google-auth-library');
const path = require('path');

async function authenticate() {
  const credentialsPath = path.resolve(__dirname, '..', 'GetSpot-Service-Account.json');

  const auth = new GoogleAuth({
    keyFilename: credentialsPath,
    scopes: ['https://www.googleapis.com/auth/cloud-platform'],
  });

  try {
    const authClient = await auth.getClient();
    console.log('Authentication successful.');
  } catch (error) {
    console.error('Error:', error.message);
  }
}

authenticate();