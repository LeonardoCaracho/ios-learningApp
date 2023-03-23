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
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            
                            VStack(spacing: 20) {
                                
                                NavigationLink(
                                    tag: module.id,
                                    selection: $model.currentContentSelected,
                                    destination: {
                                        ContentView()
                                            .onAppear {
                                                model.beginModule(module.id)
                                            }
                                    },
                                    label: {
                                        HomeViewRow(
                                            image: module.content.image,
                                            title: module.category,
                                            description: module.content.description,
                                            count: "\(module.content.lessons.count) Lessons",
                                            time: module.content.time
                                        )
                                    })
                                
                                NavigationLink(
                                    tag: module.id,
                                    selection: $model.currentTestSelected,
                                    destination: {
                                        TestView()
                                            .onAppear {
                                                model.beginTest(module.id)
                                            }
                                    },
                                    label: {
                                        HomeViewRow(
                                            image: module.test.image,
                                            title: module.category,
                                            description: module.test.description,
                                            count: "\(module.test.questions.count) Questions",
                                            time: module.test.time
                                        )
                                    }
                                )
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Get started")
            .onChange(of: model.currentContentSelected, perform: { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            })
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
