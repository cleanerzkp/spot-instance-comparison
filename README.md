# Spot Instance Price Comparison Project

## Project Overview
This project aims to monitor and compare the prices of spot instances offered by various cloud service providers, with a focus on demonstrating cost-effectiveness. The project retrieves, stores, and analyzes the pricing data of spot instances from different cloud providers like AWS, Azure, Google Cloud, and Alibaba. It is designed to run in a Unix environment and utilizes a structured database to facilitate data comparison.

## Table of Contents

1. [Setup and Installation](#setup-and-installation)
2. [Directory Structure](#directory-structure)
3. [Database Configuration](#database-configuration)
4. [Data Retrieval Scripts](#data-retrieval-scripts)
5. [API Endpoints](#api-endpoints)
6. [Testing](#testing)
7. [Monitoring and Maintenance](#monitoring-and-maintenance)
8. [Docker Configuration](#docker-configuration)
9. [Logs](#logs)
10. [Contributing](#contributing)
11. [License](#license)

## Setup and Installation

1. **Prerequisites:**
   - Node.js v14.x or later.
   - Docker and Docker Compose (if using Docker for deployment).
   - Access credentials for AWS, Azure, Google Cloud, and Alibaba.

2. **Installation:**
   - Clone the repository: `git clone https://github.com/your-username/spot-instance-comparison.git`
   - Navigate to the project directory: `cd spot-instance-comparison`
   - Install dependencies: `npm install`

3. **Configuration:**
   - Update the `.env` file with the necessary credentials and configurations.
   - Update `config/dbConfig.json` with your database configurations.

## Directory Structure

Refer to the project's directory structure documentation for an overview of the organizational setup of the project.

## Database Configuration

Update the database configurations in `config/dbConfig.json` and run the migrations using the command:

```bash
npx sequelize-cli db:migrate
```

## Data Retrieval Scripts

Scripts for data retrieval are located in the `scripts/` directory. Each script corresponds to a specific cloud provider.

- **Running Scripts:**
  - Azure: `node scripts/azureScript.js`
  - AWS: `node scripts/AWS.js`
  - Google Cloud: `node scripts/google.js`
  - Alibaba: `node scripts/alibaba.js`

## API Endpoints

API route definitions are located in the `routes/apiRoutes.js` file. Start the server using the command:

```bash
node server.js
```

Access the API at `http://localhost:PORT/` where `PORT` is the port number specified in your `.env` file.

## Testing

Tests are located in the `tests/` directory. Run tests using the command:

```bash
npm test
```

## Monitoring and Maintenance

Monitor the application logs in the `logs/` directory to ensure the system is running as expected.

## Docker Configuration

Docker configurations are provided for containerization and easier deployment. Build and run the Docker container using the commands:

```bash
docker build -t spot-instance-comparison .
docker-compose up
```

## Logs

Application logs are stored in the `logs/` directory. Review these logs to troubleshoot issues or monitor application performance.

## Contributing

Please read the CONTRIBUTING.md for details on our code of conduct, and the process for submitting pull requests to the project.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

---

This README provides an overview and setup instructions for the Spot Instance Price Comparison project. Adjust the URLs, commands, and other specifics to match your project setup.
