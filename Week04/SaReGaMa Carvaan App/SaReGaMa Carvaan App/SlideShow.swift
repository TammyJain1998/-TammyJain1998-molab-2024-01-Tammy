import SwiftUI

struct SlideShowView: View {
    var song: Song
    @State private var slideIndex = 0
    @StateObject var audioDJ = AudioDJ() // Instantiate AudioDJ
    
    var body: some View {
        VStack {
            Text(song.name)
                .font(Font.system(size: 30, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20.0)
                
            
            SingleSlideView(song: song, slideIndex: $slideIndex)
                .padding(.bottom, 20)
            
            HStack {
                Button(action: previousItemAction) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .foregroundColor(.white) // Set the color to black
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    if audioDJ.isPlaying {
                        audioDJ.pause()
                    } else {
                        audioDJ.playSong(song.audioFileName)
                    }
                }) {
                    Image(systemName: audioDJ.isPlaying ? "pause" : "play")
                        .resizable()
                        .frame(width: 20, height: 25)
                        .foregroundColor(.white) // Set the color to black
                }
                .padding()
                
                Spacer()
                
                Button(action: nextItemAction) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 20, height: 30)
                        .foregroundColor(.white) // Set the color to black
                }
                .padding()
            }
        }
        .onDisappear {
            audioDJ.stop() // Stop the audio when leaving the view
        }
    }
    
    func previousItemAction() {
        if slideIndex > 0 {
            slideIndex -= 1
        }
    }
    
    func nextItemAction() {
        if slideIndex < testdata.count - 1 {
            slideIndex += 1
        }
    }
}

struct SlideShowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideShowView(song: testdata[0])
    }
}
