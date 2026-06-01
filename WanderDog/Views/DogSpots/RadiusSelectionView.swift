//
//  RadiusSelectionView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/31/26.
//

import SwiftUI

struct RadiusSelectionView: View {
    
    @ObservedObject var dogSpotsViewModel: DogSpotsViewModel
    @State var selectedRadius: Int = 1
    
    var body: some View {
        VStack {
            Text("How many miles do you want to walk?")
                .font(.title3)
            Picker("Miles walked:", selection: $selectedRadius) {
                ForEach(1...10, id: \.self) { number in
                    Text("\(number)")
                        .tag(number)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()
            Button{
                Task {
                    await dogSpotsViewModel.findDogSpots(radius: selectedRadius)
                }
            } label: {
                Text("Search Locations")
                    .frame(width: 280, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
             
    }
    
    func searchLocationsButtonsPressed() async {
        await dogSpotsViewModel.findDogSpots(radius: selectedRadius)
    }
}

#Preview {
    @Previewable @StateObject var dogSpotsViewModel = DogSpotsViewModel()
    
    RadiusSelectionView(
        dogSpotsViewModel: dogSpotsViewModel
    )
}
