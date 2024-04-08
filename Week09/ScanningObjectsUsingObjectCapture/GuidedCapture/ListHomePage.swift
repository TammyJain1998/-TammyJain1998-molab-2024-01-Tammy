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
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme
    @State private var modelFiles: [URL] = []
    @State private var captureFolderManager = CaptureFolderManager()! // Correctly instantiated, not optional

    init(modelFiles: [URL] = []) {
        _modelFiles = State(initialValue: modelFiles)
    }

    var body: some View {
        VStack {
            HStack {
                // Conditionally show image based on color scheme
                if colorScheme == .dark {
                    Image("LOGO2") // Displayed in dark mode
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 90)
                        .padding(.vertical, 50.0)
                } else {
                    Image("LOGO") // Displayed in light mode
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 90)
                        .padding(.vertical, 50.0)
                }
                
                Spacer()
            }
            //.padding(.top, 16) // Adjust padding as needed
        NavigationView {

                List(modelFiles, id: \.self) { modelURL in
                    NavigationLink(destination: ModelView(modelFile: modelURL, endCaptureCallback: {
                        // Actions after viewing the model, if any.
                    })) {
                        Text(modelURL.lastPathComponent)
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        let urls = try await captureFolderManager.loadUSDZModelFiles()
                        modelFiles = urls
                    } catch {
                        print("Failed to load model files: \(error)")
                        modelFiles = [] // In case of error
                    }
                }
            }
            .navigationBarTitle("All Scans")
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
