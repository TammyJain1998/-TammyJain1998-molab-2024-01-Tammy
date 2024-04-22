/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Top-level app structure of the view hierarchy.
*/

// return documentsFolder.appendingPathComponent("Scans/", isDirectory: true)
// voice memo app souce code

import SwiftUI

@main
struct GuidedCaptureSampleApp: App {
    static let subsystem: String = "com.example.apple-samplecode.GuidedCapture"
    @StateObject var userData = UserData()
    
    var body: some Scene {
         WindowGroup {
             if #available(iOS 17.0, *) {
                 FirstView()
                     .environmentObject(userData)
             }
         }
     }
 }
