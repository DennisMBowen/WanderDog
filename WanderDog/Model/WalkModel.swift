//
//  WalkModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/25/26.
//

import Foundation

struct WalkModel: Identifiable, Codable {
    let id: String
    let startTime: Date
    let endTime: Date
    let distance: Double
    
    init(id: String = UUID().uuidString, startTime: Date, endTime: Date, distance: Double) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.distance = distance
    }
}
