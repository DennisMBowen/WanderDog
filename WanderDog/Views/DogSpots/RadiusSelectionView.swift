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
    
    let miles = stride(from: 1, through: 10, by: 1.0).map { $0 }
    
    var body: some View {
        VStack {
            Text("How many miles do you want to walk?")
                .font(.title3)
            Picker("Miles walked:", selection: $selectedRadius) {
                ForEach(miles, id: \.self) { mile in
                    Text(String(format: "%1.f", mile))
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()
            Button{
                dogSpotsViewModel.setRadius(radius: selectedRadius)
            } label: {
                Text("Search Locations")
                    .frame(width: 280, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.title3)
            }
        }
             
    }
}

#Preview {
    @Previewable @StateObject var dogSpotsViewModel = DogSpotsViewModel()
    
    RadiusSelectionView(
        dogSpotsViewModel: dogSpotsViewModel
    )
}
