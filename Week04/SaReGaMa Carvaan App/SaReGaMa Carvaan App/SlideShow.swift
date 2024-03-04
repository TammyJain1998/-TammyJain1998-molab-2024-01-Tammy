import SwiftUI

struct SlideShowView: View {
    var song: Song
    @State private var slideIndex = 1
    @StateObject var audioDJ = AudioDJ() // Instantiate AudioDJ
    @State private var playbackProgress: Double = 0 // For controlling playback progress
    @State private var audioLength: Double = 1 // Initialize to ensure it's always positive
    @State private var timer: Timer? = nil // Timer for tracking playback time
    
    var body: some View {
        VStack {
            Text(song.name)
                .font(Font.system(size: 30, weight: .bold))
                .multilineTextAlignment(.center)
                .padding()
            
            SingleSlideView(song: song, slideIndex: $slideIndex)
                .padding(.bottom, 20)
            
            // Slider to control playback progress
            Slider(value: $playbackProgress, in: 0...max(audioLength, 1), step: 0.1, onEditingChanged: sliderEditingChanged)
                .padding()
                .accentColor(.white)
            
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
            timer?.invalidate() // Invalidate the timer
        }
        .onReceive(audioDJ.$player) { player in
            // Update audioLength when player is set
            if let duration = player?.duration {
                audioLength = duration
                // Start timer for tracking playback time
                startTrackingPlaybackTime()
            }
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
    
    private func startTrackingPlaybackTime() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if let player = audioDJ.player, player.isPlaying {
                playbackProgress = player.currentTime
            } else {
                timer?.invalidate()
            }
        }
    }
    
    private func sliderEditingChanged(editingStarted: Bool) {
        if !editingStarted {
            if let player = audioDJ.player {
                player.currentTime = playbackProgress
                if audioDJ.isPlaying {
                    player.play()
                }
            }
        } else {
            audioDJ.player?.pause()
        }
    }
}


struct SingleSlideView: View {
    var song: Song
    @Binding var slideIndex: Int
    
    var body: some View {
        VStack {
            Image(song.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .cornerRadius(30)
            
            Text(song.singerName)
                .font(.subheadline)
                .foregroundColor(Color.gray)
        }
    }
}


struct SlideShowView_Previews: PreviewProvider {
    static var previews: some View {
        SlideShowView(song: testdata[0])
    }
}
