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
    
    
    func playSong(song:String) {
//        let playerItem = AVPlayer
//        player = AVPlayer(playerItem: AVPlayerItem()
        player?.play()
        isPlaying = true
    }
}
