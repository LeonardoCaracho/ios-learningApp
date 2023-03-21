//
//  TestResultView.swift
//  learningApp
//
//  Created by Leonardo Caracho on 21/03/23.
//

import SwiftUI

struct TestResultView: View {
    @EnvironmentObject var model: ContentModel
    var numCorrect: Int
    
    var resultHeading: String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let percent = Double(numCorrect) / Double(model.currentModule!.test.questions.count)
        
        if percent > 0.5 {
            return "Awesome!"
        }
        else if (percent > 0.2) {
            return "Doing great!"
        }
        else {
            return "Keep learning."
        }
        
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            Button(
                action: {
                    model.currentTestSelected = nil
                },
                label: {
                    ZStack {
                        RectangleCard(color: .green, height: 48)
                        
                        Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            )
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
