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
    @State private var duration: Int = 0

    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Background
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
                    
                    // MARK: - Header
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
                    
                    
                    // MARK: - Form Card
                    VStack(spacing: 18) {
                        
                        // Music
                        CustomPickerRow(
                            title: "Musique",
                            icon: "music.note",
                            selection: backgroundMusic
                        )
                        
                        // Type
                        CustomPickerRow(
                            title: "Type",
                            icon: "leaf",
                            selection: type
                        )
                        
                        // Duration
                        HStack {
                            Label("Durée", systemImage: "timer")
                                .foregroundStyle(.gray)
                            
                            Spacer()
                            
                            TextField("",
                                      value: $duration,
                                      formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.gray)
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
                    
                    
                    // MARK: - Validate Button
                    Button {
                        
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
                }
                .padding()
            }
        }
    }
}

struct CustomPickerRow: View {
    var title: String
    var icon: String
    @State var selection: String
    
    
    var body: some View {
        let image = Image(systemName: icon)
        
        HStack {
            Picker("\(image) \(title)", selection: $selection) {
               
                if title == "Musique" {
                    ForEach(
                        MeditationTimer.allCases
                    ) { index in
                        
                        Text( index.rawValue)
                                .tag(index)
                    }
                }else {
                    ForEach(
                        MeditationType.allCases
                    ) { index in
                        
                            Text(index.rawValue)
                                .tag(index)
                        
                    }
                }
                
            }
            .foregroundStyle(
                selection.isEmpty
                ? .gray : .gray
            )
            .pickerStyle(.navigationLink)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        
       
    }
}


#Preview {
    AddExercise()
}
