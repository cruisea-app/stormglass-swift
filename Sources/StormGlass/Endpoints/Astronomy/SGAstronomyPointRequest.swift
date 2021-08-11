import Foundation

public struct SGAstronomyPointRequest: SGEndpoint {
    
    public typealias Response = SGAstronomyPointResponse
    
    public var path: String {
        "/v2/astronomy/point"
    }
    
    public var parameters: [String : SGParameterEncodable?] {
        [:]
    }
    
}

public struct SGAstronomyPointResponse: Decodable {
    
}
