//
//  ListRowView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/25/26.
//

import SwiftUI

struct ListRowView: View {
    
    let walk: WalkModel
    
    var body: some View {
        HStack {
            Text(walk.startTime, format: .dateTime.day().month().year())
                .font(.title2)
            Spacer()
            Text("\(walk.distance, specifier: "%.2f") miles")
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
//    
//    let formatter = DateFormatter()
//    formatter.dateFormat = "MM/dd/yyyy HH:mm"
    
//    let testStartTime = formatter.date(from: "04/25/2026 11:30")
//    let testEndTime = formatter.date(from: "04/25/2026 12:15")
//    
//    let testStartTime2 = formatter.date(from: "04/26/2026 16:00")
//    let testEndTime2 = formatter.date(from: "04/26/2026 16:45")
    
    let walk1 = WalkModel(startTime: Date.now, endTime: Date.now, distance: 1.3)
    let walk2 = WalkModel(startTime: Date.now, endTime: Date.now, distance: 2.2)
    
    ListRowView(walk: walk1)
    ListRowView(walk: walk2)
}
