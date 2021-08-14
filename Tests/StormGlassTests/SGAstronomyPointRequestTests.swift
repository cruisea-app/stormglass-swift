@testable import StormGlass
import XCTest

final class SGAstronomyPointRequestTests: XCTestCase {
    
    func testParameters_required() {
        let endpoint = SGAstronomyPointRequest(
            coordinate: .init(latitude: 50, longitude: 40)
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertNil(queryItem("start"))
        XCTAssertNil(queryItem("end"))
    }
    
    func testParameters_optional() {
        let endpoint = SGAstronomyPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            startDate: Date(timeIntervalSince1970: 0),
            endDate: Date(timeIntervalSince1970: 60)
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("start"), "0.0")
        XCTAssertEqual(queryItem("end"), "60.0")
    }
    
    func testURL() throws {
        let endpoint = SGAstronomyPointRequest(coordinate: .zero)
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/astronomy/point?lat=0.0&lng=0.0"
        )
    }
    
}
