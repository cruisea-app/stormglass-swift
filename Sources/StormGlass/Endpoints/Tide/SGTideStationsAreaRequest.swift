import Foundation

public struct SGTideStationsAreaRequest: SGEndpoint {
    public typealias Response = SGTideStationsListResponse
    
    internal let box: SGCoordinateBox
    
    public init(box: SGCoordinateBox) {
        self.box = box
    }
    
    public var path: String {
        "/v2/tide/stations/area"
    }
    
    public var parameters: [String : SGParameterEncodable?] {
        return [
            "box": box.encodable
        ]
    }
}
