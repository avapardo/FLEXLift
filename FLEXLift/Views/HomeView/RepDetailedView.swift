//
//  RepDetailedView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/21/23.
//

import SwiftUI

struct RepDetailedView: View {
    var exercise: Exercise

    var body: some View {
        VStack {
            ForEach(exercise.repEntries, id: \.self) { rep in
                let curves = rep.calculateCurves() // Force and velocity data
                GraphView(forceData: curves.force, velocityData: curves.velocity)
                    .frame(height: 200) // Specify a fixed height for the graph
            }
        }
    }
}

struct GraphView: View {
    var forceData: [Double]
    var velocityData: [Double]

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                guard !forceData.isEmpty && !velocityData.isEmpty else { return }

                // Normalize data
                let maxY = forceData.max() ?? 0
                let maxX = velocityData.max() ?? 0

                let normalizedForce = forceData.map { $0 / maxY }
                let normalizedVelocity = velocityData.map { $0 / maxX }

                // Initial point
                let initialPoint = CGPoint(
                    x: geometry.size.width * normalizedVelocity[0],
                    y: geometry.size.height * (1 - normalizedForce[0])
                )
                
                path.move(to: initialPoint)

                // Add line segments
                for (index, force) in normalizedForce.enumerated() {
                    let x = geometry.size.width * normalizedVelocity[index]
                    let y = geometry.size.height * (1 - force) // Invert Y axis for proper graphing
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

#Preview {
    let specificExercise = Exercise(exerciseType: "Barbell Squat", weight: 100)
    RepDetailedView(exercise: specificExercise)
}
