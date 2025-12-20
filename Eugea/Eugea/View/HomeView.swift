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
        VStack {
            Text("Bonjour,\(name)")
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
