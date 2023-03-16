//
//  ContentViewRow.swift
//  learningApp
//
//  Created by Leonardo Caracho on 15/03/23.
//

import SwiftUI

struct ContentViewRow: View {
    var lesson: Lesson
    var index: Int
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack(spacing: 30) {
                
                Text("\(index + 1)")
                    .bold()
                
                VStack (alignment: .leading) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding()
        }
        .padding(.bottom, 5)
    }
}

struct ContentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        let lesson = Lesson(id: 1, title: "", video: "", duration: "", explanation: "")
        ContentViewRow(lesson: lesson, index: 1)
    }
}
