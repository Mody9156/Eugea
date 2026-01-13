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
    
    enum ThrowableError: Error {
        case someError
    }
    
    func showExercise() async throws {
        
        do{
            let result = try await meditationConfiguration.fetchResult_ofMeditation()
            
            self.meditationType = [result]
            print("super")
        }catch{
            print("meditationType \(meditationType.count)")
            print("meditationType \(meditationType.description)")
            print("dommage")
            throw ThrowableError.someError
        }
    }
}
