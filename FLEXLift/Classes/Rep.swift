//
//  Rep.swift
//  FLEXLift
//
//  Created by Ava Luna Pardo Keegan on 11/17/23.
//

import Foundation

class Rep: ObservableObject, Hashable{
    @Published var repData: [ENTRY]

    init(){
        repData = []
    }
    
    static func == (lhs: Rep, rhs: Rep) -> Bool {
            return lhs.repData == rhs.repData
    }

    func hash(into hasher: inout Hasher) {
            hasher.combine(repData)
    }
}
