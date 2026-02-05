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
    
    // L'URL de base récupérée depuis les scripts de l'API
    private let audioBaseURL = "https://elysiatools.com/public/samples/mp3/"
    
    func playSong(song: String) {
        // 1. On construit l'URL complète (ex: base + "meditation-background-409198.mp3")
        let fullURLString = audioBaseURL + song + ".mp3"
        
        print("🌐 Tentative de lecture : \(fullURLString)")
        
        guard let url = URL(string: fullURLString) else {
            print("❌ Erreur : URL malformée")
            return
        }
        
        // 2. Si le player n'existe pas ou si on change de musique
        if player == nil {
            player = AVPlayer(url: url)
            print("player == nil")
        } else {
            // Permet de changer de morceau si on clique sur un autre
            let newItem = AVPlayerItem(url: url)
            player?.replaceCurrentItem(with: newItem)
            print("player != nil")
        }
        
        // 3. Logique Play/Pause
        if isPlaying {
            player?.pause()
            isPlaying = false
            print("⏸ Pause")
        } else {
            player?.play()
            isPlaying = true
            print("▶️ Lecture en cours...")
        }
    }
}
