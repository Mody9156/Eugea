//
//  ManageMeditation.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

class ManageMeditation: MeditationProtocol {
    
    let session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum ThorwsErrors:Error {
        case badServerResponse
    }
    
    func fetchRequest(url: URLRequest) async throws -> (Data, URLResponse) {
        let (data,response) = try await session.data(for: url)
        
        guard let http_url_response = response as? HTTPURLResponse , http_url_response.statusCode == 200 else {
            throw ThorwsErrors.badServerResponse
        }
        return (data,response)
    }
}
