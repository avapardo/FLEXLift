//
//  ExerciseView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import SwiftUI

struct ExerciseView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager
    @EnvironmentObject var user: User
    @State private var currentSelection: String = "Select Exercise"
    @State private var startStopButton: Bool = true
    @State private var weight: String = ""
    var body: some View {
        VStack {
            Spacer()
                    if let lastWorkout = user.workouts.last,
                       let lastExercise = lastWorkout.exercises.last {
                        Text("\(lastExercise.exerciseType)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    } else {
                        Text("No entry")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                Spacer()
                if let lastWorkout = user.workouts.last,
                           let lastExercise = lastWorkout.exercises.last {
                    Text("\(lastExercise.weight) lb")
                        } else {
                            Text("No entry")
                        }
            Spacer()
            HStack(){
                VStack(){
                    Text("Time")
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Text("\(user.elapsedTime, specifier: "%.0f") sec")
                }
                .frame(width:75, height: 75)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                )
                VStack(){
                    Text("Reps")
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    if(bluetoothManager.REP_COUNT > 0){
                        Text("\(bluetoothManager.REP_COUNT)")
                    }
                    else{
                        Text("analyzing...")
                            .lineLimit(1)
                            .padding(.horizontal, 3)
                            .minimumScaleFactor(0.5)
                    }
                }
                .frame(width:75, height: 75)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                )
            }
            Spacer()
            HStack(){
                if(startStopButton){
                    Button("Pause") {
                        bluetoothManager.sendText("Stop")
                        startStopButton = false
                        user.pauseTimer()
                    }
                    .padding(.all, 10.0)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("AccentColor"))
                    )}
                else{
                    Button("Resume") {
                        bluetoothManager.sendText("Start")
                        startStopButton = true
                        user.startTimer()
                    }
                    .padding(.all, 10.0)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("AccentColor"))
                    )}
                Button("Stop") {
                    bluetoothManager.sendText("Stop")
                    startStopButton = true
                    user.inWorkout = false
                    user.beginWorkout = false
                    user.duringExercise = false
                    user.endExercise = true
                    user.workoutSummary = false
                    if let lastWorkout = user.workouts.last,
                               let lastExercise = lastWorkout.exercises.last {
                        lastExercise.duration = user.elapsedTime
                    }
                    user.resetTimer()
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
            Spacer()
        }
        .padding()
        .frame(width:300, height:300)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
        .fixedSize(horizontal: true, vertical: true)
    }
}

#Preview {
    ExerciseView()
        .environmentObject(BluetoothManager())
        .environmentObject(User())
}
