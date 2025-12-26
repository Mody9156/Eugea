//
//  HomeView.swift
//  Eugea
//
//  Created by Modibo on 19/12/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    // MARK: - State & Storage
    @State private var name: String = "Joe"
    @State private var speed = 0.0

    @AppStorage("symbole") private var registeredEmoji: String?

    @Query(sort: \StressData.activityName, order: .forward)
    private var stressData: [StressData]

    private let emojis = ["😢", "😕", "😐", "🙂", "😊"]

    // MARK: - View
    var body: some View {
        let stressLevel = StressLevel.from(value: Int(speed))

        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Bonjour, \(name)")
                            .font(.largeTitle)
                            .fontWeight(.medium)

                        Text("Comment vous sentez-vous aujourd'hui ?")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    // MARK: - Check-in Card
                    VStack(spacing: 16) {

                        HStack {
                            Image(systemName: "heart")
                            Text("Check-in quotidien")
                                .font(.system(size: 14, weight: .medium))
                            Spacer()
                        }

                        Text("Comment allez-vous ?")
                            .font(.system(size: 20, weight: .medium))

                        // MARK: Emoji section
                        if let emoji = registeredEmoji {
                            // Emoji sauvegardé
                            Button {
                                registeredEmoji = nil
                            } label: {
                                Text(emoji)
                                    .font(.system(size: 80))
                                    .frame(width: 120, height: 120)
                                    .glassEffect()
                                    .accessibilityLabel("Supprimer l’humeur \(emoji)")
                            }
                        } else {
                            // Sélection des emojis
                            HStack(spacing: 12) {
                                ForEach(emojis, id: \.self) { emoji in
                                    Button {
                                        registeredEmoji = emoji
                                    } label: {
                                        Text(emoji)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            .glassEffect()
                                            .accessibilityLabel("Sélectionner l’humeur \(emoji)")
                                    }
                                }
                            }
                        }

                        // Action text
                        if registeredEmoji != nil {
                            Text("Touchez l’emoji pour le supprimer")
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.8))
                        }
                    }
                    .padding(24)
                    .background(
                        LinearGradient(
                            colors: [.orange, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                    // MARK: - Stats
                    LazyVGrid(
                        columns: [.init(.flexible()), .init(.flexible())],
                        spacing: 16
                    ) {

                        if let lastData = stressData.last {
                            StatCard(
                                icon: stressLevel.symbole,
                                label: "Niveau de stress",
                                value: "\(lastData.stressLevel)/10",
                                subtext: lastData.activityName,
                                color: stressLevel.color,
                                speed: $speed
                            )
                        } else {
                            NavigationLink {
                                StressView(speed: $speed)
                            } label: {
                                StatCard(
                                    icon: "exclamationmark.triangle",
                                    label: "Niveau de stress",
                                    value: "-- /10",
                                    subtext: "Configurer le stress",
                                    color: .gray,
                                    speed: $speed
                                )
                            }
                            .buttonStyle(.plain)
                        }

                        StatCard(
                            icon: "moon.fill",
                            label: "Sommeil",
                            value: "7h 24m",
                            subtext: "Bonne nuit",
                            color: .blue,
                            speed: $speed
                        )
                    }

                    // MARK: - Recommendation
                    Text("Recommandation du jour")
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.purple)
                                .frame(width: 40, height: 40)

                            Image(systemName: "sparkles")
                                .foregroundStyle(.white)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Méditation anti-stress")
                                .font(.headline)

                            Text("Basée sur votre niveau de stress actuel, nous recommandons une séance de 10 minutes.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            NavigationLink {
                                SleepView()
                            } label: {
                                Label("Commencer", systemImage: "chevron.right")
                                    .font(.subheadline)
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color(red: 238/255, green: 242/255, blue: 255/255),
                                Color(red: 250/255, green: 245/255, blue: 255/255)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(radius: 2)

                    // MARK: - Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Actions rapides")
                            .font(.title3)
                            .fontWeight(.medium)

                        CustomNavigationLink(
                            icon: "heart.fill",
                            name: "Journal quotidien",
                            description: "Notez vos pensées"
                        )

                        CustomNavigationLink(
                            icon: "sparkles",
                            name: "Exercice de respiration",
                            description: "5 minutes"
                        )
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    HomeView()
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        self.init(
            red: Double((int >> 16) & 0xFF) / 255,
            green: Double((int >> 8) & 0xFF) / 255,
            blue: Double(int & 0xFF) / 255
        )
    }
}
struct CustomNavigationLink: View {
    let icon: String
    let name: String
    let description: String
    
    var body: some View {
        NavigationLink {
            Text(name)
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#F3E8FF"))
                    
                    Image(systemName: icon)
                        .foregroundStyle(Color(hex: "#9333EA"))
                }
                .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(name)
                        .foregroundStyle(Color(hex: "#030213"))
                        .font(.system(size: 16, weight: .medium))
                    
                    Text(description)
                        .foregroundStyle(Color(hex: "#717182"))
                        .font(.system(size: 14))
                }
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(hex: "#E5E7EB"), lineWidth: 1)
            )
            .cornerRadius(16)
        }
    }
}




struct StatCard: View {
    let icon: String
    let label: String
    let value: String
    let subtext: String
    let color: Color
    @Binding var speed: Double
    var body: some View {
        NavigationLink {
            StressView(speed: $speed)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(color)
                    
                    Spacer()
                }
                
                Text(label)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(color)
                
                Text(subtext)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
}

