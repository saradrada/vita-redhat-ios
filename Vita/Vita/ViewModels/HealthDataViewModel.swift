//
//  HealthDataViewModel.swift
//  Vita
//

import SwiftUI
import HealthKit

class HealthDataViewModel: ObservableObject {
    private var healthStore = HKHealthStore()
    private let favoritesKey = "HealthDataFavorites"

    @Published var healthDataItems: [HealthDataItem] = [
        HealthDataItem(title: "Age", value: "", isFavorite: false),
        HealthDataItem(title: "Biological Sex", value: "", isFavorite: false),
        HealthDataItem(title: "Height", value: "", isFavorite: false),
        HealthDataItem(title: "Weight", value: "", isFavorite: false),
//        HealthDataItem(title: "Blood Pressure", value: "", isFavorite: false),
//        HealthDataItem(title: "Blood Glucose", value: "", isFavorite: false),
        HealthDataItem(title: "Heart Rate", value: "", isFavorite: false)
    ]

    init() {
        loadFavorites()
        requestHealthData()
    }

    func toggleFavorite(for item: HealthDataItem) {
        if let index = healthDataItems.firstIndex(where: { $0.id == item.id }) {
            healthDataItems[index].isFavorite.toggle()
            saveFavorites()
            sortItems()
        }
    }

    private func saveFavorites() {
        let favoriteTitles = healthDataItems
            .filter { $0.isFavorite }
            .map { $0.title }
        UserDefaults.standard.set(favoriteTitles, forKey: favoritesKey)
    }

    private func loadFavorites() {
        let favoriteTitles = UserDefaults.standard.array(forKey: favoritesKey) as? [String] ?? []
        for index in healthDataItems.indices {
            if favoriteTitles.contains(healthDataItems[index].title) {
                healthDataItems[index].isFavorite = true
            }
        }
    }

    func sortItems() {
        healthDataItems.sort { $0.isFavorite && !$1.isFavorite }
    }

    private func updateItemValue(for title: String, with newValue: String) {
        if let index = healthDataItems.firstIndex(where: { $0.title == title }) {
            healthDataItems[index].value = newValue
        }
    }


    // MARK: - Retrieve health data

    private func requestHealthData() {
        if HKHealthStore.isHealthDataAvailable() {
            let healthKitTypes: Set<HKObjectType> = [
                HKObjectType.characteristicType(forIdentifier: .biologicalSex)!,
                HKObjectType.characteristicType(forIdentifier: .dateOfBirth)!,
                HKObjectType.quantityType(forIdentifier: .height)!,
                HKObjectType.quantityType(forIdentifier: .bodyMass)!,
                HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!,
                HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!,
                HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
                HKObjectType.quantityType(forIdentifier: .heartRate)!
            ]

            healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.retrieveAge()
                        self.retrieveBiologicalSex()
                        self.retrieveHeight()
                        self.retrieveWeight()
                        self.retrieveBloodPressure()
                        self.retrieveBloodGlucose()
                        self.retrieveHeartRate()
                    }
                } else if let error = error {
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
        }
    }

    private func retrieveAge() {
        do {
            if let dateOfBirth = try healthStore.dateOfBirthComponents().date {
                let calendar = Calendar.current
                let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: Date())
                if let age = ageComponents.year {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateItemValue(for: "Age", with: String(age))
                    }
                }
            }
        } catch {
            print("Failed to retrieve age: \(error.localizedDescription)")
        }
    }

    private func retrieveBiologicalSex() {
        do {
            let sex = try healthStore.biologicalSex().biologicalSex
            var sexString = "Unknown"
            switch sex {
            case .female: sexString = "Female"
            case .male: sexString = "Male"
            case .other: sexString = "Other"
            default: break
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateItemValue(for: "Biological Sex", with: sexString)
            }
        } catch {
            print("Failed to retrieve biological sex: \(error.localizedDescription)")
        }
    }

    private func retrieveHeight() {
        let heightType = HKQuantityType.quantityType(forIdentifier: .height)!
        let query = HKSampleQuery(sampleType: heightType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let heightInMeters = result.quantity.doubleValue(for: HKUnit.meter())
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Height", with: String(format: "%.2f", heightInMeters))
                }
            } else {
                DispatchQueue.main.async {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateItemValue(for: "Height", with: "No data")
                    }
                }
                print("Failed to retrieve height: \(error?.localizedDescription ?? "No error description")")
            }
        }
        healthStore.execute(query)
    }

    private func retrieveWeight() {
        let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        let query = HKSampleQuery(sampleType: weightType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let weightInKilograms = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Weight", with: String(format: "%.2f", weightInKilograms))
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Weight", with: "No data")
                }
                print("Failed to retrieve weight: \(error?.localizedDescription ?? "No error description")")
            }
        }
        healthStore.execute(query)
    }

    private func retrieveBloodPressure() {
        let systolicType = HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)!
        let diastolicType = HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        let query = HKSampleQuery(sampleType: systolicType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
            if let systolicResult = results?.first as? HKQuantitySample {
                let systolicValue = systolicResult.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                let diastolicQuery = HKSampleQuery(sampleType: diastolicType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
                    if let diastolicResult = results?.first as? HKQuantitySample {
                        let diastolicValue = diastolicResult.quantity.doubleValue(for: HKUnit.millimeterOfMercury())

                        DispatchQueue.main.async { [weak self] in
                            self?.updateItemValue(for: "Blood Pressure", with: String(format: "%.0f/%.0f mmHg", systolicValue, diastolicValue))
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.updateItemValue(for: "Blood Pressure", with: "No data")
                        }
                        print("Failed to retrieve diastolic blood pressure: \(error?.localizedDescription ?? "No error description")")
                    }
                }
                self.healthStore.execute(diastolicQuery)
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Blood Pressure", with: "No data")
                }
                print("Failed to retrieve systolic blood pressure: \(error?.localizedDescription ?? "No error description")")
            }
        }
        healthStore.execute(query)
    }

    private func retrieveBloodGlucose() {
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let query = HKSampleQuery(sampleType: bloodGlucoseType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let glucoseValue = result.quantity.doubleValue(for: HKUnit.gramUnit(with: .deci))
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Blood Glucose", with: String(format: "%.2f mg/dL", glucoseValue))
                }

            } else {
                DispatchQueue.main.async {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateItemValue(for: "Blood Glucose", with: "No data")
                    }
                }
                print("Failed to retrieve blood glucose: \(error?.localizedDescription ?? "No error description")")
            }
        }
        healthStore.execute(query)
    }

    private func retrieveHeartRate() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]) { (_, results, error) in
            if let result = results?.first as? HKQuantitySample {
                let heartRateValue = result.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                DispatchQueue.main.async { [weak self] in
                    self?.updateItemValue(for: "Heart Rate", with: String(format: "%.0f bpm", heartRateValue))
                }
            } else {
                DispatchQueue.main.async {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateItemValue(for: "Heart Rate", with: "No data")
                    }
                }
                print("Failed to retrieve heart rate: \(error?.localizedDescription ?? "No error description")")
            }
        }
        healthStore.execute(query)
    }
}
