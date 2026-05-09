import Vapor

func routes(_ app: Application) throws {
    app.post("xrpc", "app", "cosmos", "signup") { req -> Response in
        return Response(status: .ok)
    }
}
