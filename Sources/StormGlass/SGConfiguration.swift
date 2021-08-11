public class SGConfiguration {
    public static var shared = SGConfiguration()
    private init() {}

    public var host: String = "https://api.stormglass.io"
    public var apiKey: String?
}
