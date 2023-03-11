//
//  learningAppApp.swift
//  learningApp
//
//  Created by Leonardo Caracho on 11/03/23.
//

import SwiftUI

@main
struct learningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
