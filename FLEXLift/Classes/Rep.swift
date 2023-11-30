//
//  Rep.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation
import Charts 

class Rep: ObservableObject, Hashable{
    @Published var repData: [ENTRY]
    @Published var mass: Double
    let id: UUID

    init(repData: [ENTRY], mass: Double){
        self.repData = repData
        self.mass = mass / 2.205
        id = UUID()
    }
    
    static func == (lhs: Rep, rhs: Rep) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
    
    func calculateVelocityOverTime() -> [Double] {
            var velocityTimeArray: [Double] = []

           var currentVelocity = 0.0

           for i in 0..<repData.count {
               let accel = repData[i].value
               
               if i > 0 {
                   let timeStep = repData[i].timestamp - repData[i-1].timestamp
                   currentVelocity += timeStep * 0.5 * (repData[i-1].value + accel)
               }
               velocityTimeArray.append(currentVelocity)
           }

           return velocityTimeArray
    }
    
    func calculateForceOverTime() -> [Int] {
        var forceTimeArray: [Int] = []

        for data in repData {
            let force = data.value * mass
            forceTimeArray.append(Int(force))
        }

        return forceTimeArray
    }
}
