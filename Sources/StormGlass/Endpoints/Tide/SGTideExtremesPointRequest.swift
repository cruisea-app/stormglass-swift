import Foundation

public struct SGTideExtremesPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGTideExtremesPointResponse
    
    public var path: String {
        "/v2/tide/extremes/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGTideExtremesPointResponse: Decodable {
    
}
