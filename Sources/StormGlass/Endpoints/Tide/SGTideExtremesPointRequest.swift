import Foundation

public struct SGTideExtremesPointRequest: SGEndpoint {
    public typealias Response = SGTideExtremesPointResponse

    let coordinate: SGCoordinate
    let startDate: Date?
    let endDate: Date?
    let datum: SGTideDatum?

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
        let time: Date
        /// Height in meters
        let height: String
        /// Type of extreme. Either low or high
        let type: ExtremeType
    }

    public let data: [Item]
    public let meta: SGResponseMetadata
}
