@testable import StormGlass
import XCTest

final class SGBioPointRequestTests: XCTestCase {
    
    func testParameters_required() {
        let endpoint = SGBioPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .iron ]
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("params"), "iron")
        XCTAssertNil(queryItem("start"))
        XCTAssertNil(queryItem("end"))
        XCTAssertNil(queryItem("source"))
    }
    
    func testParameters_optional() {
        let endpoint = SGBioPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .iron, .oxygen ],
            startDate: Date(timeIntervalSince1970: 0),
            endDate: Date(timeIntervalSince1970: 60),
            dataSources: [ .sg ]
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("params"), "iron,oxygen")
        XCTAssertEqual(queryItem("start"), "0.0")
        XCTAssertEqual(queryItem("end"), "60.0")
        XCTAssertEqual(queryItem("source"), "sg")
    }
    
    func testURL() throws {
        let endpoint = SGBioPointRequest(coordinate: .zero, values: [ .iron ])
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/bio/point?lat=0.0&lng=0.0&params=iron"
        )
    }
    
}
