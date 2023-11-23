# Use an official Node runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Bundle your app's source code inside the Docker image
COPY . .

# Copy the startup script into the container
COPY start.sh .

# Make your app’s port available to the outside world
EXPOSE 3000

# Define the command to run your startup script
CMD ["./start.sh"]
