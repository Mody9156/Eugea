//
//  antiAnxietyView.swift
//  Eugea
//
//  Created by Modibo on 28/12/2025.
//

import SwiftUI



// MARK: - Vue principale
struct antiAnxietyView: View {
    
    var antiAnxietyViewModel: AntiAnxietyViewModel
    
    // MARK: - Local State
    @State private var backgroundMusic: String = "meditation-background-409198.mp3"
    @State private var duration: Int = 15
    @State private var meditationType: String = "Méditation de Bienveillance"
    
    @State private var isRunning: Bool = false
    @State private var isPaused: Bool = false
    @State private var remainingTime: Int = 0
    
    @State private var selectedSound: MinuteurDeMeditation = .meditationBackground
    
    var musicPlayerManager = MusicPlayerManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background Gradient
                LinearGradient(
                    colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // MARK: - Header
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
                        
                        // MARK: - Meditations
                        ForEach(antiAnxietyViewModel.meditation) { meditation in
                            AntiAnxietyMeditationCard(
                                meditation: meditation,
                                selectedSound: $selectedSound,
                                remainingTime: remainingTime,
                                isRunning: isRunning,
                                isPaused: isPaused,
                                backgroundMusic: backgroundMusic,
                                musicPlayerManager: musicPlayerManager,
                                antiAnxietyViewModel: antiAnxietyViewModel,
                                handleAction: handleAction
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.pink)
                    }
                }
                
                
            }
            .task {
                try? await antiAnxietyViewModel.showExercise(
                    type: "loving-kindness",
                    duration: 15,
                    backgroundMusic: "meditation-background-409198.mp3"
                )
            }
        }
    }
    
    // MARK: - Action Handler
    private func handleAction(_ type: String, meditation: Meditation) {
        switch type {
        case "play":
            isRunning = true
            isPaused = false
            remainingTime = meditation.data.state.duration * 60
            
        case "pause":
            isPaused = true
            
        case "stop":
            isRunning = false
            isPaused = false
            remainingTime = meditation.data.state.duration * 60
            
        default:
            break
        }
    }
}

// MARK: - Carte pour chaque méditation
private struct AntiAnxietyMeditationCard: View {
    let meditation: Meditation
    @Binding var selectedSound: MinuteurDeMeditation
    let remainingTime: Int
    let isRunning: Bool
    let isPaused: Bool
    let backgroundMusic: String
    let musicPlayerManager: MusicPlayerManager
    let antiAnxietyViewModel: AntiAnxietyViewModel
    let handleAction: (String, Meditation) -> Void
    
    @State private var localRemainingTime: Int = 0
    @State private var localIsRunning: Bool = false
    @State private var localIsPaused: Bool = false
    @State private var localBackgroundMusic: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
//            // MARK: - Music Picker
//            Text("Sélectionne un son de musique pour commencer")
//                .font(.headline)
//            
//            Picker("Sélectionne", selection: $selectedSound) {
//                ForEach(MinuteurDeMeditation.allCases) { sound in
//                    Text(sound.rawValue).tag(sound)
//                }
//            }
//            .pickerStyle(.menu)
            
            
            // Title
            Text(meditation.data.state.content.name)
                .font(.title2.bold())
            
            // Description
            Text(meditation.data.state.content.description)
                .font(.body)
                .foregroundStyle(.secondary)
            
            Divider()
            
            // MARK: - Steps (from components text)
            VStack(alignment: .leading, spacing: 10) {
                
                ForEach(meditation.data.state.content.steps, id: \.self) { step in
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.purple)
                        Text(step)
                    }
                    
                }
                
            }
            
            Divider()
            
            // MARK: - Dynamic Components
            ForEach(meditation.data.components, id: \.id) { component in
                switch component.type {
                    
                case "timer":
                    VStack(alignment: .leading) {
                        Text("Progression")
                            .font(.caption)
                        
                        ProgressView(
                            value: Double(component.config.currentTime ?? 0),
                            total: Double(component.config.totalTime ?? 1)
                        )
                    }
                    
                case "phases":
                    if let phases = component.config.phases {
                        VStack(alignment: .leading) {
                            Text("Phases")
                                .font(.caption.bold())
                            
                            ForEach(phases, id: \.self) { phase in
                                Text("• \(phase)")
                                    .font(.caption)
                            }
                        }
                    }
                    
                default:
                    EmptyView()
                }
            }
            
            Divider()
            
            // MARK: - Timer State
            HStack {
                VStack(alignment: .leading) {
                    Text("Temps restant")
                        .font(.caption)
                    
                    Text("\(localRemainingTime) sec")
                        .font(.headline.bold())
                }
                
                Spacer()
                
                Label(
                    "\(meditation.data.state.duration) min",
                    systemImage: "clock"
                )
            }
            .onAppear {
                localRemainingTime = meditation.data.state.remainingTime
                localIsRunning = meditation.data.state.isRunning
                localIsPaused = meditation.data.state.isPaused
                localBackgroundMusic = meditation.data.state.backgroundMusic
            }
            
            HStack {
                
                Spacer()
                
                Text("🌍 \(meditation.data.metadata.category.uppercased())")
                    .font(.caption)
            }
            
            // MARK: - Background music
            Label(
                meditation.data.state.backgroundMusic,
                systemImage: "music.note"
            )
            .font(.caption)
            .foregroundStyle(.secondary)
            
            Divider()
            
            // MARK: - Dynamic Actions
            HStack {
                ForEach(meditation.data.actions, id: \.id) { action in
                    Button {
                        handleAction(action.type, meditation)
                        
                        antiAnxietyViewModel.toggleStart(for: meditation)
                        
                        musicPlayerManager.playSong(
                            song: selectedSound.rawValue
                        )
                    } label: {
                        Label(action.label, systemImage: action.icon)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            
            Divider()
            
            // MARK: - Metadata
            VStack(alignment: .leading, spacing: 6) {
                Text("Fonctionnalités")
                    .font(.caption.bold())
                
                ForEach(meditation.data.metadata.features, id: \.self) {
                    Text("• \($0)")
                        .font(.caption)
                }
                
                Text("Accessibilité")
                    .font(.caption.bold())
                    .padding(.top, 4)
                
                ForEach(meditation.data.metadata.accessibility, id: \.self) {
                    Text("• \($0)")
                        .font(.caption)
                }
            }
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
}

// MARK: - Preview
#Preview {
    antiAnxietyView(
        antiAnxietyViewModel: AntiAnxietyViewModel()
    )
}
