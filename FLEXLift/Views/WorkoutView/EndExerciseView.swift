//
//  EndExerciseView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import SwiftUI

struct EndExerciseView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            Spacer()
                    if let lastWorkout = user.workouts.last,
                       let lastExercise = lastWorkout.exercises.last {
                        Text("\(lastExercise.exerciseType) Summary")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .foregroundColor(Color.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                        
                    } else {
                        Text("No entry")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
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
                        if let lastWorkout = user.workouts.last,
                                   let lastExercise = lastWorkout.exercises.last {
                            Text(user.formatTime(seconds:lastExercise.duration))
                                } else {
                                    Text("No entry")
                                }
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
                        Text("\(bluetoothManager.REP_COUNT)")
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
                    Button("Add Exercise") {
                        if let lastWorkout = user.workouts.last,
                           let lastExercise = lastWorkout.exercises.last {
                            lastExercise.totalReps = bluetoothManager.REP_COUNT
                            user.addWorkoutToContainer(exercise: lastExercise)
                            lastExercise.addRepEntries(repStartLocs: bluetoothManager.repStartLocs, entries: bluetoothManager.entries)
                        }
                        bluetoothManager.resetBluetooth()
                        user.inWorkout = true
                        user.beginWorkout = true
                        user.duringExercise = false
                        user.endExercise = false
                        user.workoutSummary = false
                    }
                    .padding(.all, 10.0)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("AccentColor"))
                    )
                Button("End Workout") {
                    if let lastWorkout = user.workouts.last,
                       let lastExercise = lastWorkout.exercises.last {
                        lastExercise.totalReps = bluetoothManager.REP_COUNT
                        user.addWorkoutToContainer(exercise: lastExercise)
                        lastExercise.addRepEntries(repStartLocs: bluetoothManager.repStartLocs, entries: bluetoothManager.entries)
                    }
                    bluetoothManager.resetBluetooth()
                    user.inWorkout = false
                    user.beginWorkout = false
                    user.duringExercise = false
                    user.endExercise = false
                    user.workoutSummary = true
                }
                .padding(.all, 10.0)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("AccentColor"))
                )
            }
            Spacer()
        }
        .frame(width:300, height:300)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EndExerciseView()
        .environmentObject(User())
        .environmentObject(BluetoothManager())
}
