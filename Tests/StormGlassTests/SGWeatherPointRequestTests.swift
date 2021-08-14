@testable import StormGlass
import XCTest

final class SGWeatherPointRequestTests: XCTestCase {
    
    func testParameters_required() {
        let endpoint = SGWeatherPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .gust ]
        )
        
        let queryItems = endpoint.parameters.convertToQueryItems()
        
        let queryItem: (String) -> String? = { key in
            queryItems.first(where: { $0.name == key })?.value
        }
        
        XCTAssertEqual(queryItem("lat"), "50.0")
        XCTAssertEqual(queryItem("lng"), "40.0")
        XCTAssertEqual(queryItem("params"), "gust")
        XCTAssertNil(queryItem("start"))
        XCTAssertNil(queryItem("end"))
        XCTAssertNil(queryItem("source"))
    }
    
    func testParameters_optional() {
        let endpoint = SGWeatherPointRequest(
            coordinate: .init(latitude: 50, longitude: 40),
            values: [ .gust, .airTemperature ],
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
        XCTAssertEqual(queryItem("params"), "gust,airTemperature")
        XCTAssertEqual(queryItem("start"), "0.0")
        XCTAssertEqual(queryItem("end"), "60.0")
        XCTAssertEqual(queryItem("source"), "sg")
    }
    
    func testURL() throws {
        let endpoint = SGWeatherPointRequest(coordinate: .zero, values: [ .gust ])
        
        let networking = SGRequest(endpoint: endpoint, apiKey: "")
        let url = try XCTUnwrap(networking.makeRequest().url).absoluteString
        
        XCTAssertEqual(
            url,
            "https://api.stormglass.io/v2/weather/point?lat=0.0&lng=0.0&params=gust"
        )
    }
    
}
