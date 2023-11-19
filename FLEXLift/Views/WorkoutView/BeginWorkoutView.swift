//
//  BeginWorkoutView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/8/23.
//

import SwiftUI

struct BeginWorkoutView: View {
    @EnvironmentObject var bluetoothManager: BluetoothManager
    @EnvironmentObject var user: User
    @State private var currentSelection: String = "Select Exercise"
    @State private var startStopButton: Bool = true
    @State private var weight: String = ""
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("Begin Workout")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .padding(.all)
            }
            Spacer()
                .frame(height:0)
            VStack(){
                Menu {
                    Button {
                        currentSelection = "Barbell Lunge"
                    } label: {
                        Text("Barbell Lunge")
                    }
                    Button {
                        currentSelection = "Barbell Squat"
                    } label: {
                        Text("Barbell Squat")
                    }
                    Button {
                        currentSelection = "Bench Press"
                    } label: {
                        Text("Bench Press")
                    }
                    Button {
                        currentSelection = "Bicep Curl"
                    } label: {
                        Text("Bicep Curl")
                    }
                    Button {
                        currentSelection = "Deadlift"
                    } label: {
                        Text("Deadlift")
                    }
                    Button {
                        currentSelection = "Shoulder Press"
                    } label: {
                        Text("Shoulder Press")
                    }
                    Button {
                        currentSelection = "Power Clean"
                    } label: {
                        Text("Power Clean")
                    }
                    Button {
                        currentSelection = "Power Snatch"
                    } label: {
                        Text("Power Snatch")
                    }
                    Button {
                        currentSelection = "Squat Clean"
                    } label: {
                        Text("Squat Clean")
                    }
                    Button {
                        currentSelection = "Squat Snatch"
                    } label: {
                        Text("Squat Snatch")
                    }
                } label: {
                    Text(currentSelection)
                }
            }
            .padding(.all)
            Spacer()
                .frame(height:10)
            HStack(){
                TextField("Enter Weight", text: $weight)
                .padding(10)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 150.0, height: 35.0)
                }
                .padding(.horizontal)
                .frame(width: 170, height: 50.0)
            }
            Spacer()
                .frame(height:20)
            if(startStopButton){
                Button("Start") {
                    bluetoothManager.sendText("Start")
                    var weightVal = 0
                    if let weightValue = Int(weight) {
                        weightVal = weightValue
                    } else {
                        print("'\(weight)' is not a valid integer")
                    }
                    if let lastWorkout = user.workouts.last {
                        lastWorkout.exercises.append(Exercise(exerciseType: currentSelection, weight: weightVal))
                    }
                    startStopButton = false
                    user.beginWorkout = false
                    user.duringExercise = true
                    user.endExercise = false
                    user.workoutSummary = false
                    user.startTimer()
                }
                .padding(.all, 5)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("AccentColor"))
                )}
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
    BeginWorkoutView()
        .environmentObject(BluetoothManager())
        .environmentObject(User())
}
