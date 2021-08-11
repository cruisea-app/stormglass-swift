import XCTest
@testable import StormGlass

final class StormGlassTests: XCTestCase {
    
    override func setUpWithError() throws {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw TestError.missingApiKey
        }
        
        if apiKey == "CHANGE-THIS" {
            throw TestError.invalidApiKey
        }
        
        StormGlassConfiguration.shared.apiKey = apiKey
        try super.setUpWithError()
    }
    
    func testExample() throws {
        let exp = expectation(description: "request should complete")
        
        let request = StormGlassRequest(endpoint: SGWeatherPointRequest(latitude: 0, longitude: 0, values: ["gust"]))
        request.fetch { result in
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}

enum TestError: Error {
    case missingApiKey
    case invalidApiKey
}
