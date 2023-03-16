//
//  HomeViewRow.swift
//  learningApp
//
//  Created by Leonardo Caracho on 13/03/23.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
                
            
            HStack {
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Learn \(title)")
                        .bold()
                    
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    HStack {
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("\(count)")
                            .font(.caption2)
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("\(time)")
                            .font(.caption2)
                    }
                    
                }
                
            }
            .padding(.horizontal, 20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(
            image: "swift", title: "Swift", description: "Swift lessons for all the family", count: "10", time: "10 hours"
        )
    }
}
