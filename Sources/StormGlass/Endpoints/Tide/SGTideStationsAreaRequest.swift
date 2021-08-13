import Foundation

public struct SGTideStationsAreaRequest: SGEndpoint {
    // Response Type
    public typealias Response = SGTideStationsListResponse

    // Required Parameters
    internal let box: SGCoordinateBox

    // Initialiser

    /// The Tide Stations Area Request will list all available tide stations within a defined geographic area.
    ///
    /// - Parameter box: The geographic area of the request location
    public init(
        box: SGCoordinateBox
    ) {
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
