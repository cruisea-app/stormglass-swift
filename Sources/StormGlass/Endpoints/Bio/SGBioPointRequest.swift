import Foundation

public struct SGBioPointRequest: StormGlassEndpoint {
    
    public typealias Response = SGBioPointResponse
    
    public var path: String {
        "/v2/bio/point"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        [:]
    }
    
}

public struct SGBioPointResponse: Decodable {
    
}
