//
//  SettingsView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var bluetoothManager: BluetoothManager

    var body: some View {
        VStack {
            Spacer()
            HStack(){
                Text("Settings")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            Spacer()
                HStack(){
                    Text("Bluetooth")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Spacer()
                        .frame(width:130)
                    if(bluetoothManager.isConnected){
                        Button("Disconnect"){
                            bluetoothManager.disconnect()
                        }
                        .padding(.all, 10.0)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("AccentColor"))
                        )
                    }
                    else{
                        Button("Connect"){
                            bluetoothManager.connect()
                        }
                        .padding(.all, 10)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color("AccentColor"))
                        )
                    }
                }
            if(bluetoothManager.isConnected){
                Spacer()
                HStack(){
                    Text("Battery")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Spacer()
                        .frame(width:200)
                    if(bluetoothManager.battery_percentage >= 97){
                        Text("97%")
                    }
                    else if(bluetoothManager.battery_percentage < 0){
                        Text("97%")
                    }
                    else{
                        Text("\(Int(bluetoothManager.battery_percentage))%")
                    }
                }
            }
            Spacer()
        }
        .frame(width: 320, height:230)
        .fixedSize(horizontal: true, vertical: false)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
    }
}

#Preview {
    SettingsView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
