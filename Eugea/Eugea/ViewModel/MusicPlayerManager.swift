//
//  MusicPlayerManager.swift
//  Eugea
//
//  Created by Modibo on 17/01/2026.
//

import Foundation
import Observation
import AVFoundation
class MusicPlayerManager {
    static var share = MusicPlayerManager()
    private var player : AVAudioPlayer?
    var isPlaying : Bool = false
    var sound: String = ""
    
    init() {
        if let sound = Bundle.main.path(forResource: sound, ofType: "mp3"){
            do {
                self.player = try AVAudioPlayer(
                    contentsOf: URL(fileURLWithPath: sound)
                )
            }catch{
                print("AVAudioPlayer could not be instantiated.")
            }
        } else {
            print("Audio file could not be found.")
        }
    }
    
    func playSong(song:String) {
        guard let startPlayer = player else { return }
        
        if startPlayer.isPlaying {
            startPlayer.pause()
            isPlaying = false
        } else {
            startPlayer.play()
            isPlaying = true
        }
    }
}
