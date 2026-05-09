import Foundation

struct CosmosConfig: Codable {
    init(from: String) throws {
        let decoder = JSONDecoder()
        let ret = try decoder.decode(
            CosmosConfig.self, from: from.data(using: .utf8).unsafelyUnwrapped)

        self = ret
    }
}
