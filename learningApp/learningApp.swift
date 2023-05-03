//
//  learningAppApp.swift
//  learningApp
//
//  Created by Leonardo Caracho on 11/03/23.
//

import SwiftUI
import FirebaseCore

@main
struct learningApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
