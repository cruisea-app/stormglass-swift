import Foundation

public struct SGWeatherPointRequest: StormGlassEndpoint {
    // Response Type
    public typealias Response = SGWeatherPointResponse
    
    // Required Parameters
    internal let latitude, longitude: Double
    internal let values: [String]
    
    // Optional Parameters
    internal let startDate: Date?
    internal let endDate: Date?
    internal let sources: [String]?
    
    // Initialiser
    
    /// The weather request is used to fetch weather data for a point. The Storm Glass API provides marine weather as well as global weather for land and lakes.
    ///
    /// To get marine data you include a coordinate at sea in your request, and to get data for land and lakes - simply send in a coordinate located on land or on a lake.
    ///
    /// - Parameters:
    ///   - latitude: The latitude of the desired coordinate
    ///   - longitude: The longitude of the desired coordinate
    ///   - values: The parameters or values that you wish to receive.
    ///   - startDate: The first forecast hour to be retrieved.
    ///   - endDate: The last forecast hour to be retrieved.
    ///   - dataSources: The data source(s) which are used to obtain the data. If `nil` is provided, then any and all data sources will be used.
    public init(
        latitude: Double,
        longitude: Double,
        values: [SGWeatherPointParameters],
        startDate: Date? = nil,
        endDate: Date? = nil,
        dataSources: [StormGlassSource]? = nil
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.values = values.map(\.rawValue)
        self.startDate = startDate
        self.endDate = endDate
        self.sources = dataSources?.map(\.rawValue)
    }
    
    // Protocol
    
    public var path: String {
        "/v2/weather/point"
    }
    
    public var parameters: [String: StormGlassParameterEncodable?] {
        return [
            "lat": latitude,
            "lng": longitude,
            "params": values,
            "start": startDate,
            "end": endDate,
            "source": sources
        ]
    }
    
}

public enum SGWeatherPointParameters: String, CaseIterable {
    /// Air temperature in degrees celsius
    case airTemperature
    /// Air temperature at 80m above sea level in degrees celsius
    case airTemperature80m
    /// Air temperature at 100m above sea level in degrees celsius
    case airTemperature100m
    /// Air temperature at 1000hpa in degrees celsius
    case airTemperature1000hpa
    /// Air temperature at 800hpa in degrees celsius
    case airTemperature800hpa
    /// Air temperature at 500hpa in degrees celsius
    case airTemperature500hpa
    /// Air temperature at 200hpa in degrees celsius
    case airTemperature200hpa
    /// Air pressure in hPa
    case pressure
    /// Total cloud coverage in percent
    case cloudCover
    /// Direction of current. 0° indicates current coming from north
    case currentDirection
    /// Speed of current in meters per second
    case currentSpeed
    /// Wind gust in meters per second
    case gust
    /// Relative humidity in percent
    case humidity
    /// Proportion, 0-1
    case iceCover
    /// Mean precipitation in kg/m²
    case precipitation
    /// Depth of snow in meters
    case snowDepth
    /// Sea level relative to MSL
    case seaLevel
    /// Direction of swell waves. 0° indicates swell coming from north
    case swellDirection
    /// Height of swell waves in meters
    case swellHeight
    /// Period of swell waves in seconds
    case swellPeriod
    /// Direction of secondary swell waves. 0° indicates swell coming from north
    case secondarySwellPeriod
    /// Height of secondary swell waves in meters
    case secondarySwellDirection
    /// Period of secondary swell waves in seconds
    case secondarySwellHeight
    /// Horizontal visibility in km
    case visibility
    /// Water temperature in degrees celsius
    case waterTemperature
    /// Direction of combined wind and swell waves. 0° indicates waves coming from north
    case waveDirection
    /// Significant Height of combined wind and swell waves in meters
    case waveHeight
    /// Period of combined wind and swell waves in seconds
    case wavePeriod
    /// Direction of wind waves. 0° indicates waves coming from north
    case windWaveDirection
    /// Height of wind waves in meters
    case windWaveHeight
    /// Period of wind waves in seconds
    case windWavePeriod
    /// Direction of wind at 10m above sea level. 0° indicates wind coming from north
    case windDirection
    /// Direction of wind at 20m above sea level. 0° indicates wind coming from north
    case windDirection20m
    /// Direction of wind at 30m above sea level. 0° indicates wind coming from north
    case windDirection30m
    /// Direction of wind at 40m above sea level. 0° indicates wind coming from north
    case windDirection40m
    /// Direction of wind at 50m above sea level. 0° indicates wind coming from north
    case windDirection50m
    /// Direction of wind at 80m above sea level. 0° indicates wind coming from north
    case windDirection80m
    /// Direction of wind at 100m above sea level. 0° indicates wind coming from north
    case windDirection100m
    /// Direction of wind at 1000hpa. 0° indicates wind coming from north
    case windDirection1000hpa
    /// Direction of wind at 800hpa. 0° indicates wind coming from north
    case windDirection800hpa
    /// Direction of wind at 500hpa. 0° indicates wind coming from north
    case windDirection500hpa
    /// Direction of wind at 200hpa. 0° indicates wind coming from north
    case windDirection200hpa
    /// Speed of wind at 10m above sea level in meters per second.
    case windSpeed
    /// Speed of wind at 20m above sea level in meters per second.
    case windSpeed20m
    /// Speed of wind at 30m above sea level in meters per second.
    case windSpeed30m
    /// Speed of wind at 40m above sea level in meters per second.
    case windSpeed40m
    /// Speed of wind at 50m above sea level in meters per second.
    case windSpeed50m
    /// Speed of wind at 80m above sea level in meters per second.
    case windSpeed80m
    /// Speed of wind at 100m above sea level in meters per second.
    case windSpeed100m
    /// Speed of wind at 1000hpa in meters per second.
    case windSpeed1000hpa
    /// Speed of wind at 800hpa in meters per second.
    case windSpeed800hpa
    /// Speed of wind at 500hpa in meters per second.
    case windSpeed500hpa
    /// Speed of wind at 200hpa in meters per second.
    case windSpeed200hpa
}

public struct SGWeatherPointResponse: Decodable {
    public struct Item: Decodable {
        /// Timestamp in UTC
        let time: Date
        /// Air temperature in degrees celsius
        let airTemperature: SGSourceValue<Double>?
        /// Air temperature at 80m above sea level in degrees celsius
        let airTemperature80m: SGSourceValue<Double>?
        /// Air temperature at 100m above sea level in degrees celsius
        let airTemperature100m: SGSourceValue<Double>?
        /// Air temperature at 1000hpa in degrees celsius
        let airTemperature1000hpa: SGSourceValue<Double>?
        /// Air temperature at 800hpa in degrees celsius
        let airTemperature800hpa: SGSourceValue<Double>?
        /// Air temperature at 500hpa in degrees celsius
        let airTemperature500hpa: SGSourceValue<Double>?
        /// Air temperature at 200hpa in degrees celsius
        let airTemperature200hpa: SGSourceValue<Double>?
        /// Air pressure in hPa
        let pressure: SGSourceValue<Double>?
        /// Total cloud coverage in percent
        let cloudCover: SGSourceValue<Double>?
        /// Direction of current. 0° indicates current coming from north
        let currentDirection: SGSourceValue<Double>?
        /// Speed of current in meters per second
        let currentSpeed: SGSourceValue<Double>?
        /// Wind gust in meters per second
        let gust: SGSourceValue<Double>?
        /// Relative humidity in percent
        let humidity: SGSourceValue<Double>?
        /// Proportion, 0-1
        let iceCover: SGSourceValue<Double>?
        /// Mean precipitation in kg/m²
        let precipitation: SGSourceValue<Double>?
        /// Depth of snow in meters
        let snowDepth: SGSourceValue<Double>?
        /// Sea level relative to MSL
        let seaLevel: SGSourceValue<Double>?
        /// Direction of swell waves. 0° indicates swell coming from north
        let swellDirection: SGSourceValue<Double>?
        /// Height of swell waves in meters
        let swellHeight: SGSourceValue<Double>?
        /// Period of swell waves in seconds
        let swellPeriod: SGSourceValue<Double>?
        /// Direction of secondary swell waves. 0° indicates swell coming from north
        let secondarySwellPeriod: SGSourceValue<Double>?
        /// Height of secondary swell waves in meters
        let secondarySwellDirection: SGSourceValue<Double>?
        /// Period of secondary swell waves in seconds
        let secondarySwellHeight: SGSourceValue<Double>?
        /// Horizontal visibility in km
        let visibility: SGSourceValue<Double>?
        /// Water temperature in degrees celsius
        let waterTemperature: SGSourceValue<Double>?
        /// Direction of combined wind and swell waves. 0° indicates waves coming from north
        let waveDirection: SGSourceValue<Double>?
        /// Significant Height of combined wind and swell waves in meters
        let waveHeight: SGSourceValue<Double>?
        /// Period of combined wind and swell waves in seconds
        let wavePeriod: SGSourceValue<Double>?
        /// Direction of wind waves. 0° indicates waves coming from north
        let windWaveDirection: SGSourceValue<Double>?
        /// Height of wind waves in meters
        let windWaveHeight: SGSourceValue<Double>?
        /// Period of wind waves in seconds
        let windWavePeriod: SGSourceValue<Double>?
        /// Direction of wind at 10m above sea level. 0° indicates wind coming from north
        let windDirection: SGSourceValue<Double>?
        /// Direction of wind at 20m above sea level. 0° indicates wind coming from north
        let windDirection20m: SGSourceValue<Double>?
        /// Direction of wind at 30m above sea level. 0° indicates wind coming from north
        let windDirection30m: SGSourceValue<Double>?
        /// Direction of wind at 40m above sea level. 0° indicates wind coming from north
        let windDirection40m: SGSourceValue<Double>?
        /// Direction of wind at 50m above sea level. 0° indicates wind coming from north
        let windDirection50m: SGSourceValue<Double>?
        /// Direction of wind at 80m above sea level. 0° indicates wind coming from north
        let windDirection80m: SGSourceValue<Double>?
        /// Direction of wind at 100m above sea level. 0° indicates wind coming from north
        let windDirection100m: SGSourceValue<Double>?
        /// Direction of wind at 1000hpa. 0° indicates wind coming from north
        let windDirection1000hpa: SGSourceValue<Double>?
        /// Direction of wind at 800hpa. 0° indicates wind coming from north
        let windDirection800hpa: SGSourceValue<Double>?
        /// Direction of wind at 500hpa. 0° indicates wind coming from north
        let windDirection500hpa: SGSourceValue<Double>?
        /// Direction of wind at 200hpa. 0° indicates wind coming from north
        let windDirection200hpa: SGSourceValue<Double>?
        /// Speed of wind at 10m above sea level in meters per second.
        let windSpeed: SGSourceValue<Double>?
        /// Speed of wind at 20m above sea level in meters per second.
        let windSpeed20m: SGSourceValue<Double>?
        /// Speed of wind at 30m above sea level in meters per second.
        let windSpeed30m: SGSourceValue<Double>?
        /// Speed of wind at 40m above sea level in meters per second.
        let windSpeed40m: SGSourceValue<Double>?
        /// Speed of wind at 50m above sea level in meters per second.
        let windSpeed50m: SGSourceValue<Double>?
        /// Speed of wind at 80m above sea level in meters per second.
        let windSpeed80m: SGSourceValue<Double>?
        /// Speed of wind at 100m above sea level in meters per second.
        let windSpeed100m: SGSourceValue<Double>?
        /// Speed of wind at 1000hpa in meters per second.
        let windSpeed1000hpa: SGSourceValue<Double>?
        /// Speed of wind at 800hpa in meters per second.
        let windSpeed800hpa: SGSourceValue<Double>?
        /// Speed of wind at 500hpa in meters per second.
        let windSpeed500hpa: SGSourceValue<Double>?
        /// Speed of wind at 200hpa in meters per second.
        let windSpeed200hpa: SGSourceValue<Double>?
    }
    
    let hours: [Item]
    let meta: SGResponseMetadata
}

struct SGResponseMetadata: Decodable {
    /// The cost this request had on your daily quota
    let cost: Int
    
    /// Your daily quota for the account specified with the API key
    let dailyQuota: Int
    
    /// The total number of requests made in this day
    let requestCount: Int
}
