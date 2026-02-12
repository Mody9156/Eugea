//
//  AddExercise.swift
//  Eugea
//
//  Created by Modibo on 06/02/2026.
//
import SwiftUI

struct AddExercise: View {
    
    @Binding var backgroundMusic: String
    @Binding var type: String
    @Binding var duration: Int
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("backgroundMusic") var backgroundMusicSetting: String = ""
    @AppStorage("type") var typeSetting: String = ""
    @AppStorage("duration") var durationSetting: Int = 0
    
    // Formatter optimisé
    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .none
        return f
    }()
    
    var isFormValid: Bool {
        !backgroundMusic.isEmpty &&
        !type.isEmpty &&
        duration != 0
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    colors: [
                        Color.purple.opacity(0.4),
                        Color.blue.opacity(0.3)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 42))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                        
                        Text("Anti-Anxiété")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 30)
                    
                    
                    // Form
                    VStack(spacing: 18) {
                        
                        CustomPickerRow(
                            title: "Musique",
                            icon: "music.note",
                            selection: $backgroundMusic
                        )
                        
                        CustomPickerRow(
                            title: "Type",
                            icon: "leaf",
                            selection: $type
                        )
                        
                        HStack {
                            Label("Durée", systemImage: "timer")
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            TextField(
                                "0",
                                value: $duration,
                                formatter: formatter
                            )
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.15),
                            radius: 20,
                            x: 0,
                            y: 10)
                    
                    Spacer()
                    
                    // Button
                    Button {
                        if isFormValid {
                            backgroundMusicSetting = backgroundMusic
                            typeSetting = type
                            durationSetting = duration
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Valider la séance")
                                .fontWeight(.bold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(
                            LinearGradient(
                                colors: [.indigo, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(color: .indigo.opacity(0.4),
                                radius: 12,
                                x: 0,
                                y: 6)
                    }
                    .disabled(!isFormValid)
                    .opacity(isFormValid ? 1 : 0.5)
                }
                .padding()
            }
        }
    }
}


struct CustomPickerRow: View {
    var title: String
    var icon: String
    @Binding var selection: String
    
    var body: some View {
        HStack {
            Picker(selection: $selection) {
                
                if title == "Musique" {
                    ForEach(MeditationTimer.allCases) { item in
                        Text(item.rawValue)
                            .tag(item.rawValue)
                    }
                } else {
                    ForEach(MeditationType.allCases) { item in
                        Text(item.rawValue)
                            .tag(item.rawValue)
                    }
                }
                
            } label: {
                Label(title, systemImage: icon)
            }
            .pickerStyle(.navigationLink)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    @Previewable @State var backgroundMusic: String = ""
    @Previewable @State var type: String = ""
    @Previewable @State var duration: Int = 0
    AddExercise(backgroundMusic: $backgroundMusic, type: $type, duration: $duration)
}
