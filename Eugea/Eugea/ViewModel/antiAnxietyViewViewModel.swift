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
    var meditation : [Meditation] = []
    
    init(meditationConfiguration: MeditationConfiguration = MeditationConfiguration()) {
        self.meditationConfiguration = meditationConfiguration
    }
    
    enum ThrowableError: Error {
        case someError
    }
    
    func showExercise(musicTrack: String,
                      duration: Int,
                      enableSound: Bool) async throws {
        
        do{
            let result = try await meditationConfiguration.fetchResult_ofMeditation(
                musicTrack: musicTrack,
                duration: duration,
                enableSound: enableSound
            )
            
            self.meditation = [result]
            print("super")
        }catch{
            print("meditationType \(meditation.count)")
            print("meditationType \(meditation.description)")
            print("dommage")
            throw ThrowableError.someError
        }
    }
    
    func toggleStart(for item: Meditation) {
       

        print("vous venez de terminer un exercice d'anxiété")
    }
}
