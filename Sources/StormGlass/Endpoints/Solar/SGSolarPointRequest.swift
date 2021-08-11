import Foundation

public struct SGSolarPointRequest: SGEndpoint {
    public typealias Response = SGSolarPointResponse

    public var path: String {
        "/v2/solar/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [:]
    }
}

public struct SGSolarPointResponse: Decodable {}
