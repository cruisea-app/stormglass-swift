import Foundation

public protocol StormGlassParameterEncodable {
    func encode() -> String
}

extension String: StormGlassParameterEncodable {
    public func encode() -> String { self }
}

extension Double: StormGlassParameterEncodable {
    public func encode() -> String { "\(self)" }
}

extension Date: StormGlassParameterEncodable {
    public func encode() -> String { "\(timeIntervalSince1970)" }
}

extension Array: StormGlassParameterEncodable where Element == String {
    public func encode() -> String { joined(separator: ",") }
}

extension Dictionary where Key == String, Value == Optional<StormGlassParameterEncodable> {
    func convertToQueryItems() -> [URLQueryItem] {
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
