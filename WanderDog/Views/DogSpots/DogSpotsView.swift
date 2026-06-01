//
//  DogSpotsView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/30/26.
//

import SwiftUI
import MapKit

struct DogSpotsView: View {
    
    @StateObject var dogSpotsViewModel = DogSpotsViewModel()
    
    var body: some View {
        VStack (){
            TitleView(titleText: "Dog Spots")
            Text("Find nearby places to bring your dog!")
                .font(.title2)
            Spacer()
            if dogSpotsViewModel.isLoading {
                Text("Loading...")
                    .font(.title)
                Spacer()
            }
            else if dogSpotsViewModel.askForRadius {
                RadiusSelectionView(dogSpotsViewModel: dogSpotsViewModel)
                Spacer()
            }
            else {
                Map(position: $dogSpotsViewModel.mapPosition) {
                    UserAnnotation()
                }
            }
        }
        .onAppear {
            dogSpotsViewModel.checkLocationAuthorization()
        }
    }
}

#Preview {
    DogSpotsView()
}
