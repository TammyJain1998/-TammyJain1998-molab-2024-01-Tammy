import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userData: UserData  // Shared user data
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showNextView: Bool = false
    let ochreColor = Color(red: 229/255, green: 194/255, blue: 124/255)
    let captureFolderManager = CaptureFolderManager() // Assuming CaptureFolderManager is defined elsewhere
    
    var body: some View {
        if showNextView {
            CombinedView() // Assuming CombinedView is the central view that might display the account details
        } else {
            VStack {
                Spacer()
                Image("LOGIN")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .cornerRadius(18.0)
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding([.top, .leading], 10)
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("Phone Number", text: $phoneNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.phonePad)
                
                Button("Login") {
                    // Simulate login success
                    userData.name = name
                    userData.phoneNumber = phoneNumber
                    isLoginSuccessful = true
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 300)
                .background(RoundedRectangle(cornerRadius: 10).fill(ochreColor))
                .padding()
                
                Spacer()
            }
            .alert(isPresented: $isLoginSuccessful) {
                Alert(
                    title: Text("Login Successful"),
                    message: Text("Welcome, \(name)!"),
                    dismissButton: .default(Text("OK")) {
                        // Transition to the next view
                        showNextView = true
                    }
                )
            }
        }
    }
}
