//
//  ContentView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/12/26.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("showWelcome") var showWelcome: Bool = true
    
    @EnvironmentObject var walkViewModel: WalkViewModel
    @State var selectedTab = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            WalkMapView(
                returnHome: viewHomeScreen
            )
                .tabItem{
                   Label("Track Walk", systemImage: "location")
                }
                .tag(1)
            AddWalkView(
                returnHome: viewHomeScreen
            )
                .tabItem{
                    Label("Add Walk", systemImage: "plus.circle")
                }
                .tag(2)
            DogSpotsView()
                .tabItem{
                    Label("Dog Spots", systemImage: "map")
                }
                .tag(3)
        }
        .fullScreenCover(isPresented: $showWelcome, content: {
            WelcomeTabView(showWelcome: $showWelcome)
        })
    }
    
    func viewHomeScreen() {
        selectedTab = 0
    }
}

#Preview {
    
    
    ContentView()
        .environmentObject(WalkViewModel())
}
