//
//  PersonalRecordByTypeView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/21/23.
//

import SwiftUI

struct PersonalRecordByTypeView: View {
    @EnvironmentObject var user: User
    @State private var currentSelection: String = "Select Exercise"
    var body: some View {
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
            VStack(){
                if let exercise = user.returnWorkoutToContainer(currentSelection: currentSelection).max(by: { $0.weight < $1.weight }){
                    VStack(){
                        NavigationLink(destination: RepDetailedView(exercise: exercise)) {
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
        }
    }
}

#Preview {
    PersonalRecordByTypeView()
}
