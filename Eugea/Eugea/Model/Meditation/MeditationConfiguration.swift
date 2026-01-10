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
    
    func fetchUrlRequest() -> URLRequest {
        let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var meditation = MeditationSession(
            backgroundMusic: "",
            duration: 0,
            meditationType: ""
        )
        let result = try? JSONEncoder().encode(meditation)
        request.httpBody = result
        return request
    }
    
    func fetchResult_ofMeditation(backgroundMusic: String,
                                  duration: Int,
                                  meditationType: String) async throws -> MeditationType {
        let (data,reponse) = try await session.fetchRequest(url: fetchUrlRequest())
        
        guard let http_url_response = reponse as? HTTPURLResponse,  http_url_response.statusCode == 200 else {
            throw ThorwsErrors.badServerResponse
        }
        let decode = JSONDecoder()
        
        guard let data_meditation = try? decode.decode(MeditationType.self, from: data) else {
            throw ThorwsErrors.badRequest
        }
        return data_meditation
    }
}
