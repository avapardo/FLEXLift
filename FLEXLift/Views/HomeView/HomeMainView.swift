//
//  HomeMainView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/8/23.
//

import SwiftUI

struct HomeMainView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                TodaysSummary()
                    .frame(height: 150)
                Spacer()
                WorkoutTimePerDayChartView()
                    .frame(height: 150)
                Spacer()
                Spacer()
                WeekAvgView()
                    .frame(height: 80)
                Spacer()
                PRHistoryView()
                    .frame(height: 150)
                Spacer()
            }
        }
            .environmentObject(user)
    }
}

#Preview {
    HomeMainView()
        .environmentObject(User())
}
