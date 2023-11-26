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
    @State private var weight: String = ""
    @State private var weightValid: Bool = false
    var body: some View {
        VStack {
            Spacer()
            VStack() {
                if(user.inWorkout == false){
                    Text("Begin Workout")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .padding(.all)
                }
                else{
                    Text("Begin Exercise")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        .padding(.all)
                }
            }
            Spacer()
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
            Spacer()
            HStack(){
                TextField("Enter weight in lb", text: $weight)
                    .padding(10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .frame(width: 150.0, height: 35.0)
                    }
                    .padding(.horizontal)
                    .frame(width: 150, height: 50.0)
            }
            Spacer()
            if(currentSelection != "Select Exercise" && weight != ""){
                Button("Start") {
                    bluetoothManager.sendText("Start")
                    var weightVal = 0
                    if let weightValue = Int(weight) {
                        weightVal = weightValue
                        weightValid = true
                    } else {
                        weightValid = false
                    }
                    if let lastWorkout = user.workouts.last {
                        lastWorkout.exercises.append(Exercise(exerciseType: currentSelection, weight: weightVal))
                    }
                    user.inWorkout = true
                    user.beginWorkout = false
                    user.duringExercise = true
                    user.endExercise = false
                    user.workoutSummary = false
                    user.startTimer()
                }
                .padding(.all, 10)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("AccentColor"))
                )}
            else{
                Text("Please fill in all details")
                    .padding(.all, 10)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                    )}
            Spacer()
        }
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
