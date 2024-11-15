//
//  GlucoseAlertData.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import Foundation

struct GlucoseAlertData: Decodable {
    let advice: String
    let bg: Double
    let risk: String
    let ts: TimeInterval

    var time: Date {
        return Date(timeIntervalSince1970: ts / 1000)
    }
}
