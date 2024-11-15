//
//  Homepage.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 15.10.24.
//

import Foundation
import SwiftUI

struct HealthDataSectionView: View {
    @StateObject private var viewModel = HealthDataViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Personal Data")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.healthDataItems.indices, id: \.self) { index in
                        HealthDataCard(viewModel: viewModel, item: viewModel.healthDataItems[index])
                    }
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            viewModel.sortItems()
        }
    }
}

#Preview {
    HealthDataSectionView()
}
