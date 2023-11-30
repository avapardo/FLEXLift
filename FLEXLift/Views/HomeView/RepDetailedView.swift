//
//  RepDetailedView.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/21/23.
//

import SwiftUI
import Charts

struct RepDetailedView: View {
    var exercise: Exercise

    var body: some View {
        VStack {
            Text("Rep Data")
                .font(.title)
            Text("Max power: \(String(format: "%.2f", exercise.calculateMaxPower())) W")
            ScrollView {
                if(exercise.repEntries.isEmpty){
                    Text("Emtpy")
                }
                ForEach(Array(exercise.repEntries.enumerated()), id: \.element) { index, rep in
                    VStack {
                        Text("Rep \(index + 1)")
                            .font(.headline)
                        let forceTimeData = rep.calculateForceOverTime()
                        let velocityTimeData = rep.calculateVelocityOverTime()
                        VStack {
                            Text("Force over Time")
                            Chart {
                                ForEach(0..<forceTimeData.count, id: \.self) { index in
                                    let item = forceTimeData[index]
                                    LineMark(
                                        x: .value("Time", index), // item.0 refers to the first element of the tuple, which is time
                                        y: .value("Force", item) // item.1 refers to the second element of the tuple, which is force
                                    )
                                }
                            }
                            .frame(height: 300)
                        }
                        VStack {
                            Text("Velocity over Time")
                            Chart {
                                ForEach(0..<velocityTimeData.count, id: \.self) { index in
                                    let item = velocityTimeData[index]
                                    LineMark(
                                        x: .value("Time", index), // item.0 refers to the first element of the tuple, which is time
                                        y: .value("Velocity", (item * -1)) // item.1 refers to the second element of the tuple, which is force
                                    )
                                }
                            }
                            .frame(height: 300)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    func generateFakeData() -> [ENTRY] {
        let duration = 5.0 // Duration of the rep in seconds
        let samplesPerSecond = 10
        let totalSamples = Int(duration * Double(samplesPerSecond))
        var entries: [ENTRY] = []

        for i in 0..<totalSamples {
            let timestamp = Double(i) / Double(samplesPerSecond)
            // Simple sinusoidal pattern for acceleration
            let value = sin(Double(i) * (2.0 * .pi / Double(totalSamples)))
            let entry = ENTRY(timestamp: timestamp, value: value)
            entries.append(entry)
        }

        return entries
    }
    
    let fakeRepData = generateFakeData()
    let fakeRep = Rep(repData: fakeRepData, mass: 20.0)
    let exercise1 = Exercise(exerciseType: "Bicep Curl", weight: 20)
    exercise1.repEntries = [fakeRep]

    return RepDetailedView(exercise: exercise1)
}
