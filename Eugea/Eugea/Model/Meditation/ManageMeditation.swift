//
//  ManageMeditation.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

class ManageMeditation: Medidation {
    
    let session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum ThorwsErrors:Error {
        case badServerResponse
    }
    
    func fetchRequest(url: URLRequest) async throws -> (Data, URLResponse) {
        let (data,response) = try await  session.data(for: url)
        
        guard let URLResponse = response as? HTTPURLResponse , URLResponse.statusCode == 200 else {
            throw ThorwsErrors.badServerResponse
        }
        return (data,response)
    }
}
