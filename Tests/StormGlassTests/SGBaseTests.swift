import XCTest

class SGBaseTests: XCTestCase {
    
    func loadFixture(withName name: String) throws -> Data {
        let url = try XCTUnwrap(Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures"),
                                "Failed to locate fixture with name '\(name)'")
        return try Data(contentsOf: url)
    }
    
}
