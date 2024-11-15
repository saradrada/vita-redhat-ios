//
//  ProfileViewModel.swift
//  Vita
//

import FirebaseAuth
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile
    @Published var fullName: String = ""
    @Published var gender: Gender = .female
    @Published var birthday: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var isProfileComplete: Bool = false

    init() {
        self.profile = Profile(
            name: "",
            gender: .female,
            birthday: "",
            phoneNumber: "",
            email: "",
            username: "",
            profileImage: "person.circle.fill"
        )
        fetchUserEmail()
    }

    private func fetchUserEmail() {
        if let currentUser = Auth.auth().currentUser {
            self.email = currentUser.email ?? ""
        }
    }

    func saveProfile() {
        // Save profile
        
        if isProfileValid() {
            isProfileComplete = true
        }
    }

    func editProfile() {
    }

    private func isProfileValid() -> Bool {
            return !fullName.isEmpty && !username.isEmpty && !birthday.isEmpty && !phoneNumber.isEmpty && !email.isEmpty
        }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()

    func getBirthdayDate() -> Date {
        return dateFormatter.date(from: birthday) ?? Date()
    }

    func updateBirthday(with date: Date) {
        birthday = dateFormatter.string(from: date)
    }
}
