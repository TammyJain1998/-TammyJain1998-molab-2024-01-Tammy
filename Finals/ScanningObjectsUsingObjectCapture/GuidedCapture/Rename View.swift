import SwiftUI

struct TextFieldAlert: UIViewControllerRepresentable {
    @Binding var text: String
    var placeholder: String
    let completion: () -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        return UIViewController() // placeholder controller, real work is done in updateUIViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard context.coordinator.alert == nil else { return }
        
        let alert = UIAlertController(title: "Rename File", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = text
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let textField = alert.textFields?.first, let text = textField.text {
                self.text = text
                completion()
            }
            alert.dismiss(animated: true)
        })
        
        context.coordinator.alert = alert
        DispatchQueue.main.async { // must be async to avoid modifying state during view update
            uiViewController.present(alert, animated: true, completion: {
                context.coordinator.alert = nil
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var alert: UIAlertController?
        var textFieldAlert: TextFieldAlert

        init(_ textFieldAlert: TextFieldAlert) {
            self.textFieldAlert = textFieldAlert
        }
    }
}
