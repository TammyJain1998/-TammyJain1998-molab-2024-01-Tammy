import SwiftUI

struct HomeButtonView: View {
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme
    
    let ochreColor = Color(red: 229/255, green: 194/255, blue: 124/255)
    let darkGreyColor = Color(red: 68/255, green: 68/255, blue: 68/255, opacity: 1)
    
    @State private var isContentVisible = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            ZStack {
                Rectangle()
                    .padding(0.0)
                    .foregroundColor(darkGreyColor)
                    .frame(height: 80)
                    .ignoresSafeArea(.all, edges: .all)
                
                ZStack {
                    
                    Circle()
                        .foregroundColor(darkGreyColor) // Adjust color as needed
                        .frame(width: 90, height: 90)
                        .offset(x: 5, y: -15) // Adjust offset to position the circle
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            // Action for Camera
                            isContentVisible.toggle()
                        }) {
                            Image(systemName: "camera.fill")
                                .foregroundColor(ochreColor)
                                .font(.system(size: 30)) // Adjust the font size
                                .padding()
                        }
                        .fullScreenCover(isPresented: $isContentVisible) {
                            ContentView()
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
            }
            .padding(.top, 750.0)
        }
    }
}

struct HomeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for preview
            HomeButtonView()
        }
    }
}
