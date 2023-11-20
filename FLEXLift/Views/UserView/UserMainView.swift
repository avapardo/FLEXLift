//
//  UserMainView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct UserMainView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var bluetoothManager: BluetoothManager

    var body: some View {
            NavigationView {
                VStack(spacing:15) {
                    Spacer()
                    Text("FLEX Lift")
                        .font(.largeTitle)
                        .padding(.all)
                    Spacer()
                    if(!user.profileSetup){
                        ProfileSetupView()
                            .environmentObject(user)
                    }
                    else{
                        UserProfileView()
                            .environmentObject(user)
                    }
                    Spacer()
                    SettingsView()
                        .environmentObject(bluetoothManager)
                    Spacer(minLength:100)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
}

#Preview {
    UserMainView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
