import Foundation

public struct SGCoordinate: Equatable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public struct SGCoordinateBox: Equatable {
    public let topRight: SGCoordinate
    public let bottomLeft: SGCoordinate

    public init(topRight: SGCoordinate, bottomLeft: SGCoordinate) {
        self.topRight = topRight
        self.bottomLeft = bottomLeft
    }

    internal var encodable: SGParameterEncodable {
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
