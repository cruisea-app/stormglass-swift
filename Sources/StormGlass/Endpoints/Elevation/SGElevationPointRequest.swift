import Foundation

public struct SGElevationPointRequest: SGEndpoint {
    public typealias Response = SGElevationPointResponse

    let coordinate: SGCoordinate
    
    public init(coordinate: SGCoordinate) {
        self.coordinate = coordinate
    }
    
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
    
    public let data: Item
    public let meta: SGResponseMetadata
}
