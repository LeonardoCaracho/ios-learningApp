//
//  ContentView.swift
//  learningApp
//
//  Created by Leonardo Caracho on 15/03/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                if let module = model.currentModule {
                    
                    ForEach(0..<module.content.lessons.count) { index in
                        let lesson = module.content.lessons[index]
                        ContentViewRow(lesson: lesson, index: index)
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ContentModel())
    }
}
