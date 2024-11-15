//
//  TIRPieChart.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 27.10.24.
//

import SwiftUI
import Charts

struct TIRPieChart: View {
    let data: [TIRValue]
    @State private var selectedAngle: Double?
    
    private let colorMapping: [String: Color] = [
            "Within Target Range": .green,
            "Below Minimum Range": .brightCyan,
            "Above Maximum Range": .red
        ]

    var body: some View {
        Chart(data, id: \.category) { item in
            SectorMark(
                angle: .value("Percentage", item.value),
                innerRadius: .ratio(0.6),
                angularInset: 2
            )
            .cornerRadius(5)
            .foregroundStyle(by: .value("Category", item.category))
            .opacity(item.category == selectedItem?.category ? 1 : 0.5)
        }
        .scaledToFit()
        .chartLegend(alignment: .center, spacing: 16)
        .chartAngleSelection(value: $selectedAngle)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                    let frame = geometry[anchor]
                    titleView
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        .padding()
    }

    private var titleView: some View {
        VStack {
            Text(selectedItem?.category ?? "Time in Range")
                .font(.title3)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 150)
            Text((selectedItem?.value.formatted() ?? "") + "%")
                .font(.callout)
                .foregroundStyle(.gray)
        }
    }

    var selectedItem: TIRValue? {
        guard let selectedAngle else { return nil }
        let cumulativeAngles = data.map(\.value).reduce(into: [0]) { cumulative, next in
            cumulative.append(cumulative.last! + next)
        }

        for (index, range) in zip(data.indices, zip(cumulativeAngles, cumulativeAngles.dropFirst())) {
            if Double(range.0)..<Double(range.1) ~= selectedAngle {
                return data[index]
            }
        }

        return nil
    }
}

#Preview {
    TIRPieChart(data: byCategory)
}

struct TIRValue {
    var category: String
    var value: Double
}

let byCategory: [TIRValue] = [
    .init(category: "Within Target Range", value: 79),
    .init(category: "Below Minimum Range", value: 15),
    .init(category: "Above Maximum Range", value: 6)
]
