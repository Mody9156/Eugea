//
//  HomeView.swift
//  Eugea
//
//  Created by Modibo on 19/12/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // MARK: - State
    @State private var name: String = "Joe"
    @State private var selectedEmoji: String? = nil
    @State private var isEmojiRegistered: Bool = false
    @State private var isNavigationActive: Bool = false
    @Query(sort:\StressData.activityName,order:.forward) var stressData: [StressData]
    private let emojis = ["😢", "😕", "😐", "🙂", "😊"]
    @State private var speed = 0.0
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
                    VStack(alignment: isEmojiRegistered ? .center : .leading, spacing: 16) {
                        
                        HStack {
                            Image(systemName: "heart")
                            Text("Check-in quotidien")
                                .font(.system(size: 14, weight: .medium))
                            Spacer()
                        }
                        .opacity(0.9)
                        
                        Text("Comment allez-vous ?")
                                .font(.system(size: 20, weight: .medium))
                       
                        // Emoji selection
                        if let emoji = selectedEmoji {
                            Button {
                                if !isEmojiRegistered {
                                    selectedEmoji = nil
                                }
                            } label: {
                                Text(emoji)
                                    .font(.system(size: isEmojiRegistered ? 80 : 32))
                                    .frame(
                                        width: isEmojiRegistered ? 120 : 56,
                                        height: isEmojiRegistered ? 120 : 56
                                    )
                                    .glassEffect()
                                    .accessibilityLabel("Humeur sélectionnée \(emoji)")
                            }
                        } else {
                            HStack(spacing: 12) {
                                ForEach(emojis, id: \.self) { emoji in
                                    Button {
                                        selectedEmoji = emoji
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
                        
                        // Action Button
                        Button {
                            if selectedEmoji != nil {
                                isEmojiRegistered.toggle()
                            }
                        } label: {
                            Text(isEmojiRegistered
                                 ? "Supprimer l’humeur"
                                 : "Enregistrer mon humeur")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.orange)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white)
                            .clipShape(Capsule())
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
                                    subtext:lastData.activityName,
                                    color: stressLevel.color
                                )
                            }
                          
                                               
                        StatCard(
                            icon: "moon.fill",
                            label: "Sommeil",
                            value: "7h 24m",
                            subtext: "Bonne nuit",
                            color: .blue
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
                                Label {
                                    Image(systemName: "chevron.right")
                                        .font(.subheadline)
                                        .foregroundColor(.purple)
                                } icon: {
                                    Text("Commencer")
                                        .font(.subheadline)
                                        .foregroundColor(.purple)
                                }
                                
                                
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
    
    var body: some View {
        NavigationLink {
            StressView()
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
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(subtext)
                    .font(.footnote)
                    .foregroundStyle(color)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }
}

