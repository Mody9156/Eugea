//
//  antiAnxietyViewViewModel.swift
//  Eugea
//
//  Created by Modibo on 31/12/2025.
//

import Foundation
import Observation

@Observable
class AntiAnxietyViewModel {
    let meditationConfiguration: MeditationConfiguration
    var meditationType : [MeditationType] = []
    
    init(meditationConfiguration: MeditationConfiguration = MeditationConfiguration()) {
        self.meditationConfiguration = meditationConfiguration
    }
    
    enum ThrowableError: Swift.Error {
        case someError
    }
    
    func showExercise( backgroundMusic: String,
                       duration: Int,
                       meditationType: String) async throws {
        do{
            let result =  try await meditationConfiguration.fetchResult_ofMeditation(
                backgroundMusic: backgroundMusic,
                duration: duration,
                meditationType: meditationType
            )
            
            self.meditationType = [result]
            
        }catch{
            throw ThrowableError.someError
        }
    }
}
