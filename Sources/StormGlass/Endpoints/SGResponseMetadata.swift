import Foundation

public struct SGResponseMetadata: Decodable {
    /// The cost this request had on your daily quota
    public let cost: Int
    /// Your daily quota for the account specified with the API key
    public let dailyQuota: Int
    /// The total number of requests made in this day
    public let requestCount: Int
}
