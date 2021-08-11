public class StormGlassConfiguration {
    
    public static var shared = StormGlassConfiguration()
    private init() { }
    
    public var host: String = "https://api.stormglass.io"
    public var apiKey: String?
    
}
