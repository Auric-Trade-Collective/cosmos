import DefaultBackend
import SwiftCrossUI

@main
struct CosmosApp: App {
    @State var state: CosmosState = CosmosState()

    var body: some Scene {
        WindowGroup("Cosmos") {
            Router().padding()
        }
    }

    @ViewBuilder
    func Router() -> some View {
        switch state.scene {
        case .Login: Login(state)
        case .Home: Home(state)
        case .Signup: Signup(state)
        }
    }
}

public enum Scenes {
    case Login
    case Home
    case Signup
}

public class CosmosState: ObservableObject {
    @Published public var scene: Scenes = .Login
    @Published public var user: String = "None"
}
