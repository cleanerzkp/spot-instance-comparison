const express = require('express');
const priceController = require('../controllers/priceController');
const router = express.Router();
router.get('/prices', priceController.getPrices);
module.exports = router;
