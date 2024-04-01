import SwiftUI

struct ModelFilesView: View {
    @ObservedObject var captureFolderManager: CaptureFolderManager
    @State private var isContentVisible = false

    var body: some View {
        NavigationView {
            VStack {
                if captureFolderManager.modelFiles.isEmpty {
                    Text("No model files found")
                } else {
                    List(captureFolderManager.modelFiles, id: \.self) { modelFile in
                        Text(modelFile.lastPathComponent)
                    }
                    .navigationTitle("Model Files")
                }
                Spacer()
                Button(action: {
                    isContentVisible.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .offset(x: 20, y: -20)
                .padding()
                .fullScreenCover(isPresented: $isContentVisible) {
                    ContentView()
                }
            }
        }
    }
}

struct ModelFilesView_Previews: PreviewProvider {
    static var previews: some View {
        if let captureFolderManager = CaptureFolderManager() {
            return AnyView(ModelFilesView(captureFolderManager: captureFolderManager))
        } else {
            return AnyView(Text("CaptureFolderManager is nil"))
        }
    }
}
