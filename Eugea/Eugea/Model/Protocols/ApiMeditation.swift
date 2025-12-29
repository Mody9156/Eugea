//
//  ApiMeditation.swift
//  Eugea
//
//  Created by Modibo on 29/12/2025.
//

import Foundation

protocol Medidation {
    func fetchRequest(url:URLRequest) -> (Data, URLResponse)
}
