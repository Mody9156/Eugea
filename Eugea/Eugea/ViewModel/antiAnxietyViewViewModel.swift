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
    var meditationType : [MeditationSession] = []
    
    init(meditationConfiguration: MeditationConfiguration = MeditationConfiguration()) {
        self.meditationConfiguration = meditationConfiguration
    }
    
    enum ThrowableError: Swift.Error {
        case someError
    }
    
    func showExercise() async throws {
        do{
            let result =  try await meditationConfiguration.fetchResult_ofMeditation(
                backgroundMusic: <#String#>,
                duration: <#Int#>,
                meditationType: <#String#>
            )
            self.meditationType = result
        }catch{
            throw ThrowableError.someError
        }
    }
}
