//
//  MeditationType.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

// MARK: - Welcome
struct MeditationType: Codable,Identifiable {
    var id = UUID()
    let data: DataClass
    let type: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let result: String
    let interactive: Bool
    let state: MeditationState   // ✅ renommé ici
    let components: [Component]
    let actions: [Action]
    let styles, scripts: String
    let metadata: Metadata
}

// MARK: - Action
struct Action: Codable {
    let type, id, label, icon: String
    let callback: String
}

// MARK: - Component
struct Component: Codable {
    let type, id: String
    let config: Config
}

// MARK: - Config
struct Config: Codable {
    let label: String
    let text: String?
    let style: Style?
    let totalTime, currentTime: Int?
    let phases: [String]?
    let colors: Colors?
}

// MARK: - Colors
struct Colors: Codable {
    let preparation, practice, completion: String
}

// MARK: - Style
struct Style: Codable {
    let fontSize: String
    let fontWeight, color: String?
    let textAlign: String
    let fontStyle, lineHeight, background, padding: String?
    let borderRadius, border, whiteSpace, transition: String?
}

// MARK: - Metadata
struct Metadata: Codable {
    let category, toolType: String
    let features, accessibility: [String]
}

// MARK: - MeditationState ✅ (ex-State)
struct MeditationState: Codable {
    let meditationType: String
    let duration: Int
    let backgroundMusic: String
    let isRunning: Bool
    let isPaused: Bool
    let remainingTime: Int
    let language: String
    let content: Content
}

// MARK: - Content
struct Content: Codable {
    let name: String
    let description: String
    let steps: [String]
}
