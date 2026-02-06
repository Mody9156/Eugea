//
//  AddExercise.swift
//  Eugea
//
//  Created by Modibo on 06/02/2026.
//

import SwiftUI

struct AddExercise: View {
    @State private var backgroundMusic: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack (spacing: 8){
                // MARK: - Header
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                
                Text("Anti-Anxiété")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
//                MinuteurDeMeditation
                
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

#Preview {
    AddExercise()
}
