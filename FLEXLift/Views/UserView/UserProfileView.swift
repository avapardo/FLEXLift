//
//  UserProfileView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16.0) {
                HStack() {
                    Spacer()
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    Spacer()
                        .frame(width: 30.0)
                    NavigationLink(destination: ProfileEditView()) {
                        Text("Edit Profile")
                            .padding(.all, 10.0)
                            .foregroundColor(.white)
                            .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                            .frame(width: 150.0, height: 50)
                    }
                }
                HStack(){
                    Spacer()
                        .frame(width: 25.0)
                    Text(user.name)
                }
                HStack(){
                    Spacer()
                        .frame(width: 25.0)
                    VStack(){
                        Text("Age")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 35)
                        Text("\(user.age)")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 50)
                    }
                    .frame(width:55, height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                    )
                    Spacer()
                    VStack(){
                        Text("Height")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 45)
                        Text("\(user.height)")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 50)
                        
                    }
                    .frame(width:55, height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                    )
                    Spacer()
                    VStack(){
                        Text("Weight")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 45)
                        Text("\(user.weight)")
                            .minimumScaleFactor(0.5) // The text can scale down to half its size if needed
                            .frame(width: 50)
                        
                    }
                    .frame(width:55, height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                    )
                    Spacer()
                }
            }
            .padding(.all)
            
            Spacer() // No minLength unless you have a specific need for it.
        }
        .frame(width:320, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
    }
}

#Preview {
    UserProfileView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
