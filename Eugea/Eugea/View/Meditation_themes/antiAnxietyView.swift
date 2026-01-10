//
//  antiAnxietyView.swift
//  Eugea
//
//  Created by Modibo on 28/12/2025.
//

import SwiftUI

struct antiAnxietyView: View {
    var antiAnxietyViewModel : AntiAnxietyViewModel
    var body: some View {
        VStack {
           

        }
        .task {
            try? await antiAnxietyViewModel.showExercise()
        }
    }
}

#Preview {
    antiAnxietyView(antiAnxietyViewModel: AntiAnxietyViewModel())
}
