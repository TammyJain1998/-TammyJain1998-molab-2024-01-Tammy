import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userData: UserData  // Accessing the shared user data
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            Spacer()
            Group {
                if let imageData = userData.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Image(systemName: "person.circle.fill")  // Default image
                        .resizable()
                }
            }
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1)) // Inner border
            .padding(10) // Creates space between the inner image and the outer circle
            .background(Circle().stroke(Color.gray, lineWidth: 3)) // Outer circle as a background with a border
            .padding(.bottom, 0)  // Space between the image and the text

            Text("\(userData.name)")
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
            
            Text("\(userData.phoneNumber)")
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
        if let imageData = inputImage.jpegData(compressionQuality: 1.0) {
            userData.imageData = imageData
            DataManager.saveUserData(userData: userData)  // Correctly reference DataManager
        }
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
