const runAlibabaScript = require('./updateAlibabaSpotPrices');
const runAWSScript = require('./updateAWSSpotPrices');
const runAzureScript = require('./updateAzureSpotPrices');
const runGCPScript = require('./updateGCPSpotPrices');

async function runAllScripts() {
    await runAlibabaScript();
    await runAWSScript();
    await runAzureScript();
    await runGCPScript();
}
console.log('Script is running:', new Date());


runAllScripts();
