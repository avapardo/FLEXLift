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
    let id: UUID

    
    init(timestamp: Double, value: Double){
        self.timestamp = timestamp
        self.value = value
        id = UUID()
    }
    
    static func == (lhs: ENTRY, rhs: ENTRY) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
