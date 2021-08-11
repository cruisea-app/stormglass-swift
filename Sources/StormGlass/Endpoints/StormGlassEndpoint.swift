public protocol StormGlassEndpoint {
    associatedtype Response: Decodable
    
    var path: String { get }
    var parameters: [String: StormGlassParameterEncodable?] { get }
}
