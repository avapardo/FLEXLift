//
//  DailyWorkoutSummaryView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/21/23.
//

import SwiftUI

struct DailyWorkoutSummaryView: View {
    @EnvironmentObject var user: User
    @State private var selectedDate: String = ""
    var body: some View {
        VStack(){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(user.getWorkoutDates(), id: \.self) { date in
                        VStack {
                            Text(date)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                                .frame(width: 50)
                        }
                        .frame(width: 75, height: 75)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
                        )
                        .onTapGesture {
                            self.selectedDate = date
                        }
                    }
                }
            }
            
            // You can use the selectedDate for fetching workouts
            let workoutsToday = user.workoutsOnDate(date: selectedDate)
            ForEach(workoutsToday, id: \.self) { workout in
                ScrollView{
                    VStack(){
                        ScrollView{
                            ForEach(workout.exercises, id: \.self) { exercise in
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
                    .frame(width:275, height: 150)
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

#Preview {
    DailyWorkoutSummaryView()
}
