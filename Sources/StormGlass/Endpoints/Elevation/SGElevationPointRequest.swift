import Foundation

public struct SGElevationPointRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGElevationPointResponse

    // Required Parameters
    internal let coordinate: SGCoordinate

    // Initialiser

    /// The elevation request is used to fetch elevation data (bathymetry for oceans and topography for land) for a point. The Storm Glass API provides elevation data globally.
    ///
    /// - Parameter coordinate: The coordinates of the location you would like elevation data for
    public init(
        coordinate: SGCoordinate
    ) {
        self.coordinate = coordinate
    }

    // Protocol

    public var path: String {
        "/v2/elevation/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
        ]
    }
}

public struct SGElevationPointResponse: Decodable {
    public struct Item: Decodable {
        /// The elevation value given in meters relative to sea level.
        public let elevation: Double
    }

    /// The data for this request
    public let data: Item
    /// Extra metadata about the request, including details about your remaining quota
    public let meta: SGResponseMetadata
}
