//
//  Item.swift
//  SaReGaMa Carvaan App
//
//  Created by Tamanna Jain on 2/24/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
