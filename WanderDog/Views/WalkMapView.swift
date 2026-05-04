//
//  WalkMapView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 5/2/26.
//

import SwiftUI
import MapKit

struct WalkMapView: View {
    
    @EnvironmentObject var walkViewModel: WalkViewModel
    @StateObject var walkMapViewModel = WalkMapViewModel()
    
    @State private var confirmDiscard: Bool = false
    
    var returnHome: () -> Void
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Tracking Walk")
                .font(.title)
                .bold()
            if (walkMapViewModel.trackWalk || walkMapViewModel.walkFinished){
                Text("Walk Started: \(walkMapViewModel.startTime.formatted(date: .omitted, time: .shortened))")
            }
            if (walkMapViewModel.walkFinished){
                Text("Walk Ended: \(walkMapViewModel.endTime.formatted(date: .omitted, time: .shortened))")
                    .font(.body)
//                Text("Miles Traveled: \(walkMapViewModel.milesTraveled.formatted(.number.precision(.fractionLength(2))))")
                Text("Miles Traveled: \(walkMapViewModel.milesTraveled, specifier: "%.2f")")
                    
            }
            ZStack(alignment: .bottom){
                Map(position: $walkMapViewModel.position) {
                    UserAnnotation()
                    MapPolyline(coordinates: walkMapViewModel.walkCoordinates)
                        .stroke(.blue, lineWidth: 5)
                }
                .onAppear{
                    walkMapViewModel.isLocationServicesEnabled()
                }
                Spacer()
                if walkMapViewModel.walkFinished {
                    VStack() {
                        Button{
                            walkViewModel.addWalk(
                                startTime: walkMapViewModel.startTime,
                                endTime: walkMapViewModel.endTime,
                                distance: walkMapViewModel.milesTraveled)
                            walkMapViewModel.resetWalk()
                            returnHome()
                        } label: {
                            WalkMapButtonView(buttonLabel: "Save", buttonColor: Color.blue)
                        }
                        .padding()
                        Button{
                            walkMapViewModel.resumeButtonPressed()
                        } label: {
                            WalkMapButtonView(buttonLabel: "Resume", buttonColor: Color.gray)
                        }
                        .padding()
                        Button{
                            confirmDiscard = true
                        } label: {
                            WalkMapButtonView(buttonLabel: "Discard", buttonColor: Color.red)
                        }
                        .confirmationDialog("Confirm discard of walk",
                                            isPresented: $confirmDiscard) {
                            Button("Confirm", role: .destructive) {
                                walkMapViewModel.resetWalk()
                                returnHome()
                            }
                            Button("Cancel"){}
                        } message: {
                            Text("Are you sure want to discard this walk? This action cannot be undone.")
                        }
                        .padding()
                    }
                }
                else if walkMapViewModel.trackWalk {
                    Button{
                        walkMapViewModel.finishButtonPressed()
                    } label: {
                        WalkMapButtonView(buttonLabel: "Finish", buttonColor: Color.blue)
                    }
                    .padding()
                }
                else {
                    Button{
                        walkMapViewModel.startTrackingWalk()
                    } label: {
                        WalkMapButtonView(buttonLabel: "Track", buttonColor: Color.blue)
                    }
                    .padding()
                }
            }
        }
    }
}

func viewHomeScreenFromWalkMapView() {
    print("Going back to home screen")
}

#Preview {
    
    let walkMapViewModel = WalkMapViewModel()
    WalkMapView(returnHome: viewHomeScreenFromWalkMapView)
        .environmentObject(WalkViewModel())
}
