//
//  Places.swift
//  App1
//
//  Created by Tamanna Jain on 2/10/24.
//

import SwiftUI

struct Places : Identifiable {
    var id = UUID()
    var name: String
    var capacity : Int
    var hasWashroom: Bool = false
    
    var imageName: String { return name }
    var image : String
}

#if DEBUG
let testData = [
    Places(name: "Starbucks", capacity: 6, hasWashroom: true, image: "Starbucks"),
    Places(name: "Dunkin", capacity: 10, hasWashroom: false, image: "Dunkin"),
    Places(name: "Ralphs", capacity: 8, hasWashroom: true, image: "Ralphs"),
    Places(name: "DELI", capacity: 5, hasWashroom: true, image: "DELI"),
    Places(name: "Hardware Store", capacity: 12, hasWashroom: false, image: "Hardware Store"),
    Places(name: "Zoo", capacity: 15, hasWashroom: true, image: "Zoo"),
]
#endif
