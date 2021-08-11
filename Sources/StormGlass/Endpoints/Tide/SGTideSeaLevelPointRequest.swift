import Foundation

public struct SGTideSeaLevelPointRequest: SGEndpoint {
    public typealias Response = SGTideSeaLevelPointResponse

    let coordinate: SGCoordinate
    let startDate: Date?
    let endDate: Date?
    let datum: SGTideDatum?

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

    public let data: [Item]
    public let meta: SGResponseMetadata
}
