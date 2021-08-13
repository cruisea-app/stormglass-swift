import Foundation

public struct SGRequest<Endpoint: SGEndpoint> {
    internal let endpoint: Endpoint
    internal let apiKeyOverride: String?
    internal let urlSession: URLSession

    public init(
        endpoint: Endpoint,
        apiKey: String? = nil,
        urlSession: URLSession = .shared
    ) {
        self.endpoint = endpoint
        apiKeyOverride = apiKey
        self.urlSession = urlSession
    }

    internal func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: SGConfiguration.shared.host) else {
            throw SGServiceError.badURL
        }

        components.path = endpoint.path
        components.queryItems = endpoint.parameters.convertToQueryItems()

        guard let url = components.url else {
            throw SGServiceError.badURL
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy
        )

        request.httpMethod = "GET"

        if let apiKey = apiKeyOverride ?? SGConfiguration.shared.apiKey {
            request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        } else {
            throw SGServiceError.unauthorised
        }

        return request
    }

    internal var decoder: JSONDecoder = {
        let decoder = JSONDecoder()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        decoder.dateDecodingStrategy = .custom { decoder in
            let value = try decoder.singleValueContainer().decode(String.self)

            guard let date = formatter.date(from: value) else {
                throw SGServiceError.badResponse
            }

            return date
        }

        return decoder
    }()

    public func fetch(completion: @escaping (Result<Endpoint.Response, Error>) -> Void) {
        do {
            let task = try urlSession.dataTask(with: makeRequest()) { data, response, error in
                // Network Errors

                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(SGServiceError.badResponse))
                    return
                }

                // Error Handling

                if let error = try? self.decoder.decode(SGErrorResponse.self, from: data) {
                    completion(.failure(error))
                    return
                }

                if let httpResponse = response as? HTTPURLResponse,
                   let error = SGServiceError(statusCode: httpResponse.statusCode)
                {
                    completion(.failure(error))
                    return
                }

                // Decode Response

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
