@testable import StormGlass
import XCTest

final class SGTideStationsListRequestTests: SGBaseTests {
    
    func testParameters_required() {
        let endpoint = SGTideStationsListRequest()
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        XCTAssertEqual(queryItems.count, 0)
    }
    
    func testURL() throws {
        let endpoint = SGTideStationsListRequest()
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/tide/stations?"
        )
    }
    
    func testDecoding() throws {
        let endpoint = SGTideStationsListRequest()
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        
        _ = try networking.decoder.decode(SGTideStationsListResponse.self, from: loadFixture(withName: "tide-list"))
    }
    
}
