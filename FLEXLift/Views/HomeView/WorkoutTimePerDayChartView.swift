//
//  WorkoutTimePerDayChartView.swift
//  FLEXLift
//
//  Created by Ava Pardo on 11/20/23.
//

import SwiftUI

struct WorkoutTimePerDayChartView: View {
    @EnvironmentObject var user: User
    
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        VStack {
            Text("This Week's Workout Time")
                .font(.headline)

            GeometryReader { geometry in
                let dataPoints = user.workoutTimeForPastWeek()
                let maxValue = max((dataPoints.values.max() ?? 0), 1)
                let segmentWidth = geometry.size.width / CGFloat(daysOfWeek.count)
                let barWidth = segmentWidth * 0.7 // 70% of the segment width

                // Drawing the bars
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    let day = daysOfWeek[index]
                    let workoutTime = dataPoints[day, default: 0]
                    let xPosition = segmentWidth * CGFloat(index) + (segmentWidth - barWidth) / 2
                    let barHeight = geometry.size.height * (CGFloat(workoutTime) / CGFloat(maxValue))

                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: barWidth, height: barHeight)
                        .offset(x: xPosition, y: geometry.size.height - barHeight)
                }

                // X-Axis Labels
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    let xPosition = segmentWidth * CGFloat(index) + segmentWidth / 2

                    Text(daysOfWeek[index])
                        .position(x: xPosition, y: geometry.size.height + 20)
                        .font(.caption)
                }

                // Y-Axis Labels
                let yAxisLabelCount = maxValue <= 15 ? 5 : 3
                let yAxisInterval = (maxValue / yAxisLabelCount)

                // Y-Axis Labels
                ForEach(0...yAxisLabelCount, id: \.self) { i in // Include the top label
                    let yLabel = i * yAxisInterval
                    let yPosition = geometry.size.height * (1 - CGFloat(yLabel) / CGFloat(maxValue))

                    Text("\(yLabel) ")
                        .position(x: geometry.size.width * -0.05, y: yPosition)
                        .font(.caption)
                }

                // Drawing the axes
                Path { path in
                    // Vertical line
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                    
                    // Horizontal line
                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
                .stroke(Color.black, lineWidth: 1)
            }
            .frame(width: 280, height: 150)
            .fixedSize(horizontal: true, vertical: true)
        }
        .frame(width: 280, height: 150)
    }
}

#Preview {
    WorkoutTimePerDayChartView()
        .environmentObject(User())
}
