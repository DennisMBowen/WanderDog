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

class DogSpotsViewModel:ObservableObject{
    
    @Published var radius: Int = 0
    @Published var testMessage: String = "Nope"
    
    init() {
        self.radius = radius
    }
    
    func getRadius() -> Int {
        return radius
    }
    
    func setRadius(radius: Int) {
        self.radius = radius
    }
    
    func findDogSpots(radius: Int) {
        
        let dogSpots = callFindDogFriendlyEstablishmentsMicroservice(
            radius: radius,
            startingLatitude: 47.6687604,
            startingLongitude: -122.350254,
        )
        self.testMessage = "Finished"
    }
    
}
