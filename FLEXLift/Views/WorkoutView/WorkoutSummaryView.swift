//
//  WorkoutSummaryView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import SwiftUI

struct WorkoutSummaryView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager
    @EnvironmentObject var user: User
    @State private var currentSelection: String = "Select Exercise"
    @State private var startStopButton: Bool = true
    @State private var weight: String = ""
    var body: some View {
        VStack {
            Text("Today's Workout Summary")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.all)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .lineLimit(1)
                .minimumScaleFactor(0.50)
            ScrollView{
                if let lastWorkout = user.workouts.last {
                    ForEach(lastWorkout.exercises, id: \.self) { exercise in
                        VStack(){
                            HStack(){
                                    Text("\(exercise.exerciseType) Summary")
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.black)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                            }
                            Text("\(exercise.weight) lb")
                            HStack(){
                                VStack(){
                                    Text("Time")
                                        .font(.headline)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.75)
                                    Text("\(exercise.duration, specifier: "%.0f") sec")
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
                                    Text("\(exercise.totalReps)")
                                }
                                .frame(width:75, height: 75)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                                )
                            }
                        }
                        .frame(width:265, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                        )
                    }
            }
        }
            .frame(width:275, height: 150)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
            Spacer()
                .frame(height:10)
            HStack(){
                    Button("New Workout") {
                        bluetoothManager.sendText("Start")
                        user.beginWorkout = true
                        user.duringExercise = false
                        user.endExercise = false
                        user.workoutSummary = false
                        user.workouts.append(Workout())
                    }
                    .padding(.all, 3.0)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("AccentColor"))
                    )
                Button("History") {
                    bluetoothManager.sendText("Stop")
                    user.beginWorkout = false
                    user.duringExercise = false
                    user.endExercise = false
                    user.workoutSummary = true
                }
                .padding(.all, 3.0)
                .lineLimit(2)
                .minimumScaleFactor(0.75)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("AccentColor"))
                )
            }
        }
        .padding()
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
    WorkoutSummaryView()
        .environmentObject(BluetoothManager())
        .environmentObject(User())
}
