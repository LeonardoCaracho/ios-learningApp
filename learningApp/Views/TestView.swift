//
//  TestView.swift
//  learningApp
//
//  Created by Leonardo Caracho on 19/03/23.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        if model.currentQuestion != nil {
            VStack(alignment: .leading) {
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                CodeTextView()
                    .padding(.horizontal, 20)
                
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button(action: {
                                selectedAnswerIndex = index
                            }) {
                                ZStack {
                                    
                                    if submitted == false {
                                        RectangleCard(
                                            color: index == selectedAnswerIndex ? .gray : .white,
                                            height: 48
                                        )
                                    } else {
                                        if (index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex) ||
                                            index == model.currentQuestion!.correctIndex {
                                            RectangleCard(
                                                color: .green,
                                                height: 48
                                            )
                                        }
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            RectangleCard(
                                                color: .red,
                                                height: 48
                                            )
                                        } else {
                                            RectangleCard(
                                                color: .white,
                                                height: 48
                                            )
                                        }
                                    }
                                    
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                Button(action: {
                    if submitted == true {
                        model.nextQuestion()
                        
                        submitted = false
                        selectedAnswerIndex = nil
                    } else {
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                        
                        submitted = true
                    }
                }) {
                    ZStack {
                        RectangleCard(color: .green, height: 48)
                        
                        Text(buttonText)
                            .bold()
                    }
                }
                .accentColor(.white)
                .padding()
                .disabled(selectedAnswerIndex == nil)
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else {
            TestResultView(numCorrect: numCorrect)
        }
    }
    
    var buttonText:String {
        if submitted {
            return model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count ?
            "Finish" :
            "Next"
        }
        
        return "Submit"
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(ContentModel())
    }
}
