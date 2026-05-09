import Foundation

public struct ATProto {
    private let host: URL
    private let session: URLSession

    init(_ host: URL, _ session: URLSession = .shared) {
        self.host = host
        self.session = session
    }

    public func Post<T: Codable>(nsid: String, val: T?) async throws -> T {
        let url = host.appendingPathComponent("xrpc/\(nsid)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let val = val {
            request.httpBody = try JSONEncoder().encode(val)
        }

        let (data, _) = try await session.data(for: request)  // eventually we want to check for errors
        return try JSONDecoder().decode(T.self, from: data)
    }
}
