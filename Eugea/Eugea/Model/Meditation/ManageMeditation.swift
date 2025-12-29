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
    
    
    
    func fetchRequest(url: URLRequest) -> (Data, URLResponse) {
        <#code#>
    }

    
}
