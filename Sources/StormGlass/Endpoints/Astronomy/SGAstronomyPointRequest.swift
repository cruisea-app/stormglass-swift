import Foundation

public struct SGAstronomyPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGAstronomyPointResponse
    
    public var path: String {
        "/v2/astronomy/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGAstronomyPointResponse: Decodable {
    
}
