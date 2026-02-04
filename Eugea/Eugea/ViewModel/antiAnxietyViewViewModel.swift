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
    
    func showExercise(backgroundMusic: String,
                      duration: Int,
                      enableSound: Bool) async throws {
        
        do{
            let result = try await meditationConfiguration.fetchResult_ofMeditation(
                backgroundMusic: backgroundMusic,
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
    
    func toggleStart(for meditation: Meditation) {
        guard let id = meditation.id else { return }
        if let index = self.meditation.firstIndex(where: { $0.id == id }) {
            self.meditation[index].data.state.isRunning.toggle()
            print("toggle :\(self.meditation[index].data.state.isRunning.toggle())")
            print("index :\(index)")
        }
        print("start toggleStart")
    }
}
