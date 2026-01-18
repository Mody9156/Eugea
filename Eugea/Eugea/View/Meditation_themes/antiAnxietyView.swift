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
            
            ForEach(antiAnxietyViewModel.meditation) { meditation in
                Text(meditation.data.state.content.description)
                Text(meditation.data.state.content.name)
                
                if let steps = meditation.data.state.content.steps as? [String] {
                    ForEach(steps, id: \.self) { step in
                        Text(step)
                            .foregroundStyle(.green)
                    }
                }

                Text("\(meditation.data.state.duration)")
                Text(meditation.data.state.meditationType)
                    .foregroundStyle(.red)
                
            }
            
            Button {
                
            } label: {
                Text("Jouer")
            }
            .padding()
            .background(Color.purple)
            .foregroundStyle(.white)
            .font(.callout.bold())
        }
        .task {
            try? await antiAnxietyViewModel
                .showExercise(backgroundMusic: backgroundMusic, duration: duration, meditationType: meditationType)
        }
        
    }
}






#Preview {
    antiAnxietyView(antiAnxietyViewModel: AntiAnxietyViewModel())
}
