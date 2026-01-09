//
//  antiAnxietyView.swift
//  Eugea
//
//  Created by Modibo on 28/12/2025.
//

import SwiftUI

struct antiAnxietyView: View {
    var antiAnxietyViewModel : AntiAnxietyViewModel
    var meditationType : [MeditationType] = []
    var body: some View {
        VStack {
            ForEach(
                meditationType
            ) { type in
                Text(type.type)
                    .foregroundStyle(.blue)
            }

        }
        .task {
            try? await antiAnxietyViewModel.showExercise()
        }
    }
}

#Preview {
    antiAnxietyView(antiAnxietyViewModel: AntiAnxietyViewModel())
}
