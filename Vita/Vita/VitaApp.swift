//
//  VitaApp.swift
//  Vita
//

import Firebase
import SwiftUI

@main
struct VitaApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
