//
//  Item.swift
//  GuidedCapture
//
//  Created by Tamanna Jain on 3/24/24.
//  Copyright © 2024 Apple. All rights reserved.
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
