//
//  DogSpotsViewModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/30/26.
//

import Foundation
import MapKit
import SwiftUI
internal import Combine

let dogSpotsStartingLocation = CLLocationCoordinate2D(latitude: 47.6687604, longitude: -122.350254)
let dogSpotsStartingSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)

class DogSpotsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var askForRadius: Bool = true
    @Published var testMessage: String = "Nope"
    @Published var isLoading: Bool = false
    @Published var dogSpots: [DogSpotModel] = []
    @Published var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var userLocation: CLLocation?
    var locationManager =  CLLocationManager()
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
  
    
    
    func findDogSpots(radius: Int) async {
        print("Button pressed")
        self.isLoading = true
        self.askForRadius = false
//        dogSpots = await callFindDogFriendlyEstablishmentsMicroservice(
//            radius: radius,
//            startingLatitude: 47.6687604,
//            startingLongitude: -122.350254,
//        )
        print(userLatitude)
        print(userLongitude)
        print(userLatitude)
        print(userLongitude)
        if userLatitude != 0.0 && userLongitude != 0.0 {
            dogSpots = await callFindDogFriendlyEstablishmentsMicroservice(
                radius: radius,
                startingLatitude: userLatitude,
                startingLongitude: userLongitude,
            )
        }
        print("Dog spots")
        print(dogSpots)
        testMessage = "Success"
        self.isLoading = false
    }
    
    // Map and User Location logic
    @Published var mapRegion: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: dogSpotsStartingLocation,
            span: dogSpotsStartingSpan)
        )
    
    func checkLocationAuthorization() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        // Send alerts
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location permission is restricted, likely due to by parental controls")
        case .denied:
            print("Location permissions has been denied. User must go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            mapPosition = .userLocation(fallback: .automatic)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        self.userLatitude = userLocation?.coordinate.latitude ?? 0.0
        self.userLongitude = userLocation?.coordinate.longitude ?? 0.0
    }
    
}
