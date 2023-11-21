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
7. [Data Accuracy and Fairness](#data-accuracy-and-fairness)
8. [Google Cloud Special Considerations](#google-cloud-special-considerations)
9. [Contributing](#contributing)
10. [License](#license)

## Setup and Installation

### Prerequisites

- Node.js v14.x or later.
- PostgreSQL or compatible SQL database.
- Access credentials for AWS, Azure, Google Cloud, and Alibaba.

### Installation Steps

1. Clone the repository: `git clone https://github.com/cleanerzkp/spot-instance-comparison.git`
2. Navigate to the directory: `cd spot-instance-comparison`
3. Install dependencies: `npm install`

## Configuration

- Update `.env` file with necessary credentials for each cloud provider.
- Configure `config/dbConfig.json` with your database settings.
- Set up `GetSpot-Service-Account.json` for Google Cloud Platform integration.

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
- Particularly useful before adding new instances or regions to the database.

### models

- Defines the Sequelize database models.

### Additional Scripts

- **`testDbConnection.js`**: Tests the database connection.
- **Google Cloud Test Scripts**: Two scripts are used for Google Cloud due to the requirement of SKU ID alongside API Key.

## Running the Application

- Navigate to `automation-scripts` and run `node updateAll.js` to update all providers.
- Use specific scripts in `historical-data` and `test` for additional data fetching and testing.

## Database Structure

- **CloudProvider**: Stores basic info about each cloud provider.
- **InstanceType**: Groups similar instances for objective comparison.
- **Region**: Maps different naming conventions of regions across providers.
- **SpotPricing**: Core table for storing average daily prices.

## Data Accuracy and Fairness

- Focus on objective comparison by calculating average daily prices, accommodating different data update frequencies among providers.
- Region and instance type mapping ensures accurate and fair comparisons.

## Google Cloud Special Considerations

- Before fetching spot prices, SKU IDs must be verified.
- The main script for Google Cloud (`runGCPScript`) retrieves spot prices and inserts them into the database.

## Contributing

- Contributions are welcome! Please read CONTRIBUTING.md for guidelines on contributing to this project.

## License

- This project is licensed under the MIT License - see LICENSE.md for details.
