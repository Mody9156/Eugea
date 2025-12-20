//
//  ContentView.swift
//  Eugea
//
//  Created by Modibo on 19/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State var name : String = "Joe"
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bonjour, \(name)")
                .font(.system(size: 24, weight: .medium))
                .lineSpacing(8)

            Text("Comment vous sentez-vous aujourd'hui ?")
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondary)
                .lineSpacing(8)

            
            ZStack{
                Rectangle()
                    .frame(height: 200)
                    .foregroundStyle(.orange)
                VStack {
                    HStack{
                        
                    }
                }
                
            }

        }
        .padding()
    }
}

#Preview {
    HomeView()
}
