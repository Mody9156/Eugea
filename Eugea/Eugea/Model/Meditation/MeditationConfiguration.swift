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
        case badServerResponse
    }
    
    func fetchUrlRequest() -> URLRequest {
        let url = URL(string: "https://elysiatools.com/fr/api/tools/guided-meditation")!
        let request = URLRequest(url: url)
        return request
    }
    
    func fetchResult_ofMeditation() async throws -> MeditationType {
        let (data,reponse) = try await session.fetchRequest(url: fetchUrlRequest())
        
        guard let http_url_response = reponse as? HTTPURLResponse,  http_url_response.statusCode == 200 else {
            throw ThorwsErrors.badServerResponse
        }
        let decode = JSONDecoder()
        
        let data_meditation:MeditationType = try decode.decode(MeditationType.self, from: data)
        return data_meditation
    }
}
