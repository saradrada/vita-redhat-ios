//
//  LaunchScreenView.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 15.10.24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(gradient: Gradient(colors: [.lightGold, .brightCyan, .steelBlue]), startPoint: .top, endPoint: .bottom)
                .overlay(.ultraThinMaterial)

            LottieView(animation: .launch())
                .frame(width: 200)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SplashScreenView()
}
