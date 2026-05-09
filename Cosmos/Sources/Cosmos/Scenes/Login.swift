import DefaultBackend
import SwiftCrossUI

public struct Login: View {
    @State private var state: CosmosState
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var pds: String = "cosmos.aurictradecollective.org"  //Should be Cosmos by default

    init(_ state: CosmosState) {
        self.state = state
    }

    public var body: some View {
        HStack {
            VStack {
                Text("Welcome to Cosmos!\nLet's get you logged in!").padding().font(.title)

                Spacer().frame(height: 20)
                TextField("Username", text: $username).frame(width: 300)
                SecureField("Password", text: $password).frame(width: 300)
                Spacer().frame(height: 20)

                VStack(alignment: .leading) {
                    Text("Server").font(.body).padding(.leading, 5)
                    TextField("Server", text: $pds).frame(width: 300)
                }
                Spacer().frame(height: 20)

                Button("Login") {
                    Login()
                }.background(Color.blue).foregroundColor(.white).cornerRadius(8)

                Spacer().frame(height: 5)
                Button("Sign Up") {
                    state.scene = .Signup
                }.background(Color.blue).foregroundColor(.white).cornerRadius(8)
            }
        }
    }

    private func Login() {
        state.scene = .Home
        state.user = username

        //this should save the pds to a configuration somewhere
    }
}
