//
//  Entry.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class ENTRY: ObservableObject, Hashable{
    @Published var timestamp: Double
    @Published var value: Double
    
    init(timestamp: Double, value: Double){
        self.timestamp = timestamp
        self.value = value
    }
    
    static func == (lhs: ENTRY, rhs: ENTRY) -> Bool {
        return lhs.timestamp == rhs.timestamp && lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
        hasher.combine(value)
    }
    
}
