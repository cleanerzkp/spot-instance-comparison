const express = require('express');
const db = require('./models'); 

const app = express();

app.use(express.json());

app.get('/providers', async (req, res) => {
  const providers = await db.CloudProvider.findAll();
  res.json(providers);
});

db.sequelize.sync()
  .then(() => {
    const port = 3000;
    app.listen(port, () => {
      console.log(`Server running on http://localhost:${port}`);
      console.log('Database synced');
    });
  })
  .catch((error) => {
    console.log('Error syncing database', error);
  });