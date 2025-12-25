//
//  stressData.swift
//  Eugea
//
//  Created by Modibo on 25/12/2025.
//

import Foundation
import SwiftData

@Model
class StressData {
    var activityName : String
    var stressLevel : Int
    
    init(activityName: String, stressLevel: Int) {
        self.activityName = activityName
        self.stressLevel = stressLevel
    }
}
