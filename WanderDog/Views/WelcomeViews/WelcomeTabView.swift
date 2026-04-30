//
//  WelcomeTabView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/28/26.
//

import SwiftUI

struct WelcomeTabView: View {
    @Binding var showWelcome: Bool
    
    @EnvironmentObject var walkViewModel: WalkViewModel
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            WelcomeView(
                exitWelcome: updateShowWelcome,
                viewAddDog: updateView
            )
                .tag(0)
                .toolbar(.hidden, for: .tabBar)
            AddDogView(
                exitWelcome: updateShowWelcome
            )
                .tag(1)
                .toolbar(.hidden, for: .tabBar)
        }
    }
    
    func updateShowWelcome() {
        showWelcome = false
    }
    
    func updateView() {
        selectedTab = 1
    }
       
}
//
//#Preview {
//    
//    @Previewable @Binding var showBool = true
//    
//    WelcomeTabView(
//        showWelcome: showBool
//    )
//    .environmentObject(WalkViewModel())
//}
