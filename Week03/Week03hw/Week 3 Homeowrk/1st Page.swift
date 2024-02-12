import SwiftUI

struct FirstView: View {
    var body: some View {
        ZStack {
            Color.gray
            NavigationStack {
                VStack {
                    Text("Tamanna Jain")
                        .font(.largeTitle)
                    Text("CretiveLines")
                        .font(.title)
                        .fontWeight(.ultraLight)
                    NavigationLink("Play", destination: ContentView())
                        .padding(.all, 1.0)
                        .background(Color("AccentColor"))
                        .foregroundColor(.blue)
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
