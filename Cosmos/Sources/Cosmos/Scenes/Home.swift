import DefaultBackend
import SwiftCrossUI

public struct Home: View {
    @State private var state: CosmosState

    init(_ state: CosmosState) {
        self.state = state
    }

    public var body: some View {
        VStack {
            Text("This is the home scene!").padding()
            Text("Welcome to your homepage, \(state.user)").padding()
        }
    }
}
