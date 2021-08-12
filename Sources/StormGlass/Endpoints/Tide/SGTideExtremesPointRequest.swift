import Foundation

public struct SGTideExtremesPointRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideExtremesPointResponse

    // Required Parameters
    internal let coordinate: SGCoordinate

    // Optional Parameters
    internal let startDate: Date?
    internal let endDate: Date?
    internal let datum: SGTideDatum?

    // Initialiser

    public init(coordinate: SGCoordinate, startDate: Date? = nil, endDate: Date? = nil, datum: SGTideDatum? = nil) {
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
