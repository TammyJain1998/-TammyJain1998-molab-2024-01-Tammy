import SwiftUI

struct AccountView: View {
     var name: String
     var phoneNumber: String
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var image: Image = Image(systemName: "person.circle.fill")  // Default image

    var body: some View {
        VStack {
            Spacer()
            image
                .resizable()
                             .scaledToFill()
                             .frame(width: 150, height: 150)
                             .clipShape(Circle())
                             .overlay(Circle().stroke(Color.gray, lineWidth: 1)) // Inner border
                             .padding(10) // Creates space between the inner image and the outer circle
                             .background(Circle().stroke(Color.gray, lineWidth: 3)) // Outer circle as a background with a border
                             .padding(.bottom, 0)  // Space between the image and the text
            Text(name)
                .font(.title)
                .fontWeight(.medium)

            Button("Change Photo") {
                showingImagePicker = true
            }
            .foregroundColor(.gray)

            Text("Phone Number")
                .font(.title3)
                .fontWeight(.medium)
                .padding(.top, 40)
            
            Text(phoneNumber)
                .font(.title)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
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
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
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

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(name: "John Doe", phoneNumber: "+1234567890")
    }
}
