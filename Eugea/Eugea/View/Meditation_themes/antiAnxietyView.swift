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
        ZStack {
            // 🌈 Background doux
            LinearGradient(
                colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

          
            
            ScrollView {
                VStack(spacing: 24) {

                    // 🧘‍♀️ Titre
                    VStack(spacing: 8) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 40))
                            .foregroundStyle(.white)

                        Text("Anti-Anxiété")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)

                        Text("Prenez un moment pour respirer")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding(.top, 40)

                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 100)
                        .foregroundStyle(.primary.opacity(0.4))
                        .overlay {
                           //Write 
                        }
                    
                    // 📦 Cartes de méditation
                    ForEach(antiAnxietyViewModel.meditation) { meditation in
                        VStack(alignment: .leading, spacing: 16) {

                            Text(meditation.data.state.content.name)
                                .font(.title2.bold())

                            Text(meditation.data.state.content.description)
                                .font(.body)
                                .foregroundStyle(.secondary)

                            Divider()

                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(meditation.data.state.content.steps, id: \.self) { step in
                                    HStack(alignment: .top) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.purple)
                                        Text(step)
                                            .font(.callout)
                                    }
                                }
                            }

                            Divider()

                            HStack {
                                Label(
                                    "\(meditation.data.state.duration) min",
                                    systemImage: "clock"
                                )

                                Spacer()

                                Label(
                                    meditation.data.state.meditationType,
                                    systemImage: "heart.fill"
                                )
                                .foregroundStyle(.purple)
                            }
                            .font(.caption.bold())
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(radius: 8)
                    }

                    // ▶️ Bouton jouer
                    Button {
                        // Action play
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Commencer la méditation")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(radius: 10)
                    .padding(.vertical, 30)
                }
                .padding(.horizontal)
            }
        }
        .task {
            try? await antiAnxietyViewModel.showExercise(
                backgroundMusic: backgroundMusic,
                duration: duration,
                meditationType: meditationType
            )
        }
    }

}






#Preview {
    antiAnxietyView(antiAnxietyViewModel: AntiAnxietyViewModel())
}
