import Foundation

public protocol SGParameterEncodable {
    func encode() -> String
}

extension String: SGParameterEncodable {
    public func encode() -> String { self }
}

extension Double: SGParameterEncodable {
    public func encode() -> String { "\(self)" }
}

extension Date: SGParameterEncodable {
    public func encode() -> String { "\(timeIntervalSince1970)" }
}

extension Array: SGParameterEncodable where Element == String {
    public func encode() -> String { joined(separator: ",") }
}

extension Dictionary where Key == String, Value == SGParameterEncodable? {
    internal func convertToQueryItems() -> [URLQueryItem] {
        compactMap { parameter in
            guard let value = parameter.value?
                .encode()
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
                return nil
            }

            return URLQueryItem(
                name: parameter.key,
                value: value
            )
        }
    }
}
