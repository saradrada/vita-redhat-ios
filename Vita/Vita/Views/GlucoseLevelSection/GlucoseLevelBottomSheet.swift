//
//  GlucoseLevelBottomSheet.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 26.10.24.
//

import SwiftUI

struct GlucoseLevelBottomSheet: View {
    var body: some View {
        VStack {
            Text("Understanding Your Glucose Target Ranges")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.top, 16)

            Divider()
                .padding(.vertical)

            VStack(spacing: 16) {
                HStack {
                    Label(
                        title: {
                            VStack(alignment: .leading) {
                                Text("Fasting or Pre-Meal Glucose")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.steelBlue)
                                Text("Target: 80-130 mg/dL \nThis range is ideal for most adults before meals.")
                                    .font(.subheadline)
                            }
                        },
                        icon: { Image(systemName: "1.circle")
                                .font(.title3)
                                .foregroundStyle(.steelBlue)
                        }
                    )
                    .padding(.leading)
                    Spacer()
                }

                DotDivier(dotSize: 5.0, dotColor: .lightGold)

                HStack {
                    Label(
                        title: {
                            VStack(alignment: .leading) {
                                Text("After Meal (1-2 Hours Postprandial)")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.steelBlue)
                                Text("Target: Less than 180 mg/dL \nAim to keep levels below this range after eating.")
                                    .font(.subheadline)
                            }
                        },
                        icon: { Image(systemName: "2.circle")
                                .font(.title3)
                                .foregroundStyle(.steelBlue)
                        }
                    )
                    .padding(.leading)
                    Spacer()
                }

                DotDivier(dotSize: 5.0, dotColor: .lightGold)

                HStack {
                    Label(
                        title: {
                            VStack(alignment: .leading) {
                                Text("HbA1c (3-Month Average)")
                                    .fontWeight(.medium)
                                    .foregroundStyle(.steelBlue)
                                Text("Target: Less than 7% \nThis equates roughly to an average glucose of 154 mg/dL.")
                                    .font(.subheadline)
                            }
                        },
                        icon: { Image(systemName: "3.circle")
                                .font(.title3)
                                .foregroundStyle(.steelBlue)
                        }
                    )
                    .padding(.leading)
                    Spacer()
                }

            }
            .frame(width: 350)
            .padding(.bottom)
            .padding(.horizontal, 16)

            CardText(text: "These targets may vary. Discuss your ideal range with your healthcare provider for personalized recommendations.", icon: "info.circle")
                .padding(.horizontal, 16)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    GlucoseLevelBottomSheet()
}
