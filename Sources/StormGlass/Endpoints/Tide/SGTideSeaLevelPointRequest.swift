import Foundation

public struct SGTideSeaLevelPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGTideSeaLevelPointResponse
    
    public var path: String {
        "/v2/tide/sea-level/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGTideSeaLevelPointResponse: Decodable {
    
}
