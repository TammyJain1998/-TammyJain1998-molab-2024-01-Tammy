import SwiftUI

struct FirstView: View {
    @State private var logoOpacity: Double = 0.0 // State variable to control opacity
    var body: some View {
        NavigationView {
            ZStack {
                // Multicolor hombre rectangle
                Rectangle()
                    .fill(
                        AngularGradient(
                            gradient: Gradient(colors: [Color.yellow, Color.gray]),
                            center: .topTrailing,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 360)
                        )
                    )
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Image("LOGO")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .opacity(logoOpacity) // Apply opacity based on state
                    
                        .onAppear { // Triggered when the view appears
                            withAnimation(.easeIn(duration: 2.0)) { // Add animation
                                logoOpacity = 1.0 // Fade in the logo
                            }
                        }
                        .padding() // Add padding to VStack
                        .scaleEffect(logoOpacity > 0.0 ? 1.0 : 0.5) // Start from smaller size and ease into current size
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
