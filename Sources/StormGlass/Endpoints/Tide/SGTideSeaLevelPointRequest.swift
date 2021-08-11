import Foundation

public struct SGTideSeaLevelPointRequest: SGEndpoint {
    
    public typealias Response = SGTideSeaLevelPointResponse
    
    public var path: String {
        "/v2/tide/sea-level/point"
    }
    
    public var parameters: [String : SGParameterEncodable?] {
        [:]
    }
    
}

public struct SGTideSeaLevelPointResponse: Decodable {
    
}
