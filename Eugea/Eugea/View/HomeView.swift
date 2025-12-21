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
                columns: [
                    GridItem(.flexible(), spacing: 16),
                    GridItem(.flexible(), spacing: 16)
                ],
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

            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
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
