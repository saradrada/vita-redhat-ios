//
//  CountryCode.swift
//  Vita

import SwiftUI

struct CountryCode: Identifiable {
    let id = UUID()
    let code: String
    let country: String
}

let countryCodes = [
    CountryCode(code: "+49", country: "DE"),
    CountryCode(code: "+57", country: "CO"),
    CountryCode(code: "+504", country: "HN"),
    CountryCode(code: "+44", country: "UK"),
]
