//
//  SocialRegistrationView.swift
//  Vita
//

import SwiftUI

struct RegistrationWithSocialsView: View {
    @State private var navigateToRegister = false

    var body: some View {
            VStack(spacing: 20) {
                Image("vitalogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.top, 78)

                Text("Create\nan Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
                    .padding(.bottom, 32)

                VStack(spacing: 16) {
                    socialButton(label: "Continue with Google", icon: "googlelogo", isSF: false)
                    socialButton(label: "Continue with Apple", icon: "applelogo")
                }
                .padding(.horizontal, 20)

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

                NavigationLink {
                    RegisterView()
                } label: {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .frame(width: 24, height: 16)
                            .padding(.trailing, 16)
                        Text("Sign Up with Email")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)

                Spacer()
            }
    }

    private func socialButton(label: String, icon: String, isSF: Bool = true) -> some View {
        Button{ } label: {
            HStack {
                let image = isSF ? Image(systemName: icon) : Image(icon)
                image
                    .resizable()
                    .frame(width: 24, height: isSF ? 28 : 24)
                    .padding(.trailing, 16)
                Text(label)
                Spacer()
            }
            .foregroundColor(.black)
            .frame(height: 32)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
            )
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationWithSocialsView()
    }
}
