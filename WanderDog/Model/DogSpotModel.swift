//
//  DogSpotModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/31/26.
//

import Foundation

struct DogSpotModel: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(id: String = UUID().uuidString, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
