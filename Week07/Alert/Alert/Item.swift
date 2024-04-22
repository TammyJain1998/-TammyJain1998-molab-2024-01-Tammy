//
//  Item.swift
//  Alert
//
//  Created by Tamanna Jain on 4/19/24.
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
