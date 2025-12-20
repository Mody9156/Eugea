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
                    Image(systemName: "heart.fill")
                        .font(.system(size: 18))
                    Text("Check-in quotidien")
                        .font(.system(size: 14, weight: .medium))
                        .opacity(0.9)
                }
                
                Text("Comment allez-vous ?")
                    .font(.system(size: 20, weight: .medium))
                    .lineSpacing(6)
                
                HStack(spacing: 12) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button {
                            // action
                        } label: {
                            Text(emoji)
                                .font(.system(size: 24))
                                .frame(width: 48, height: 48)
                                .background(.white.opacity(0.2))
                                .clipShape(Circle())
                                .background(.ultraThinMaterial)
                        }
                    }
                }
                
                Button {
                    // action
                } label: {
                    Text("Enregistrer mon humeur")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.purple)
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
                        Color.purple,
                        Color.blue
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.bottom)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
