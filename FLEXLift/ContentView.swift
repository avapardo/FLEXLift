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
                        HomeMainView()
                            .tabItem(){
                                Image("ic-home")
                            }
                        WorkoutMainView()
                            .tabItem(){
                                Image("ic-activity-circle")
                            }
                        UserMainView()
                            .tabItem(){
                                Image("ic-profile")
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
