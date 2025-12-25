//
//  StressLevel.swift
//  Eugea
//
//  Created by Modibo on 25/12/2025.
//

import Foundation

enum StressLevel: Int, CaseIterable {
    
    case veryLow = 1      // 1–2
    case low = 3          // 3–4
    case medium = 5       // 5–6
    case high = 7         // 7–8
    case veryHigh = 9     // 9–10
    
    var name: String {
        switch self {
        case .veryLow:
            return "Très faible"
        case .low:
            return "Faible"
        case .medium:
            return "Modéré"
        case .high:
            return "Élevé"
        case .veryHigh:
            return "Très élevé"
        }
    }
    
    /// Convertit une valeur 1–10 en StressLevel
    static func from(value: Int) -> StressLevel {
        switch value {
        case 1...2: return .veryLow
        case 3...4: return .low
        case 5...6: return .medium
        case 7...8: return .high
        default:    return .veryHigh
        }
    }
}
