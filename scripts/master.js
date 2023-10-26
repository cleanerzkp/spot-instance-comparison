const { runAlibabaScript } = require('./Alibaba');
// Import other provider scripts here, e.g.,
// const { runAwsScript } = require('./aws');
// const { runGcpScript } = require('./gcp');
// const { runAzureScript } = require('./azure');

const runAllScripts = async () => {
  await runAlibabaScript();
  // Run other provider scripts here, e.g.,
  // await runAwsScript();
  // await runGcpScript();
  // await runAzureScript();
};

runAllScripts()
  .then(() => console.log('All data saved successfully'))
  .catch(err => console.error('Error saving data:', err));
// pobierz dane
// zmappuj na obietk bazodanowy
// nadaj grupy & region 
// zapisz do basy insdert -> 
