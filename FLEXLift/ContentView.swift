//
//  ContentView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var bluetoothManager: BluetoothManager
    var body: some View {
            HStack {
                if(user.tabView){
                    TabView{
                        UserMainView()
                            .tabItem(){
                                Image("ic-profile")
                            }
                        WorkoutMainView()
                            .tabItem(){
                                Image("ic-activity-circle")
                            }
                        HomeMainView()
                            .tabItem(){
                                Image("ic-home")
                            }
                    }
                    .environmentObject(user)
                    .environmentObject(bluetoothManager)
                }
            }
    }
}

#Preview {
    ContentView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
