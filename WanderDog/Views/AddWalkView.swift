//
//  AddWalkView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/25/26.
//

import SwiftUI

struct AddWalkView: View {
    @EnvironmentObject var walkViewModel: WalkViewModel
    
    var returnHome: () -> Void
    
    @State var startTime: Date = Date.now
    @State var endTime: Date = Date.now
    @State var distance: Double = 0.0
    
    let miles = stride(from: 0.0, through: 20.0, by: 0.1).map { $0 }
    
    var body: some View {
        VStack {
            TitleView(titleText: "Add New Walk")
            Spacer()
            DatePicker(
                "Start date:",
                selection: $startTime,
                displayedComponents: .date)
            .datePickerStyle(.compact)
            .frame(maxHeight: 50)
            DatePicker(
                "Start time:",
                selection: $startTime,
                displayedComponents: .hourAndMinute)
            .datePickerStyle(.compact)
            .frame(maxHeight: 50)
            DatePicker(
                "End date:",
                selection: $endTime,
                displayedComponents: .date)
            .datePickerStyle(.compact)
            .frame(maxHeight: 50)
            DatePicker(
                "End time:",
                selection: $endTime,
                displayedComponents: .hourAndMinute)
            .datePickerStyle(.compact)
            .frame(maxHeight: 50)
            HStack {
                Text("Miles walked: ")
                Picker("Miles walked:", selection: $distance) {
                    ForEach(miles, id: \.self) { mile in
                        Text(String(format: "%.1f", mile))
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 200)
                .clipped()
            }
            Button{
                saveButtonPressed()
                returnHome()
                
            } label: {
                Text("SAVE")
                    .frame(width: 280, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.title3)
                    .cornerRadius(10)
            }
            Button{
                returnHome()
            } label: {
                Text("Cancel")
                    .frame(width: 280, height: 50)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .font(.title3)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    
    func saveButtonPressed() {
        walkViewModel.addWalk(startTime: startTime, endTime: endTime, distance: distance)
    }
}

func viewHomeScreenPreview() {
    print("Going back to home screen")
}

#Preview {
    
    AddWalkView(
        returnHome: viewHomeScreenPreview
    )
    .environmentObject(WalkViewModel())
}
