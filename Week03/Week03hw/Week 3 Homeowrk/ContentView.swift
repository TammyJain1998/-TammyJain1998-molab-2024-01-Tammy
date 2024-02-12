import SwiftUI

struct ContentView: View {
    let dim = CGFloat(400) // Adjust the size of the image as needed
    let lineLen = 1 / 10.0
    let strokeLen = 4 / 10.0
    @State private var generatedImage: Image?
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(UIImage(), transitionMaskImage: UIImage())
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Display the generated image
                generatedImage?
                    .resizable()
                    .frame(width: dim*2, height: dim*2.5)
                
                // VStack containing buttons
                VStack {
                    // Regenerate button
                    Button(action: {
                        self.generateImage()
                    }) {
                        Text("Regenerate")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    // Download button
                    Button(action: {
                        // Action for the Download button
                        print("Download tapped")
                    }) {
                        Text("Download")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .padding()
            .onAppear {
                self.generateImage()
            }
        }
    }
    
    func generateImage() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: dim*2, height: dim*2.2))
        
        let image = renderer.image { (context) in
            let ctx = context.cgContext
            let box = CGRect(origin: .zero, size: renderer.format.bounds.size)
            UIColor.gray.setFill()
            ctx.fill(box)
            let xlen = box.width * CGFloat(lineLen)
            let ylen = box.height * CGFloat(lineLen)
            ctx.setLineCap(.round)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.setLineWidth(xlen * CGFloat(strokeLen))
            var x = CGFloat(0)
            var y = CGFloat(0)
            while y < box.height {
                if Bool.random() {
                    // Draw line top left to bottom right
                    ctx.move(to: CGPoint(x: x, y: y))
                    ctx.addLine(to: CGPoint(x: x+xlen, y: y+ylen))
                } else {
                    // Draw line top right to bottom left
                    ctx.move(to: CGPoint(x: x+xlen, y: y))
                    ctx.addLine(to: CGPoint(x: x, y: y+ylen))
                }
                ctx.drawPath(using: .fillStroke)
                x += xlen
                if x > box.width {
                    x = 0
                    y += ylen
                }
            }
        }
        
        self.generatedImage = Image(uiImage: image)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
