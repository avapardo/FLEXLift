//
//  Exercise.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class Exercise: ObservableObject, Hashable {
    @Published var exerciseType:String
    @Published var duration: Double
    @Published var repEntries: [Rep]
    @Published var weight: Int
    @Published var totalReps: Int
    
    init(exerciseType:String, weight:Int){
        self.exerciseType = exerciseType
        repEntries = []
        duration = 0 
        self.weight = weight
        totalReps = 0 
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(exerciseType)
        hasher.combine(duration)
        hasher.combine(repEntries)
        hasher.combine(weight)
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
            return lhs.exerciseType == rhs.exerciseType &&
                   lhs.duration == rhs.duration &&
                   lhs.repEntries == rhs.repEntries &&
                   lhs.weight == rhs.weight
    }
}
