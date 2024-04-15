import SwiftUI

struct ModelsListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var modelFiles: [URL] = []
    @State private var captureFolderManager = CaptureFolderManager()!
    @State private var showRenameAlert = false
    @State private var newName: String = ""
    @State private var fileToRename: URL?
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Use `spacing: 0` to remove any default spacing between elements in VStack
                // Logo at the top
                HStack {
                    if colorScheme == .dark {
                        Image("LOGO2") // Displayed in dark mode
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 90)
                            .padding(.vertical, 10)
                    } else {
                        Image("LOGO") // Displayed in light mode
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 90)
                            .padding(.vertical, 10)
                    }

                    Spacer()
                }
                HStack{
                    // Custom title
                    Text("All Scans")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 25.0)
                        .padding(.top, 15.0)
                    Spacer()
                }

                // List with deletion
                List {
                     ForEach(modelFiles, id: \.self) { modelURL in
                         HStack {
                                 Image("LOGIN")
                                     .resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 60, height: 60)
                                     .cornerRadius(5)
                                     .clipped()
                            
                             NavigationLink(destination: ModelView(modelFile: modelURL, endCaptureCallback: { })) {
                                 Text(modelURL.lastPathComponent)
                             }
                         }
                         .contextMenu {
                             Button("Rename") {
                                 fileToRename = modelURL
                                 newName = modelURL.lastPathComponent
                                 showRenameAlert = true
                             }
                             Button("Delete") {
                                 if let index = modelFiles.firstIndex(of: modelURL) {
                                     deleteItems(at: IndexSet(integer: index))
                                 }
                             }
                         }
                     }
                     .onDelete(perform: deleteItems)
                 }
             }
            .alert(isPresented: $showRenameAlert) {
                 Alert(title: Text("Rename File"), message: Text("Enter new name"), primaryButton: .default(Text("OK")) {
                     if let file = fileToRename, !newName.isEmpty {
                         do {
                             let newURL = try captureFolderManager.renameModelFile(at: file, newName: newName)
                             if let index = modelFiles.firstIndex(of: file) {
                                 modelFiles[index] = newURL
                             }
                         } catch {
                             print("Error renaming file: \(error)")
                         }
                     }
                     newName = ""
                 }, secondaryButton: .cancel())
             }
             .onAppear(perform: loadModelFiles)
             .navigationBarHidden(true)
         }
     }

     private func loadModelFiles() {
         Task {
             do {
                 modelFiles = try await captureFolderManager.loadUSDZModelFiles()
             } catch {
                 print("Failed to load model files: \(error)")
             }
         }
     }

     private func deleteItems(at offsets: IndexSet) {
         let urlsToDelete = offsets.map { modelFiles[$0] }
         for url in urlsToDelete {
             captureFolderManager.deleteModelFile(at: url)
         }
         modelFiles.remove(atOffsets: offsets)
     }
 }


