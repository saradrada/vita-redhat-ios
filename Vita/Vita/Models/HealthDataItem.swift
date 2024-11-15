//
//  HealthDataItem.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 16.10.24.
//

import Foundation

struct HealthDataItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    var value: String
    var isFavorite: Bool
}
