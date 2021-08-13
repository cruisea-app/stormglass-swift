# Storm Glass for Swift

> Global high-resolution weather forecasts directly from the world’s most trusted meteorological institutions.

In order to use this package, you will first need to obtain an API key from [Storm Glass](https://stormglass.io/).

## Installation

Add package to your Xcode project using Swift Package Manager.

## Usage

```swift

// Step 1:
// Configure API Key

SGConfiguration.shared.apiKey = "your-api-key"

// Step 2:
// Create Endpoint Request

import StormGlass
let endpoint = SGWeatherPointRequest(... parameters)

// Step 3:
// Create Networking Request

let request = SGRequest(endpoint: endpoint)

// Step 4:
// Execute

request.fetch { result in
    // Step 5:
    // Handle Result...
    
    // (psst, this is where you put your code using the data!)
}
```

## TODO

Tests are yet to be written. Recommended against using in any production app until this has been done.
