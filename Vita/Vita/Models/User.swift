//
//  User.swift
//  Vita
//

import Foundation

struct Profile {
    let name: String
    let gender: Gender
    let birthday: String
    let phoneNumber: String
    let email: String
    let username: String
    let profileImage: String
}

enum Gender: String, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    case other = "Other"

    var id: String { self.rawValue }
}
