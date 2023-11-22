//
//  WorkoutTimePerDayChartView.swift
//  FLEXLift
//
//  Created by Ava Pardo on 11/20/23.
//

import SwiftUI

struct WorkoutTimePerDayChartView: View {
    @EnvironmentObject var user: User
    
    let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "E" // Format for short day of the week, e.g., "Mon"
            return formatter
    }()
    
    let inputDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "Your input date format here" // Adjust this format to match your date strings
            return formatter
        }()
    
    var body: some View {
        Text("This Week's Workout Time")
        GeometryReader { geometry in
            let dataPoints = user.workoutTimeForPastWeek()
            let sortedDates = dataPoints.keys.sorted() // To ensure the dates are in order
            // let maxValue = (dataPoints.values.max() ?? 1) // Avoid division by zero
            let maxValue = 30
            
            Path { path in
                for (index, date) in sortedDates.enumerated() {
                    let workoutTime = dataPoints[date, default: 0]
                    let xPosition = geometry.size.width * CGFloat(index) / CGFloat(sortedDates.count - 1)
                    let yPosition = geometry.size.height * (1 - CGFloat(workoutTime) / CGFloat(maxValue))
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.accentColor, lineWidth: 2)
            
            ForEach(sortedDates.indices, id: \.self) { index in
                                let dateString = sortedDates[index]
                                if let date = inputDateFormatter.date(from: dateString) {
                                    let day = dayFormatter.string(from: date)
                                    let xPosition = geometry.size.width * CGFloat(index) / CGFloat(sortedDates.count - 1)

                                    Text(day)
                                        .position(x: xPosition, y: geometry.size.height + 20)
                                }
                            }
            
            ForEach(0...3, id: \.self) { i in
                                let yLabel = i * 10
                                let yPosition = geometry.size.height * (1 - CGFloat(yLabel) / CGFloat(maxValue))

                                Text("\(yLabel)")
                                    .position(x: -15, y: yPosition)
                            }
            
        }
        .frame(width: 280, height: 180)
    }
}

#Preview {
    WorkoutTimePerDayChartView()
        .environmentObject(User())
}
