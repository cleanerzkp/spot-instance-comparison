const runAlibabaScript = require('./updateAlibabaSpotPrices');

async function runAllScripts() {
    await runAlibabaScript();
    // ... run other scripts ...
}

runAllScripts();
