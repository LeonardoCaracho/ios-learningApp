//
//  RectangleCard.swift
//  learningApp
//
//  Created by Leonardo Caracho on 19/03/23.
//

import SwiftUI

struct RectangleCard: View {
    var color = Color.white
    var height = 48.0
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
