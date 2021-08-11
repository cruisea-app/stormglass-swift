@testable import StormGlass
import XCTest

final class StormGlassTests: XCTestCase {
    override func setUpWithError() throws {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw TestError.missingApiKey
        }

        if apiKey == "CHANGE-THIS" {
            throw TestError.invalidApiKey
        }

        SGConfiguration.shared.apiKey = apiKey
        try super.setUpWithError()
    }

    func testExample() throws {
        let exp = expectation(description: "request should complete")

        let request = SGRequest(endpoint: SGWeatherPointRequest(latitude: 0, longitude: 0, values: SGWeatherPointParameters.allCases))
        request.fetch { _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}

enum TestError: Error {
    case missingApiKey
    case invalidApiKey
}
