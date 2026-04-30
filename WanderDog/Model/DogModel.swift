//
//  DogModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/28/26.
//

import Foundation

struct DogModel: Identifiable, Codable {
    let id: String
    var name: String
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}
