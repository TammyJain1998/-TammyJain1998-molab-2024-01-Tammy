import SwiftUI

struct ContentView: View {
    let dim = CGFloat(400) // Adjust the size of the image as needed
    let lineLen = 1 / 10.0
    let strokeLen = 4 / 10.0
    @State private var generatedImage: UIImage?
    @State private var opacity: Double = 1.0 // Initial opacity
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.setBackIndicatorImage(UIImage(), transitionMaskImage: UIImage())
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Display the generated image with fading animation
                Image(uiImage: generatedImage ?? UIImage())
                    .resizable()
                    .frame(width: dim*2, height: dim*2.5)
                    .opacity(opacity) // Apply opacity
                    .animation(.easeInOut(duration: 0.8)) // Animation duration
                
                VStack {
                    Spacer()
                    HStack {
                        // Regenerate button
                        Button(action: {
                            self.opacity = 0.7 // Fade out
                            self.generateImage()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    self.opacity = 1.0 // Fade in
                                }
                            }
                        }) {
                            Text("Regenerate")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                        }
                        .padding(.vertical)
                        
                        // Download button
                        Button(action: {
                            // Action for the Download button
                            if let image = self.generatedImage {
                                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            }
                        }) {
                            Text("Download")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(10)
                        }
                        .padding(.vertical)
                    }
                    .padding(.bottom, 90.0)
                }
                .padding()
                .onAppear {
                    self.generateImage()
                }
            }
        }
    }
    
    func generateImage() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: dim*2, height: dim*2.2))
        
        let image = renderer.image { (context) in
            let ctx = context.cgContext
            let box = CGRect(origin: .zero, size: renderer.format.bounds.size)
            
            // Set a random fill color
            let randomColor = UIColor(red: .random(in: 0...1),
                                      green: .random(in: 0...1),
                                      blue: .random(in: 0...1),
                                      alpha: 1.0)
            randomColor.setFill()
            
            ctx.fill(box)
            
            let xlen = box.width * CGFloat(lineLen)
            let ylen = box.height * CGFloat(lineLen)
            
            ctx.setLineCap(.round)
            ctx.setStrokeColor(UIColor.black.cgColor) // Set stroke color to black
            
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
        
        self.generatedImage = image
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
