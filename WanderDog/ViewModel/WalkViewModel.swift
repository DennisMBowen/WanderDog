//
//  WalkViewModel.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/25/26.
//

import Foundation
internal import Combine
import SwiftUI
import CoreLocation

class WalkViewModel: ObservableObject {
        
    // DogModel Logic
    @Published var dog: DogModel = DogModel(name: "")
    
    func addDogName (name: String) {
        self.dog.name = name
    }
    
    func getDogName() -> String {
        return self.dog.name
    }
    
    func dogExists() -> Bool {
        if self.dog.name != "" {
            return true
        }
        return false
    }
    
    
    // WalkModel Logic
    @Published var walks: [WalkModel] = [] {
        didSet {
            saveWalks()
        }
    }
    let walksKey: String = "walks_list"
    
    init() {
        getSavedWalks()
    }
    
    func getSavedWalks() {
        // Test Items
//        let sampleWalks: [WalkModel] = [
//            WalkModel(startTime: Date.now, endTime: Date.now, distance: 1.3),
//            WalkModel(startTime: Date.now, endTime: Date.now, distance: 2.2),
//            WalkModel(startTime: Date.now, endTime: Date.now, distance: 1.9),
//        ]
//        walks.append(contentsOf: sampleWalks)
        
        guard
            let data = UserDefaults.standard.data(forKey: walksKey),
            let savedWalks = try? JSONDecoder().decode([WalkModel].self, from: data)
        else { return }
        self.walks = savedWalks
    }
    
    func deleteWalk(indexSet: IndexSet) {
        walks.remove(atOffsets: indexSet)
    }
    
    func addWalk(startTime: Date, endTime: Date, distance: Double) {
        let newWalk = WalkModel(startTime: startTime, endTime: endTime, distance: distance)
        walks.append(newWalk)
    }
    
    func saveWalks() {
        if let encodedData = try? JSONEncoder().encode(walks) {
            UserDefaults.standard.set(encodedData, forKey: walksKey)
        }
    }
    
}
