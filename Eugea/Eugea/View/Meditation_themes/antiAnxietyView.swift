//
//  antiAnxietyView.swift
//  Eugea
//
//  Created by Modibo on 28/12/2025.
//

import SwiftUI

struct antiAnxietyView: View {
   var antiAnxietyViewModel : AntiAnxietyViewModel
    @State var backgroundMusic: String = "meditation-background-409198.mp3"
    @State var duration: Int = 15
    @State var meditationType: String = "loving-kindness"
    
    var body: some View {
        VStack {
            ForEach(antiAnxietyViewModel.meditationType) { meditation in
                Text(meditation.data.scripts)
                    .foregroundStyle(.red)
            }
        }
        .task {
             try? await antiAnxietyViewModel
                .showExercise()
        }
    }
}

#Preview {
    antiAnxietyView(antiAnxietyViewModel: AntiAnxietyViewModel())
}
