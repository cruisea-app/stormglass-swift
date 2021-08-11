public protocol SGEndpoint {
    associatedtype Response: Decodable

    var path: String { get }
    var parameters: [String: SGParameterEncodable?] { get }
}
