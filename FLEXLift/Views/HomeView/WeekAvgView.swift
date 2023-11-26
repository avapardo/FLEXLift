//
//  WeekAvgView.swift
//  FLEXLift
//
//  Created by Ava Pardo on 11/20/23.
//

import SwiftUI

struct WeekAvgView: View {
    @EnvironmentObject var user: User
    var body: some View {
        HStack(){
            Spacer()
            VStack(){
                Text("Avg. Daily Exercises")
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .padding(.horizontal, 3)
                    .frame(width: 55)
                Text("\(user.averageDailyExercises(), specifier: "%.0f")")
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(width: 50)
            }
            .frame(width:75, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
            Spacer()
            VStack(){
                Text("Avg. Daily Workout time")
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .padding(.horizontal, 3)

                Text(user.formatTime(seconds: user.averageDailyWorkoutTime()))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(width: 50)
                
            }
            .frame(width:75, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
            Spacer()
            VStack(){
                Text("Avg. Daily Reps")
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .frame(width: 50)
                Text("\(user.averageDailyReps(), specifier: "%.0f")")
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(width: 50)
                
            }
            .frame(width:75, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
            Spacer()
            VStack(){
                Text("Favorite Exercise")
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .frame(width: 45)
                Text(user.favoriteExercise())
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
                    .frame(width: 50)
            }
            .frame(width:75, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
            )
            Spacer()
        }
        .frame(height:80)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    WeekAvgView()
        .environmentObject(User())
}
