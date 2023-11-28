#!/bin/bash
# Run migrations and seeds
npx sequelize-cli db:migrate
npx sequelize-cli db:seed:all

# Start the application
node app.js

