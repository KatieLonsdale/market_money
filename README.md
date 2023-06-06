# Market Money

The Market Money API provides developers with data about local markets and the vendors that sell their products there. It offers a RESTful architecture, allowing developers to interact with the API using standard JSON consumption.

This README provides an overview of the API.

## Features

- **Market Data:** Retrieve information about local markets, including their names, addresses, coordinates, and number of vendors who sell there.

- **Vendor Data:** Access data about vendors operating in local markets, including their names, description of products, contact information, and whether they accept credit.

- **Search Functionality:** Search for markets based on various parameters, such as name and location.

- **Closest ATM:** Find the closest ATM, sorted by distance, from a given market.
  - This feature utilizes the [TomTom API](https://developer.tomtom.com/)
