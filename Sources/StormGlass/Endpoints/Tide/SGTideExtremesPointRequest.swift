import Foundation

public struct SGTideExtremesPointRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideExtremesPointResponse

    // Required Parameters
    internal let coordinate: SGCoordinate
    internal let datum: SGTideDatum

    // Optional Parameters
    internal let startDate: Date?
    internal let endDate: Date?

    // Initialiser

    /// Retrieve information about high and low tide for a single coordinate
    ///
    /// - Parameters:
    ///   - coordinate: The coordinates of the location you would like tide data for
    ///   - startDate: Timestamp in UTC for first forecast hour
    ///   - endDate: Timestamp in UTC for last forecast hour
    ///   - datum: Datum values will be relative to (defaults to MSL - Mean Sea Level)
    public init(
        coordinate: SGCoordinate,
        startDate: Date? = nil,
        endDate: Date? = nil,
        datum: SGTideDatum = .meanSeaLevel
    ) {
        self.coordinate = coordinate
        self.startDate = startDate
        self.endDate = endDate
        self.datum = datum
    }

    // Protocol

    public var path: String {
        "/v2/tide/extremes/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "start": startDate,
            "end": endDate,
            "datum": datum,
        ]
    }
}

public struct SGTideExtremesPointResponse: Decodable {
    public enum ExtremeType: String, Decodable {
        case low, high
    }

    public struct Item: Decodable {
        /// Timestamp in UTC
        public let time: Date
        /// Height in meters
        public let height: String
        /// Type of extreme. Either low or high
        public let type: ExtremeType
    }

    /// The data for this request
    public let data: [Item]
    /// Extra metadata about the request, including details about your remaining quota
    public let meta: SGResponseMetadata
}
