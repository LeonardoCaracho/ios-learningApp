//
//  ContentView.swift
//  learningApp
//
//  Created by Leonardo Caracho on 11/03/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
