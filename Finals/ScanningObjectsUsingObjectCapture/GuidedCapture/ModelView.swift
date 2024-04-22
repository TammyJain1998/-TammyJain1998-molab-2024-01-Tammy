/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A wrapper for AR QuickLook viewer that shows the reconstructed USDZ model
 file directly.
*/

import ARKit
import QuickLook
import SwiftUI
import UIKit
import os
import RealityKit
import Combine

struct ModelView: View {
    let modelFile: URL
    let endCaptureCallback: () -> Void

    var body: some View {
        ARQuickLookController(modelFile: modelFile, endCaptureCallback: endCaptureCallback)
    }
}

private struct ARQuickLookController: UIViewControllerRepresentable {
    static let logger = Logger(subsystem: GuidedCaptureSampleApp.subsystem,
                                category: "ARQuickLookController")

    let modelFile: URL
    let endCaptureCallback: () -> Void

    func makeUIViewController(context: Context) -> QLPreviewControllerWrapper {
        let controller = QLPreviewControllerWrapper()
        controller.qlvc.dataSource = context.coordinator
        controller.qlvc.delegate = context.coordinator
        return controller
    }

    func makeCoordinator() -> ARQuickLookController.Coordinator {
        return Coordinator(parent: self)
    }

    func updateUIViewController(_ uiViewController: QLPreviewControllerWrapper, context: Context) {}

    class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        let parent: ARQuickLookController

        init(parent: ARQuickLookController) {
            self.parent = parent
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.modelFile as QLPreviewItem
        }

        func previewControllerWillDismiss(_ controller: QLPreviewController) {
            ARQuickLookController.logger.log("Exiting ARQL ...")
            parent.endCaptureCallback()
        }
    }
}

private class QLPreviewControllerWrapper: UIViewController {
    let qlvc = QLPreviewController()
    var qlPresented = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !qlPresented {
            present(qlvc, animated: false, completion: nil)
            qlPresented = true
        }
    }
}

//struct ModelView: View {
//    let modelFile: URL
//    let endCaptureCallback: () -> Void
//
//    var body: some View {
//        BodyTrackingARView(modelFile: modelFile)
//            .onDisappear(perform: endCaptureCallback)
//    }
//}
//
//struct BodyTrackingARView: UIViewRepresentable {
//    let modelFile: URL
//    
//    func makeUIView(context: Context) -> ARView {
//        let arView = ARView(frame: .zero)
//        context.coordinator.setupARView(arView: arView)
//        return arView
//    }
//    
//    func updateUIView(_ uiView: ARView, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(modelFile: modelFile)
//    }
//}
//
//class Coordinator: NSObject {
//    var modelFile: URL
//    var character: BodyTrackedEntity?
//    var cancellables: Set<AnyCancellable> = []
//
//    init(modelFile: URL) {
//        self.modelFile = modelFile
//        super.init()
//    }
//
//    func setupARView(arView: ARView) {
//        guard ARBodyTrackingConfiguration.isSupported else {
//            fatalError("Body tracking is not supported on this device.")
//        }
//
//        let configuration = ARBodyTrackingConfiguration()
//        arView.session.run(configuration)
//
//        loadModelEntity(for: arView)
//    }
//
//    func loadModelEntity(for arView: ARView) {
//        let anchor = AnchorEntity()
//        arView.scene.addAnchor(anchor)
//
//        Entity.loadModelAsync(contentsOf: modelFile)
//            .sink(receiveCompletion: { loadCompletion in
//                // Handle errors
//                switch loadCompletion {
//                case .failure(let error):
//                    print("Failed to load model: \(error)")
//                case .finished:
//                    break
//                }
//            }, receiveValue: { entity in
//                if let bodyTrackedEntity = entity as? BodyTrackedEntity {
//                    // Configure and add the entity if it's correctly loaded
//                    self.character = bodyTrackedEntity
//                    anchor.addChild(bodyTrackedEntity)
//                }
//            }).store(in: &cancellables)
//    }
//}
