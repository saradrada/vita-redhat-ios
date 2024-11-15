//
//  HomeView.swift
//  Vita
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @State private var isSplashScreen = true
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                if isSplashScreen {
                    SplashScreenView()
                } else {
                    if authViewModel.isAuthenticated {
                        HomeView(profileViewModel: profileViewModel)
                    }else {
                        LoginView()
                    }
                }
            }
            .overlay(
                GlucoseAlertOverlayView()
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isSplashScreen = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
