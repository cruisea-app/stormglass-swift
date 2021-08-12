import Foundation

public struct SGTideStationsListRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideStationsListResponse

    // Initialiser

    public init() {}

    // Protocol

    public var path: String {
        "/v2/tide/stations"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [:]
    }
}

public struct SGTideStationsListResponse: Decodable {
    public struct Item: Decodable {
        /// Name of tide station
        public var name: String
        /// Latitude of tide station
        public var lat: Double
        /// Longitude of tide station
        public var lng: Double
        /// Tide station owner
        public var source: SGDataSource
    }

    /// The data for this request
    public let data: [Item]
    /// Extra metadata about the request, including details about your remaining quota
    public let meta: SGResponseMetadata
}
