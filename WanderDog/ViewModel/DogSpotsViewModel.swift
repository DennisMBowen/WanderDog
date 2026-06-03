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
let dogSpotsStartingSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

class DogSpotsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var askForRadius: Bool = true
    @Published var testMessage: String = "Nope"
    @Published var isLoading: Bool = false
    @Published var dogSpots: [DogSpotModel] = []
    @Published var mapPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var userLocation: CLLocation?
    @Published var mapRoute: [CLLocationCoordinate2D] = []
    @Published var distanceInMiles = 0.0
    @Published var formattedDistance: String = ""
    @Published var routeHours: Int = 0
    @Published var routeMinutes: Int = 0
    var locationManager =  CLLocationManager()
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    
    
    func findDogSpots(radius: Int) async {
        self.isLoading = true
        self.askForRadius = false
//        dogSpots = await callFindDogFriendlyEstablishmentsMicroservice(
//            radius: radius,
//            startingLatitude: 47.6687604,
//            startingLongitude: -122.350254,
//        )
        print(userLatitude)
        print(userLongitude)
        if userLatitude != 0.0 && userLongitude != 0.0 {
//            dogSpots = await callFindDogFriendlyEstablishmentsMicroservice(
//                radius: radius,
//                startingLatitude: userLatitude,
//                startingLongitude: userLongitude,
//            )
            await getTestDogWalks()
        }
        print("Dog spots")
        print(dogSpots)
        testMessage = "Success"
        self.isLoading = false
    }
    
    func findRouteToDogSpot(destinationLatitude: Double, destinationLongitude: Double) async {
        self.isLoading = true
        
        let results: Route = await callFindRouteMicroservice(originLat: userLatitude, originLon: userLongitude, destinationLat: destinationLatitude, destinationLon: destinationLongitude)
        print("Route distance in meters:")
        print(results.route_distance_m)
        print("Route duration in seconds:")
        print(results.route_duration_sec)
        // print(results.geometry)
        
        
        for coordinate in results.geometry.coordinates {
            mapRoute.append(CLLocationCoordinate2D(latitude: coordinate[1], longitude: coordinate[0]))
        }
        let distanceDouble = Double(results.route_distance_m)
        distanceInMiles = await callConvertLengthMicroservice(measurement: distanceDouble, inputType: "m", conversionType: "mi")
        print(distanceInMiles)
        formattedDistance = String(format: "%.2f", distanceInMiles)
        
        let roundedDuration = Int(Double(results.route_duration_sec.rounded()))
        let convertTime = await callDurationConversionMicroservice(seconds: roundedDuration)
        print(convertTime.formatted)
        routeHours = convertTime.hours
        routeMinutes = convertTime.minutes
        
        self.isLoading = false
        
    }
    
    func getTestDogWalks() async {
        let sampleDogSpots: [DogSpotModel] = [
            DogSpotModel(name: "Kiss Cafe", latitude: 47.6684721, longitude: -122.3937385),
            DogSpotModel(name: "My Friend Derek’s", latitude: 47.6688088, longitude: -122.333408),
            DogSpotModel(name: "Pine Tavern", latitude: 47.66425, longitude: -122.3787054)
        ]
        dogSpots.append(contentsOf: sampleDogSpots)
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
