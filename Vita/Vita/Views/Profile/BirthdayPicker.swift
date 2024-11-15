//
//  BirthdayPicker.swift
//  Vita
//

import SwiftUI

struct BirthdayDropdown: View {
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        DatePicker(
            "Select Birthday",
            selection: Binding(
                get: { viewModel.getBirthdayDate() },
                set: { viewModel.updateBirthday(with: $0) }
            ),
            displayedComponents: [.date]
        )
        .datePickerStyle(.compact)
        .labelsHidden()
    }
}



#Preview {
    BirthdayDropdown(viewModel: ProfileViewModel())
}
