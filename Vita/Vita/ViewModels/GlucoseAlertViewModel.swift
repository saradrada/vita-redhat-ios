//
//  GlucoseLevelAlertViewModel.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import SwiftUI
import Combine

class GlucoseAlertViewModel: ObservableObject {
    static let shared = GlucoseAlertViewModel()

    @Published var alertMessage: String?
    @Published var riskLevel: String?
    @Published var bloodGlucose: Double?
    @Published var isShowingAlert = false

    private init() {}

    func handleAlert(alert: GlucoseAlertData) {
        guard !isShowingAlert else { return }

        alertMessage = alert.advice
        riskLevel = alert.risk
        bloodGlucose = alert.bg
        isShowingAlert = true
    }

    func dismissAlert() {
        isShowingAlert = false
        alertMessage = nil
        riskLevel = nil
        bloodGlucose = nil
    }
}
