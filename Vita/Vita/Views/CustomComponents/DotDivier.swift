//
//  DotDivier.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 26.10.24.
//

import SwiftUI

struct DotDivier: View {
    var numberOfDots: Int = 3
    var dotSize: CGFloat = 8
    var dotSpacing: CGFloat = 4
    var dotColor: Color = .steelBlue

    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(1...numberOfDots, id: \.self) { _ in
                Circle()
                    .fill(dotColor)
                    .frame(width: dotSize, height: dotSize)
            }
        }
    }
}


#Preview {
    DotDivier()
}
