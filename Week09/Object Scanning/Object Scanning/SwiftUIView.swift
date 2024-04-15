import SwiftUI

struct LoginView: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var isLoginSuccessful: Bool = false
    let ochreColor = Color(red: 229/255, green: 194/255, blue: 124/255)
    
    var body: some View {
        if isLoginSuccessful {
            AccountView(name: name, phoneNumber: phoneNumber)
        } else {
            VStack {
                Spacer()
                Image("Image") // Ensure you have an image named 'Image' in your assets
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
                    isLoginSuccessful = true // Simulate login success
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
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
