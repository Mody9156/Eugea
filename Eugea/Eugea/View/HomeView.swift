//
//  ContentView.swift
//  Eugea
//
//  Created by Modibo on 19/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State var name : String = "Joe"
    let emojis = ["😢", "😕", "😐", "🙂", "😊"]
    @State private var selectedEmojis : Bool = false
    @State private var saveEmojis : String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Bonjour, \(name)")
                        .fontWeight(.medium)
                        .font(.largeTitle)
                    
                    Text("Comment vous sentez-vous aujourd'hui ?")
                        .fontWeight(.regular)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 8) {
                            Image(systemName: "heart")
                                .font(.system(size: 18))
                            Text("Check-in quotidien")
                                .font(.system(size: 14, weight: .medium))
                                .opacity(0.9)
                        }
                        
                        Text("Comment allez-vous ?")
                            .font(.system(size: 20, weight: .medium))
                            .lineSpacing(6)
                        
                        if selectedEmojis {
                            
                            VStack {
                                Button {
                                    selectedEmojis.toggle()
                                    saveEmojis = ""
                                } label: {
                                    Text(saveEmojis)
                                        .font(.system(size: 30))
                                        .frame(width: 50, height: 50)   // vrai gros bouton
                                        .multilineTextAlignment(.center)
                                        .glassEffect()
                                }
                            }
                            
                        }else {
                            HStack(spacing: 12) {
                                ForEach(emojis, id: \.self) { emoji in
                                    Button {
                                        selectedEmojis.toggle()
                                        saveEmojis = emoji
                                    } label: {
                                        Text(emoji)
                                            .font(.system(size: 30))
                                            .frame(width: 50, height: 50)
                                            .glassEffect()
                                    }
                                }
                            }
                        }
                        
                        Button {
                            //action
                        } label: {
                            Text("Enregistrer mon humeur")
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
                            colors: [
                                Color.orange,
                                Color.yellow
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.bottom)
                    
                    LazyVGrid(
                        columns:
                            [.init(.flexible()),.init(.flexible())],
                        spacing: 16
                    ) {
                        StatCard(
                            icon: "chart.line.uptrend.xyaxis",
                            label: "Niveau de stress",
                            value: "6/10",
                            subtext: "Légèrement élevé",
                            color: .orange
                        )
                        
                        StatCard(
                            icon: "moon.fill",
                            label: "Sommeil",
                            value: "7h 24m",
                            subtext: "Bonne nuit",
                            color: .blue
                        )
                    }
                    .padding(.bottom, 24)
                    .padding(.horizontal)
                    
                    Text("Recommandation du jour")
                        .fontWeight(.regular)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .padding()
                    
                    
                    HStack(alignment: .top) {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 40,height: 40)
                                .foregroundStyle(.purple)
                            
                            Image(systemName: "sparkles")
                                .foregroundStyle(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Méditation anti-stress")
                                .font(.headline)
                                .fontWeight(.medium)
                            
                            
                            Text("Basée sur votre niveau de stress actuel, nous recommandons une séance de 10 minutes")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Label {
                                    Image(systemName: "chevron.right")
                                } icon: {
                                    Text("Commencer")
                                }
                                .font(.subheadline)
                                .foregroundColor(Color.purple)
                                .labelStyle(.titleAndIcon)
                                
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
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
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
                    .padding()

                    
                    Spacer()
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
    var icon,name,description: String

    var body: some View {
        NavigationLink {
            // Destination
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
            .background(Color(hex: "#FFFFFF"))
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
