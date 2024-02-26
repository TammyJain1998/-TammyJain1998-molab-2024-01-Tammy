//
//  AudioDJ.swift
//  SaReGaMa Carvaan App
//
//  Created by Tamanna Jain on 2/25/24.
//

import AVFoundation

class AudioDJ: ObservableObject {
    @Published var soundIndex = 0
    @Published var soundFile = audioRef[0]
    @Published var player: AVAudioPlayer? = nil
    @Published var isPlaying: Bool = false
    @Published var playbackPosition: TimeInterval = 0 // Store playback position
    
    // class must have initializer
    init() {
        print("AudioDJ init")
    }
    
    func playSong(_ fileName: String) {
        stop() // Stop any currently playing audio
        soundFile = fileName // Set the new audio file
        play() // Play the new audio
    }

    
    func play() {
        player = loadAudio(soundFile)
        player?.currentTime = playbackPosition // Set playback position
        print("AudioDJ player", player as Any)
        // Loop indefinitely
        player?.numberOfLoops = -1
        player?.play()
        isPlaying = true
    }
    
    func pause() {
        player?.pause()
        playbackPosition = player?.currentTime ?? 0 // Store playback position
        isPlaying = false
    }
    
    func stop() {
        player?.stop()
        isPlaying = false
    }
    
    func next() {
        choose(soundIndex+1)
    }
    
    func choose(_ index:Int) {
        soundIndex = (index) % AudioDJ.audioRef.count
        soundFile = AudioDJ.audioRef[soundIndex]
    }
    
    func loadAudio(_ str:String) -> AVAudioPlayer? {
        if (str.hasPrefix("https://")) {
            return loadUrlAudio(str)
        }
        return loadBundleAudio(str)
    }
    
    func loadUrlAudio(_ urlString:String) -> AVAudioPlayer? {
        let url = URL(string: urlString)
        do {
            let data = try Data(contentsOf: url!)
            return try AVAudioPlayer(data: data)
        } catch {
            print("loadUrlSound error", error)
        }
        return nil
    }
    
    func loadBundleAudio(_ fileName:String) -> AVAudioPlayer? {
        if let path = Bundle.main.path(forResource: fileName, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            do {
                return try AVAudioPlayer(contentsOf: url)
            } catch {
                print("loadBundleAudio error", error)
            }
        } else {
            print("Audio file not found:", fileName)
        }
        return nil
    }
    
    static let audioRef = [
        "Kehdoon Tumhe, Ya Chup Rahun  Kishore Kumar  Deewaar Romantic Song 4K.mp3",
        "Dekha Ek Khwab Song  Silsila  Amitabh Bachchan, Rekha  Kishore Kumar, Lata Mangeshkar, Shiv-Hari.mp3",
        "Mere Samne Wali Khidki Mein - Padosan - Saira Banu, Sunil Dutt & Kishore Kumar - Old Hindi Songs.mp3",
        "Chura lia hai tumne...old hindi songs by copied.mp3",
        "Tu Tu Hai Wahi   Love Song   Kishore Kumar  Asha Bhosle.mp3",
        "Tere Jaisa Yaar Kahan  Kishore Kumar  Yaarana 1981 Songs  Amitabh Bachchan.mp3"
    ]
}
