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
    private var player : AVPlayer?
    var isPlaying : Bool = false
    
    func playSong(song: String) {
        print("🎵 Tentative de lecture : \(song)")
        
        guard let startPlayer = URL(string: song) else {
            print("❌ Erreur : URL invalide pour la piste : \(song)")
            return
        }
        
        if player == nil {
            print("🛠 Initialisation du AVPlayer...")
            player = AVPlayer(url: startPlayer)
        }
        
        if isPlaying {
            player?.pause()
            isPlaying = false
            print("⏸ Musique mise en pause.")
        } else {
            player?.play()
            isPlaying = true
            print("▶️ Lecture en cours...")
        }
    }
}
