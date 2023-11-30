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
                Spacer()
                WorkoutTimePerDayChartView()
                Spacer()
                Spacer()
                WeekAvgView()
                Spacer()
                PRHistoryView()
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
