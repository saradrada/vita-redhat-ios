//
//  IconWithBackground.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 16.10.24.
//

import SwiftUI

struct IconWithBackground: View {
    @Binding var isSelected: Bool
    let backgroundSize: CGFloat = 24
    let iconSize: CGFloat = 16
    let gesture: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: backgroundSize, height: backgroundSize)
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.subheadline)
                .foregroundColor(isSelected ? .lightGold : .gray)
        }
        .onTapGesture {
            gesture()
        }
    }
}

#Preview {
    IconWithBackground(isSelected: .constant(false), gesture: {})
}
