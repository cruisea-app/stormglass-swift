@testable import StormGlass
import XCTest

final class SGElevationPointRequestTests: SGBaseTests {
    
    func testParameters_required() {
        let endpoint = SGElevationPointRequest(
            coordinate: .init(latitude: 50, longitude: 40)
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
    }
    
    func testURL() throws {
        let endpoint = SGElevationPointRequest(coordinate: .zero)
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/elevation/point?lat=0.0&lng=0.0"
        )
    }
    
    func testDecoding() throws {
        let endpoint = SGElevationPointRequest(coordinate: .zero)
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        
        _ = try networking.decoder.decode(SGElevationPointResponse.self, from: loadFixture(withName: "elevation-point"))
    }
    
}
