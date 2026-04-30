//
//  HomeView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/27/26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var walkViewModel: WalkViewModel
    
    var body: some View {
        VStack (spacing: 10) {
            TitleView(titleText: walkViewModel.dog.name)
            Spacer()
            List {
                ForEach(walkViewModel.walks) { walk in
                    ListRowView(walk: walk)
                }
                .onDelete(perform: walkViewModel.deleteWalk)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(WalkViewModel())
}
