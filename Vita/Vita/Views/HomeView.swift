//
//  HomeView.swift
//  Vita
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 1
    @State private var showProfileSetup = false
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        TabView(selection: $selection) {
            ZStack {
                ScrollView {
                    VStack(spacing: 16) {
                        header
                        HealthDataSectionView()
                        Divider()
                        GlucoseLevelChart()
                        GlucoseLevelCard()
                        Spacer()
                    }
                }
                .ignoresSafeArea()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(1)
        }
        .fullScreenCover(isPresented: .constant(!profileViewModel.isProfileComplete)) {
            ProfileSetupView(viewModel: profileViewModel)
                .transition(.move(edge: .leading))
        }
    }

    private var header: some View {
        ZStack(alignment: .top) {
            LinearGradient(gradient:
                            Gradient(colors: [
                                .brightCyan,
                                .brightCyan.opacity(0.4)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.all)

            HStack {
                Text("Welcome to Vita")
                Spacer()
                Image(systemName: "person.circle.fill")
                Image(systemName: "bell")
            }
            .font(.title2)
            .foregroundStyle(.white)
            .padding(.top, 64)
            .padding(.horizontal, 32)
        }
        .frame(height: 140)
    }
}

#Preview {
    HomeView(profileViewModel: ProfileViewModel())
}
