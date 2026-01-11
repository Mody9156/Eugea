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
    
    enum ThrowsError:Error {
        case badServerResponse,badRequest
        
    }
    
    func fetchUrlRequest() throws  -> URLRequest {
        let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let meditation = MeditationSession(
            backgroundMusic: "meditation-background-409198.mp3",
            duration: 15,
            meditationType: "loving-kindness"
        )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let result = try JSONEncoder().encode(meditation)
        request.httpBody = result
        if let json = String(data: result, encoding: .utf8) {
            print("📤 Body JSON:\n\(json)")
        }
        print("request.httpBody:\(String(describing: request.httpBody))")
        return request
    }
    
    func fetchResult_ofMeditation() async throws -> MeditationType {
        let (data,reponse) = try await session.fetchRequest(
            url: fetchUrlRequest()
        )
        
        guard let http_url_response = reponse as? HTTPURLResponse,  http_url_response.statusCode == 200 else {
            print("mauvaise réponse ")
            throw ThrowsError.badServerResponse
        }
        let decode = JSONDecoder()
        
        
        do {
            let meditation = try decode.decode(MeditationType.self, from: data)
            return meditation
        } catch {
            print("❌ Decoding error:", error)
            throw ThrowsError.badRequest
        }
    }
}
