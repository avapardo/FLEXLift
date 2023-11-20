//
//  WorkoutMainView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/8/23.
//

import SwiftUI

struct WorkoutMainView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var bluetoothManager: BluetoothManager
    
    var body: some View {
        NavigationView {
            VStack() {
                Text("FLEX Lift")
                    .font(.largeTitle)
                    
                Spacer(minLength: 150)
                if(user.beginWorkout){
                    BeginWorkoutView()
                }
                else if(user.duringExercise){
                    ExerciseView()
                }
                else if(user.endExercise){
                    EndExerciseView()
                }
                else if(user.workoutSummary){
                    WorkoutSummaryView()
                }
                Spacer(minLength:170)
            }
            .fixedSize(horizontal: true, vertical: true)
        }
            .environmentObject(user)
            .environmentObject(bluetoothManager)
    }
}

#Preview {
    WorkoutMainView()
        .environmentObject(BluetoothManager())
        .environmentObject(User())
}
