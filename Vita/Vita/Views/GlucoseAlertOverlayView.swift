//
//  GlucoseAlertOverlayView.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import SwiftUI

struct GlucoseAlertOverlayView: View {
    @ObservedObject var alertViewModel = GlucoseAlertViewModel.shared

    var body: some View {
        if alertViewModel.isShowingAlert, let alertMessage = alertViewModel.alertMessage {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        alertViewModel.dismissAlert()
                    }

                VStack(spacing: 8) {
                        if let riskLevel = alertViewModel.riskLevel {
                            Image(systemName: icon(for: riskLevel))
//                            Image(systemName: icon(for: "hypoglycemia"))
                                .font(.title)
                                .foregroundColor(riskColor(for: riskLevel))
//                                .foregroundColor(riskColor(for: "hypoglycemia"))
                        }

                        Text("Glucose Alert")
                        .padding(.top, 8)

                    Text(alertMessage)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    Divider().padding(.horizontal, 16)

                    if let riskLevel = alertViewModel.riskLevel {
                        Text("Risk Level: \(riskLevel.capitalized)")
//                            .font(.subheadline)
                            .foregroundColor(riskColor(for: riskLevel))
                    }

                    if let bloodGlucose = alertViewModel.bloodGlucose {
                        Text("Blood Glucose: \(bloodGlucose, specifier: "%.1f") mg/dL")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.bottom)
                    }

                    Button(action: {
                        alertViewModel.dismissAlert()
                    }) {
                        Text("Dismiss")
                            .bold()
                            .padding(.vertical, 10)
                            .frame(maxWidth: 150)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color(.systemBackground).opacity(0.95))
                .cornerRadius(12)
                .shadow(radius: 10)
                .padding(.horizontal)
                .transition(.scale)
            }
            .animation(.easeInOut, value: alertViewModel.isShowingAlert)
        }
    }

    private func riskColor(for riskLevel: String) -> Color {
        switch riskLevel.lowercased() {
        case "hypoglycemia":
            return .red
        case "hyperglycemia":
            return .orange
        default:
            return .green
        }
    }

    private func icon(for riskLevel: String) -> String {
        switch riskLevel.lowercased() {
        case "hypoglycemia":
            return "exclamationmark.triangle"
        case "hyperglycemia":
            return "exclamationmark.octagon"
        default:
            return "checkmark.seal"
        }
    }
}

#Preview {
    GlucoseAlertOverlayView()
}


#Preview {
    GlucoseAlertOverlayView()
}
