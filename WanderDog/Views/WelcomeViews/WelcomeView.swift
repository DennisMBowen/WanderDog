//
//  WelcomeView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/28/26.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var walkViewModel: WalkViewModel
    let exitWelcome: () -> Void
    let viewAddDog: () -> Void
    
    var body: some View {
        VStack (spacing: 10) {
            Spacer()
            Image(systemName: "dog.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("Welcome to WanderDog!")
                .font(.title)
                .bold()
            Text("The app designed to track the daily walk habits of your favorite furry friend!")
                .font(.title2)
                .multilineTextAlignment(.center)
            Spacer()
            if walkViewModel.dogExists() {
                Button{
                    exitWelcome()
                } label: {
                    Text("View Walks")
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title3)
                        .cornerRadius(10)
                }
            } else {
                Button{
                    viewAddDog()
                } label: {
                    Text("Add a New Dog")
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title3)
                        .cornerRadius(10)
                }
            }
            Spacer()
            
            
        }
        .padding(16)
    }
}

func exitWelcomePreview() {
    print("Going to the home screen")
}

func viewAddDogPreview() {
    print("Going to the add dog screen")
}

#Preview {
    WelcomeView(
        exitWelcome: exitWelcomePreview,
        viewAddDog: viewAddDogPreview
    )
        .environmentObject(WalkViewModel())
}
