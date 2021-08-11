import Foundation

public struct SGTideExtremesPointRequest: SGEndpoint {
    public typealias Response = SGTideExtremesPointResponse

    public var path: String {
        "/v2/tide/extremes/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [:]
    }
}

public struct SGTideExtremesPointResponse: Decodable {}
