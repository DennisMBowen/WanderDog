//
//  WalkMapButtonView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/3/26.
//

import SwiftUI

struct WalkMapButtonView: View {
    
    var buttonLabel: String
    var buttonColor: Color
    
    var body: some View {
        Text(buttonLabel)
            .frame(width: 120, height: 40)
            .background(buttonColor)
            .opacity(0.8)
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.semibold)
            .cornerRadius(10)
    }
}

#Preview {
    
    let buttonText = "Test"
    let buttonColor = Color.blue
    
    WalkMapButtonView(
        buttonLabel: buttonText, buttonColor: buttonColor
    )
}
