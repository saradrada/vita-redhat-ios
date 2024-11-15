//
//  DemoChart.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 24.10.24.
//

import SwiftUI
import Charts

struct GlucoseLevelChart: View {
    @Environment(\.calendar) private var calendar
    @StateObject private var viewModel = GlucoseChartViewModel() 
    @State private var chartSelection: Date?

    private var areaBackground: Gradient {
        Gradient(colors: [Color.accentColor, Color.accentColor.opacity(0.1)])
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Glucose Levels")
            Chart(viewModel.glucoseData) { dataPoint in
                LineMark(
                    x: .value("Time", dataPoint.time, unit: .minute),
                    y: .value("Glucose (mg/dL)", dataPoint.glucose)
                )
                .symbol(.circle)
                .interpolationMethod(.catmullRom)

                AreaMark(
                    x: .value("Time", dataPoint.time, unit: .minute),
                    yStart: .value("Glucose Start", dataPoint.glucose),
                    yEnd: .value("Glucose End", 0)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(areaBackground)

                if let chartSelection, viewModel.getGlucose(for: chartSelection) != nil {
                    RuleMark(x: .value("Time", chartSelection, unit: .minute))
                        .foregroundStyle(.yellow.opacity(0.5))
                        .annotation(
                            position: .automatic,
                            overflowResolution: .init(x: .disabled, y: .fit)
                        ) {
                            ZStack {
                                Text("\(viewModel.getGlucose(for: chartSelection)!) mg/dL")
                                    .font(.caption)
                                    .padding(.horizontal, 4)
                                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.yellow.opacity(0.7)))
                            }
                        }
                        .zIndex(1)
                }

                RuleMark(y: .value("Min Limit", viewModel.getMinLimit()))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    .foregroundStyle(.green)
                    .annotation(position: .trailing) {
                        Text("Min")
                            .foregroundColor(.green)
                            .font(.caption)

                    }

                RuleMark(y: .value("Max Limit", viewModel.getMaxLimit()))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 5]))
                    .foregroundStyle(.red)
                    .annotation(position: .trailing) {
                        Text("Max")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .minute, count: 3)) { _ in
                    AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
                }
            }
            .chartYScale(domain: 0 ... 200)
            .frame(height: 200)
            .chartXSelection(value: $chartSelection)
            .padding(.bottom)

//            details
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            viewModel.startListening()
        }
        .onDisappear {
            viewModel.stopListening()
        }
    }

    private var details: some View {
        Text("details")
    }
}

#Preview {
    GlucoseLevelChart()
}
