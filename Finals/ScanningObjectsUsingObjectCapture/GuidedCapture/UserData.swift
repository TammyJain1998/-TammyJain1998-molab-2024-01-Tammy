import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var imageData: Data?  // Store image data

    func toJSONData() -> Data? {
        let dict: [String: Any] = [
            "name": name,
            "phoneNumber": phoneNumber,
            "imageData": imageData?.base64EncodedString() ?? ""
        ]

        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) {
            return jsonData
        } else {
            return nil
        }
    }
    
    func fromJSONData(_ data: Data) {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                DispatchQueue.main.async {
                    self.name = jsonObject["name"] as? String ?? ""
                    self.phoneNumber = jsonObject["phoneNumber"] as? String ?? ""
                    if let imageDataString = jsonObject["imageData"] as? String, let imageData = Data(base64Encoded: imageDataString) {
                        self.imageData = imageData
                    }
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

struct DataManager {
    static func saveUserData(userData: UserData) {
        guard let jsonData = userData.toJSONData() else { return }
        let filename = getDocumentsDirectory().appendingPathComponent("user.json")
        do {
            try jsonData.write(to: filename)
            print("User data saved successfully.")
        } catch {
            print("Failed to save user data: \(error)")
        }
    }

    static func loadUserData(userData: UserData) {
        let filename = getDocumentsDirectory().appendingPathComponent("user.json")
        do {
            let data = try Data(contentsOf: filename)
            userData.fromJSONData(data)
        } catch {
            print("Failed to load user data: \(error)")
        }
    }

    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
