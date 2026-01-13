//
//  MeditationConfiguration.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

class MeditationConfiguration {
    let session : Medidation
    
    init(session: Medidation = ManageMeditation()) {
        self.session = session
    }
    
    enum MeditationError: Error {
        case badServerResponse
        case badRequest
        case badUrl
    }
    
    func fetchUrlRequest() throws  -> URLRequest {
        guard let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation") else {
            throw MeditationError.badUrl
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
        let (data,reponse) = try await session.fetchRequest(
            url: fetchUrlRequest()
        )
        
        guard let http_url_response = reponse as? HTTPURLResponse,  http_url_response.statusCode == 200 else {
            print("mauvaise réponse ")
            throw MeditationError.badServerResponse
        }
        
        do {
            let decode = JSONDecoder()
            let  meditation = try decode.decode(MeditationType.self, from: data)
            return meditation
        } catch {
            print("❌ Decoding error:", error)
            throw MeditationError.badRequest
        }
    }
}
