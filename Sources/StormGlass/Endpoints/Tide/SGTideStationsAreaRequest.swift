import Foundation

public struct SGTideStationsAreaRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideStationsListResponse

    // Required Parameters
    internal let box: SGCoordinateBox

    // Initialiser

    public init(box: SGCoordinateBox) {
        self.box = box
    }

    // Protocol

    public var path: String {
        "/v2/tide/stations/area"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [
            "box": box.encodable,
        ]
    }
}
