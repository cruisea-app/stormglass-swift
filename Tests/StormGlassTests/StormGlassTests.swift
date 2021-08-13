@testable import StormGlass
import XCTest

final class IntegrationTests: XCTestCase {
    override func setUpWithError() throws {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            throw XCTSkip("Missing API Key")
        }

        if apiKey == "CHANGE-THIS" {
            throw XCTSkip("Invalid API Key")
        }

        SGConfiguration.shared.apiKey = apiKey
        try super.setUpWithError()
    }

    func testExample() throws {
        let exp = expectation(description: "request should complete")

        let endpoint = SGAstronomyPointRequest(coordinate: .zero)

        // let endpoint = SGBioPointRequest(coordinate: .zero, values: [ .iron ])
        // let endpoint = SGBioPointRequest(coordinate: .zero, values: SGBioPointParameters.allCases)

        // let endpoint = SGElevationPointRequest(coordinate: .zero)

        // let endpoint = SGSolarPointRequest(coordinate: .zero, values: [ .uvIndex ])
        // let endpoint = SGSolarPointRequest(coordinate: .zero, values: SGSolarPointParameters.allCases)

        // let endpoint = SGWeatherPointRequest(coordinate: .zero, values: [ .gust ])
        // let endpoint = SGWeatherPointRequest(coordinate: .zero, values: SGWeatherPointParameters.allCases)

        // let endpoint = SGTideStationsListRequest()
        // let endpoint = SGTideStationsAreaRequest(box: .init(topRight: .init(latitude: 0, longitude: 0), bottomLeft: .init(latitude: 50, longitude: 50)))

        // let endpoint = SGTideExtremesPointRequest(coordinate: .zero)
        // let endpoint = SGTideSeaLevelPointRequest(coordinate: .zero)
        // let endpoint = SGTideSeaLevelPointRequest(coordinate: .zero, datum: .meanLowerLowWater)

        let request = SGRequest(endpoint: endpoint)
        request.fetch { _ in
            exp.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}
