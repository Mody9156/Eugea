//
//  StressView.swift
//  Eugea
//
//  Created by Modibo on 25/12/2025.
//

import SwiftUI

struct StressView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    @State var stressLevel: Int = 0
    @State var activityName : String = ""
    
    var body: some View {
        VStack{
            Slider(value: $speed, in: 0...10) { editing in
                isEditing = editing
            }
            Text("\(Double(speed))")
        }
    }
}

#Preview {
    StressView()
}
