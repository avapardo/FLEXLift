//
//  FLEXLiftApp.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/7/23.
//

import SwiftUI

@main
struct FLEXLiftApp: App {
    var user = User()
    var bluetoothManager = BluetoothManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(user)
                .environmentObject(bluetoothManager)
        }
    }
}
