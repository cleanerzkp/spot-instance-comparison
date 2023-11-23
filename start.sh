#!/bin/bash

# Run Sequelize migrations
npx sequelize-cli db:migrate --config ./config/dbConfig.json

# Start your application
node app.js
