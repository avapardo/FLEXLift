//
//  PRHistoryView.swift
//  FLEXLift
//
//  Created by Ava Pardo on 11/20/23.
//

import SwiftUI

struct PRHistoryView: View {
    @EnvironmentObject var user: User

    var body: some View {
        VStack {
            Spacer()
                HStack(){
                    Text("History")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Spacer()
                        .frame(width:80)
                    HStack(){
                        NavigationLink(destination: DailyWorkoutSummaryView()){
                            Text("Daily")
                                .minimumScaleFactor(0.5)
                                .padding(.all, 10.0)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                        }
                        .environmentObject(user)
                    }
                    HStack(){
                        NavigationLink(destination: WorkoutByTypeSummaryView()){
                            Text("Exercise")
                                .minimumScaleFactor(0.5)
                                .padding(.all, 10.0)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                        }
                        .environmentObject(user)
                    }
                }
            Spacer()
                HStack(){
                    Text("Personal Records")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                    Spacer()
                        .frame(width:110)
                    HStack(){
                        NavigationLink(destination: PersonalRecordByTypeView()){
                            Text("PR")
                                .minimumScaleFactor(0.5)
                                .padding(.all, 10.0)
                                .foregroundColor(.white)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("AccentColor")))
                        }
                        .environmentObject(user)
                    }
                }
            Spacer()
        }
        .frame(width: 320, height:150)
        .fixedSize(horizontal: true, vertical: false)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white)
                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.918), radius: 10, x: 0, y: 2)
        )
    }
}

#Preview {
    PRHistoryView()
        .environmentObject(User())
}
