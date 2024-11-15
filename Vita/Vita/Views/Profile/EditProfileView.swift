//
//  EditProfileView.swift
//  Vita
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                }
                Spacer()
            }

            Text("Edit Profile")
                .font(.title)
                .padding(.bottom, 16)

            // Profile Image
            VStack(spacing: 8) {
                Image(systemName: viewModel.profile.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 2)
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                        }
                        .offset(x: 30, y: 30)
                    )


                Text(viewModel.profile.name)
                    .font(.headline)

                Text(viewModel.profile.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Divider()
                .padding(.vertical, 16)

            VStack(spacing: 16) {
                LabeledTextField(label: "Full Name", text: $viewModel.fullName)
                HStack(spacing: 8) {
                    VStack(alignment: .leading) {
                        Text("Gender")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                            .padding(.leading, 8)
                        Picker("Gender", selection: $viewModel.gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Birthday")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                        BirthdayDropdown(viewModel: viewModel)
                    }
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                    PhoneNumberTextField(phoneNumber: $viewModel.phoneNumber)
                }

                LabeledTextField(label: "Email", text: $viewModel.email)
                LabeledTextField(label: "User Name", text: $viewModel.username)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)

            Button(action: {
                viewModel.saveProfile()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    EditProfileView(viewModel: ProfileViewModel())
}
