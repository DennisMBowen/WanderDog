//
//  AddDogView.swift
//  WanderDog
//
//  Created by Dennis Bowen on 4/28/26.
//

import SwiftUI

struct AddDogView: View {

    @State var dogName: String = ""
    @EnvironmentObject var walkViewModel: WalkViewModel
    let exitWelcome: () -> Void
    
    var body: some View {
            VStack(spacing: 10) {
                Spacer()
                Text("Add New Dog")
                    .font(.title)
                    .bold()
                Spacer()
                Text("What is your dog's name?")
                    .font(.title)
                    .fontWeight(.semibold)
                TextField ("Enter name here", text: $dogName)
                    .padding(20)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
                Button{
                    dogNameEntered()
                    exitWelcome()
                } label: {
                    Text("Let's Get Walking!")
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title3)
                        .cornerRadius(10)
                }
                .padding(10)
                Spacer()
        }
    }
    
    func dogNameEntered() {
        if dogName.count > 1 {
            walkViewModel.addDogName(name: dogName)
        }
    }
}

func exitAddDogScreen() {
    print("Going to the home screen")
}

#Preview {
    AddDogView(exitWelcome: exitWelcomePreview)
        .environmentObject(WalkViewModel())
}
