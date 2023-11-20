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
                Text("FLEX Lift")
                    .font(.largeTitle)
                    
                Spacer(minLength: 150)
                TodaysSummary()
                Spacer()
                WeekAvgView()
                Spacer()
                PRHistoryView()
                Spacer(minLength:170)
            }
            .fixedSize(horizontal: true, vertical: true)
        }
            .environmentObject(user)
    }
}

#Preview {
    HomeMainView()
        .environmentObject(User())
}
