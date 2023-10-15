const SpotInstancePricing = require('../../models/spotinstanceprice');
exports.getPrices = async (req, res) => {
  try {
    const prices = await SpotInstancePricing.findAll();
    res.json(prices);
  } catch (error) {
    res.status(500).send(error.message);
  }
};
