//
//  ApiMeditation.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

protocol Meditation {
    func fetchRequest(url:URLRequest) async throws -> (Data, URLResponse)
}
