//
//  CountryCodeDropdown.swift
//  Vita
//

import SwiftUI

struct CountryCodeDropdown: View {
    @Binding var selectedCode: String

    var body: some View {
        Picker("Select Country Code", selection: $selectedCode) {
            ForEach(countryCodes, id: \.id) { countryCode in
                Text("\(countryCode.country) \(countryCode.code)")
                    .tag(countryCode.code)
            }
        }
        .pickerStyle(.menu)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

#Preview {
    CountryCodeDropdown(selectedCode: .constant("49"))
}
