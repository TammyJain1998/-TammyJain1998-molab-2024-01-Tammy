import SwiftUI

//struct ModelsListView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @State private var modelFiles: [URL] = []
//    @State private var captureFolderManager = CaptureFolderManager()!
//    @State private var showRenameAlert = false
//    @State private var newName: String = ""
//    @State private var fileToRename: URL?
//    @State private var showingImagePicker: Bool = false
//    @State private var inputImage: UIImage?
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) { // Use `spacing: 0` to remove any default spacing between elements in VStack
//                // Logo at the top
//                HStack {
//                    if colorScheme == .dark {
//                        Image("LOGO2") // Displayed in dark mode
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 120, height: 90)
//                            .padding(.vertical, 10)
//                    } else {
//                        Image("LOGO") // Displayed in light mode
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 120, height: 90)
//                            .padding(.vertical, 10)
//                    }
//
//                    Spacer()
//                }
//                HStack{
//                    // Custom title
//                    Text("All Scans")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .multilineTextAlignment(.leading)
//                        .padding(.leading, 25.0)
//                        .padding(.top, 15.0)
//                    Spacer()
//                }
//
//                // List with deletion
//                List {
//                     ForEach(modelFiles, id: \.self) { modelURL in
//                         HStack {
//                                 Image("LOGIN")
//                                     .resizable()
//                                     .aspectRatio(contentMode: .fill)
//                                     .frame(width: 60, height: 60)
//                                     .cornerRadius(5)
//                                     .clipped()
//                            
//                             NavigationLink(destination: ModelView(modelFile: modelURL, endCaptureCallback: { })) {
//                                 Text(modelURL.lastPathComponent)
//                             }
//                         }
//                         .contextMenu {
//                             Button("Rename") {
//                                 fileToRename = modelURL
//                                 newName = modelURL.lastPathComponent
//                                 showRenameAlert = true
//                             }
//                             Button("Delete") {
//                                 if let index = modelFiles.firstIndex(of: modelURL) {
//                                     deleteItems(at: IndexSet(integer: index))
//                                 }
//                             }
//                         }
//                     }
//                     .onDelete(perform: deleteItems)
//                 }
//             }
//            .alert(isPresented: $showRenameAlert) {
//                 Alert(title: Text("Rename File"), message: Text("Enter new name"), primaryButton: .default(Text("OK")) {
//                     if let file = fileToRename, !newName.isEmpty {
//                         do {
//                             let newURL = try captureFolderManager.renameModelFile(at: file, newName: newName)
//                             if let index = modelFiles.firstIndex(of: file) {
//                                 modelFiles[index] = newURL
//                             }
//                         } catch {
//                             print("Error renaming file: \(error)")
//                         }
//                     }
//                     newName = ""
//                 }, secondaryButton: .cancel())
//             }
//             .onAppear(perform: loadModelFiles)
//             .navigationBarHidden(true)
//         }
//     }
//
//     private func loadModelFiles() {
//         Task {
//             do {
//                 modelFiles = try await captureFolderManager.loadUSDZModelFiles()
//             } catch {
//                 print("Failed to load model files: \(error)")
//             }
//         }
//     }
//
//     private func deleteItems(at offsets: IndexSet) {
//         let urlsToDelete = offsets.map { modelFiles[$0] }
//         for url in urlsToDelete {
//             captureFolderManager.deleteModelFile(at: url)
//         }
//         modelFiles.remove(atOffsets: offsets)
//     }
// }
//
//


struct ModelsListView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var modelFiles: [URL] = []
    @State private var captureFolderManager = CaptureFolderManager()!
    @State private var showRenameAlert = false
    @State private var newName: String = ""
    @State private var fileToRename: URL?
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var image: Image = Image("LOGIN")  // Default image when no photo has been selected yet
    @State private var selectedImageIndex: Int? // To keep track of which image is being replaced
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Logo at the top
                HStack {
                    if colorScheme == .dark {
                        Image("LOGO2") // Dark mode logo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 90)
                            .padding(.vertical, 10)
                    } else {
                        Image("LOGO") // Light mode logo
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 90)
                            .padding(.vertical, 10)
                    }
                    Spacer()
                }
                
                // Custom title
                HStack {
                    Text("All Scans")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 25.0)
                        .padding(.top, 15.0)
                    Spacer()
                }
                
                // List with clickable images for updating
                List {
                    ForEach(modelFiles.indices, id: \.self) { index in
                        HStack {
                            Image(uiImage: self.inputImage ?? UIImage(named: "LOGIN")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(5)
                                .clipped()
                                .onTapGesture {
                                    self.selectedImageIndex = index
                                    self.showingImagePicker = true
                                }
                            
                            NavigationLink(destination: ModelView(modelFile: modelFiles[index], endCaptureCallback: { })) {
                                Text(modelFiles[index].lastPathComponent)
                            }
                        }
                        .contextMenu {
                            Button("Rename") {
                                fileToRename = modelFiles[index]
                                newName = modelFiles[index].lastPathComponent
                                showRenameAlert = true
                            }
                            Button("Delete") {
                                deleteItems(at: IndexSet(integer: index))
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .alert("Rename File", isPresented: $showRenameAlert) {
                TextField("Enter new name", text: $newName)
                Button("OK", action: { renameFile() })
            } message: {
                Text("Please enter a new name for the file.")
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker2(image: $inputImage)
            }
            .navigationBarHidden(true)
            .onAppear(perform: loadModelFiles)
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
    
    private func loadImage() {
        guard let selectedImageIndex = selectedImageIndex,
              let inputImage = inputImage else { return }

        let imageData = inputImage.jpegData(compressionQuality: 1.0)
        do {
            try captureFolderManager.saveCustomImage(imageData!, for: modelFiles[selectedImageIndex])
            modelFiles[selectedImageIndex] = captureFolderManager.customImageURL(for: modelFiles[selectedImageIndex])
        } catch {
            print("Failed to save the image for the model: \(error.localizedDescription)")
        }
    }


    private func renameFile() {
        guard let fileToRename = fileToRename, !newName.isEmpty else { return }
        do {
            let newURL = try captureFolderManager.renameModelFile(at: fileToRename, newName: newName)
            if let index = modelFiles.firstIndex(of: fileToRename) {
                modelFiles[index] = newURL
            }
            showRenameAlert = false
        } catch {
            print("Error renaming file: \(error)")
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

struct ImagePicker2: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker2

        init(_ parent: ImagePicker2) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

