//
//  Rep.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class Rep: ObservableObject, Hashable{
    @Published var repData: [ENTRY]
    @Published var mass: Double

    init(repData: [ENTRY], mass: Double){
        self.repData = repData
        self.mass = mass
    }
    
    static func == (lhs: Rep, rhs: Rep) -> Bool {
            return lhs.repData == rhs.repData
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(repData)
    }
    
    func calculateCurves() -> (force: [Double], velocity: [Double]) {
           var force = [Double]()
           var velocity = [Double]()
           var currentVelocity = 0.0

           for i in 0..<repData.count {
               let accel = repData[i].value
               force.append(accel * mass)

               if i > 0 {
                   let timeStep = repData[i].timestamp - repData[i-1].timestamp
                   currentVelocity += timeStep * 0.5 * (repData[i-1].value + accel)
               }
               velocity.append(currentVelocity)
           }

           return (force, velocity)
       }
}
