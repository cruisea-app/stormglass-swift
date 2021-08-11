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
    case unknown
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
        
        self.values = valuesBuilder
    }
}
