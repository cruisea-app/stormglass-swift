import Foundation

public struct SGSolarPointRequest: SGEndpoint {
    public typealias Response = SGSolarPointResponse

    internal let coordinate: SGCoordinate
    internal let values: [String]
    internal let startDate: Date?
    internal let endDate: Date?
    internal let sources: [String]?

    public init(
        coordinate: SGCoordinate,
        values: [SGSolarPointParameters],
        startDate: Date? = nil,
        endDate: Date? = nil,
        dataSources: [SGDataSource]? = nil
    ) {
        self.coordinate = coordinate
        self.values = values.map(\.rawValue)
        self.startDate = startDate
        self.endDate = endDate
        sources = dataSources?.map(\.rawValue)
    }

    public var path: String {
        "/v2/solar/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "params": values,
            "start": startDate,
            "end": endDate,
            "source": sources,
        ]
    }
}

public enum SGSolarPointParameters: String, CaseIterable {
    /// Ultraviolet (UV) radiation at ground or sea level
    case uvIndex
    /// Downward short-wave radiation flux (W m⁻²) at ground or sea level
    case downwardShortWaveRadiationFlux
}

public struct SGSolarPointResponse: Decodable {
    public struct Item: Decodable {
        /// Timestamp in UTC
        public let time: Date
        /// Ultraviolet (UV) radiation at ground or sea level
        public let uvIndex: SGDataSourceValue<Double>?
        /// Downward short-wave radiation flux (W m⁻²) at ground or sea level
        public let downwardShortWaveRadiationFlux: SGDataSourceValue<Double>?
    }

    public let data: [Item]
    public let meta: SGResponseMetadata
}
