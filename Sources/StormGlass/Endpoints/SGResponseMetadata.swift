import Foundation

struct SGResponseMetadata: Decodable {
    /// The cost this request had on your daily quota
    let cost: Int
    
    /// Your daily quota for the account specified with the API key
    let dailyQuota: Int
    
    /// The total number of requests made in this day
    let requestCount: Int
}
