//
//  Workout.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class Workout: ObservableObject, Hashable{
    @Published var exercises: [Exercise]

    init(){
        exercises = []
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
            return lhs.exercises == rhs.exercises
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(exercises)
    }
}
