import Foundation

public struct SGTideStationsListRequest: StormGlassEndpoint {
    public typealias Response = SGTideStationsListResponse
    
    public var path: String {
        "/v2/tide/stations"
    }
    
    public var parameters: [String : StormGlassParameterEncodable?] {
        return [:]
    }
}

public struct SGTideStationsListResponse: Decodable {
    public struct Item: Decodable {
        /// Name of tide station
        var name: String
        /// Latitude of tide station
        var lat: Double
        /// Longitude of tide station
        var lng: Double
        /// Tide station owner
        var source: StormGlassSource
    }
    
    let data: [Item]
    let meta: SGResponseMetadata
}
