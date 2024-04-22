//
//  UserData.swift
//  GuidedCapture
//
//  Created by Tamanna Jain on 4/15/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var imageData: Data?  // Store image data
}
