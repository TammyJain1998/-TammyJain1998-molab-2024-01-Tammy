//
//  First View.swift
//  GuidedCapture
//
//  Created by Tamanna Jain on 3/24/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct FirstView: View {
    @State private var logoOpacity: Double = 0.0 // State variable to control opacity
    @State private var shouldNavigate: Bool = false // State variable to control navigation
    
    // Create an instance of CaptureFolderManager
    let captureFolderManager = CaptureFolderManager()

    var body: some View {
        NavigationView {
            ZStack {
                // Multicolor hombre rectangle
                Rectangle()
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.yellow, Color.gray]),
                            center: .topTrailing,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 360)
                        )
                    )
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("LOGO")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .opacity(logoOpacity) // Apply opacity based on state
                    
                        .onAppear { // Triggered when the view appears
                            withAnimation(.easeIn(duration: 2.0)) { // Add animation
                                logoOpacity = 1.0 // Fade in the logo
                            }
                            // Start timer to navigate after 5 seconds
                            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                shouldNavigate = true // Set the flag to trigger navigation
                            }
                        }
                        .padding() // Add padding to VStack
                        .scaleEffect(logoOpacity > 0.0 ? 1.0 : 0.5) // Start from smaller size and ease into current size
                }
            }
            .fullScreenCover(isPresented: $shouldNavigate) {
                if let captureFolderManager = captureFolderManager {
                    ModelFilesView(captureFolderManager: captureFolderManager)
                } else {
                    // Handle case where captureFolderManager is nil
                    Text("Error: Capture folder manager not initialized")
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
