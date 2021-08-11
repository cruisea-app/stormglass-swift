import Foundation

public struct SGElevationPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGElevationPointResponse
    
    public var path: String {
        "/v2/elevation/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGElevationPointResponse: Decodable {
    
}
