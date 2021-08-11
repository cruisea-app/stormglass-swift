public enum SGDataSource: String, CaseIterable, Decodable {
    case icon
    case noaa
    case meteo
    case meto
    case fcoo
    case fmi
    case yr
    case smhi
    case sg
    case mercator // bio only
    case unknown

    public var description: String {
        switch self {
        case .icon:
            return "Germany’s National Meteorological Service, the Deutscher Wetterdienst"
        case .noaa:
            return "National Oceanic and Atmospheric Administration"
        case .meteo:
            return "French National Meteorological service"
        case .meto:
            return "United Kingdom’s national weather service, The UK MetOffice"
        case .fcoo:
            return "Danish Defence Centre for Operational Oceanography"
        case .fmi:
            return "The Finnish Meteorological Institution"
        case .yr:
            return "Norwegian Meteorological Institute and NRK"
        case .smhi:
            return "Swedish Meteorological and Hydrological Institute"
        case .sg:
            return "Handpicked local forecast in each geographical area by Storm Glass"
        case .mercator:
            return "Mercator"
        case .unknown:
            return "Unknown Data Source"
        }
    }
    
    public var updateFrequency: Int? {
        switch self {
        case .icon:
            return 12
        case .noaa:
            return 6
        case .meteo:
            return 24
        case .meto:
            return 24
        case .fcoo:
            return 12
        case .fmi:
            return 4
        case .yr:
            return 4
        case .smhi:
            return 12
        case .sg:
            return 4
        case .mercator:
            return nil
        case .unknown:
            return nil
        }
    }
}

public struct SGDataSourceValue<Value: Decodable>: Decodable {
    let values: [SGDataSource: Value]

    public init(from decoder: Decoder) throws {
        let dictionary = try decoder.singleValueContainer().decode([String: Value].self)

        var valuesBuilder = [SGDataSource: Value]()
        dictionary.forEach {
            let source = SGDataSource(rawValue: $0.key) ?? .unknown
            valuesBuilder[source] = $0.value
        }

        values = valuesBuilder
    }
}
