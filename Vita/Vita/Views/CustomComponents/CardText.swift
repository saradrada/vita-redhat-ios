//
//  CardText.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 26.10.24.
//

import SwiftUI

struct CardText: View {
    var text: String
    var icon: String
    var gradientColors: [Color] = [.brightCyan, .purple]
    var textColor: Color = .black
    var cornerRadius: CGFloat = 10
    var height: CGFloat = 100

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(gradient: Gradient(colors: gradientColors),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.regularMaterial)
                )

            VStack{
                Label(
                    title: { Text(text)
                            .font(.caption)
                    },
                    icon: { Image(systemName: icon)
                        .font(.subheadline)}
                )
            }
            .padding(.horizontal)
        }
        .frame(height: height)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    CardText(text: "These targets may vary. Discuss your ideal range with your healthcare provider for personalized recommendations.", icon: "info.circle")
}
