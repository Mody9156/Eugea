//
//  MeditationType.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

// MARK: - Welcome
struct Meditation: Codable, Identifiable {
    var id = UUID()
    var data: DataClass
    var type: String
}

// MARK: - DataClass
struct DataClass: Codable {
    var result: String
    var interactive: Bool
    var state: State
    var components: [Component]
    var actions: [Action]
    var styles, scripts: String
    var metadata: Metadata
}

// MARK: - Action
struct Action: Codable {
    var type, id, label, icon: String
    var callback: String
}

// MARK: - Component
struct Component: Codable {
    var type, id: String
    var config: Config
}

// MARK: - Config
struct Config: Codable {
    var label: String
    var text: String?
    var style: Style?
    var totalTime, currentTime: Int?
    var phases: [String]?
    var colors: Colors?
}

// MARK: - Colors
struct Colors: Codable {
    var preparation, practice, completion: String
}

// MARK: - Style
struct Style: Codable {
    var fontSize: String
    var fontWeight, color: String?
    var textAlign: String
    var fontStyle, lineHeight, background, padding: String?
    var borderRadius, border, whiteSpace, transition: String?
}

// MARK: - Metadata
struct Metadata: Codable {
    var category, toolType: String
    var features, accessibility: [String]
}

// MARK: - State
struct MeditationState: Codable {
    var meditationType: String
    var duration: Int
    var backgroundMusic: String
    var isRunning, isPaused: Bool
    var remainingTime: Int
    var language: String
    var content: Content
}

// MARK: - Content
struct Content: Codable {
    var name, description: String
    var steps: [String]
}
