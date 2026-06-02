//
//  DogSpotsMapView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 6/1/26.
//

import SwiftUI
import MapKit

struct DogSpotsMapView: View {
    
    @ObservedObject var dogSpotsViewModel: DogSpotsViewModel
    var body: some View {
        Map(initialPosition: dogSpotsViewModel.mapRegion) {
            UserAnnotation()
            ForEach (dogSpotsViewModel.dogSpots) { dogSpot in
                 Annotation(
                    dogSpot.name,
                    coordinate: CLLocationCoordinate2D(latitude: dogSpot.latitude, longitude: dogSpot.longitude),
                    anchor: .bottom) {
                        Image(systemName: "wineglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.white)
                            .frame(width: 12, height: 20)
                            .padding(5)
                            .background(.pink)
                            .cornerRadius(12)
                            .contextMenu{
                                Button("Get Directions", systemImage: "figure.walk") {
                                    Task {
                                        await dogSpotsViewModel.findRouteToDogSpot(destinationLatitude: dogSpot.latitude, destinationLongitude: dogSpot.longitude)
                                    }
                                }
                            }
                    }
            }
            MapPolyline(coordinates: dogSpotsViewModel.mapRoute)
                .stroke(.pink, lineWidth: 5)
        }
        .tint(.pink)
    }
}

#Preview {
    @Previewable @StateObject var dogSpotsViewModel = DogSpotsViewModel()
    DogSpotsMapView(
        dogSpotsViewModel: dogSpotsViewModel
    )
}
