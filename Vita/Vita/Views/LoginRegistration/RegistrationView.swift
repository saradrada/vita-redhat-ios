//
//  RegisterView.swift
//  Vita
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 20) {
            Image("vitalogo")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.top, 40)

            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.bottom, 32)

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .frame(height: 50)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .frame(height: 50)

            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .frame(height: 50)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 5)
            }

            Button(action: {
                if password == confirmPassword {
                    viewModel.register(email: email, password: password)
                } else {
                    viewModel.errorMessage = "Passwords do not match"
                }
            }) {
                Text("Sign Up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.bottom, 32)

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    RegisterView()
}
