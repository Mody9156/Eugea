//
//  MeditationConfiguration.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation


class MeditationConfiguration {
    let session: Meditation
    
    init(session: Meditation = ManageMeditation()) {
        self.session = session
    }
    
    enum MeditationError: Error {
        case badServerResponse
        case badRequest
    }
    
    func fetchUrlRequest() throws -> URLRequest {
        guard let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation") else {
            fatalError("URL invalide")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let meditation = MeditationSession(
            backgroundMusic: "meditation-background-409198.mp3",
            duration: 15,
            meditationType: "loving-kindness"
        )
        
        let data = try JSONEncoder().encode(meditation)
        request.httpBody = data
        
        if let json = String(data: data, encoding: .utf8) {
            print("📤 Body JSON:\n\(json)")
        }
        
        return request
    }
    
    func fetchResult_ofMeditation() async throws -> MeditationType {
        let (data, response) = try await session.fetchRequest(url: fetchUrlRequest())
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("❌ Mauvaise réponse du serveur")
            throw MeditationError.badServerResponse
        }
        
        do {
            let meditation = try JSONDecoder().decode(MeditationType.self, from: data)
            return meditation
        } catch {
            print("❌ Erreur de décodage:", error)
            if let json = String(data: data, encoding: .utf8) {
                print("📥 Contenu reçu:\n\(json)")
            }
            throw MeditationError.badRequest
        }
    }
}
