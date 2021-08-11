import Foundation

public struct SGCoordinate {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public struct SGCoordinateBox {
    public let topRight: SGCoordinate
    public let bottomLeft: SGCoordinate
    
    public init(topRight: SGCoordinate, bottomLeft: SGCoordinate) {
        self.topRight = topRight
        self.bottomLeft = bottomLeft
    }
    
    internal var encodable: StormGlassParameterEncodable {
        [
            "\(topRight.latitude)",
            ",",
            "\(topRight.longitude)",
            ":",
            "\(bottomLeft.latitude)",
            ",",
            "\(bottomLeft.longitude)",
        ].joined()
    }
}

