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
    
    enum ThorwsErrors:Error {
        case badServerResponse,badRequest
        
    }
    
    func fetchUrlRequest(backgroundMusic: String,
                         duration: Int,
                         meditationType: String) throws  -> URLRequest {
        let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let meditation = MeditationSession(
            backgroundMusic: backgroundMusic,
            duration: duration,
            meditationType: meditationType
        )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let result = try JSONEncoder().encode(meditation)
        request.httpBody = result
        return request
    }
    
    func fetchResult_ofMeditation(backgroundMusic: String,
                                  duration: Int,
                                  meditationType: String) async throws -> MeditationType {
        let (data,reponse) = try await session.fetchRequest(
            url: fetchUrlRequest(
                backgroundMusic: backgroundMusic,
                duration: duration,
                meditationType: meditationType
            )
        )
        
        guard let http_url_response = reponse as? HTTPURLResponse,  http_url_response.statusCode == 200 else {
            print("mauvaise réponse ")
            throw ThorwsErrors.badServerResponse
        }
        print(" réponse: \(http_url_response) ")
        let decode = JSONDecoder()
        
        guard let data_meditation = try? decode.decode(MeditationType.self, from: data) else {
            throw ThorwsErrors.badRequest
        }
        print(" decodage: \(data_meditation) ")
        return data_meditation
    }
}
