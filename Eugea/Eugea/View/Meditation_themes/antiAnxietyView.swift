//
//  antiAnxietyView.swift
//  Eugea
//
//  Created by Modibo on 28/12/2025.
//

import SwiftUI

enum MinuteurDeMédibtation: String, CaseIterable, Identifiable {
    case meditationackground = "Meditation-background-409198"
    case meditationMusic1 = "Meditation Music 1"
    case meditationMusic2 = "Meditation Music 2"
    case meditationMusic3 = "Meditation Music 3"
    case meditationMusic4 = "Meditation Music 4"
    case Yogameditation = "Yoga Meditation"
    case RelaxingYogaMusic = "Relaxing Yoga Music"
    case DeepRelaxation = "Deep Relaxation"

    var id: String { rawValue }
}

struct antiAnxietyView: View {

    var antiAnxietyViewModel: AntiAnxietyViewModel

    // MARK: - Local State
    @State private var backgroundMusic: String = "Meditation-background-409198"
    @State private var duration: Int = 15
    @State private var meditationType: Bool = true

    @State private var isRunning: Bool = false
    @State private var isPaused: Bool = false
    @State private var remainingTime: Int = 0

    @State private var selectedSound: MinuteurDeMédibtation = .meditationackground

    var musicPlayerManager = MusicPlayerManager()

    var body: some View {
        ZStack {
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
                        VStack(alignment: .leading, spacing: 16) {

                            // MARK: - Music Picker
                            Text("Sélectionne un son de musique pour commencer")
                                .font(.headline)

                            Picker("Selectionne", selection: $selectedSound) {
                                ForEach(MinuteurDeMédibtation.allCases) { sound in
                                    Text(sound.rawValue).tag(sound)
                                }
                            }
                            .pickerStyle(.menu)

                            // MARK: - Actions titles
                            ForEach(meditation.data.actions, id: \.self) { action in
                                Text(action.label)
                                    .font(.title2.bold())

                                Text(action.type)
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                            }

                            Divider()

                            // MARK: - Steps (from components text)
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(
                                    meditation.data.components.filter { $0.type == "text" },
                                    id: \.id
                                ) { component in
                                    HStack(alignment: .top) {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.purple)

                                        Text(component.config.text ?? "")
                                            .font(.callout)
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

                                    Text("\(remainingTime) sec")
                                        .font(.headline.bold())
                                }

                                Spacer()

                                Label(
                                    "\(meditation.data.state.duration) min",
                                    systemImage: "clock"
                                )
                            }
                            .onAppear {
                                remainingTime = meditation.data.state.remainingTime
                                isRunning = meditation.data.state.isRunning
                                isPaused = meditation.data.state.isPaused
                                backgroundMusic = meditation.data.state.musicTrack
                            }

                            // MARK: - Meditation type & category
                            HStack {
                                Label(
                                    meditation.data.state.enableSound ? "Guidée" : "Silencieuse",
                                    systemImage: "heart.fill"
                                )
                                .foregroundStyle(.purple)

                                Spacer()

                                Text("🌍 \(meditation.data.metadata.category.uppercased())")
                                    .font(.caption)
                            }

                            // MARK: - Background music
                            Label(
                                meditation.data.state.musicTrack,
                                systemImage: "music.note"
                            )
                            .font(.caption)
                            .foregroundStyle(.secondary)

                            Divider()

                            // MARK: - Dynamic Actions
                            HStack {
                                ForEach(meditation.data.actions, id: \.id) { action in
                                    Button {
                                        handleAction(action.type, meditation: meditation)
                                       
                                            musicPlayerManager.playSong(
                                                song: selectedSound.rawValue
                                            )
//                                        antiAnxietyViewModel.toggleStart(for: meditation)

                                        
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
                .padding(.horizontal)
            }
        }
        .task {
            try? await antiAnxietyViewModel.showExercise(
                musicTrack: backgroundMusic,
                duration: duration,
                enableSound: meditationType
            )
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

#Preview {
    antiAnxietyView(
        antiAnxietyViewModel: AntiAnxietyViewModel()
    )
}
