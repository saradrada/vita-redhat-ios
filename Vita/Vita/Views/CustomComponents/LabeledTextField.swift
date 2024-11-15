//
//  LabeledTextField.swift
//  Vita
//

import SwiftUI

struct LabeledTextField: View {
    var label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 8)
            TextField("", text: $text)
                .font(.body)
                .foregroundColor(.black)
                .padding(.bottom, 8)
        }
        .padding(.leading, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}


#Preview {
    LabeledTextField(label: "Name", text: .constant("Sara"))
}
