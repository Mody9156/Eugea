//
//  AddExercise.swift
//  Eugea
//
//  Created by Modibo on 06/02/2026.
//

import SwiftUI

struct AddExercise: View {
    @State private var backgroundMusic: String = ""
    @State private var type: String = ""
    @State private var duration: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // MARK: - Header
                VStack (spacing: 8){
                    
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                    
                    Text("Anti-Anxiété")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    
                    Picker("Music",
                           selection: $backgroundMusic
                    ) {
                            ForEach(MeditationTimer.allCases) { music in
                                    Text(music.rawValue).tag(music)
                        }
                    }
                    .foregroundStyle(backgroundMusic.isEmpty ? .gray: .primary)
                    .pickerStyle(.navigationLink)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(height: 50)
                                .foregroundStyle(Color.indigo)
                            Text("Valider")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    AddExercise()
}
