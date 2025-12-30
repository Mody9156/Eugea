//
//  MedidationView.swift
//  Eugea
//
//  Created by Modibo on 26/12/2025.
//

import SwiftUI

struct MedidationView: View {

    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Méditation")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                        
                        Text("Trouvez votre calme intérieur")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    // MARK: - Featured Session
                    FeaturedMeditationCard()
                    
                    // MARK: - Categories
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Catégories")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        LazyVGrid(
                            columns: [.init(.flexible()), .init(.flexible())],
                            spacing: 12
                        ) {
                            CategoryCard(
                                icon: "wind",
                                title: "Respiration",
                                sessions: "12 séances",
                                colors: [.cyan, .blue],
                                type: "respiration"
                            )
                            CategoryCard(
                                icon: "heart.fill",
                                title: "Anti-stress",
                                sessions: "18 séances",
                                colors: [.pink, .red],
                                type: "stress"
                            )
                            CategoryCard(
                                icon: "moon.fill",
                                title: "Sommeil",
                                sessions: "15 séances",
                                colors: [.indigo, .purple],
                                type: "sleep"
                            )
                            CategoryCard(
                                icon: "face.smiling",
                                title: "Bonheur",
                                sessions: "10 séances",
                                colors: [.yellow, .orange],
                                type: "happiness"
                            )
                        }
                    }
                    
                    // MARK: - Popular Sessions
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Séances populaires")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        SessionRow(
                            title: "Respiration 4-7-8",
                            duration: "5 min",
                            difficulty: "Débutant",
                            icon: "wind",
                            color: .cyan
                        )
                        
                        SessionRow(
                            title: "Scan corporel",
                            duration: "15 min",
                            difficulty: "Intermédiaire",
                            icon: "sparkles",
                            color: .purple
                        )
                        
                        SessionRow(
                            title: "Méditation du sommeil",
                            duration: "20 min",
                            difficulty: "Tous niveaux",
                            icon: "moon.fill",
                            color: .indigo
                        )
                        
                        SessionRow(
                            title: "Gratitude quotidienne",
                            duration: "8 min",
                            difficulty: "Débutant",
                            icon: "heart.fill",
                            color: .pink
                        )
                    }
                }
                .padding()
            }
        }
    }
}


struct FeaturedMeditationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            Label("Recommandé pour vous", systemImage: "sparkles")
                .font(.footnote)
                .opacity(0.9)

            Text("Calme et sérénité")
                .font(.title2)
                .fontWeight(.medium)

            Text("Une méditation guidée de 10 minutes adaptée à votre niveau de stress actuel")
                .font(.subheadline)
                .opacity(0.9)

            HStack(spacing: 12) {
                Label("10 min", systemImage: "clock")
                Text("•")
                Text("Niveau débutant")
            }
            .font(.footnote)

            Button {
                // start session
            } label: {
                Label("Commencer la séance", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .foregroundColor(.purple)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(radius: 8)
    }
}

enum MeditationTypeKind: String {
    case respiration
    case sleep
    case happiness
    case stress
}

struct CategoryCard: View {
    let icon: String
    let title: String
    let sessions: String
    let colors: [Color]
    let type: String
    
    @ViewBuilder
    var destination : some View {
        switch type {
        case "respiration":
            SleepView()

        case "sleep":
            SleepView()

        case "happiness":
            SleepView()

        case "stress":
            SleepView() // ✅ Binding obligatoire

        default:
            EmptyView()
        }
    }
  
    
    @ViewBuilder
    func destination(for type: MeditationTypeKind) -> some View {
        switch type {
        case .respiration, .sleep:
            SleepView()

        case .happiness:
            SleepView()

        case .stress:
            SleepView()
        }
    }
    var body: some View {
        NavigationLink {
            destination(
                for: MeditationTypeKind(
                    rawValue: (MeditationTypeKind(rawValue: type)?.rawValue)!
                ) ?? .respiration
            )
            
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(sessions)
                    .font(.caption)
                    .opacity(0.9)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

struct SessionRow: View {
    let title: String
    let duration: String
    let difficulty: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(color)

                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack(spacing: 6) {
                    Text(duration)
                    Text("•")
                    Text(difficulty)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "play.fill")
                .foregroundStyle(.secondary)
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(Circle())
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.systemGray5))
        )
    }
}


#Preview {
    MedidationView()
}
