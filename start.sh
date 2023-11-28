#!/bin/bash

# Wait for the database service to be ready (adjust the host and port)
echo "Waiting for DB to be ready..."
while ! nc -z db 5432; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "DB is up - executing command"

# Run migrations and seeds
npm run db:migrate
npm run db:seed:all

# Start the application
node app.js
