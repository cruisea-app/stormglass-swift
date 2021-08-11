import Foundation

public struct SGBioPointRequest: SGEndpoint {
    
    public typealias Response = SGBioPointResponse
    
    public var path: String {
        "/v2/bio/point"
    }
    
    public var parameters: [String : SGParameterEncodable?] {
        [:]
    }
    
}

public struct SGBioPointResponse: Decodable {
    
}
