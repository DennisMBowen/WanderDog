//
//  WanderDogApp.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/12/26.
//

import SwiftUI

@main
struct WanderDogApp: App {
    
    @StateObject var walkViewModel: WalkViewModel = WalkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(walkViewModel)
    }
}
