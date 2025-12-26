//
//  EugeaApp.swift
//  Eugea
//
//  Created by Modibo on 19/12/2025.
//

import SwiftUI
import SwiftData

@main
struct EugeaApp: App {
    @Environment(\.modelContext) private var context
    
    var shareModelContainer: ModelContainer = {
        let schema = Schema([
            StressData.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do{
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        }catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabView{
                Tab("Acceuil", systemImage: "house"){
                    HomeView()
                        .modelContainer(shareModelContainer)
                        .foregroundStyle(.purple)
                }
                
                Tab("Méditer", systemImage: "sparkles"){
                    HomeView()
                        .modelContainer(shareModelContainer)
                        .foregroundStyle(.purple)
                }
            }
            
                
        }
    }
}
