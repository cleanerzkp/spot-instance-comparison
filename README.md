# Spot Instance Price Comparison Project

## Overview
This project automates the collection and comparison of spot instance pricing data from major cloud providers (AWS, Azure, Google Cloud, and Alibaba). It stores and analyzes this data in a PostgreSQL database, focusing on standardizing the data format and keeping it current with automated updates.

## Table of Contents
1. [Setup and Installation](#setup-and-installation)
2. [Configuration](#configuration)
3. [Data Collection & Processing](#data-collection--processing)
4. [Database Structure](#database-structure)
5. [Running the Application](#running-the-application)
6. [Folder Structure and Scripts](#folder-structure-and-scripts)
7. [API Endpoints](#api-endpoints)
8. [Additional Information](#additional-information)
9. [Google SKU Logic](#google-sku-logic)

## Setup and Installation
### Prerequisites
- Node.js 14+
- PostgreSQL
- Docker
- Provider credentials for AWS, Azure, GCP, Alibaba

### Installation Steps
1. Clone the repository: `git clone https://github.com/cleanerzkp/spot-instance-comparison.git`
2. Navigate to the directory: `cd spot-instance-comparison`
3. Set up and start the project using Docker: `docker-compose up --build`

## Configuration
- Update `.env.example` with your credentials and rename it to `.env`.
- Ensure `config/config.json` matches your database settings.
- Copy `GetSpot-Service-Account.json.example` to `GetSpot-Service-Account.json` and add GCP service account info.

## Data Collection & Processing
- The `/automation-scripts` directory contains scripts to fetch daily pricing data from each provider.
- Historical data for AWS and Alibaba is fetched and processed using scripts in the `/historical-data` directory.

## Database Structure
- `CloudProviders`: Information about each cloud provider.
- `InstanceTypes`: Details of instance types grouped by categories.
- `Regions`: Mapping of regions across different providers.
- `SpotPricings`: Stores average daily prices.

## Running the Application
- The application, including database migrations and seeders, is automatically set up and run via Docker.
- The `start.sh` script, executed through Docker, automates the entire setup process.

## Folder Structure and Scripts
- `automation-scripts`: Scripts to update the database with the latest spot prices.
- `historical-data`: Scripts to fetch historical data for AWS and Alibaba.
- `test`: Test scripts and utilities.
- `models`: Sequelize models defining the database structure.
- `seeders`: Scripts for initial data seeding.
- `scripts(api-connection-test)`: Testing API connections to cloud providers.

## API Endpoints
- `/providers`: Retrieves all cloud providers.
- `/instance-types`: Retrieves all instance types.
- `/regions`: Retrieves all regions.
- `/spot-pricings`: Retrieves spot pricing data.

## Additional Information
- Docker automates the setup of database migrations and seeders, ensuring a streamlined installation process.
- Historical data functionality is currently available for AWS and Alibaba.


## Google SKU Logic
Google Cloud's spot instance pricing uniquely employs a SKU-based system, where each SKU corresponds to a specific combination of an instance type and a region. This approach differs from other providers like AWS, Azure, and Alibaba, which mainly categorize their offerings by region and instance type.

### Importance of SKU Mapping
- Every Google Cloud SKU is a unique identifier for a specific instance type in a particular region.
- To ensure accurate data collection and comparison, it's crucial to update the SKU mapping in the project when introducing new regions or instance types for Google Cloud.

### Testing for SKU Availability
- Before updating the SKU mappings, run the `testGCPInstancePrices.js` script in the `test(regions-and-hardware)` folder to check if the specific Google SKU (region and hardware) has price history.
- The script tests and returns recent prices for defined SKUs. If it finds prices, it indicates the SKU is valid and has pricing data.

### Updating SKU Mappings
- To add a new region or instance type for Google Cloud, update the `skuToInstanceRegionMap` in the `updateGCPSpotPrices.js` script within the `automation-scripts` folder with the corresponding SKU.
- Find appropriate SKU codes for new regions or instance types at:
  - [Google Cloud SKUs](https://cloud.google.com/skus/sku-groups/compute-engine-flexible-cud-eligible-skus) - For specific SKU codes.

### Steps for Updating
1. **Add Region/Instance to Database**: First, add the new region and instance type to the relevant database tables.
2. **Run Test Script**: Execute `testGCPInstancePrices.js` to verify price history for the new SKUs.
3. **Update SKU Mapping**: If the test script confirms price history, manually update the `skuToInstanceRegionMap` mapping in the `updateGCPSpotPrices.js` script with the new SKU codes.
4. **Test and Validate**: After updating the SKU mapping, run the script again to ensure it correctly fetches and processes the pricing data.

By following these steps, the project remains current with Google Cloud's offerings and maintains accurate pricing comparisons across different cloud providers.