//
//  MinuteurDeMeditation.swift
//  Eugea
//
//  Created by Modibo on 05/02/2026.
//

import Foundation

// MARK: - Enum des sons de méditation
enum MeditationTimer: String, CaseIterable, Identifiable {
    case meditationBackground = "meditation-background-409198.mp3"
    case meditationMusic1 = "meditation-music-322801.mp3"
    case meditationMusic2 = "meditation-music-338902.mp3"
    case meditationMusic3 = "meditation-music-368634.mp3"
    case meditationMusic4 = "meditation-music-409195.mp3"
    case yogaMeditation = "meditation-yoga-409201.mp3"
    case relaxingYoga1 = "meditation-yoga-relaxing-music-380330.mp3"
    case relaxingYoga2,deepRelaxation = "meditation-yoga-relaxing-music-409196.mp3"
    
    var id: String { rawValue }
}
