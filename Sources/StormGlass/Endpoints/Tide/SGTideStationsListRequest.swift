import Foundation

public struct SGTideStationsListRequest: SGEndpoint {
    public typealias Response = SGTideStationsListResponse

    public var path: String {
        "/v2/tide/stations"
    }

    public var parameters: [String: SGParameterEncodable?] {
        return [:]
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

    public let data: [Item]
    public let meta: SGResponseMetadata
}
