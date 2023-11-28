# Spot Instance Price Comparison Project

## Overview
This project aims to collect and compare spot instance pricing data from major cloud providers (AWS, Azure, Google Cloud, and Alibaba) and store it in a PostgreSQL database for analysis. It focuses on standardizing the data format and automating updates for current and historical pricing information, enabling objective comparisons.

## Table of Contents
1. [Setup and Installation](#setup-and-installation)
2. [Configuration](#configuration)
3. [Data Collection & Processing](#data-collection--processing)
4. [Database Structure](#database-structure)
5. [Running the Application](#running-the-application)
6. [Folder Structure and Scripts](#folder-structure-and-scripts)
7. [API Endpoints](#api-endpoints)
8. [Additional Information](#additional-information)

## Setup and Installation
### Prerequisites
- Node.js 14+
- PostgreSQL
- Docker
- Provider credentials for AWS, Azure, GCP, Alibaba

### Installation Steps
1. Clone the repository: `git clone https://github.com/cleanerzkp/spot-instance-comparison.git`
2. Navigate to the directory and install dependencies: `cd spot-instance-comparison && npm install`
3. Set up Docker containers: `docker-compose up --build`

## Configuration
- Update the `.env.example` file with necessary credentials and rename it to `.env`.
- Edit `config/config.json` to match your database settings.
- Configure database settings in `config/config.json`.
- Copy `GetSpot-Service-Account.json.example` to `GetSpot-Service-Account.json` and add GCP service account info.

## Data Collection & Processing
- Scripts located in `/automation-scripts` fetch pricing data from each provider.
- `updateAll.js` runs all provider scripts and is configured as a cron job for daily updates.
- Historical data located in `/historical-data` for some providers.
- Test scripts in `/test(regions-and-hardware)` check data availability.

## Database Structure
- `CloudProviders`: Metadata for each cloud provider.
- `InstanceTypes`: Normalization and classification of instances.
- `Regions`: Mapping of region names across providers.
- `SpotPricings`: Stores average daily prices.

## Running the Application
1. Navigate to `automation-scripts` and run `node updateAll.js` to update all data.
2. Configure as a cron job for daily updates.
3. Seeded historical data can be used from the `historical-data` folder.

## Folder Structure and Scripts
- `automation-scripts`: Fetch and update the latest spot prices.
- `historical-data`: Fetch historical data for AWS and Alibaba.
- `test`: Test scripts and utilities.
- `models`: Sequelize models for database structure.
- `scripts(api-connection-test)`: Test API connections.
- `seeders`: Scripts for initial database seeding.
- `test(regions-and-hardware)`: Validate price history availability.

## API Endpoints
- `/providers`: Retrieves all cloud providers.
- `/instance-types`: Retrieves all instance types.
- `/regions`: Retrieves all regions.
- `/spot-pricings`: Retrieves spot pricing data.

## Additional Information
- The `start.sh` script automates database setup and application launch.
- Database setup includes seeding with provider, instance type, and region data.
- The project is verified to work with the current Docker configuration.
- Historical data scripts work for AWS and Alibaba.
- For all 4 providers pricing data from the last 28 days is availiable from SpotPricings.csv which used updateAll script daily (few exceptions)
- The `test(regions-and-hardware)` folder is crucial for ensuring data accuracy.

---
