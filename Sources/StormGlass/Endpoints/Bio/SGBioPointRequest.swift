import Foundation

public struct SGBioPointRequest: SGEndpoint {
    public typealias Response = SGBioPointResponse

    internal let coordinate: SGCoordinate
    internal let values: [String]
    internal let startDate: Date?
    internal let endDate: Date?
    internal let sources: [String]?

    public init(
        coordinate: SGCoordinate,
        values: [SGBioPointParameters],
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
        "/v2/bio/point"
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

public enum SGBioPointParameters: String, CaseIterable {
    /// Mass concentration of chlorophyll a in sea water
    case chlorophyll
    /// Mole concentration of dissolved iron in sea water
    case iron
    /// Mole concentration of nitrate in sea water
    case nitrate
    /// Net primary production of biomass expressed as carbon per unit volume in sea water
    case phyto
    /// Mole concentration of dissolved molecular oxygen in sea water
    case oxygen
    /// Sea water ph reported on total scale
    case ph
    /// Mole concentration of phytoplankton expressed as carbon in sea water
    case phytoplankton
    /// Mole concentration of phosphate in sea water
    case phosphate
    /// Mole concentration of silicate in sea water
    case silicate
    /// Sea water salinity given in per mille
    case salinity
    /// Volumetric soil moisture content at 0 to 10 cm below surface
    case soilMoisture
    /// Volumetric soil moisture content at 10 to 40 cm below surface
    case soilMoisture10cm
    /// Volumetric soil moisture content at 40 to 100 cm below surface
    case soilMoisture40cm
    /// Volumetric soil moisture content at 100 to 200 cm below surface
    case soilMoisture100cm
    /// Soil temperature at 0 to 10 cm below surface
    case soilTemperature
    /// Soil temperature at 10 to 40 cm below surface
    case soilTemperature10cm
    /// Soil temperature at 40 to 100 cm below surface
    case soilTemperature40cm
    /// Soil temperature at 100 to 200 cm below surface
    case soilTemperature100cm
}

public struct SGBioPointResponse: Decodable {
    public struct Item: Decodable {
        /// Timestamp in UTC
        public let time: Date
        /// Mass concentration of chlorophyll a in sea water
        public let chlorophyll: SGDataSourceValue<Double>?
        /// Mole concentration of dissolved iron in sea water
        public let iron: SGDataSourceValue<Double>?
        /// Mole concentration of nitrate in sea water
        public let nitrate: SGDataSourceValue<Double>?
        /// Net primary production of biomass expressed as carbon per unit volume in sea water
        public let phyto: SGDataSourceValue<Double>?
        /// Mole concentration of dissolved molecular oxygen in sea water
        public let oxygen: SGDataSourceValue<Double>?
        /// Sea water ph reported on total scale
        public let ph: SGDataSourceValue<Double>?
        /// Mole concentration of phytoplankton expressed as carbon in sea water
        public let phytoplankton: SGDataSourceValue<Double>?
        /// Mole concentration of phosphate in sea water
        public let phosphate: SGDataSourceValue<Double>?
        /// Mole concentration of silicate in sea water
        public let silicate: SGDataSourceValue<Double>?
        /// Sea water salinity given in per mille
        public let salinity: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 0 to 10 cm below surface
        public let soilMoisture: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 10 to 40 cm below surface
        public let soilMoisture10cm: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 40 to 100 cm below surface
        public let soilMoisture40cm: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 100 to 200 cm below surface
        public let soilMoisture100cm: SGDataSourceValue<Double>?
        /// Soil temperature at 0 to 10 cm below surface
        public let soilTemperature: SGDataSourceValue<Double>?
        /// Soil temperature at 10 to 40 cm below surface
        public let soilTemperature10cm: SGDataSourceValue<Double>?
        /// Soil temperature at 40 to 100 cm below surface
        public let soilTemperature40cm: SGDataSourceValue<Double>?
        /// Soil temperature at 100 to 200 cm below surface
        public let soilTemperature100cm: SGDataSourceValue<Double>?
    }

    public let data: [Item]
    public let meta: SGResponseMetadata
}
