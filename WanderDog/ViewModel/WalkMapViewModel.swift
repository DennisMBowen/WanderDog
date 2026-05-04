//
//  WalkMapViewModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/2/26.
//

import Foundation
import MapKit
import SwiftUI
internal import Combine

let defaultStartingLocation = CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118)
let defaultEndingLocation = CLLocationCoordinate2D(latitude: 37.331675, longitude: -120.02)
let defaultStartingSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)

class WalkMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: defaultStartingLocation,
            span: defaultStartingSpan)
        )
    
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @Published var walkCoordinates: [CLLocationCoordinate2D] = []
    @Published var trackWalk: Bool = false
    @Published var walkFinished: Bool = false
    
    @Published var startTime: Date = Date.now
    @Published var endTime: Date = Date.now
    @Published var milesTraveled = 0.00
    
    
    var locationManager: CLLocationManager?
    
    func isLocationServicesEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.activityType = .fitness
            locationManager?.startUpdatingLocation()
        }
        else {
            print("Error encountered during isLocationServicesEanbled check")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        // Send alerts
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location permission is restricted, likely due to by parental controls")
        case .denied:
            print("Location permissions has been denied. User must go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            position = .userLocation(fallback: .automatic)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        if self.trackWalk{
            walkCoordinates.append(lastLocation!.coordinate)
        }
    }
    
    func startTrackingWalk() {
        self.startTime = Date.now
        trackWalk = true
    }
    
    func finishButtonPressed() {
        self.milesTraveled = calculateMilesTraveled()
        self.endTime = Date.now
        self.trackWalk = false
        self.walkFinished = true
    }
    
    func resumeButtonPressed() {
        self.trackWalk = true
        self.walkFinished = false
    }
    
    private func calculateMilesTraveled() -> Double {
        var totalDistance = 0.00
        
        var i = 0
        var j = 1
        
        while j <= walkCoordinates.count - 1 {
            let startLocation = CLLocation(latitude: walkCoordinates[i].latitude, longitude: walkCoordinates[i].longitude)
            let endLocation = CLLocation(latitude: walkCoordinates[j].latitude, longitude: walkCoordinates[j].longitude)
            print(endLocation)
            
            let distanceInMeters = startLocation.distance(from: endLocation)
            totalDistance += distanceInMeters
            
            i += 1
            j += 1
        }
        
        // Convert meters to miles
        return totalDistance * 0.00062137
    }
    
    func resetWalk() {
        self.walkCoordinates = []
        self.milesTraveled = 0.0
        self.trackWalk = false
        self.walkFinished = false
    }
    
    private func resetMiles() {
        self.milesTraveled = 0.0
    }
}
