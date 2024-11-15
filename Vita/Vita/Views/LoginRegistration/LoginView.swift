//
//  LoginView.swift
//  Vita
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false

    var body: some View {
        VStack(spacing: 20) {
            Image("vitalogo")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .clipShape(Circle())
                .padding(.top, 40)

            Text("Welcome back!")
                .font(.largeTitle)
                .padding(.top, 10)
                .padding(.bottom, 32)

            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .frame(height: 50)

            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(height: 50)
                        .cornerRadius(10)
                } else {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(height: 50)
                        .cornerRadius(10)
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing, 15)
                }
            }

            // Login Button
            Button(action: {
                authViewModel.login(email: email, password: password)
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.bottom, 32)

            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))

                Text("or")
                    .foregroundColor(.gray)

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.vertical, 10)

            HStack(alignment: .center, spacing: 20) {
                socialLoginButton(action: {}, icon: "googlelogo", isSF: false)
                socialLoginButton(action: {}, icon: "applelogo", isSF: true, width: 30)
            }

            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.gray)

                NavigationLink {
                    RegistrationWithSocialsView()
                } label: {
                    Text("Sign up")
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding(.horizontal, 20)
    }

    private func socialLoginButton(action: () -> Void, icon: String, isSF: Bool, width: CGFloat = 35, height: CGFloat = 35) -> some View {
        Button {} label: {
            ZStack {
                Color.white
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4)
                    .frame(width: 60, height: 60)

                let image = isSF ? Image(systemName: icon) : Image(icon)
                image
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundColor(.black)

            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
