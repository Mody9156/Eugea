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
    var sound: String = ""
    
    
    
    
    func playSong(song:String) {
        player?.play()
        isPlaying = true
    }
}
