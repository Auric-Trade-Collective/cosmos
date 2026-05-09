import DefaultBackend
import Foundation
import SwiftCrossUI

public struct Signup: View {
    @State private var state: CosmosState

    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var showPassword: Bool = false

    init(_ state: CosmosState) {
        self.state = state
    }

    public var body: some View {
        HStack {
            VStack {
                Text("Signup for Cosmos").padding().font(.title)

                Spacer().frame(height: 20)
                TextField("Email", text: $email).frame(width: 300)
                TextField("Username", text: $username).frame(width: 300)
                if !showPassword {
                    SecureField("Password", text: $password).frame(width: 300)
                    SecureField("Repeat Password", text: $repeatPassword).frame(width: 300)
                } else {
                    TextField("Password", text: $password).frame(width: 300)
                    TextField("Repeat Password", text: $repeatPassword).frame(width: 300)
                }
                Toggle("Show Password", isOn: $showPassword).frame(width: 300)

                if !goodPassword() {
                    Text("Passwords do not match or don't meet password requirements.")
                        .foregroundColor(.red)
                    Text(
                        "Passwords must contain at least one special character,\ntwo uppercase letters,\none number,\nand be 8 characters long"
                    ).foregroundColor(.red)
                }

                Spacer().frame(height: 20)

                Button("Sign Up") {
                    do {
                        try Signup()
                        state.scene = .Login
                    } catch {
                        print(error)
                    }
                }.background(
                    (goodPassword()) ? Color.blue : Color.clear
                )
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }

    func goodPassword() -> Bool {
        let special = "!@#$%^&*()_+-=[]{}|;':\",./<>?"
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let num = "0123456789"
        return password == repeatPassword && password.filter { special.contains($0) }.count > 0
            && password.filter { upper.contains($0) }.count > 1
            && password.filter { num.contains($0) }.count > 0
            && password.count > 7
    }

    private func Signup() throws {
        let atProto = ATProto(URL(string: "http://localhost:8080").unsafelyUnwrapped)  // lets actually do proper error handling later on
        Task {
            try await atProto.Post(
                nsid: "com.atproto.server.createAccount",
                val: UserLogin(handle: username, email: email, password: password))
        }

        if goodPassword() {
            state.scene = .Login
        }
    }
}
