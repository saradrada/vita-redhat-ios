//
//  ProfileSetupView.swift
//  Vita
//

import SwiftUI

struct ProfileSetupView: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            Text("Complete Your Profile")
                .font(.title)
                .padding(.vertical, 16)

            VStack(spacing: 8) {
                Image(systemName: viewModel.profile.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .foregroundStyle(.gray)
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
            }

            Divider()
                .padding(.vertical, 16)

            VStack(spacing: 16) {
                LabeledTextField(label: "Full Name", text: $viewModel.fullName)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Birthday")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                        BirthdayDropdown(viewModel: viewModel)
                    }
                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Gender")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                        Picker("Gender", selection: $viewModel.gender) {
                            ForEach(Gender.allCases) { gender in
                                Text(gender.rawValue).tag(gender)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Spacer()
                }

                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .font(.caption)
                        .foregroundColor(.gray)
                    PhoneNumberTextField(phoneNumber: $viewModel.phoneNumber)
                }

                LabeledTextField(label: "Email", text: $viewModel.email)
                LabeledTextField(label: "Username", text: $viewModel.username)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)

            Button {
                viewModel.saveProfile()
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileSetupView(viewModel: ProfileViewModel())
}

#Preview {
    return Text("Parent View for Profile Setup Preview")
        .sheet(isPresented: .constant(true)) {
            ScrollView {
                ProfileSetupView(viewModel: ProfileViewModel())
            }
        }
}
