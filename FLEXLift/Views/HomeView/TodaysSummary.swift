//
//  TodaysSummary.swift
//  FLEXLift
//
//  Created by Ava Pardo on 11/19/23.
//

import SwiftUI

struct TodaysSummary: View {
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16.0) {
                Spacer()
                HStack() {
                    Spacer()
                    Text("Today's Summary")
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.black)
                    Spacer()
                    Text("\(formatDate(Date(), format: "MM/dd/yy"))")
                        .foregroundColor(.accentColor)
                    Spacer()
                }
                HStack(){
                    Spacer()
                    VStack(){
                        Text("Total Exercises")
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                            .padding(.horizontal, 3)
                            .frame(width: 55)
                        Text("\(user.totalExercisesToday())")
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
                        Text("Total Workout time")
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                            .padding(.horizontal, 3)

                        Text("\(user.totalWorkoutTimeToday(), specifier: "%.0f") sec")
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
                        Text("Total Reps")
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                            .frame(width: 25)
                        Text("\(user.totalRepsToday())")
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
                }
                Spacer()
            }
        }
        .frame(width:320, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
    }
}

func formatDate(_ date: Date, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

#Preview {
    TodaysSummary()
        .environmentObject(User())
}
