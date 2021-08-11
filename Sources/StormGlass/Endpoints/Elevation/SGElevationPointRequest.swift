import Foundation

public struct SGElevationPointRequest: SGEndpoint {
    
    public typealias Response = SGElevationPointResponse
    
    public var path: String {
        "/v2/elevation/point"
    }
    
    public var parameters: [String : SGParameterEncodable?] {
        [:]
    }
    
}

public struct SGElevationPointResponse: Decodable {
    
}
