@testable import StormGlass
import XCTest

final class SGSolarPointRequestTests: SGBaseTests {
    
    func testParameters_required() {
        let endpoint = SGSolarPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .uvIndex ]
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("params"), "uvIndex")
        XCTAssertNil(queryItem("start"))
        XCTAssertNil(queryItem("end"))
        XCTAssertNil(queryItem("source"))
    }
    
    func testParameters_optional() {
        let endpoint = SGSolarPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .uvIndex, .downwardShortWaveRadiationFlux ],
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
        XCTAssertEqual(queryItem("params"), "uvIndex,downwardShortWaveRadiationFlux")
        XCTAssertEqual(queryItem("start"), "0.0")
        XCTAssertEqual(queryItem("end"), "60.0")
        XCTAssertEqual(queryItem("source"), "sg")
    }
    
    func testURL() throws {
        let endpoint = SGSolarPointRequest(coordinate: .zero, values: [ .uvIndex ])
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/solar/point?lat=0.0&lng=0.0&params=uvIndex"
        )
    }
    
    func testDecoding() throws {
        let endpoint = SGSolarPointRequest(coordinate: .zero, values: [ .uvIndex ])
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        
        _ = try networking.decoder.decode(SGSolarPointResponse.self, from: loadFixture(withName: "solar-point-singleValue"))
        _ = try networking.decoder.decode(SGSolarPointResponse.self, from: loadFixture(withName: "solar-point-allValues"))
    }
    
}
