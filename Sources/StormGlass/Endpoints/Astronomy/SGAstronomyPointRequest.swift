import Foundation

public struct SGAstronomyPointRequest: SGEndpoint {
    public typealias Response = SGAstronomyPointResponse

    let coordinate: SGCoordinate
    let startDate: Date?
    let endDate: Date?

    public init(coordinate: SGCoordinate, startDate: Date? = nil, endDate: Date? = nil) {
        self.coordinate = coordinate
        self.startDate = startDate
        self.endDate = endDate
    }

    public var path: String {
        "/v2/astronomy/point"
    }

    public var parameters: [String: SGParameterEncodable?] {
        [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "start": startDate,
            "end": endDate,
        ]
    }
}

public struct SGAstronomyPointResponse: Decodable {
    public struct MoonPhase: Decodable {
        public enum PhaseTextValue: String, Decodable {
            case newMoon = "New moon"
            case waxingCrescent = "Waxing crescent"
            case firstQuarter = "First quarter"
            case waxingGibbous = "Waxing gibbous"
            case fullMoon = "Full moon"
            case vaningGibbous = "Vaning gibbous"
            case thirdQuarter = "Third quarter"
            case vaningCrescent = "Vaning crescent"
        }

        public struct Phase: Decodable {
            /// A string describing the moon phase.
            public let text: PhaseTextValue
            /// Timestamp in UTC showing what time the moon phase object describes.
            public let time: Date
            /// A float value for the phase of the given time.
            public let value: Double
        }

        /// the current moon phase
        public let current: Phase
        /// closest phase being one of New moon, First quarter, Full moon or Third quarter.
        public let closest: Phase
    }

    public struct Item: Decodable {
        /// Timestamp in UTC indicating the day for the data
        public let time: Date
        /// Timestamp for sunrise in UTC. Will return null if no sunsrise occurs on the given day
        public let sunrise: Date
        /// Timestamp for sunset in UTC. Will return null if no sunset occurs on the given day
        public let sunset: Date
        /// Timestamp for moonrise in UTC. Will return null if no moonrise occurs on the given day
        public let moonrise: Date
        /// Timestamp for moonset in UTC. Will return null if no moonset occurs on the given day
        public let moonset: Date
        /// A float number between 0 and 1 indicating how much of the moon is illuminated
        public let moonFraction: Double
        /// Objects describing the current and the closest moon phase
        public let moonPhase: MoonPhase
        /// Timestamp in UTC. Will return null if no dawn occurs on the given day
        public let astronomicalDawn: Date
        /// Timestamp in UTC. Will return null if no dusk occurs on the given day
        public let astronomicalDusk: Date
        /// Timestamp for sunset in UTC. Will return null if no dawn occurs on the given day
        public let civilDawn: Date
        /// Timestamp for sunset in UTC. Will return null if no dusk occurs on the given day
        public let civilDusk: Date
        /// Timestamp for sunset in UTC. Will return null if no dawn occurs on the given day
        public let nauticalDawn: Date
        /// Timestamp for sunset in UTC. Will return null if no dusk occurs on the given day
        public let nauticalDusk: Date
    }

    public let data: [Item]
    public let meta: SGResponseMetadata
}
