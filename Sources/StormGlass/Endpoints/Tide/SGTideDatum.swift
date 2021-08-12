import Foundation

/// The datum to be used when returning tide information
public enum SGTideDatum: String, SGParameterEncodable {
    /// The average height of the lowest tide recorded at a tide station each day during a 19-year recording period
    case meanLowerLowWater = "mllw"
    /// The average level of the surface of one or more of Earth's bodies of water
    case meanSeaLevel = "msl"

    public func encode() -> String { rawValue }
}
