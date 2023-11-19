//
//  ProfileSetupView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct ProfileSetupView: View {
    @EnvironmentObject var user: User

    var body: some View {
                VStack(alignment: .leading, spacing: 16.0) {
                    Spacer()
                    HStack() {
                        Spacer()
                        Text("Profile")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    HStack(){
                        Spacer()
                        Text("Please complete your profile")
                            .foregroundColor(Color.gray)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8) // The text can scale down to half its size if needed
                        Spacer()
                    }
                    HStack(){
                        Spacer()
                        NavigationLink(destination: ProfileEditView()){
                            Text("Setup Profile")
                                .minimumScaleFactor(0.5)
                                .frame(width: 100)
                                .padding(.all, 10.0)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                                .frame(width: 150.0, height: 50)
                        }
                        .simultaneousGesture(TapGesture().onEnded {})
                        .environmentObject(user)
                        Spacer()
                    }
                    Spacer()
                }
            .frame(width:320, height: 230)
            .fixedSize(horizontal: true, vertical: true)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
        }
}

#Preview {
    ProfileSetupView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
