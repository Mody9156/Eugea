//
//  MeditationViewModel.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation
import Observation

@Observable
class MeditationViewModel {
    let meditationConfiguration: MeditationConfiguration
    
    init(meditationConfiguration: MeditationConfiguration = MeditationConfiguration()) {
        self.meditationConfiguration = meditationConfiguration
    }
    
    
}
