import datetime
import json
import requests

# Set your Google API key and project ID.
GOOGLE_API_KEY = 'AIzaSyBtytMTszA9w0WyIgj6d8HQ4x4ubyAmZjA'
GOOGLE_CLOUD_PROJECT = 'neural-period-383116'


# Define the start and end dates for the price history.
start_date = datetime.datetime(2023, 10, 31)
end_date = datetime.datetime(2023, 11, 6)

# Define the instance types to get the price history for.
instance_types = ['e2-standard-4', 'c2-standard-4']

# Make a request to the Google Cloud APIs to get the Spot instance prices history.
for instance_type in instance_types:
    url = f'https://compute.googleapis.com/compute/v1/projects/{GOOGLE_CLOUD_PROJECT}/regions/us-central1/machineTypes/{instance_type}/spotPricesHistory?start={start_date.isoformat()}&end={end_date.isoformat()}'
    headers = {
        'Authorization': f'Bearer {GOOGLE_API_KEY}'
    }
    response = requests.get(url, headers=headers)

    # Parse the JSON response and print the Spot instance prices history.
    if response.status_code == 200:
        json_response = json.loads(response.content)
        print(f'Instance type: {instance_type}')
        for spot_price_history in json_response['spotPriceHistory']:
            for spot_price in spot_price_history['spotPrices']:
                print(f'Timestamp: {spot_price["timestamp"]} Price: {spot_price["price"]}')
    else:
        print(f'Error: {response.content}')
