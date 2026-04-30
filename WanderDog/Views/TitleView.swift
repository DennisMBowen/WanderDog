//
//  TitleView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/25/26.
//

import SwiftUI

struct TitleView: View {
    
    var titleText: String
    
    var body: some View {
        Text(titleText)
            .font(.title)
            .bold()
    }
}

#Preview {
    TitleView(
        titleText: "Rover"
    )
}
