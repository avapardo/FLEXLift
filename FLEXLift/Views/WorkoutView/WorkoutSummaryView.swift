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
            Spacer()
            Text("Workout Summary")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .lineLimit(1)
                .minimumScaleFactor(0.50)
            if let lastWorkout = user.workouts.last {
                if(lastWorkout.exercises.count > 1){
                    Text("scroll below")
                }
                ScrollView{
                    ForEach(lastWorkout.exercises, id: \.self) { exercise in
                        NavigationLink(destination: RepDetailedView(exercise: exercise)){
                            VStack(){
                                Spacer()
                                Text("\(exercise.exerciseType) Summary")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.black)
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                Spacer()
                                Text("\(exercise.weight) lb")
                                Spacer()
                                HStack(){
                                    VStack(){
                                        Text("Time")
                                            .font(.headline)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.75)
                                        Text(user.formatTime(seconds:exercise.duration))
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
                                Spacer()
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
                HStack(){
                    Button("New Workout") {
                        user.beginWorkout = true
                        user.duringExercise = false
                        user.endExercise = false
                        user.workoutSummary = false
                        user.workouts.append(Workout())
                    }
                    .padding(.all, 10.0)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("AccentColor"))
                    )
                }
                Spacer()
            }
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
    WorkoutSummaryView()
        .environmentObject(BluetoothManager())
        .environmentObject(User())
}
