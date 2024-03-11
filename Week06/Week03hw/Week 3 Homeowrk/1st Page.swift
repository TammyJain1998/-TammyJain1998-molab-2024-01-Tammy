import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Multicolor hombre rectangle
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("CreativeLines")
                        .font(.title)
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                    NavigationLink("Play", destination: ContentView())
                        //.padding()
                        .background(Color("AccentColor"))
                        .foregroundColor(.white)
                }
                .padding() // Add padding to VStack
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
