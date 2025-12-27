//
//  BreathingView.swift
//  Eugea
//
//  Created by Modibo on 27/12/2025.
//

import SwiftUI
import AVKit

struct BreathingView: View {
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        VStack {
            if let player {
                VideoPlayer(player: player)
                    .frame(width: 320, height: 180, alignment: .center)
                
                Button {
                    isPlaying ? player.pause() : player.play()
                    isPlaying.toggle()
                    player.seek(to: .zero)
                } label: {
                    Image(systemName: isPlaying ? "stop" : "play")
                        .padding()
                }
            }
        }
        .task {
            // Use the task modifier to defer creating the player to ensure
            // SwiftUI creates it only once when it first presents the view.
            let url = URL(string: "https://yoursite.com/video.mp4")!
            player = AVPlayer(url: url)
        }
    }
}

#Preview {
    BreathingView()
}
