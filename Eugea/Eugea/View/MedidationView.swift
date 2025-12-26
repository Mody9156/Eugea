//
//  MedidationView.swift
//  Eugea
//
//  Created by Modibo on 26/12/2025.
//

import SwiftUI

struct MedidationView: View {

    var body: some View {
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
                        CategoryCard(icon: "wind", title: "Respiration", sessions: "12 séances", colors: [.cyan, .blue])
                        CategoryCard(icon: "heart.fill", title: "Anti-stress", sessions: "18 séances", colors: [.pink, .red])
                        CategoryCard(icon: "moon.fill", title: "Sommeil", sessions: "15 séances", colors: [.indigo, .purple])
                        CategoryCard(icon: "face.smiling", title: "Bonheur", sessions: "10 séances", colors: [.yellow, .orange])
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

struct CategoryCard: View {
    let icon: String
    let title: String
    let sessions: String
    let colors: [Color]

    var body: some View {
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
