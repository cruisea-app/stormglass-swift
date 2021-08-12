import Foundation

public struct SGSolarPointRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGSolarPointResponse

    // Required Parameters
    internal let coordinate: SGCoordinate
    internal let values: [String]

    // Optional Parameters
    internal let startDate: Date?
    internal let endDate: Date?
    internal let sources: [String]?

    // Initialiser

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

    // Protocol

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

    /// The data for this request
    public let data: [Item]
    /// Extra metadata about the request, including details about your remaining quota
    public let meta: SGResponseMetadata
}
