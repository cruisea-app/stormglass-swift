import Foundation

public struct SGTideSeaLevelPointRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideSeaLevelPointResponse

    // Required Parameters
    let coordinate: SGCoordinate
    let datum: SGTideDatum

    // Optional Parameters
    let startDate: Date?
    let endDate: Date?

    // Initialiser

    /// Retrieve the sea level given in meters hour by hour for a single coordinate
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
        "/v2/tide/sea-level/point"
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

public struct SGTideSeaLevelPointResponse: Decodable {
    public struct Item: Decodable {
        private struct FailableDouble: Decodable {
            fileprivate let value: Double?

            init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()
                value = try? container.decode(Double.self)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case time
        }

        /// Timestamp in UTC
        public let time: Date
        /// Sea level given in metres where the key itself is the name of the source
        public let data: [SGDataSource: Double]

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawData = try decoder.singleValueContainer().decode([String: FailableDouble].self)
            var builder = [SGDataSource: Double]()

            rawData.forEach { key, value in
                if let dataSource = SGDataSource(rawValue: key), let underlyingValue = value.value {
                    builder[dataSource] = underlyingValue
                }
            }

            time = try container.decode(Date.self, forKey: .time)
            data = builder
        }
    }

    /// The data for this request
    public let data: [Item]
    /// Extra metadata about the request, including details about your remaining quota
    public let meta: SGResponseMetadata
}
