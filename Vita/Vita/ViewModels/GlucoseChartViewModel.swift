//
//  GlucoseChartViewModel.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 24.10.24.
//

import Foundation
import Combine

class GlucoseChartViewModel: ObservableObject {
    @Published var glucoseData: [GlucoseData] = []
    private let webSocketHandler: WebSocketMessageHandler
    private let minLimit: Double = 70
    private let maxLimit: Double = 180

    init() {
        webSocketHandler = WebSocketMessageHandler(urlString: "ws://192.168.2.187:8765")
        webSocketHandler.glucoseChartViewModel = self
        loadGlucoseData()
        startListening()
    }

    func getGlucose(for time: Date) -> Decimal? {
        let calendar = Calendar.current
        if let dataPoint = glucoseData.first(where: { calendar.isDate($0.time, equalTo: time, toGranularity: .minute) }) {
            let glucoseValue = NSDecimalNumber(decimal: dataPoint.glucose).rounding(accordingToBehavior: twoDecimalRoundingHandler)
            return glucoseValue.decimalValue
        }
        return nil
    }

    private let twoDecimalRoundingHandler: NSDecimalNumberHandler = {
        return NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    }()


    func startListening() {
        webSocketHandler.startListening()
    }

    func stopListening() {
        webSocketHandler.stopListening()
    }

    func getMinLimit() -> Double {
        minLimit
    }

    func getMaxLimit() -> Double {
        maxLimit
    }

    func updateGlucoseData(with newGlucoseData: [GlucoseData]) {
        glucoseData.append(contentsOf: newGlucoseData)
        if glucoseData.count > 6 {
            glucoseData = Array(glucoseData.suffix(6))
        }
        saveGlucoseData()
    }

    private func saveGlucoseData() {
        if let encoded = try? JSONEncoder().encode(glucoseData) {
            UserDefaults.standard.set(encoded, forKey: "lastGlucoseData")
        }
    }

    private func loadGlucoseData() {
        if let savedData = UserDefaults.standard.data(forKey: "lastGlucoseData"),
           let decodedData = try? JSONDecoder().decode([GlucoseData].self, from: savedData) {
            glucoseData = decodedData
        }
    }

    deinit {
        stopListening()
    }
}
