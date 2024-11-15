//
//  GlucoseLevelCard.swift
//  Vita

import SwiftUI

struct GlucoseLevelCard: View {
    @State var presentSheet = false
    var gradientColors: [Color] = [.brightCyan, .lightGold]
    var textColor: Color = .black
    var cornerRadius: CGFloat = 10

    var body: some View {
        card
            .sheet(isPresented: $presentSheet) {
                GlucoseLevelBottomSheet()
            }
    }

    private var card: some View {
        VStack(alignment: .leading) {
            Text("Glucose Goals")
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


                HStack(alignment: .top) {
                    fastingCard
                    Spacer()
                    postMealCard
                    Spacer()
                    hbA1c
                }
                .padding()
            }
            .frame(height: 170)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                presentSheet = true
            }
        }
        .padding(.horizontal)
    }


    private var fastingCard: some View {
        cardView(icon: "sunrise", title: "Fasting", range: "80-130 mg/dL")
    }

    private var postMealCard: some View {
        cardView(icon: "cup.and.saucer", title: "Post-Meal", range: "Less than 180 mg/dL")
    }

    private var hbA1c: some View {
        cardView(icon: "calendar", title: "HbA1c", range: "Less than 7%")
    }

    private func cardView(icon: String, title: String, range: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 50, height: 50)

                    Image(systemName: icon)
                        .foregroundColor(.yellow)
                        .font(.title3)
                }
                Spacer()
            }
            .padding(.vertical, 8)
            Text(title)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
            Text(range)
                .font(.caption2)
                .multilineTextAlignment(.leading)
                .lineLimit(2, reservesSpace: true)
            Spacer()
        }
        .frame(minWidth: 75, minHeight: 0)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThickMaterial)
        )
    }
}

#Preview {
    NavigationStack {
        GlucoseLevelCard()
    }
}
