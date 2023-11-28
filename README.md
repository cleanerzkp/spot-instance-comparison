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

---

