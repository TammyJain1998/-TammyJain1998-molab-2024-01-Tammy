import SwiftUI

struct ContentView: View {
    let ochreColor = Color(red: 229/255, green: 194/255, blue: 124/255)
    let darkGreyColor = Color(red: 68/255, green: 68/255, blue: 68/255)
    
    var body: some View {
        VStack {
            // Your main content here
            
            Spacer()
            
            ZStack() {
                Rectangle()
                    .padding(0.0)
                    .foregroundColor(darkGreyColor)
                    .frame(height: 80)
                    .ignoresSafeArea(.all, edges: .all)
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Action for Camera
                    }) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(ochreColor)
                            .font(.system(size: 30)) // Adjust the font size
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for Home
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(ochreColor)
                            .font(.system(size: 30)) // Adjust the font size
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for Account
                    }) {
                        Image(systemName: "person.fill")
                            .foregroundColor(ochreColor)
                            .font(.system(size: 30)) // Adjust the font size
                            .padding()
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 750.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
