//
//  MeditationType.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

// MARK: - Meditation
struct Meditation: Codable, Identifiable {
    var data: DataClass
    var type: String
    var id: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    var result: String
    var interactive: Bool
    var state: StateMeditation
    var components: [Component]
    var actions: [Action]
    var styles, scripts: String
    var metadata: Metadata
}

// MARK: - Action
struct Action: Codable, Hashable{
    var type, id, label, icon: String
    var callback: String
}

// MARK: - Component
struct Component: Codable {
    var type, id: String
    var config: ConfigMeditation
}

// MARK: - Config
struct ConfigMeditation: Codable {
    var label: String
    var totalTime, currentTime: Int?
    var phases: [String]?
    var colors: ColorsMeditation?
    var text: String?
    var style: StyleMeditation?
}

// MARK: - Colors
struct ColorsMeditation: Codable {
    var ready, meditation, completed: String
}

// MARK: - Style
struct StyleMeditation: Codable {
    var fontSize: String
    var fontWeight: String?
    var color, textAlign: String
    var fontStyle: String?
}

// MARK: - Metadata
struct Metadata: Codable {
    var category, toolType: String
    var features, accessibility: [String]
}

// MARK: - State
struct StateMeditation: Codable {
    var duration: Int
    var musicTrack: String
    var enableSound, isRunning, isPaused: Bool
    var remainingTime, sessions: Int
    var currentPhase: String
}
