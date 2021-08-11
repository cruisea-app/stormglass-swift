import Foundation

public struct StormGlassRequest<Endpoint: StormGlassEndpoint> {
    
    internal let endpoint: Endpoint
    internal let apiKeyOverride: String?
    internal let urlSession: URLSession
    
    public init(
        endpoint: Endpoint,
        apiKey: String? = nil,
        urlSession: URLSession = .shared
    ) {
        self.endpoint = endpoint
        self.apiKeyOverride = apiKey
        self.urlSession = urlSession
    }
    
    internal func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: StormGlassConfiguration.shared.host) else {
            throw StormGlassServiceError.badURL
        }
        
        components.path = endpoint.path
        components.queryItems = endpoint.parameters.convertToQueryItems()
        
        guard let url = components.url else {
            throw StormGlassServiceError.badURL
        }
        
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy
        )
        
        request.httpMethod = "GET"
        
        if let apiKey = apiKeyOverride ?? StormGlassConfiguration.shared.apiKey {
            request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        } else {
            throw StormGlassServiceError.unauthorised
        }
        
        return request
    }
    
    internal var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        decoder.dateDecodingStrategy = .custom({ decoder in
            let value = try decoder.singleValueContainer().decode(String.self)
            
            guard let date = formatter.date(from: value) else {
                throw StormGlassServiceError.badResponse
            }
            
            return date
        })
        
        return decoder
    }()
    
    public func fetch(completion: @escaping (Result<Endpoint.Response, Error>) -> Void) {
        
        do {
            let task = try urlSession.dataTask(with: makeRequest()) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(StormGlassServiceError.badResponse))
                    return
                }
                
                do {
                    let result = try self.decoder.decode(Endpoint.Response.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
}
extension String: Error { }
