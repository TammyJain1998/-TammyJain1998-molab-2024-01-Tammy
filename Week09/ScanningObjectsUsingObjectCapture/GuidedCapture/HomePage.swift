//
//  HomePage.swift
//  GuidedCapture
//
//  Created by Tamanna Jain on 4/7/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation
import SwiftUI

struct CombinedView: View {
    @State private var modelFiles: [URL] = []
    @State private var captureFolderManager: CaptureFolderManager?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ModelsListView(modelFiles: modelFiles)
            
            HomeButtonView()
            // Depending on your layout, you might need to adjust the alignment or positioning
        }
        .onAppear {
            Task {
                if let manager = captureFolderManager {
                    do {
                        let urls = try await manager.loadUSDZModelFiles()
                        modelFiles = urls
                    } catch {
                        print("Failed to load model files: \(error)")
                        modelFiles = [] // In case of error
                    }
                } else {
                    print("CaptureFolderManager was not initialized.")
                }
            }
        }
    }
}
