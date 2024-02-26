import SwiftUI

struct ContentView: View {
    @State private var logoOpacity: Double = 0.0 // State variable to control opacity
    
    var body: some View {
        NavigationView {
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
                        }
                    NavigationLink(destination : Song_List(songs: testdata)){
                        Text("Song Listing")
                            .font(.body)
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
