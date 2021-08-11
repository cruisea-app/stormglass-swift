import Foundation

public struct SGSolarPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGSolarPointResponse
    
    public var path: String {
        "/v2/solar/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGSolarPointResponse: Decodable {
    
}
