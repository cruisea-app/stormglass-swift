@testable import StormGlass
import XCTest

final class SGTideStationsAreaRequestTests: SGBaseTests {
    
    func testParameters_required() {
        let endpoint = SGTideStationsAreaRequest(
            box: .init(topRight: .zero, bottomLeft: .init(latitude: 50, longitude: 40))
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("box"), "0.0,0.0:50.0,40.0")
    }
    
    func testURL() throws {
        let endpoint = SGTideStationsAreaRequest(
            box: .init(topRight: .zero, bottomLeft: .init(latitude: 50, longitude: 40))
        )
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/tide/stations/area?box=0.0,0.0:50.0,40.0"
        )
    }
    
    func testDecoding() throws {
        let endpoint = SGTideStationsAreaRequest(
            box: .init(topRight: .zero, bottomLeft: .init(latitude: 50, longitude: 40))
        )
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        
        _ = try networking.decoder.decode(SGTideStationsListResponse.self, from: loadFixture(withName: "tide-area"))
    }
    
}
