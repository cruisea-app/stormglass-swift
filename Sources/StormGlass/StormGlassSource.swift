public enum StormGlassSource: String, CaseIterable, Decodable {
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


public struct SGSourceValue<Value: Decodable>: Decodable {
    let values: [StormGlassSource: Value]
    
    public init(from decoder: Decoder) throws {
        let dictionary = try decoder.singleValueContainer().decode([String: Value].self)
        
        var valuesBuilder = [StormGlassSource: Value]()
        dictionary.forEach {
            let source = StormGlassSource(rawValue: $0.key) ?? .unknown
            valuesBuilder[source] = $0.value
        }
        
        self.values = valuesBuilder
    }
}
