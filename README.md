# Spot Instance Price Comparison Project

## Project Overview

This project aims to analyze and compare spot instance prices from AWS, Azure, Google Cloud, and Alibaba. It focuses on objective comparison by calculating the average daily price of spot instances with similar hardware specifications in equivalent regions.

## Table of Contents

1. [Setup and Installation](#setup-and-installation)
2. [Configuration](#configuration)
3. [Key Components](#key-components)
4. [Folders and Scripts](#folders-and-scripts)
5. [Running the Application](#running-the-application)
6. [Database Structure](#database-structure)


## Setup and Installation

### Prerequisites

- Node.js v14.x or later.
- PostgreSQL or compatible SQL database.
- Access credentials for AWS, Azure, Google Cloud, and Alibaba (configured in `.env` file).
- Access to Google Cloud JSON for API integration.

### Installation Steps

1. Clone the repository: `git clone https://github.com/cleanerzkp/spot-instance-comparison.git`
2. Navigate to the directory: `cd spot-instance-comparison`
3. Install dependencies: `npm install`

## Configuration

- Update `.env.example` file with necessary credentials for each cloud provider (remove .example).
- Configure `config/dbConfig.json` with your database settings.
- Set up `GetSpot-Service-Account.json.example` for Google Cloud Platform integration (remove .example).

## Key Components

- **Cloud Providers**: Integration with AWS, Azure, Google Cloud, and Alibaba.
- **Instance Types**: Grouped by categories like General Purpose (GP1), Compute Optimized (CO1), etc.
- **Region Mapping**: Aligning different region names across providers for accurate comparison.
- **Spot Pricing**: Storing and comparing average daily prices from each provider.

## Folders and Scripts

### automation-scripts

- Contains scripts for each provider and a master script (`updateAll`) to run them all.
- Updates the database with the average spot price for the last 24 hours.
- Can be set up as a cron job for regular updates.

### historical-data

- Fetches historical data, available for AWS and Alibaba.
- Useful for historical price analysis and trend identification.

### test

- Contains test scripts to check price history availability for specific instances and regions.
- Includes two tests for Google Cloud: one for SKU verification and another for testing spot prices fetch.

### models

- Defines the Sequelize database models.

### Additional Scripts

- **`testDbConnection.js`**: Tests the database connection.

## Running the Application

- Navigate to `automation-scripts` and run `node updateAll.js` to update all providers.
- Use specific scripts in `historical-data` and `test` for additional data fetching and testing.

## Database Structure

- **CloudProvider**: Stores basic info about each cloud provider.
- **InstanceType**: Groups similar instances for objective comparison.
- **Region**: Maps different naming conventions of regions across providers.
- **SpotPricing**: Core table for storing average daily prices.
