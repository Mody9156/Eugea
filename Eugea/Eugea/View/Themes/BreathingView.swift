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
        Text("Respiration")
    }
}

#Preview {
    BreathingView()
}
