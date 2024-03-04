import SwiftUI

struct ContentView: View {
    @State private var logoOpacity: Double = 0.0 // State variable to control opacity
    @State private var shouldNavigate: Bool = false // State variable to control navigation

    var body: some View {
        ZStack{
            Image("BACKGROUND")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("LOGO")
                    .opacity(logoOpacity) // Apply opacity based on state
                    .onAppear { // Triggered when the view appears
                        withAnimation(.easeIn(duration: 2.0)) { // Add animation
                            logoOpacity = 1.0 // Fade in the logo
                        }
                        
                        // Start timer to navigate after 5 seconds
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                            shouldNavigate = true // Set the flag to trigger navigation
                        }
                    }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $shouldNavigate) {
            Song_List(songs: testdata)
        }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
