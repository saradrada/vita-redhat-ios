//
//  ProfileView.swift
//  Vita
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var viewModel: ProfileViewModel

    init(authViewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }


    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: viewModel.profile.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())

                Text(viewModel.profile.name)
                    .font(.headline)

                Text(viewModel.profile.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                NavigationLink {
                    EditProfileView(viewModel: viewModel)
                } label: {
                    Text("Edit Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 16)

            Divider()

            VStack(spacing: 16) {
                ProfileOptionRow(iconName: "gear", title: "Settings")
                ProfileOptionRow(iconName: "heart", title: "Pregnancy Mode")
                ProfileOptionRow(iconName: "lock", title: "Change Password")

                Divider()

                ProfileOptionRow(iconName: "questionmark.circle", title: "Help & Support")

                Button(action: {}) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                        Text("Log out")
                    }
                    .foregroundColor(.black)
                }
            }
            .padding()

            Spacer()
        }
    }
}

struct ProfileOptionRow: View {
    let iconName: String
    let title: String

    var body: some View {

        NavigationLink {
            Text(title)
        } label: {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.black)
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
    }
}



#Preview {
    NavigationStack {
        ProfileView(authViewModel: AuthViewModel())
    }
}
