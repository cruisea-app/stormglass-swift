import Foundation

public struct SGBioPointRequest: SGEndpoint {
    public typealias Response = SGBioPointResponse

    let coordinate: SGCoordinate
    let values: [String]
    let startDate: Date?
    let endDate: Date?
    let sources: [String]?
    
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
            "source": sources
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
        let time: Date
        /// Mass concentration of chlorophyll a in sea water
        let chlorophyll: SGDataSourceValue<Double>?
        /// Mole concentration of dissolved iron in sea water
        let iron: SGDataSourceValue<Double>?
        /// Mole concentration of nitrate in sea water
        let nitrate: SGDataSourceValue<Double>?
        /// Net primary production of biomass expressed as carbon per unit volume in sea water
        let phyto: SGDataSourceValue<Double>?
        /// Mole concentration of dissolved molecular oxygen in sea water
        let oxygen: SGDataSourceValue<Double>?
        /// Sea water ph reported on total scale
        let ph: SGDataSourceValue<Double>?
        /// Mole concentration of phytoplankton expressed as carbon in sea water
        let phytoplankton: SGDataSourceValue<Double>?
        /// Mole concentration of phosphate in sea water
        let phosphate: SGDataSourceValue<Double>?
        /// Mole concentration of silicate in sea water
        let silicate: SGDataSourceValue<Double>?
        /// Sea water salinity given in per mille
        let salinity: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 0 to 10 cm below surface
        let soilMoisture: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 10 to 40 cm below surface
        let soilMoisture10cm: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 40 to 100 cm below surface
        let soilMoisture40cm: SGDataSourceValue<Double>?
        /// Volumetric soil moisture content at 100 to 200 cm below surface
        let soilMoisture100cm: SGDataSourceValue<Double>?
        /// Soil temperature at 0 to 10 cm below surface
        let soilTemperature: SGDataSourceValue<Double>?
        /// Soil temperature at 10 to 40 cm below surface
        let soilTemperature10cm: SGDataSourceValue<Double>?
        /// Soil temperature at 40 to 100 cm below surface
        let soilTemperature40cm: SGDataSourceValue<Double>?
        /// Soil temperature at 100 to 200 cm below surface
        let soilTemperature100cm: SGDataSourceValue<Double>?
    }
    
    public let data: [Item]
    public let meta: SGResponseMetadata
}
