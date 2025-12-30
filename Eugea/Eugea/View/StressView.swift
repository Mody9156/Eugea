//
//  StressView.swift
//  Eugea
//
//  Created by Modibo on 25/12/2025.
//

import SwiftUI
import SwiftData

struct StressView: View {
    @Binding  var speed : Double
    @State private var isEditing: Bool = false
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var stressData: [StressData]
    
    var body: some View {
        let stressLevel = StressLevel.from(value: Int(speed))

        VStack(spacing: 30) {
            // Carte principale
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(
                        LinearGradient(colors: [Color(.secondarySystemBackground), Color(.systemBackground)], startPoint: .top, endPoint: .bottom)
                    )
                    .frame(width: 320, height: 320)
                    .shadow(radius: 8)
                
                VStack(spacing: 15) {
                    // Icône avec animation légère
                    Image(systemName: stressLevel.symbole)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(stressLevel.color)
                        .scaleEffect(isEditing ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: speed)
                    
                    // Texte
                    Text("Niveau de stress")
                        .font(.title2.bold())
                    
                    Text("\(Int(speed))/10")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(stressLevel.color)
                    
                    Text(stressLevel.name)
                        .font(.subheadline.smallCaps())
                        .foregroundStyle(stressLevel.color.opacity(0.8))
                }
                .padding()
            }
            
            // Slider stylé
            VStack(spacing: 10) {
                Text("Valeur: \(Int(speed))")
                    .foregroundStyle(stressLevel.color)
                    .font(.headline)
                
                Slider(value: $speed, in: 0...10) {
                } minimumValueLabel: {
                    Text("0")
                        .font(.caption)
                        .foregroundStyle(.gray)
                } maximumValueLabel: {
                    Text("10")
                        .font(.caption)
                        .foregroundStyle(.gray)
                } onEditingChanged: { editing in
                    isEditing = editing
                }
                .accentColor(stressLevel.color)
                .padding(.horizontal, 40)
            }
            
            // Bouton Enregistrer
            Button {
                let stressData = StressData(
                    activityName: stressLevel.name,
                    stressLevel: Int(speed)
                )
                context.insert(stressData)
                
                dismiss()
            } label: {
                Text("Enregistrer")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(stressLevel.color.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    StressView()
}

