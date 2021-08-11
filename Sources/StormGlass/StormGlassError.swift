import Foundation

public enum StormGlassServiceError: LocalizedError {
    
    /// Bad URL – The URL could not be generated successfully.
    case badURL
    
    /// Bad Request – Your request is invalid.
    case badRequest
    
    /// Bad Response – Unable to decode the response.
    case badResponse
    
    /// Unauthorized – Your API key is invalid.
    case unauthorised
    
    /// Too Many Requests – You’ve reached your daily limit.
    case rateLimit
    
    /// Internal Server Error – We had a problem with our server. Try again later.
    case internalServerError
    
    /// Service Unavailable – We’re temporarily offline for maintenance. Please try again later.
    case maintenance
    
    internal init?(statusCode: Int) {
        switch statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorised
        case 429:
            self = .rateLimit
        case 500:
            self = .internalServerError
        case 503:
            self = .maintenance
        default:
            return nil
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .badURL:
            return "The request could not be created safely"
        case .badRequest:
            return "Your request is invalid"
        case .badResponse:
            return "We were unable to decode the response"
        case .unauthorised:
            return "Your API key is invalid"
        case .rateLimit:
            return "You've reached your daily rate limit"
        case .internalServerError:
            return "Storm Glass had a problem returning the data requested"
        case .maintenance:
            return "Storm Glass is temporarily offline for maintenance"
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .unauthorised:
            return "Check the provided API key to ensure it matches the one provided by Storm Glass"
        case .rateLimit:
            return "Try again tomorrow"
        case .internalServerError, .maintenance:
            return "Try again later"
        default:
            return nil
        }
    }
}
