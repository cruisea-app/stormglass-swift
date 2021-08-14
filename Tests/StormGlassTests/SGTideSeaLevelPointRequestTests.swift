@testable import StormGlass
import XCTest

final class SGTideSeaLevelPointRequestTests: SGBaseTests {
    
    func testParameters_required() {
        let endpoint = SGTideSeaLevelPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            datum: .meanSeaLevel
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("datum"), "MSL")
        XCTAssertNil(queryItem("start"))
        XCTAssertNil(queryItem("end"))
    }
    
    func testParameters_optional() {
        let endpoint = SGTideSeaLevelPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            startDate: Date(timeIntervalSince1970: 0),
            endDate: Date(timeIntervalSince1970: 60),
            datum: .meanLowerLowWater
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("datum"), "MLLW")
        XCTAssertEqual(queryItem("start"), "0.0")
        XCTAssertEqual(queryItem("end"), "60.0")
    }
    
    func testURL() throws {
        let endpoint = SGTideSeaLevelPointRequest(coordinate: .zero)
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/tide/sea-level/point?datum=MSL&lat=0.0&lng=0.0"
        )
    }
    
    func testDecoding() throws {
        let endpoint = SGTideSeaLevelPointRequest(coordinate: .zero)
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        
        _ = try networking.decoder.decode(SGTideSeaLevelPointResponse.self, from: loadFixture(withName: "tide-seaLevel-point-msl"))
        _ = try networking.decoder.decode(SGTideSeaLevelPointResponse.self, from: loadFixture(withName: "tide-seaLevel-point-mllw"))
    }
    
}
