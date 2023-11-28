# Use Node.js version 14
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Commands to run the Sequelize migrations and seeders, then start the application
CMD npx sequelize-cli db:migrate && npx sequelize-cli db:seed:all && node app.js
