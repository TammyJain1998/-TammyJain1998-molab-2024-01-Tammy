import SwiftUI

//struct StoredDataListView: View {
//    @State private var storedFiles: [URL] = []
//
//    var body: some View {
//        NavigationView {
//            List(storedFiles, id: \.self) { fileURL in
//                NavigationLink(destination: Text("Detail View for \(fileURL.lastPathComponent)")) {
//                    Text(fileURL.lastPathComponent)
//                }
//            }
//            .navigationTitle("Stored Data")
//            .onAppear {
//                loadStoredFiles()
//            }
//        }
//    }
//
//    func loadStoredFiles() {
//        guard let capturesFolder = CaptureFolderManager.rootScansFolder() else {
//            print("Error: Unable to get root scans folder")
//            return
//        }
//        
//        do {
//            let scanDirectories = try FileManager.default.contentsOfDirectory(at: capturesFolder,
//                                                                               includingPropertiesForKeys: nil,
//                                                                               options: .skipsHiddenFiles)
//            var allFiles: [URL] = []
//            for directory in scanDirectories {
//                let contents = try FileManager.default.contentsOfDirectory(at: directory,
//                                                                            includingPropertiesForKeys: nil,
//                                                                            options: .skipsHiddenFiles)
//                allFiles.append(contentsOf: contents)
//            }
//            storedFiles = allFiles
//        } catch {
//            print("Error: \(error)")
//        }
//    }
//}
//
//struct StoredDataListView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoredDataListView()
//    }
//}
struct ModelsListView: View {
    @State private var modelFiles: [URL] = []
    @State private var captureFolderManager = CaptureFolderManager()! // Correctly instantiated, not optional
    
    init(modelFiles: [URL] = []) {
        _modelFiles = State(initialValue: modelFiles)
    }

    var body: some View {
        NavigationView {
             List(modelFiles, id: \.self) { modelURL in
                NavigationLink(destination: ModelView(modelFile: modelURL, endCaptureCallback: {
                    // Actions after viewing the model, if any.
                })) {
                    Text(modelURL.lastPathComponent)
                }
            }
            .onAppear {
                Task {
                    do {
                        let urls = try await captureFolderManager.loadUSDZModelFiles() // Correct usage, not optional
                        modelFiles = urls // Assuming loadUSDZModelFiles() returns [URL], no need for a default value
                    } catch {
                        print("Failed to load model files: \(error)")
                        modelFiles = [] // Setting modelFiles to an empty array in case of error
                    }
                }
            }
            Spacer()
           
            .navigationBarTitle("USDZ Models")
        }
    }
}

struct ModelsListView_Previews: PreviewProvider {
    static var previews: some View {
        // Creating sample URLs for preview
        let sampleModelFiles = (1...5).map { i -> URL in
            URL(string: "https://example.com/model\(i).usdz")!
        }
        
        ModelsListView(modelFiles: sampleModelFiles)
            .previewDisplayName("ModelsListView Preview")
    }
}
