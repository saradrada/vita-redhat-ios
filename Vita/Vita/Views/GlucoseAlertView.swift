//
//  GlucoseAlertView.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import SwiftUI

//struct GlucoseAlertView: View {
//    @ObservedObject var alertViewModel: GlucoseAlertViewModel
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text("Glucose Alert")
//                .font(.title)
//                .fontWeight(.bold)
//
//            if let alertMessage = alertViewModel.alertMessage {
//                Text(alertMessage)
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//                    .padding()
//            }
//
//            if let riskLevel = alertViewModel.riskLevel {
//                Text("Risk Level: \(riskLevel.capitalized)")
//                    .font(.headline)
//                    .foregroundColor(riskColor(for: riskLevel))
//            }
//
//            if let bloodGlucose = alertViewModel.bloodGlucose {
//                Text("Blood Glucose: \(bloodGlucose, specifier: "%.1f") mg/dL")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .cornerRadius(12)
//        .shadow(radius: 5)
//        .padding()
//    }
//
//    private func riskColor(for riskLevel: String) -> Color {
//        switch riskLevel.lowercased() {
//        case "hypoglycemia":
//            return .red
//        case "hyperglycemia":
//            return .orange
//        default:
//            return .green
//        }
//    }
//}

struct GlucoseAlertView: View {
    @ObservedObject var alertViewModel: GlucoseAlertViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                if let riskLevel = alertViewModel.riskLevel {
                    Image(systemName: icon(for: riskLevel))
                        .foregroundColor(riskColor(for: riskLevel))
                        .font(.title)
                }

                Text("Glucose Alert")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.top, 8)

            if let alertMessage = alertViewModel.alertMessage {
                Text(alertMessage)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }

            Divider().padding(.horizontal, 16)

            if let riskLevel = alertViewModel.riskLevel {
                Text("Risk Level: \(riskLevel.capitalized)")
                    .font(.headline)
                    .foregroundColor(riskColor(for: riskLevel))
                    .padding(.top, 4)
            }

            if let bloodGlucose = alertViewModel.bloodGlucose {
                Text("Blood Glucose: \(bloodGlucose, specifier: "%.1f") mg/dL")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Button(action: {
                alertViewModel.dismissAlert()
            }) {
                Text("Dismiss")
                    .fontWeight(.medium)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)
        }
        .padding()
        .background(riskColor(for: alertViewModel.riskLevel ?? ""))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    private func riskColor(for riskLevel: String) -> Color {
        switch riskLevel.lowercased() {
        case "hypoglycemia":
            return .red.opacity(0.15)
        case "hyperglycemia":
            return .orange.opacity(0.15)
        default:
            return .green.opacity(0.15)
        }
    }

    private func icon(for riskLevel: String) -> String {
        switch riskLevel.lowercased() {
        case "hypoglycemia":
            return "exclamationmark.triangle.fill"
        case "hyperglycemia":
            return "exclamationmark.octagon.fill"
        default:
            return "checkmark.seal.fill"
        }
    }
}

#Preview {
    GlucoseAlertView(alertViewModel: GlucoseAlertViewModel.shared)
}
