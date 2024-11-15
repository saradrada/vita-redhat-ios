//
//  HealthDataCard.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 15.10.24.
//

import SwiftUI

struct HealthDataCard: View {
    @ObservedObject var viewModel: HealthDataViewModel
    let item: HealthDataItem
    var gradientColors: [Color] = [.brightCyan, .lightGold]
    var cornerRadius: CGFloat = 10

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(gradient: Gradient(colors: gradientColors),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.regularMaterial)
                )

            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .center) {
                    Text(item.title)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .padding(.trailing, 16)
                    Spacer()
                    IconWithBackground(isSelected: .constant(item.isFavorite)) {
                        viewModel.toggleFavorite(for: item)
                    }
                }
                Text(item.value)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding(.leading, 4)
            .padding(6)
        }
        .frame(maxWidth: .infinity, minHeight: 45)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.brightCyan.opacity(0.1))
        )
        
    }
}

#Preview {
    HealthDataCard(viewModel: HealthDataViewModel(), item: HealthDataItem(title: "Age", value: "10", isFavorite: true))
}
