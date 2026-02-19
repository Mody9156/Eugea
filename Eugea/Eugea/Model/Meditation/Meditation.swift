//
//  MeditationType.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

// MARK: - Welcome
struct Meditation: Codable, Identifiable{
    var id: String?
    let data: DataClass
    let type: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let result: String
    let interactive: Bool
    let state: MeditationState
    let components: [MeditationComponent]
    let actions: [Action]
    let styles, scripts: String
    let metadata: MeditationMetadata
}

// MARK: - Action
struct Action: Codable, Hashable {
    let type, id, label, icon: String
    let callback: String
}

// MARK: - Component
struct MeditationComponent: Codable {
    let type, id: String
    let config: MeditationConfig
}

// MARK: - Config
struct MeditationConfig: Codable {
    let label: String
    let text: String?
    let style: MeditationStyle?
    let totalTime, currentTime: Int?
    let phases: [String]?
    let colors: MeditationColors?
}

// MARK: - Colors
struct MeditationColors: Codable {
    let preparation, practice, completion: String
}

// MARK: - Style
struct MeditationStyle: Codable {
    let fontSize: String
    let fontWeight, color: String?
    let textAlign: String
    let fontStyle, lineHeight, background, padding: String?
    let borderRadius, border, whiteSpace, transition: String?
}

// MARK: - Metadata
struct MeditationMetadata: Codable {
    let category, toolType: String
    let features, accessibility: [String]
}

// MARK: - State
struct MeditationState: Codable {
    let meditationType: String
    let duration: Int
    let backgroundMusic: String
    let isRunning, isPaused: Bool
    let remainingTime: Int
    let language: String
    let content: MeditationContent
}

// MARK: - Content
struct MeditationContent: Codable {
    let name, description: String
    let steps: [String]
}
