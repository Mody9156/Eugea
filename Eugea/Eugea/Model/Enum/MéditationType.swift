//
//  MéditationType.swift
//  Eugea
//
//  Created by Modibo on 06/02/2026.
//

import Foundation

enum MeditationType : String, CaseIterable, Identifiable {
    case MeditationBienVeillance = "Méditation de Bienveillance"
    case MonitoringMonitoring = "Méditation de Monitoring Ouvert"
    case MeditationBien = "Méditation d'attention focalisée"
    
    var id: String { rawValue }
}
