//
//  PhoneNumberTextField.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 04.11.24.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @Binding var phoneNumber: String
    @State private var selectedCountryCode = "+880"

    var body: some View {
        HStack {
            CountryCodeDropdown(selectedCode: $selectedCountryCode)

            TextField("Phone number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .font(.body)
                .padding(8)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }
}

#Preview {
    PhoneNumberTextField(phoneNumber: .constant("156378234905"))
}
