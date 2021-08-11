import Foundation

public struct SGTideExtremesPointRequest: SGEndpoint {
    public typealias Response = SGTideExtremesPointResponse

    internal let coordinate: SGCoordinate
    internal let startDate: Date?
    internal let endDate: Date?
    internal let datum: SGTideDatum?

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

public enum SGTideDatum: String, SGParameterEncodable {
    case meanLowerLowWater = "mllw"
    case meanSeaLevel = "msl"

    public func encode() -> String { rawValue }
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

    public let data: [Item]
    public let meta: SGResponseMetadata
}
