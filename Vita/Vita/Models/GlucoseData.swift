//
//  GlucoseData.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 24.10.24.
//

import Foundation

struct GlucoseData: Identifiable, Codable {
    var id = UUID()
    var time: Date
    var glucose: Decimal

    private enum CodingKeys: String, CodingKey {
        case time = "ts"
        case glucose = "bg"
    }
}
