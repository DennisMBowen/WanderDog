//
//  DogSpotsView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/30/26.
//

import SwiftUI

struct DogSpotsView: View {
    
    @StateObject var dogSpotsViewModel = DogSpotsViewModel()
    
    var body: some View {
        VStack (){
            TitleView(titleText: "Dog Spots")
            Text("Find nearby places to bring your dog!")
                .font(.title2)
            Spacer()
            if dogSpotsViewModel.getRadius() == 0 {
                RadiusSelectionView(dogSpotsViewModel: dogSpotsViewModel)
            }
            else {
                Text(dogSpotsViewModel.testMessage)
            }
            Spacer()
        }
    }
}

#Preview {
    DogSpotsView()
}
