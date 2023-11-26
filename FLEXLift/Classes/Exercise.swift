//
//  Exercise.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class Exercise: ObservableObject, Hashable {
    @Published var exerciseType:String
    @Published var duration: Int
    @Published var repEntries: [Rep]
    @Published var weight: Int
    @Published var totalReps: Int
    let id: UUID
    
    init(exerciseType:String, weight:Int){
        self.exerciseType = exerciseType
        repEntries = []
        duration = 0 
        self.weight = weight
        totalReps = 0 
        id = UUID()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    func addRepEntries(repStartLocs: [Int], entries: [ENTRY]){
        // Iterate over each start location
            for (index, startLoc) in repStartLocs.enumerated() {
                // Determine the end index for this range
                let endLoc = index < repStartLocs.count - 1 ? repStartLocs[index + 1] : entries.count
                // Ensure indices are within bounds
                guard startLoc < entries.count, endLoc <= entries.count else {
                    continue
                }
                // Create a subarray for this rep
                let repEntriesSlice = Array(entries[startLoc..<endLoc])
                // Create a Rep object and add to repEntries
                let rep = Rep(repData: repEntriesSlice, mass: Double(weight))
                repEntries.append(rep)
            }
    }
}
